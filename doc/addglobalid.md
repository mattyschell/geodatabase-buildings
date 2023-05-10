# Add Global IDs To Buildings Procedure

This documentation describes the testing and implementation plan to resolve [issue 36](https://github.com/mattyschell/geodatabase-buildings/issues/36)

Deploy this repository and geodatabase-toiler (includes addglobalids.py) to the environment and then:

### Test plan

1. Import building and building_historic from a higher environment.

2. Create a version under bldg_doitt_edit and perform some edits. Exit.

3. Create a second version, perform some edits, and reconcile and post. Exit

4. Open a map document and use a read only connection to add both layers 

5. Verify that no editing sessions are open to either layer. Stop if this returns anything. We will not distinguish between a user editing and a user reading - any connection to data under the building schema other than from BLDG_READONLY is risky and we will hold. 

``` sql
select 
    sde_id
   ,owner
   ,nodename
   ,start_time
   ,direct_connect 
from 
    process_information a 
where 
    a.sde_id in 
        (select 
              b.sde_id 
         from 
              table_locks b
             ,table_registry c
             ,process_information d
        where 
            b.registration_id = c.registration_id
        and b.sde_id = d.sde_id
        and c.owner = 'BLDG') 
and
    a.owner <> 'BLDG_READONLY'
```

6. Delete the read-only table locks. This is bad but it is our best option.  

```sql
delete from 
    table_locks 
where
    sde_id in (
select 
    sde_id
from 
    process_information a 
where 
    a.sde_id in 
        (select 
              b.sde_id 
         from 
              table_locks b
             ,table_registry c
             ,process_information d
        where 
            b.registration_id = c.registration_id
        and b.sde_id = d.sde_id
        and c.owner = 'BLDG') );
commit;
```

7. Update and run geodatabase-scripts/sample_addglobalids.bat

8. Reconcile and post the step 2 edits

9. Create a new version

10. Add a new building. It should get a new globalid.

11. "Demolish" a building by copying it to building_historic and deleting it. The record in building_historic should receive a globalid that is different from the source building record.

12. Split a building. One lobe should receive a new globalid.  This should be the same record as the new doitt_id.  

13. Review the archiving table building_h and the building_evw versioned view. The new globalid column should be populated. 

14. Run the nightly maintenance script. It should complete as normal without any updates.


#### Staging only

15. Test the import script by importing from staging to development.

16. Test the open data publishing process. Globalid should appear in the outputs.

18. Test the ArcGIS Online publishing process.  


### Implementation - Production

1. Notify users.  All users including read only should close out to avoid errors. You'll get things like "application has stopped working" if you have an open connection.

2. Run steps 5 through 7 from the test plan above.

3. Test steps 9 through 13 in the test plan above.

# Add Global IDs To Buildings Procedure

### Test plan: Dev

1. Import building and building_historic from a higher environment.

2. Create a version under bldg_doitt_edit and perform some edits. Exit.

3. Create a second version, perform some edits, and reconcile and post. Exit

4. Open a map document and use a read only connection to add both layers 

5. Verify that no editing sessions are open to either layer. Stop if this returns anything. We will not distinguish between a user editing and a user reading - any connection to BLDG data other than from BLDG_READONLY is a stop sign. 

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

6. Delete the read-only locks. This is bad but it is our best option.  

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

7. ?? Also 7 - Delete the same ids from process_information? Perhaps this prevents errors in end user desktop software. ??

8. Update and run geodatabase-scripts/sample_addglobalids.bat

9. Reconcile and post the step 2 edits

10. Create a new version

11. Add a new building. It should get a new globalid.

12. "Demolish" a building by copying it to historic and deleting it. The record in building_historic should receive a globalid that is different from the source building record.

13. Split a building. One lobe should receive a new globalid.  This should be the same record as the new doitt_id.  (Makes you wonder if globalids could meet the original requirements that motivated us to add doitt_ids)

14. Review the archiving table building_h. The new globalid column should be populated. 

15. Run nightly maintenance script. It should complete as normal without any updates.


#### Staging only

16. Test the import script by importing from staging to development.

17. Test the open data publishing process

18. Test the ArcGIS Online publishing process


### Implementation - Production

1. Notify users.  All users including read only should close out to avoid errors. You'll get things like "application has stopped working" if you have an open connection.

2. Run steps 5 through 8 in the test plan above.

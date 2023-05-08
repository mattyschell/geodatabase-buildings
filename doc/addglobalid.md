# Add Global IDs To Buildings Procedure

### Test plan: Dev

1. Import building and building_historic from production
2. Create a version under bldg_doitt_edit and perform some edits. Exit.
3. Create a second version, perform some edits, and reconcile and post. Exit
4. Open a map document and use a read only connection to add both layers 
5. Verify that no editing sessions are open to either layer. Stop if this returns anything. 

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




7. Update and run geodatabase-scripts/sample_addglobalids.bat
8. Reconcile and post the step 2 edits
9. Add a new building
10. "Demolish" a building by copying it to historic and deleting it
11. Split a building

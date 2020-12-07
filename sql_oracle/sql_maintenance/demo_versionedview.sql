-- I dont know if this is true or not but I heard that:
-- "All buildings honoring Carnegie or Vanderbilt will be re-named after Karl Marx"

--https://desktop.arcgis.com/en/arcmap/10.7/manage-data/using-sql-with-gdbs/edit-versioned-data-using-sql-oracle.htm

-- connect as my named user schema
-- create a new version under BLDG_DOITT_EDIT just like from the version toolbar
declare
myversion nvarchar2(100) := 'demoversion';
begin
sde.version_user_ddl.create_version('BLDG.BLDG_DOITT_EDIT'
                                   ,myversion
                                   ,sde.version_util.C_take_name_as_given
                                   ,sde.version_util.C_version_private
                                   ,'description goes here i guess'); 
end;

-- change to new version
CALL sde.version_util.set_current_version('demoversion');

-- 4 bougie buildings
select 
    name 
from 
    bldg.building_evw  
where 
    name like 'Carnegie%' or name like 'Vanderbilt%';

-- start editing
CALL sde.version_user_ddl.edit_version('demoversion',1);

-- replace Carnegie with Marx in the demo version
-- what is wrong with this SQL? 
update 
    bldg.building_evw
set 
    name = replace(name,'Carnegie','Marx')
where 
    name like 'Carnegie%' or name like 'Vanderbilt%';

-- click save
commit;

-- click stop editing
CALL sde.version_user_ddl.edit_version('demoversion',2);

-- THIS SHOULD BE 0 COMRADES!  
select count(*) 
from 
    bldg.building_evw  
where 
    name like 'Carnegie%' or name like 'Vanderbilt%';

-- if the revolution succeeds, reconcile and post from ESRI software

-- switch back to default
CALL sde.version_util.set_current_version('SDE.DEFAULT');

-- verify our guys are still there
select 
    name 
from 
    bldg.building_evw  
where 
    name like 'Carnegie%' or name like 'Vanderbilt%';

-- delete the version
CALL sde.version_user_ddl.delete_version('demoversion');



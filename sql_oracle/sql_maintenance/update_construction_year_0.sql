--from mschell create constructionyear version

--set version
begin
    sde.version_util.set_current_version('constructionyear');
end;

select * from bldg.building_evw

--start editing
begin
    sde.version_user_ddl.edit_version ('constructionyear', 1);
end;


--update cobnstruction_year 0s to be NULLs
-- changes 6109 records
update 
    bldg.building_evw
set 
    construction_year = null
where 
    construction_year = 0;

commit;

--stop editing
begin
    sde.version_user_ddl.edit_version ('constructionyear', 2);
end;

--reconcile and post and delete constructionyear 
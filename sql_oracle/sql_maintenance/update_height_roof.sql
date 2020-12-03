--from user schema create heightroof version

begin
    sde.version_util.set_current_version('heightroof');
end;


--start editing
begin
    sde.version_user_ddl.edit_version ('heightroof', 1);
end;


-- round_height roof for all that arent photogrammetry
-- this will take a while because versions
update 
    bldg.building_evw
set 
    height_roof = round(height_roof)
where 
    geom_source = 'Other (Manual)'
and instr(height_roof,'.') > 0;

commit;


begin
    sde.version_user_ddl.edit_version ('heightroof', 2);
end;

--reconcile and post and delete heightroof 


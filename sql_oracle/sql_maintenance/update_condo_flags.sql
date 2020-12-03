--from user schema create condoflags version

begin
    sde.version_util.set_current_version('condoflags');
end;


--start editing
begin
    sde.version_user_ddl.edit_version ('condoflags', 1);
end;


-- correct condo_flags
-- when base_bbl and mappluto_bbl differ, condo flags is Y
-- update 58
update 
    bldg.building_evw
set 
    condo_flags = 'Y'
where 
    base_bbl <> mappluto_bbl
and 
    condo_flags <> 'Y';

-- when base_bbl and mappluto_bbl are the same, not condos
-- update 161
update 
    bldg.building_evw
set 
    condo_flags = 'N'
where 
    base_bbl = mappluto_bbl
and 
    condo_flags = 'Y';


commit;


begin
    sde.version_user_ddl.edit_version ('condoflags', 2);
end;

--reconcile and post and delete condoflags 
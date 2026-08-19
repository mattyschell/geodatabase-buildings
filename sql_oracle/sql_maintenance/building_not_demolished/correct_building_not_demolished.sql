
SET SERVEROUTPUT ON;
SET ECHO OFF;

ACCEPT old_doitt_id PROMPT 'Enter building_not_demolished doitt_id: ' NUMBER;

declare
    old_doitt_id    number         := &old_doitt_id;
    new_doitt_id    number;
    myversion       nvarchar2(100) := 'BLDGNOTDEMOLISHED';
    sequencename    varchar2(32);
    psql            varchar2(1000);
    version_exists  exception;
    pragma exception_init(version_exists, -20177);
    id_count        number;
    doitt_not_found exception;
begin
    begin
        sde.version_user_ddl.create_version('BLDG.BLDG_DOITT_EDIT'
                                           ,myversion
                                           ,sde.version_util.C_take_name_as_given
                                           ,sde.version_util.C_version_public
                                           ,'correct building not demolished');
        dbms_output.put_line('Version ' || myversion || ' created.');
    exception
        when others then
            if sqlcode = -20177 then
                dbms_output.put_line('Using existing version ' || myversion || '.');
            else
                raise;
            end if;
    end;
    sde.version_util.set_current_version(myversion);
    
    -- Check if old_doitt_id exists in building_historic
    psql := 'select '
         || '   count(*) '
         || 'from '
         || '   bldg.building_historic_evw '
         || 'where '
         || '   doitt_id = :p1';
    execute immediate psql into id_count 
                           using old_doitt_id;
    if id_count = 0 then
        dbms_output.put_line('ERROR: doitt_id ' || old_doitt_id || ' not found in building_historic');
        raise doitt_not_found;
    end if;    
    dbms_output.put_line('Found ' || id_count || ' record(s) with doitt_id ' || old_doitt_id);
    psql := 'select ''A'' || to_char(registration_id) || ''SEQ'' '
         || 'from '
         || '    sde.table_registry '
         || 'where '
         || '    owner = :p1 '
         || 'and table_name = :p2 ';
    execute immediate psql into sequencename using 'BLDG'
                                                  ,'BUILDING';
    psql := 'select ' || sequencename || '.nextval '
         || 'from dual';
    execute immediate psql into new_doitt_id;
    dbms_output.put_line('updating building_historic doitt_id');
    dbms_output.put_line('from old to new. Add this line to the README');
    dbms_output.put_line(' ');
    dbms_output.put_line('| ' || old_doitt_id 
                              || ' | ' || new_doitt_id
                              || ' |' );
    dbms_output.put_line(' ');
    -- start editing
    sde.version_user_ddl.edit_version(myversion,1);
    --update statement here
    psql := 'update '
        || '   bldg.building_historic_evw a '
        || 'set '
        || '   a.doitt_id = :p1 '
        || 'where '
        || '   a.doitt_id = :p2 ';
    execute immediate psql using new_doitt_id
                                ,old_doitt_id;    
    -- click save
    commit;
    -- click stop editing
    sde.version_user_ddl.edit_version(myversion,2);
    --rec/post
    sde.version_util.set_current_version('BLDG.BLDG_DOITT_EDIT');
end;
/
EXIT


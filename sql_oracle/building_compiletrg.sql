CREATE or replace PROCEDURE ADD_BUILDING_TRIGGER 
   AS

        --mschell! 20200925
        --dont snitch me out to Redlands 

        psql                VARCHAR2(8000);
        sequence_id         NUMBER;
        created_date        VARCHAR2(32) := 'CREATED_DATE';
        created_user        VARCHAR2(32) := 'CREATED_USER';
        addtable            varchar2(64);
    
BEGIN

    psql := 'select ''A'' || to_char(registration_id) '
            || 'from '
            || '    sde.table_registry '
            || 'where '
            || '    owner = :p1 '
            || 'and table_name = :p2 ';
    
    execute immediate psql into addtable using 'BLDG'
                                              ,'BUILDING';
                                        

    psql := 'SELECT NVL(MAX(doitt_id + :p1), :p2) FROM ( '
            || 'SELECT MAX(doitt_id) doitt_id '
            || 'FROM BUILDING '
            || 'UNION ALL '
            || 'SELECT MAX(doitt_id) doitt_id '
            || 'FROM ' || addtable || ') ';

    EXECUTE IMMEDIATE psql INTO sequence_id USING 1, 1;
    
    begin
        execute immediate 'DROP SEQUENCE ' || UPPER(addtable) || 'SEQ';
    exception when others then null;
    end;

    psql := 'CREATE SEQUENCE ' || addtable || 'SEQ '
            || 'MINVALUE ' || sequence_id || ' '
            || 'MAXVALUE 999999999999999999999999999 '
            || 'START WITH ' || sequence_id || ' '
            || 'INCREMENT BY 1 '
            || 'CACHE 20 ';

    EXECUTE IMMEDIATE psql;

    --ESRI "editor tracking" is enabled,
    --with "Create Date Field" set to "CREATED_DATE" (in UTC)
    --We wish to autopopulate doitt_id whenever a new building is created
    --This includes
    -- 1. Simple create new
    -- 2. Splits
    -- 3. Splits of splits
    -- 4. Multisplits
    -- 5. Copy and pastes
    --So if we are inserting a record with created_date within the last 1.5 seconds
    --Update doitt_id to sequence value

    psql := 'CREATE OR REPLACE TRIGGER ' || addtable || 'TRG FOR '
        || 'INSERT '
        || 'ON ' || addtable || ' '
        || 'COMPOUND TRIGGER '
        || '  TYPE add_table_rec IS RECORD '
        || '  ( '
        || '   objectid ' || addtable || '.objectid%TYPE, '
        || '   sde_state_id ' || addtable || '.sde_state_id%TYPE, '
        || '   ' || created_date || ' ' || addtable || '.' || created_date || '%TYPE, '
        || '   ' || created_user || ' ' || addtable || '.' || created_user || '%TYPE '
        || '  ); '
        || '  TYPE add_table_t IS TABLE OF add_table_rec '
        || '  INDEX BY PLS_INTEGER; '
        || '  add_table_rows   add_table_t; '
        || 'AFTER EACH ROW '
        || 'IS '
        || 'BEGIN '
        || '  add_table_rows (add_table_rows.COUNT + 1).objectid := :NEW.objectid; '
        || '  add_table_rows (add_table_rows.COUNT).sde_state_id := :NEW.sde_state_id; '
        || '  add_table_rows (add_table_rows.COUNT).' || created_date || ' := :NEW.' || created_date || '; '
        || '  add_table_rows (add_table_rows.COUNT).' || created_user || ' := :NEW.' || created_user || '; '
        || 'END AFTER EACH ROW; '
        || 'AFTER STATEMENT '
        || 'IS '
        || 'BEGIN '
        || '  FOR i IN 1 .. add_table_rows.COUNT '
        || '  LOOP '
        || '    IF UPPER(add_table_rows(i).' || created_user || ') = UPPER(USER) '
        || '    AND ( EXTRACT ( DAY FROM ( SYS_EXTRACT_UTC (SYSTIMESTAMP) - add_table_rows(i).' || created_date || ')) * 24 * 60 * 60 '
        || '      +   EXTRACT ( HOUR FROM ( SYS_EXTRACT_UTC (SYSTIMESTAMP) - add_table_rows(i).' || created_date || ')) * 60 * 60 '
        || '      +   EXTRACT ( MINUTE FROM ( SYS_EXTRACT_UTC (SYSTIMESTAMP) - add_table_rows(i).' || created_date || ')) * 60 '
        || '      +   EXTRACT ( SECOND FROM ( SYS_EXTRACT_UTC (SYSTIMESTAMP) - add_table_rows(i).' || created_date || '))) < 1.5 '
        || '    THEN '
        || '      UPDATE ' || addtable || ' '
        || '      SET doitt_id = ' || addtable || 'SEQ.NEXTVAL '
        || '      WHERE objectid = add_table_rows(i).objectid '
        || '      AND sde_state_id = add_table_rows (i).sde_state_id; '
        || '    END IF; '
        || '  END LOOP; '
        || 'END AFTER STATEMENT; '
        || 'END; ';

    --dbms_output.put_line(psql);
    execute immediate psql;

END;
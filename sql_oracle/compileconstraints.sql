CREATE or replace PROCEDURE ADD_BUILDING_CONSTR (
    p_table_name            VARCHAR2 DEFAULT 'BUILDING'
) AS

        --mschell! 20200925

        psql                VARCHAR2(8000);
        addtable            varchar2(64);
    
BEGIN

    psql := 'select ''A'' || to_char(registration_id) '
            || 'from '
            || '    sde.table_registry '
            || 'where '
            || '    owner = :p1 '
            || 'and table_name = :p2 ';
    
    execute immediate psql into addtable using user
                                              ,UPPER(p_table_name);

    -- building identification numbers are boro code (1-5) million
    -- dcp temporary bins are boro code (1-5) || 8 || xxxxx and are not allowed
    psql := 'ALTER TABLE ' || addtable || ' '
         || 'ADD CONSTRAINT ' || addtable || 'BIN '
         || 'CHECK '
         || '(    bin >= 1000000 '
         || ' and bin < 6000000 '
         || ' and to_char(bin) not like ''18%'' '
         || ' and to_char(bin) not like ''28%'' '
         || ' and to_char(bin) not like ''38%'' '
         || ' and to_char(bin) not like ''48%'' '
         || ' and to_char(bin) not like ''58%'' '
         || ' and to_char(length(bin)) = 7 '
         || ')';

    EXECUTE IMMEDIATE psql;

    -- buildings should be built between the date of dutch settlement and 2100
    -- Reminder: dynamic values like Current Year are not constraints
    --           we'll get a little more specific in QA scripting
    -- null is ok for now.  Get outta here with 0 though 
    psql := 'ALTER TABLE ' || addtable || ' '
         || 'ADD CONSTRAINT ' || addtable || 'CONSTRUCTION_YEAR '
         || 'CHECK '
         || '(    construction_year > 1626 '
         || ' and construction_year < 2100 '
         || ')';

    EXECUTE IMMEDIATE psql;

    -- when mappluto_bbl differs from base_bbl, condo_flag should be Y
    psql := 'ALTER TABLE ' || addtable || ' '
         || 'ADD CONSTRAINT ' || addtable || 'CONDO_FLAGS '
         || 'CHECK '
         || '(   ( (mappluto_bbl <> base_bbl) and condo_flags = ''Y'' ) '
         || ' OR ( (mappluto_bbl = base_bbl)  and condo_flags = ''N'' ) '
         || ')';

    EXECUTE IMMEDIATE psql;

END;
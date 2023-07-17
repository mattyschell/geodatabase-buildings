CREATE or replace PROCEDURE ADD_H_BUILDING_CONSTR (
    p_table_name            VARCHAR2 DEFAULT 'BUILDING'
) AS

        --mschell 20230630
        --sloppy coppy of ADD_BUILDING_CONSTR
        --allows more relaxed attitude toward bad data in  
        --  building_historic.  Necessary when editing because
        --  sometimes we are only tidying some of the bad data
        --  in a tuple

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
    -- null is ok sadly
    psql := 'ALTER TABLE ' || addtable || ' '
         || 'ADD CONSTRAINT ' || addtable || 'CONSTRUCTION_YEAR '
         || 'CHECK '
         || '(    (construction_year > 1626 '
         || ' and construction_year < 2100) '
         || ' or construction_year = 0 '
         || ')';

    EXECUTE IMMEDIATE psql;

END;
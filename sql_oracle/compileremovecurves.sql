create or replace procedure remove_curves (
     p_table_name           varchar2 default 'BUILDING'
    ,p_pkc_col              varchar2 default 'DOITT_ID'
) as

        psql                varchar2(4000);

begin

    -- curves exist in legacy databases using SDE.ST_GEOMETRY types
    -- remove_curves is intended for use in import.py
    -- we will execute this procedure against the base table before versioning
    -- if running after versioning pass in xxx_evw as the table name 

    psql := 'update ' || p_table_name || ' a ' 
         || 'set '
         || '   a.shape = sdo_geom.sdo_arc_densify(a.shape, :p1, :p2) ' 
         || 'where '
         || 'a.' || p_pkc_col || ' in ( '
         || '   select distinct ' || p_pkc_col || ' ' 
         || '   from (select aa.' || p_pkc_col || ' ' 
         || '        ,decode(mod(rownum, 3), 2, t.column_value, null) etype '
         || '        ,decode(mod(rownum, 3), 0, t.column_value, null) interpretation '
         || '        from '
         || '        ' || p_table_name || ' aa, '
         || '         TABLE(aa.shape.sdo_elem_info) t '
         || '         ) '
         || '    where ' 
         || '       etype in (:p3,:p4) '
         || '    or interpretation IN (:p5,:p6) '
         || ') ';
    
    execute immediate psql using .0005
                                ,'arc_tolerance=0.1 unit=FOOT'
                                ,1005
                                ,2005
                                ,2
                                ,4;
    commit;

end;
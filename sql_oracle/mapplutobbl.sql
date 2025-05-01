DECLARE
    editversion         varchar2(64) := 'BLDG_DOITT_EDIT';
    featureclass        varchar2(64) := 'building';
    condotable          varchar2(64) := 'condo';
    psql                varchar2(4000);
BEGIN

    -- Run before nightly reconcile and post
    sde.version_util.set_current_version(editversion);
    sde.version_user_ddl.edit_version(editversion,1);

    -- this sets condos regardless of what an editor does
    -- any base_bbl that has a special mappluto_bbl on the list
    -- will get one applied here
    psql := 'update '
         || '    ' || featureclass || '_evw a '
         || 'set '
         || '    a.mappluto_bbl = '
         || '        (select '
         || '            b.condo_billing_bbl '
         || '         from '
         || '            ' || condotable || ' b '
         || '         where '
         || '             REGEXP_LIKE(a.base_bbl, ''^[[:digit:]]{1,}$'') '
         || '         and a.base_bbl = b.condo_base_bbl '
         || '         and a.mappluto_bbl <> b.condo_billing_bbl) '
         || 'where exists '
         || '   (select 1 '
         || '    from '
         || '        ' || condotable || ' c '
         || '     where '
         || '         REGEXP_LIKE(a.base_bbl, ''^[[:digit:]]{1,}$'') '
         || '     and a.base_bbl = c.condo_base_bbl '
         || '     and a.mappluto_bbl <> c.condo_billing_bbl)';
    execute immediate psql;
    -- click save
    commit;

    -- everything not a condo copy base_bbl to mappluto_bbl
    -- this only applies to null mappluto_bbl
    -- (usually new buildings) 
    psql := 'update '
         || '   ' || featureclass || '_evw a '
         || 'set '
         || '   a.mappluto_bbl  = a.base_bbl '
         || 'where '
         || '    a.mappluto_bbl is null ';
    execute immediate psql;
    commit;

    -- occasionally editors will mistakenly set mappluto_bbl to be
    -- different from base_bbl 
    -- or a building base_bbl will stop being a condo (alteration i guess)
    -- or we will update the base_bbl to a lot that isnt a condo (ex lot split)
    -- flip these back to not being condo bbls as they arise
    -- https://github.com/mattyschell/geodatabase-buildings/issues/51
    psql := 'update '
         || '    ' || featureclass || '_evw a '
         || 'set '
         || '    a.mappluto_bbl = a.base_bbl '
         || 'where '
         || '    a.base_bbl <> a.mappluto_bbl '
         || 'and not regexp_like(a.base_bbl, ''[A-Za-z[:space:]]'') '
         || 'and a.base_bbl not in (select '
         || '                           b.condo_base_bbl '
         || '                       from '
         || '                           ' || condotable || ' b )';
    execute immediate psql;
    commit;
    
    -- stop editing
    sde.version_user_ddl.edit_version(editversion,2);

END; 

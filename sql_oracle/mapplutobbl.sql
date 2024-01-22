DECLARE
    editversion         varchar2(64) := 'BLDG_DOITT_EDIT';
    featureclass        varchar2(64) := 'building';
    condotable          varchar2(64) := 'condo';
    psql                varchar2(4000);
BEGIN

    -- Run before nightly reconcile and post
    sde.version_util.set_current_version(editversion);
    sde.version_user_ddl.edit_version(editversion,1);
    psql := 'update '
         || '    ' || featureclass || '_evw a '
         || 'set '
         || '    a.mappluto_bbl = '
         || '        (select '
         || '            b.condo_billing_bbl '
         || '         from '
         || '            ' || condotable || ' b '
         || '         where '
         || '             a.base_bbl = b.condo_base_bbl '
         || '         and a.mappluto_bbl <> b.condo_billing_bbl) '
         || 'where exists '
         || '   (select 1 '
         || '    from '
         || '        ' || condotable || ' c '
         || '     where '
         || '         a.base_bbl = c.condo_base_bbl '
         || '     and a.mappluto_bbl <> c.condo_billing_bbl)';
    execute immediate psql;
    -- click save
    commit;

    -- everything not a condo from above
    -- copy base_bbl to mappluto_bbl
    psql := 'update '
         || '   ' || featureclass || '_evw a '
         || 'set '
         || '   a.mappluto_bbl  = a.base_bbl '
         || 'where '
         || '    a.mappluto_bbl is null ';
    execute immediate psql;
    commit;

    -- stop editing
    sde.version_user_ddl.edit_version(editversion,2);

END; 

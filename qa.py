import sys
import os
import logging
import time 
from datetime import datetime

import gdb
import cx_sde

synthetickey = 'doitt_id'
col2         = 'last_edited_user'

def fetchsql(whichsql
            ,fcname):

    # different patterns in this fetchsql.  cluephone ringaling

    versionedview = fcname + '_evw'
    
    sql = "select " \
        + "a.{0} || ' (' || a.{1} || ')' ".format(synthetickey, col2) \
        + "from {0} a ".format(versionedview) \
        + "where " \

    if whichsql == 'doitt_id':

        sql += "a.doitt_id IS NULL OR a.doitt_id = 0 "

    elif whichsql == 'shape':

        sql += "  sdo_geom.validate_geometry_with_context(a.shape,.0005) <> 'TRUE' " \
             + "or SDO_UTIL.GETNUMELEM(a.shape) > 1 "
          
    elif whichsql == 'bin':

        sql += "  a.bin < 1000000 " \
             + "or a.bin >= 6000000 " \
             + "or to_char(a.bin) like '18%' " \
             + "or to_char(a.bin) like '28%' " \
             + "or to_char(a.bin) like '38%' " \
             + "or to_char(a.bin) like '48%' " \
             + "or to_char(a.bin) like '58%' " \
             + "or to_char(length(a.bin)) <> 7 " \
             + "or a.bin is NULL "

    elif whichsql == 'duplicate bin':

        # different for performance

        sql = "select " \
            + "a.{0} || ' (' || a.{1} || ')' ".format(synthetickey, col2) \
            + "from {0} a ".format(versionedview) \
            + "inner join " \
            + "   (select bin " \
            + "    from {0} ".format(versionedview) \
            + "    group by bin " \
            + "    having count(*) >= 2) dups " \
            + "on dups.bin = a.bin " \
            + "where a.bin not in (1000000,2000000,3000000,4000000,5000000) "

    elif whichsql == 'construction_year':

        sql += "    a.construction_year < 1626 " \
             +  "or a.construction_year > ({0} + 1) ".format(time.strftime("%Y"))

    elif whichsql == 'condo_flags':

        sql += "   ( (a.mappluto_bbl <> a.base_bbl) and a.condo_flags = 'N' ) " \
            +  "or ( (a.mappluto_bbl = a.base_bbl)  and a.condo_flags = 'Y' ) " \
            +  "or a.mappluto_bbl is null " \
            +  "or a.condo_flags is null "

    elif whichsql == 'geometric curves':

        # different
        sql = "select distinct {0} ".format(synthetickey) \
            + "from (select a.{0} ".format(synthetickey) \
            + "     ,decode(mod(rownum, 3), 2, t.column_value, null) etype " \
            + "     ,decode(mod(rownum, 3), 0, t.column_value, null) interpretation " \
            + "      from " \
            + "         {0} a, ".format(versionedview) \
            + "         TABLE(a.shape.sdo_elem_info) t " \
            + "     ) " \
            + "where " \
            + "   etype in (1005,2005) " \
            + "or interpretation IN (2,4) "

    elif whichsql == 'building_layer_extent':
    
        # very very different
        # https://github.com/mattyschell/geodatabase-buildings/issues/24
        
        sql = "select case " \
            + "    when a.layer_id > 0 " \
            + "    then 'layer extent in the geodatabase (not a specific doitt_id)'" \
            + "end  " \
            + "from sde.layers a " \
            + "where " \
            + "    a.table_name = 'BUILDING' " \
            + "and a.owner = 'BLDG' " \
            + "and (round(a.minx,-3) <> 913000 " \
            + "  or round(a.miny,-3) <> 121000 " \
            + "  or round(a.maxx,-3) <> 1067000 " \
            + "  or round(a.maxy,-3) <> 273000 " \
            + "  ) "

    elif whichsql == 'duplicate_doitt_id':

        # https://github.com/mattyschell/geodatabase-buildings/issues/27

        sql =  "select {0} from {1} ".format(synthetickey,versionedview) \
             + "group by {0} ".format(synthetickey) \
             + "having count(*) > 1 "

    elif whichsql == 'name':

        # https://github.com/mattyschell/geodatabase-buildings/issues/29

        sql += "    upper(a.name) like '%NULL%' " \
             +  "or a.name = ' ' "

    elif whichsql == 'bin_mismatch_bbl':

        sql += " substr(to_char(bin),1,1) <> substr(base_bbl,1,1) "

    elif whichsql == 'mappluto_bbl':

        # must start with 1-5 then 9 digits to the end of the string
        # https://github.com/mattyschell/geodatabase-buildings/issues/35
        sql += """ not regexp_like(mappluto_bbl, '^[1-5][[:digit:]]{9}$')"""

    elif whichsql == 'base_bbl': 

        # must start with 1-5 then 9 digits to the end of the string
        # next need to disallow 75 in the 7th and 8th digit
        # https://github.com/mattyschell/geodatabase-buildings/issues/13
        sql += """ not regexp_like(base_bbl, '^[1-5][[:digit:]]{9}$') """ \
            +  """ or base_bbl is null"""

    #print(sql)
    return sql 

             
def main(targetgdb
        ,targetfcname
        ,sqlsoverride):

    qareport = os.linesep

    # new QA check to add?
    # 1. Add the name of the check to checksqls list (probably a column name)
    # 2. Add the switch and sql whereclause in fetchsql above

    checksqls = ['doitt_id'
                ,'shape'
                ,'bin'
                ,'duplicate bin'
                ,'construction_year'
                ,'condo_flags'
                ,'geometric curves'
                ,'duplicate_doitt_id'
                ,'name'
                ,'bin_mismatch_bbl'
                ,'mappluto_bbl'
                ,'base_bbl'
                ,'building_layer_extent']
    
    if set(sqlsoverride).issubset(set(checksqls)):
        checksqls = sqlsoverride

    for checksql in checksqls:

        invalidids = cx_sde.selectacolumn(targetgdb.sdeconn
                                         ,fetchsql(checksql
                                                  ,targetfcname))

        if len(invalidids) > 0:

            qareport = qareport + os.linesep \
                    + 'invalid {0} for {1}(s): {2}'.format(checksql, synthetickey, os.linesep) \
                    + os.linesep.join(f'     {invalidid}' for invalidid in invalidids)  
    
    #print(qareport)     
    return qareport


if __name__ == '__main__':

    ptargetfcname  = sys.argv[1]

    if len(sys.argv) == 2:
        psqlsoverride = 'no'
    else:
        # optionally pass in a subset of the checksqls above
        # use this for building_historic where we enforce few checks
        psqlsoverride = sys.argv[2].split(',')

    ptargetgdb     = gdb.Gdb()
        
    timestr = time.strftime("%Y%m%d-%H%M%S")
    targetlog = os.path.join(os.environ['TARGETLOGDIR'] 
                            ,'qa-{0}-{1}.log'.format(ptargetfcname, timestr))

    # encoding not available at this python encoding='utf-8'
    logging.basicConfig(filename=targetlog
                       ,level=logging.DEBUG)

    retqareport = main(ptargetgdb
                      ,ptargetfcname
                      ,psqlsoverride)

    if len(retqareport) > 4:

        # 4 allows for a pair of sloppy CRLFs
        #QA does not notify. It QAs and writes the results
        logging.error(retqareport)

    

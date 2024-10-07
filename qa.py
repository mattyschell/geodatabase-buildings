import sys
import os
import logging
import time 
from datetime import datetime

import gdb
import cx_sde

def fetchsql(whichsql
            ,fcname):
    
    synthetickey = 'doitt_id'
    flag4        = 'last_edited_user'
    flag4datecol = 'last_edited_date'
    flag4date    = """to_char(a.last_edited_date, 'Day Mon DD YYYY')"""

    versionedview = fcname + '_evw'
    
    sql = "select " \
        + "a.{0} || ' (' || a.{1} || ')' ".format(synthetickey, flag4) \
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

        # different for performance and reporting

        sql = "select " \
            + "'DOITT_ID ' || a.{0} || ' | ".format(synthetickey) \
            + "BIN ' || a.bin || ' | " \
            + "' || a.{0} || ' | ".format(flag4) \
            + "' || {0} ".format(flag4date) \
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
        # https://github.com/mattyschell/geodatabase-buildings/issues/63
        # https://github.com/mattyschell/geodatabase-buildings/issues/65

        #WITH dupes AS (
        #    SELECT 
        #        doitt_id, 
        #        MAX(last_edited_date) AS last_edited_date
        #    FROM 
        #        bldg.building_evw
        #    GROUP BY 
        #        doitt_id
        #    HAVING 
        #        COUNT(*) > 1 )
        #SELECT 
        #    a.doitt_id || ' (' ||  
        #    a.last_edited_user || ') '
        #FROM 
        #    building_evw a
        #JOIN 
        #    dupes b
        #ON 
        #    a.doitt_id = b.doitt_id 
        #AND a.last_edited_date = b.last_edited_date

        # substitution costs arguably greater than benefits
        sql = "WITH dupes AS (" \
            + "    SELECT " \
            + "       {0}, ".format(synthetickey) \
            + "       MAX({0}) AS last_edited_date ".format(flag4datecol) \
            + "    FROM " \
            + "       {0} ".format(versionedview) \
            + "    GROUP BY " \
            + "       {0} ".format(synthetickey) \
            + "    HAVING " \
            + "        COUNT(*) > 1 ) " \
            + " SELECT " \
            + "    a.{0} || ' (' ||  ".format(synthetickey) \
            + "    a.{0} || ') ' ".format(flag4) \
            + " FROM " \
            + "     {0} a ".format(versionedview) \
            + " JOIN " \
            + "    dupes b " \
            + " ON " \
            + "     a.{0} = b.{1} ".format(synthetickey,synthetickey) \
            + " AND " \
            + "    a.{0} = b.{1} ".format(flag4datecol,flag4datecol)

    elif whichsql == 'name':

        # https://github.com/mattyschell/geodatabase-buildings/issues/29

        sql += "    upper(a.name) like '%NULL%' " \
             +  "or a.name = ' ' "

    elif whichsql == 'bin_mismatch_bbl':

        sql += " substr(to_char(bin),1,1) <> substr(base_bbl,1,1) "

    elif whichsql == 'base_bbl': 

        # must start with 1-5 then 9 digits to the end of the string
        # next need to disallow 75 in the 7th and 8th digit
        # https://github.com/mattyschell/geodatabase-buildings/issues/13
        sql += """ not regexp_like(base_bbl, '^[1-5][[:digit:]]{9}$') """ \
            +  """ or base_bbl is null"""

    elif whichsql == 'mappluto_bbl':

        # if mappluto_bbl differs from base_bbl then
        #    mappluto designates a "condo bbl" 
        #    condo bbls are 10 digits with 75 in places 7 and 8
        # when mappluto_bbls are not condo bbls
        #      then mappluto_bbl should be the usual boro followed by 9 digits
        # all mappluto_bbls should be in the same boro as the base_bbl
        sql += """ (base_bbl <> mappluto_bbl """ \
            +  """  and not regexp_like(mappluto_bbl, '^[1-5]\d{5}75\d{2}$') """ \
            +  """  ) """ \
            + """ or not """ \
            + """    regexp_like(mappluto_bbl, '^[1-5][[:digit:]]{9}$') """ \
            + """ or substr(to_char(bin),1,1) <> substr(mappluto_bbl,1,1) """
        
    elif whichsql == 'feature_code': 

        #https://github.com/mattyschell/geodatabase-buildings/issues/34
        sql += " a.feature_code = 0 " \
             + " or a.feature_code is null "

    #print(sql)
    return sql 

def qalogging(logfile
             ,level=logging.DEBUG):
    
    qalogger = logging.getLogger(__name__)
    qalogger.setLevel(level)
    filehandler = logging.FileHandler(logfile)
    qalogger.addHandler(filehandler)

    return qalogger

             
def main(targetgdb
        ,targetfcname
        ,sqlsoverride):

    synthetickey = 'doitt_id'
    qareport = ""

    # new QA check to add?
    # 1. Add the name of the check to checksqls list (probably a column name)
    # 2. Add the switch and sql whereclause in fetchsql above

    checksqls = ['doitt_id'
                ,'shape'
                ,'bin'
                ,'duplicate bin'
                ,'construction_year'
                ,'geometric curves'
                ,'duplicate_doitt_id'
                ,'name'
                ,'bin_mismatch_bbl'
                ,'base_bbl'
                ,'mappluto_bbl'
                ,'building_layer_extent'
                ,'feature_code']
    
    # wtf is this? must be for testing
    if set(sqlsoverride).issubset(set(checksqls)):
        checksqls = sqlsoverride

    for checksql in checksqls:

        invalidids = cx_sde.selectacolumn(targetgdb.sdeconn
                                         ,fetchsql(checksql
                                                  ,targetfcname))

        if len(invalidids) > 0:

            if len(qareport) > 0:
                qareport = qareport + os.linesep

            qareport = qareport + 'invalid {0} for {1}(s): {2}'.format(checksql, synthetickey, os.linesep) \
                                + os.linesep.join(f'     {invalidid}' for invalidid in invalidids)  
    
    #print("qa report ------->")
    #print(qareport)     
    #print("<------- qa report")
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

    qalogger = qalogging(targetlog)

    retqareport = main(ptargetgdb
                      ,ptargetfcname
                      ,psqlsoverride)

    if len(retqareport) > 4:

        #4 allows for a pair of sloppy CRLFs
        #QA does not notify. It QAs 
        qalogger.error(retqareport)

    

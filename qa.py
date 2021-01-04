import sys
import os
import logging
import time 
from datetime import datetime

import gdb
import fc
import cx_sde

synthetickey = 'doitt_id'

def fetchsql(whichsql
            ,fcname):

    # different patterns in this fetchsql.  cluephone ringaling

    versionedview = fcname + '_evw'
    
    sql = "select a.{0} ".format(synthetickey) \
        + "from {0} a ".format(versionedview) \
        + "where " \

    if whichsql == 'doitt_id':

        sql += "a.doitt_id IS NULL OR a.doitt_id = 0 "

    elif whichsql == 'shape':

        sql += "sdo_geom.validate_geometry_with_context(a.shape,.0005) <> 'TRUE' "

    elif whichsql == 'bin':

        sql += "  a.bin < 1000000 " \
            + "or a.bin >= 6000000 " \
            + "or to_char(a.bin) like '18%' " \
            + "or to_char(a.bin) like '28%' " \
            + "or to_char(a.bin) like '38%' " \
            + "or to_char(a.bin) like '48%' " \
            + "or to_char(a.bin) like '58%' " \
            + "or to_char(length(a.bin)) <> 7 "

    elif whichsql == 'duplicate bin':

        sql += "a.bin in ( " \
             + "select bin from {0} ".format(versionedview) \
             + "where bin not in (1000000,2000000,3000000,4000000,5000000)  " \
             + "group by bin having count(bin) > 1) "

    elif whichsql == 'construction_year':

        sql += "    a.construction_year < 1626 " \
            +  "or a.construction_year > ({0} + 1) ".format(time.strftime("%Y"))

    elif whichsql == 'condo_flags':

        sql += "   ( (a.mappluto_bbl <> a.base_bbl) and a.condo_flags = 'N' ) " \
             + "or ( (a.mappluto_bbl = a.base_bbl)  and a.condo_flags = 'Y' ) "

    # print(sql)
    return sql 


def main(targetsdeconn
        ,targetfcname):

    targetgdb = gdb.Gdb()

    targetfc = fc.Fc(targetgdb
                    ,targetfcname)  

    qareport = os.linesep

    # new QA check to add?
    # 1. Add the name of the check to checksqls list (probably a column name)
    # 2. Add the switch and sql whereclause in fetchsql above

    checksqls = ['doitt_id'
                ,'shape'
                ,'bin'
                ,'duplicate bin'
                ,'construction_year'
                ,'condo_flags']

    for checksql in checksqls:

        invalidids = cx_sde.selectacolumn(targetgdb.sdeconn
                                         ,fetchsql(checksql
                                                  ,targetfcname))

        # print('kount of invalid ' + checksql + ' is ' + str(len(invalidids)))

        if len(invalidids) > 0:

            qareport = qareport + os.linesep \
                    + 'invalid {0} for {1}(s): {2}'.format(checksql, synthetickey, os.linesep) \
                    + os.linesep.join(map(str, (invalidids)))  
            
    return qareport


if __name__ == '__main__':

    ptargetsdeconn = os.environ['SDEFILE']
    ptargetfcname  = sys.argv[1]
        
    timestr = time.strftime("%Y%m%d-%H%M%S")
    targetlog = os.path.join(os.environ['TARGETLOGDIR'] 
                            ,'qa-{0}-{1}.log'.format(ptargetfcname, timestr))

    # encoding not available at this python encoding='utf-8'
    logging.basicConfig(filename=targetlog
                       ,level=logging.DEBUG)

    retqareport = main(ptargetsdeconn
                      ,ptargetfcname)

    if len(retqareport) > 4:

        # 4 allows for a pair of sloppy CRLFs
        logging.error(retqareport)


    #QA does not email. It QAs

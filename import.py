import sys
import os
import logging
import pathlib

# SET PYTHONPATH=C:\gis\geodatabase-toiler\src\py
import gdb
import fc
import cx_sde


def fetchsql(whichsql
            ,database):

    sqlfilepath = pathlib.Path(__file__).parent \
                                        .joinpath('sql_{0}'.format(database)) \
                                        .joinpath(whichsql)
        
    with open(sqlfilepath, 'r') as sqlfile:
        sql = sqlfile.read() 

    return sql 



if __name__ == "__main__":

    targetfcname = sys.argv[1]
    sourcefc     = sys.argv[2]

    if sourcefc.lower().endswith('historic'):
        targetfctype = 'historic'
    else:
        targetfctype = 'building'


    targetsdeconn = os.environ['SDEFILE']
    targetgdb = gdb.Gdb()

    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger(__name__)

    logger.info('importing {0}'.format(targetfcname))

    # We do not overwrite, we do not trust me  
    # Caller must delete as an explicit decision if thats desired on this target
    targetgdb.importfeatureclass(sourcefc
                                ,targetfcname)

    targetfc = fc.Fc(targetgdb
                    ,targetfcname)  

    logger.info('removing any geometric curves from {0}'.format(targetfcname))

    sdereturn = cx_sde.execute_immediate(targetsdeconn,
                                         fetchsql('compileremovecurves.sql'
                                                  ,targetgdb.database))

    # editing base table before versioning and indexes, monitor performance
    sdereturn = cx_sde.execute_immediate(targetsdeconn,
                                         """begin remove_curves('{0}'); end; """.format(targetfcname))


    logger.info('versioning {0}'.format(targetfcname))
    targetfc.version()

    # columns should already exist
    logger.info('tracking edits on {0}'.format(targetfcname))
    output = targetfc.trackedits()

    logger.info('indexing {0} on {1}'.format('BIN'
                                             ,targetfcname))
    output = targetfc.index('BIN')

    # generic helper index for performance
    logger.info('indexing {0} on {1}'.format('BASE_BBL'
                                             ,targetfcname))    
    output = targetfc.index('BASE_BBL')

    # reminder: "unique indexes cant be specified for multiversioned tables"
    logger.info('indexing {0} on {1}'.format('DOITT_ID'
                                                ,targetfcname))
    output = targetfc.index('DOITT_ID')

    if targetfctype != 'historic':

        # only add trigger to main building feature class
        logger.info('adding doitt_id trigger to {0}'.format(targetfcname))

        sdereturn = cx_sde.execute_immediate(targetsdeconn,
                                             fetchsql('compiletriggers.sql'
                                                     ,targetgdb.database))

        # todo: get oracle syntax outta here.  Requires pushing table name to SQL 
        sdereturn = cx_sde.execute_immediate(targetsdeconn,
                                             """begin ADD_BUILDING_TRIGGER('{0}'); end; """.format(targetfcname))

        # different constraints than historic
        logger.info('adding constraints to Add table of {0}'.format(targetfcname))

        sdereturn = cx_sde.execute_immediate(targetsdeconn,
                                             fetchsql('compileconstraints.sql'
                                                      ,targetgdb.database))

        # todo: get oracle syntax outta here. Requires pushing table name to SQL
        sdereturn = cx_sde.execute_immediate(targetsdeconn,
                                            """begin ADD_BUILDING_CONSTR('{0}'); end; """.format(targetfcname))

    elif targetfctype == 'historic':

        # different constraints for historic
        logger.info('adding constraints to Add table of {0}'.format(targetfcname))

        sdereturn = cx_sde.execute_immediate(targetsdeconn,
                                             fetchsql('historic-compileconstraints.sql'
                                                      ,targetgdb.database))

        # todo: get oracle syntax outta here. Requires pushing table name to SQL
        sdereturn = cx_sde.execute_immediate(targetsdeconn,
                                            """begin ADD_H_BUILDING_CONSTR('{0}'); end; """.format(targetfcname))


    logger.info('updating statistics on {0}'.format(targetfcname))

    output = targetfc.analyze()

    logger.info('enabling archiving (from today forward) on {0}'.format(targetfcname))

    output = targetfc.enablearchiving()

    # creating versions like BLDG_DOITT_EDIT probably comes next but that is not
    # part of the import of a single feature class
    # 'SDE.DEFAULT'
    #        'BLDG_DOITT_EDIT'
    logger.info('completed import of {0}'.format(targetfcname))

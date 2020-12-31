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
    editors      = sys.argv[3]

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

    logger.info('versioning {0}'.format(targetfcname))
    targetfc.version()

    # columns should already exist
    logger.info('tracking edits on {0}'.format(targetfcname))
    output = targetfc.trackedits()

    for editor in editors.strip().split(','):
        
        logger.info('granting edit privileges on {0} to {1}'.format(targetfcname
                                                                   ,editor))
        output = targetfc.grantprivileges(editor)

    logger.info('indexing {0} on {1}'.format('BIN'
                                             ,targetfcname))
    output = targetfc.index('BIN')

    logger.info('indexing {0} on {1}'.format('BASE_BBL'
                                             ,targetfcname))
    
    output = targetfc.index('BASE_BBL')

    # reminder: "unique indexes cant be specified for multiversioned tables"
    logger.info('indexing {0} on {1}'.format('DOITT_ID'
                                             ,targetfcname))
    output = targetfc.index('DOITT_ID')

    logger.info('adding doitt_id trigger to {0}'.format(targetfcname))

    sdereturn = cx_sde.execute_immediate(targetsdeconn,
                                         fetchsql('compiletriggers.sql'
                                                  ,targetgdb.database))

    # todo: get oracle syntax outta here.  Requires pushing table name to SQL 
    sdereturn = cx_sde.execute_immediate(targetsdeconn,
                                         """begin ADD_BUILDING_TRIGGER('{0}'); end; """.format(targetfcname))

    logger.info('adding constraints to Add table of {0}'.format(targetfcname))

    sdereturn = cx_sde.execute_immediate(targetsdeconn,
                                         fetchsql('compileconstraints.sql'
                                                  ,targetgdb.database))

    # todo: get oracle syntax outta here. Requires pushing table name to SQL
    sdereturn = cx_sde.execute_immediate(targetsdeconn,
                                         """begin ADD_BUILDING_CONSTR('{0}'); end; """.format(targetfcname))

    logger.info('updating statistics on {0}'.format(targetfcname))

    output = targetfc.analyze()

    logger.info('enabling archiving (from today forward) on {0}'.format(targetfcname))

    output = targetfc.enablearchiving()

    # creating versions like BLDG_DOITT_EDIT probably comes next but that is not
    # part of the import of a single feature class
    # 'SDE.DEFAULT'
    #        'BLDG_DOITT_EDIT'
    logger.info('completed import of {0}'.format(targetfcname))

import sys
import os
import logging

import gdb
import fc


if __name__ == "__main__":

    #if len(sys.argv) != 3:
    #    raise ValueError('Expected 2 inputs, notifyonsuccess flag and emails')

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
    targetfc.trackedits()

    for editor in editors.strip().split(',')
        
        logger.info('granting edit privileges on {0} to {1}'.format(targetfcname
                                                                   ,editor))
        targetfc.grantprivileges(editor)

    logger.info('indexing {0} on {1}'.format('BIN'
                                             ,targetfcname))
    targetfc.index('BIN')

    logger.info('indexing {0} on {1}'.format('BASE_BBL'
                                             ,targetfcname))
    targetfc.index('BASE_BBL')

    # reminder: "unique indexes cant be specified for multiversioned tables"
    logger.info('indexing {0} on {1}'.format('DOITT_ID'
                                             ,targetfcname))
    targetfc.index('DOITT_ID')

    logger.info('adding doitt_id trigger to {0}'.format(targetfcname))

    sdereturn = cx_sde.execute_immediate(self.sdeconn,
                                         targetgdb.fetchsql('building_compiletrg.sql'))

    sdereturn = cx_sde.execute_immediate(self.sdeconn,
                                         targetgdb.fetchsql('building_addtrg.sql'))

    logger.info('adding constraints to Add table of {0}'.format(targetfcname))

    sdereturn = cx_sde.execute_immediate(self.sdeconn,
                                         targetgdb.fetchsql('building_compilecons.sql'))

    sdereturn = cx_sde.execute_immediate(self.sdeconn,
                                         targetgdb.fetchsql('building_addcons.sql'))

    logger.info('updating statistics on {0}'.format(targetfcname))

    targetfc.analyze()

    # not enabling archiving 
    # https://pro.arcgis.com/en/pro-app/tool-reference/data-management/enable-archiving.htm

    # creating versions like BLDG_DOITT_EDIT probably comes next but that is not
    # part of the import of a single feature class
    # 'SDE.DEFAULT'
    #        'BLDG_DOITT_EDIT'
    logger.info('completed import of {0}'.format(targetfcname))

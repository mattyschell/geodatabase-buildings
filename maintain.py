import sys
import os
import logging
import time

import gdb
import fc

# this here is 4! 
# 1. Update any data that editors don't maintain manually
# 2. Reconcile and post BUILDING_DOITT_EDIT version to DEFAULT
# 3. Compress and rebuild geodatabase administrator indexes
# 4. Rebuild buildings feature class indexes and update database optimizer statistics
# 5. Run QA on buildings feature class DEFAULT version
# 6. Notify the squad of QA results

if __name__ == '__main__':

    ptargetfcname  = sys.argv[1]

    geodatabase    = gdb.Gdb()
    buildings      = fc.Fc(geodatabase
                          ,ptargetfcname)

    timestr = time.strftime("%Y%m%d-%H%M%S")
    
    targetlog = os.path.join(os.environ['TARGETLOGDIR'] 
                            ,'maintain-{0}-{1}.log'.format(ptargetfcname
                                                          ,timestr))

    logging.basicConfig(filename=targetlog
                       ,level=logging.INFO)
    
    retval = 1
 
    try:
        retval = buildings.rebuildindexes()
        logging.info('Rebuilt {0} indexes '.format(ptargetfcname))
    except:
        logging.error('Failed to rebuild {0} indexes'.format(ptargetfcname)) 
        retval = 1

    if retval == 0:

        try:
            retval = buildings.analyze()
            logging.info('Analyzed {0}'.format(ptargetfcname))
        except:
            logging.error('Failed to analyze: {0}'.format(ptargetfcname)) 
            retval = 1        

    exit(retval)


import sys
import os
import logging
import time

import gdb

# https://pro.arcgis.com/en/pro-app/latest/help/data/geodatabases/manage-oracle/rebuild-system-table-indexes.htm

if __name__ == '__main__':

    geodatabase = gdb.Gdb()

    timestr = time.strftime("%Y%m%d-%H%M%S")
    
    targetlog = os.path.join(os.environ['TARGETLOGDIR'] 
                            ,'maintaingeodatabase-{0}-{1}.log'.format('SDE'
                                                                     ,timestr))
    logging.basicConfig(filename=targetlog
                       ,level=logging.INFO)

    print('should be logging to {0}'.format(targetlog))
    logging.info('Logging to {0}'.format(targetlog))
    
    retval = 1
    states_removed = 0
 
    try:
        states_removed = geodatabase.compress()
        logging.info('Compression removed {0} states from: {1}'.format(states_removed, geodatabase.sdeconn))
    except:
        logging.error('Failed to compress: {0}'.format(geodatabase.sdeconn)) 
        retval = 1

    if states_removed > 0:

        try:
            retval = geodatabase.rebuildindexes()
            logging.info('Rebuilt geodatabase administrator indexes on {0}'.format(geodatabase.sdeconn))
        except:
            logging.error('Failed to rebuild indexes on: {0}'.format(geodatabase.sdeconn)) 
            retval = 1        

    exit(retval)


import sys
import os
import logging
import time

import gdb
import fc

# this here is 4 and 5! 
# 1 rec and post
# 2 compress
# 3 rebuild sde indexes 
# 4 rebuild feature class indexes 
# 5 analyze https://pro.arcgis.com/en/pro-app/latest/help/data/geodatabases/manage-oracle/update-statistics.htm
# (TBD 6 rebuild building_historic)
# 7 qa 

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


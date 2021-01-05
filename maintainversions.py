import sys
import os
import logging
import time

import gdb
import version

if __name__ == '__main__':

    bldg_edit_version_name  = sys.argv[1]

    timestr = time.strftime("%Y%m%d-%H%M%S")
    targetlog = os.path.join(os.environ['TARGETLOGDIR'] 
                            ,'maintainversion-{0}-{1}.log'.format(bldg_edit_version_name
                                                                 ,timestr))
    
    logging.basicConfig(filename=targetlog
                       ,level=logging.INFO)
    
    geodatabase = gdb.Gdb()
    bldg_edit_version = version.Version(geodatabase
                                       ,bldg_edit_version_name)

    retval = 1
 
    try:
        recnpostoutput = bldg_edit_version.reconcileandpost()
    except:
        logging.error('Failed reconcile and post of: {0}'.format(bldg_edit_version.versionname))        

    if 'succeeded' in recnpostoutput.lower():
        logging.info('Successful reconcile and post of {0}'.format(bldg_edit_version.versionname))
        logging.info('{0}'.format(recnpostoutput))
        retval = 0
    else:
        # not reachable, I think, just in case
        logging.error('Failed reconcile and post of: {0}'.format(bldg_edit_version.versionname))
        logging.error('{0}'.format(recnpostoutput))

    exit(retval)

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

    logging.basicConfig(filename=targetlog)

    geodatabase = gdb.Gdb()
    bldg_edit_version = version.Version(geodatabase
                                       ,bldg_edit_version_name)

    recnpostoutput = bldg_edit_version.reconcileandpost()

    if 'succeeded' in recnpostoutput.lower():
        logging.info('Successful reconcile and post of {0}'.format(bldg_edit_version.versionname))
        logging.info('{0}'.format(recnpostoutput))
    else:
        logging.error('Failed reconcile and post of: {0}'.format(bldg_edit_version.versionname))
        logging.error('{0}'.format(recnpostoutput))

import sys
import os
import logging
import time

import gdb
import version

if __name__ == '__main__':

    versionname  = sys.argv[1]
    alteration   = sys.argv[2]      

    timestr = time.strftime("%Y%m%d-%H%M%S")
    targetlog = os.path.join(os.environ['TARGETLOGDIR'] 
                            ,'changeversionaccess-{0}-{1}.log'.format(versionname
                                                                     ,timestr))
    
    logging.basicConfig(filename=targetlog
                       ,level=logging.INFO)
    
    geodatabase = gdb.Gdb()
    defaultversion = version.Version(geodatabase
                                     ,versionname)

    retval = 1
 
    try:
        if alteration == 'unprotect':
            defaultversion.unprotect()
        elif alteration == 'protect':
            defaultversion.protect()
    except:
        logging.error('Failed to alter: {0}'.format(defaultversion.versionname))        
        exit(retval)

    logging.info('Successfully {0}ed {1}'.format(alteration
                                                ,defaultversion.versionname))
    
    retval = 0
    exit(retval)

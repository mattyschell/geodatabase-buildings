import sys
import logging
import os

import gdb
import fc

# %PROPY% grant.py BUILDING MSCHELL N

if __name__ == '__main__':

    ptargetsdeconn = os.environ['SDEFILE']
    ptargetfcname  = sys.argv[1]
    pgrantees      = sys.argv[2]
    pviewer        = sys.argv[3] # read only Y or N
        
    timestr = time.strftime("%Y%m%d-%H%M%S")
    targetlog = os.path.join(os.environ['TARGETLOGDIR'] 
                            ,'grant-{0}-{1}.log'.format(ptargetfcname, timestr))

    # encoding not available at this python encoding='utf-8'
    logging.basicConfig(filename=targetlog
                       ,level=logging.INFO)

    targetgdb = gdb.Gdb()

    targetfc = fc.Fc(targetgdb
                    ,ptargetfcname)  

    for grantee in pgrantees.strip().split(','):
        
        logging.info('granting privileges on {0} to {1}'.format(ptargetfcname
                                                              ,grantee))
        
        if pviewer != 'Y':

            output = targetfc.grantprivileges(grantee)

        else:

            output = targetfc.grantprivileges(grantee
                                             ,'AS_IS')


import sys
import os
import logging

# SET PYTHONPATH=C:\gis\geodatabase-toiler\src\py
import gdb
import fc


if __name__ == "__main__":


    targetfcname = sys.argv[1]

    targetsdeconn = os.environ['SDEFILE']
    targetgdb = gdb.Gdb()

    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger(__name__)

    logger.info('attempting to delete {0}'.format(targetfcname))

    # check for locks or be legends?
    targetfc = fc.Fc(targetgdb
                    ,targetfcname)  

    if targetfc.exists():
        targetfc.delete()

    logger.info('completed deleting {0}'.format(targetfcname))

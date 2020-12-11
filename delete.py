import sys
import os
import logging

# SET PYTHONPATH=C:\geodatabase-toiler\src\py
import gdb
import fc

if __name__ == "__main__":

    #if len(sys.argv) != 3:
    #    raise ValueError('Expected 2 inputs, notifyonsuccess flag and emails')

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

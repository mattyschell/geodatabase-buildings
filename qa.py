#import sys
#import os
#import logging
#import pathlib
#
#import gdb
#import fc
#import cx_sde
#
#def fetchsql(whichsql
#            ,database):
#
#    sqlfilepath = pathlib.Path(__file__).parent \
#                                        .joinpath('sql_{0}'.format(database)) \
#                                        .joinpath(whichsql)
#        
#    with open(sqlfilepath, 'r') as sqlfile:
#        sql = sqlfile.read() 
#
#    return sql 
#
#
#if __name__ == "__main__":
#
#    #if len(sys.argv) != 3:
#    #    raise ValueError('Expected 2 inputs, notifyonsuccess flag and emails')
#
#    targetfcname = sys.argv[1]
#
#    targetsdeconn = os.environ['SDEFILE']
#    targetgdb = gdb.Gdb()
#
#    logging.basicConfig(level=logging.INFO)
#    logger = logging.getLogger(__name__)
#
#    targetfc = fc.Fc(targetgdb
#                    ,targetfcname)  
#
#    logger.info('QAing {0}'.format(targetfcname))
#    targetfc.version()
#
#
#    #qa emails
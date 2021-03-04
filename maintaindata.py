import sys
import os
import logging
import time
import pathlib

# geodatabase-toiler
import cx_sde

# this here is number 1! 
# 1. Update any data that editors don't maintain manually
# 2. Reconcile and post BUILDING_DOITT_EDIT version to DEFAULT
# 3. Compress and rebuild geodatabase administrator indexes
# 4. Rebuild buildings feature class indexes and update database optimizer statistics
# 5. Run QA on buildings feature class DEFAULT version
# 6. Notify the squad of QA results

def fetchsql(whichsql
            ,database='oracle'):

        # fetch any sql from the library under the repo sql_oracle directory

        sqlfilepath = pathlib.Path(__file__).parent \
                                            .joinpath('sql_{0}'.format(database)) \
                                            .joinpath(whichsql)
        
        with open(sqlfilepath, 'r') as sqlfile:
            sql = sqlfile.read() 

        return sql 


if __name__ == '__main__':

    ptargetsdeconn = os.environ['SDEFILE']
    ptargetfcname  = sys.argv[1]
    ptargetversionname  = sys.argv[2]

    timestr = time.strftime("%Y%m%d-%H%M%S")
    targetlog = os.path.join(os.environ['TARGETLOGDIR'] 
                            ,'maintaindata-{0}-{1}.log'.format(ptargetfcname
                                                              ,timestr))
    
    logging.basicConfig(filename=targetlog
                       ,level=logging.INFO)

    if ptargetfcname.upper() != 'BUILDING':
        logging.info('Skipping data maintenance on testing feature class {0}'.format(ptargetfcname))
        exit(0)

    if ptargetversionname != 'BLDG_DOITT_EDIT':
        # consider converting mapplutobbl to a stored procedure
        # or just skipping this update in some cases
        raise ValueError('maintaindata.py only edits BLDG_DOITT_EDIT version')

    # add more to the list here should work        
    datasqls = ['mapplutobbl.sql']

    retval = 0

    for datasql in datasqls:
 
        try:
            sdereturn = cx_sde.execute_immediate(ptargetsdeconn
                                                ,fetchsql(datasql))
            logging.info('Successfully executed {0} against {1} on version {2}'.format(datasql
                                                                                      ,ptargetfcname
                                                                                      ,ptargetversionname))
        except:
            logging.error('Failed executing : {0} : {1}'.format(datasql
                                                               ,sdereturn)) 
            # fail maintaindata.py but continue with any other sqls if possible       
            retval = 1

    exit(retval)

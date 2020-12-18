import sys
import os
from subprocess import call

import gdb
import fc
import cx_sde

def shp2json(fcname):

    # reminder
    # ogr2ogr 
    #   -dialect SQLite 
    #   -sql "SELECT doitt_id AS doitt_id, geometry AS geometry from buildingsi" 
    #   -t_srs EPSG:4326 
    #   -f GeoJSON 
    #   -lco COORDINATE_PRECISION=6 
    #   buildingsi.geojson 
    #   buildingsi.shp

    sql = """ "SELECT doitt_id AS doitt_id, geometry AS geometry from {0}" """.format(fcname)

    #todo: the rest of the column shenanigans
    
    callcmd =  f"ogr2ogr -dialect SQLite -sql {sql} -t_srs EPSG:4326 -f GeoJSON -lco COORDINATE_PRECISION=6 {fcname}.geojson {fcname}.shp "

    #print(callcmd)
    
    exit_code = call(callcmd)

    return exit_code

def deleteshp(shapedir
             ,name):

    exts = ['shp','dbf','shx','cpg','sbn','sbx','shp.xml','prj']

    for ext in exts:

        if os.path.exists(os.path.join(shapedir
                                      ,'{0}.{1}'.format(name,ext))):

            os.remove(os.path.join(shapedir
                                  ,'{0}.{1}'.format(name,ext)))

def main(sourcesdeconn
        ,sourcefcname
        ,targetdir):

    sourcegdb = gdb.Gdb()

    sourcefc = fc.Fc(sourcegdb
                    ,sourcefcname)

    deleteshp(targetdir
             ,sourcefcname)  

    sourcefc.exporttoshp(targetdir
                        ,'{0}.{1}'.format(sourcefcname.lower()
                                         ,'shp'))

    exit_code = shp2json(sourcefcname)

if __name__ == '__main__':

    psourcesdeconn = os.environ['SDEFILE']
    psourcefcname  = sys.argv[1]

    exit_code = main(psourcesdeconn
                    ,psourcefcname
                    ,os.path.dirname(os.path.realpath(__file__)))

    # Todo something with graceful exit



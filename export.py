import sys
import os
from subprocess import call
import logging
import time

import gdb
import fc
import cx_sde

def shp2json(fcdir
            ,fcname
            ,precision=6):

    # 6 digits = approximately 1/10 meter
    
    # reminder
    # ogr2ogr 
    #   -dialect SQLite 
    #   -sql "SELECT doitt_id AS doitt_id, geometry AS geometry from buildingsi" 
    #   -t_srs EPSG:4326 
    #   -f GeoJSON 
    #   -lco COORDINATE_PRECISION=6 
    #   buildingsi.geojson 
    #   buildingsi.shp

    # todo: replace feature_codes with text?
    #       do something better with last edited dates "2017\/08\/22"
    #       fix shapefile messes like 0s and spaces

    sql = """ "SELECT doitt_id AS doitt_id """ \
          """ ,bin AS bin """ \
          """ ,base_bbl AS base_bbl """ \
          """ ,name AS name """ \
          """ ,constructi AS construction_year """ \
          """ ,geom_sourc AS geom_source """ \
          """ ,last_statu as last_status """ \
          """ ,height_roo as height_roof """ \
          """ ,feature_co as feature_code """ \
          """ ,status as status """ \
          """ ,ground_ele as ground_elevation """ \
          """ ,last_edi_1 as last_edited_date """ \
          """ ,addressabl as addressable """ \
          """ ,mappluto_b as mappluto_bbl """ \
          """ ,condo_flag as condo_flag """ \
          """ ,alteration as alteration_year """ \
          """ ,geometry AS geometry """ \
          """ from {0} ORDER BY bin " """.format(fcname)
    
    inshp = os.path.join(fcdir
                        ,'{0}.{1}'.format(fcname,'shp'))

    outjson = os.path.join(fcdir
                          ,'{0}.{1}'.format(fcname,'geojson'))

    callcmd =  f"ogr2ogr -dialect SQLite -sql {sql} -t_srs EPSG:4326 -f GeoJSON -lco COORDINATE_PRECISION={precision} {outjson} {inshp} "

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

    main_exit_code = shp2json(targetdir
                             ,'{0}'.format(sourcefcname.lower()))

    deleteshp(targetdir
             ,sourcefcname) 

    return main_exit_code

if __name__ == '__main__':

    psourcesdeconn = os.environ['SDEFILE']
    psourcefcname  = sys.argv[1]

    timestr = time.strftime("%Y%m%d-%H%M%S")
    targetlog = os.path.join(os.environ['TARGETLOGDIR'] 
                            ,'export-{0}.log'.format(timestr))

    logging.basicConfig(filename=targetlog)

    exit_code = main(psourcesdeconn
                    ,psourcefcname
                    ,os.path.dirname(os.path.realpath(__file__)))

    if exit_code == 0:
        logging.info('Successfully exported {0}'.format(psourcefcname))
    else:
        logging.error('Failed to export {0}'.format(psourcefcname))

    



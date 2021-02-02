# The NYC Buildings Maintenance Toilin'

Code and helpers for maintaining New York City building footprints in a versioned ESRI Enterprise Geodatabase. Friends, this is our NYC buildings footprints in a versioned ESRI Enterprise Geodatabase toil, our rules, the trick is never to be afraid.

Dependencies: 

   * [ESRI ArcGIS Pro python 3.x](https://pro.arcgis.com/en/pro-app/arcpy/get-started/installing-python-for-arcgis-pro.htm) 
   * [geodatabase-toiler](https://github.com/mattyschell/geodatabase-toiler) on PYTHONPATH


# Import 

```bat
> set SDEFILE=T:\GIS\Internal\Connections\oracle19c\dev\GIS-ditGSdv1\bldg.sde
> set PYTHONPATH=C:\geodatabase-toiler\src\py;C:\geodatabase-buildings
> c:\Progra~1\ArcGIS\Pro\bin\Python\scripts\propy.bat import.py BUILDING C:\conns\bldg@geocdev.sde\BLDG.BUILDING
```

# QA 

```bat
> set SDEFILE=T:\GIS\Internal\Connections\oracle19c\dev\GIS-ditGSdv1\bldg.sde
> set PYTHONPATH=C:\geodatabase-toiler\src\py;C:\geodatabase-buildings
> c:\Progra~1\ArcGIS\Pro\bin\Python\scripts\propy.bat qa.py BUILDING 
```


# Export To GeoJSON

Additional Dependency: 

   * [ogr2ogr](https://gdal.org/programs/ogr2ogr.html) on PATH

Consider repeatedly dumping this file to a drive that supports previous versions
or to somewhere cloudy.

```bat
> set SDEFILE=T:\GIS\Internal\Connections\oracle19c\dev\GIS-ditGSdv1\bldg.sde
> set PYTHONPATH=C:\geodatabase-toiler\src\py;C:\geodatabase-buildings
> c:\Progra~1\ArcGIS\Pro\bin\Python\scripts\propy.bat export.py BUILDING 
```

# Execute Nightly Maintenance Tasks

1. Reconcile and post BUILDING_DOITT_EDIT version to DEFAULT
2. Compress and rebuild geodatabase administrator indexes
3. Rebuild buildings feature class indexes and update database optimizer statistics
4. Run QA on buildings feature class DEFAULT version
5. Notify the squad of QA results

Update the environmental variables at the top of this batch file as needed.

```bat
> sample_maintain.bat 
```

# SOP Setup

Copy sample batch files out of geodatabase-buildings and into
geodatabase-scripts.  Then update variables at the top of the batch files
to match the machine where we are running.

```
\gis
   \connections
   \geodatabase-buildings
   \geodatabase-scripts
                       \logs
                            \import-building.log
                            \qa-building.log
   \geodatabase-toiler        
```


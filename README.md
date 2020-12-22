# The NYC Buildings Maintenance Toilin'

Code and helpers for maintaining New York City building footprints in a versioned ESRI Enterprise Geodatabase. Friends, this is our NYC buildings footprints in a versioned ESRI Enterprise Geodatabase toil, our rules, the trick is never to be afraid.

Dependencies: 

   * [ESRI ArcGIS P-ro python 3.x](https://pro.arcgis.com/en/pro-app/arcpy/get-started/installing-python-for-arcgis-pro.htm) 
   * [geodatabase-toiler](https://github.com/mattyschell/geodatabase-toiler) on PYTHONPATH


# Import 

```bat
> set SDEFILE=T:\GIS\Internal\Connections\oracle19c\dev\GIS-ditGSdv1\bldg.sde
> set PYTHONPATH=C:\geodatabase-toiler\src\py;C:\geodatabase-buildings
> c:\Progra~1\ArcGIS\Pro\bin\Python\scripts\propy.bat import.py BUILDING C:\conns\bldg@geocdev.sde\BLDG.BUILDING "MSCHELL,BKNOWLES"
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




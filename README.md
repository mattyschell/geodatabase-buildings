# The NYC Buildings Maintenance Toilin'

Code and helpers for maintaining New York City building footprints in a versioned ESRI Enterprise Geodatabase. Friends, this is our NYC buildings footprints in a versioned ESRI Enterprise Geodatabase toil, our rules, the trick is never to be afraid.

Dependencies: 

   * ESRI ArcGIS Pro arcpy python 3.x 
   * [geodatabase-toiler](https://github.com/mattyschell/geodatabase-toiler) on PYTHONPATH


# Import Buildings

```bat
> set SDEFILE=T:\GIS\Internal\Connections\oracle19c\dev\GIS-ditGSdv1\bldg.sde
> set PYTHONPATH=C:\geodatabase-toiler\src\py;C:\geodatabase-buildings
> c:\Progra~1\ArcGIS\Pro\bin\Python\scripts\propy.bat import.py BUILDING C:\conns\bldg@geocdev.sde\BLDG.BUILDING "MSCHELL,BKNOWLES"
```

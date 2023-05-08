REM https://github.com/mattyschell/geodatabase-buildings/issues/36
REM change these
SET DBENV=DEV
SET DBNAME=XXXXXXXX
SET BASEPATH=XXXXXX
REM review the rest
SET SDEFILE=%BASEPATH%\connections\oracle19c\%DBENV%\GIS-%DBNAME%\bldg.sde
SET PY27=C:\Python27\ArcGIS10.7\python.exe
SET TOILER=%BASEPATH%\geodatabase-toiler
set TARGETFC=BUILDING_HISTORIC
%PY27% %TOILER%\src\py27\addglobalids.py %TARGETFC%
set TARGETFC=BUILDING
%PY27% %TOILER%\src\py27\addglobalids.py %TARGETFC%

set BUILDINGSDEFILE=T:\GIS\Internal\Connections\oracle19c\dev\GIS-ditGSdv1\bldg.sde
set ADMINSDEFILE=T:\GIS\Internal\Connections\oracle19c\dev\GIS-ditGSdv1\mschell_private\sde.sde
set BUILDINGFC=BUILDINGSI
set BUILDINGEDITVERSION=BLDG_DOITT_EDIT
set NOTIFY=mschell@doitt.nyc.gov
set TARGETLOGDIR=C:\Temp\
set TOILER=C:\matt_projects\geodatabase-toiler\
set BUILDINGS=C:\matt_projects\geodatabase-buildings\
set PYTHONPATH=%TOILER%\src\py;%BUILDINGS%
set PROPY=c:\Progra~1\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe
echo reconciling and posting on %date% at %time% >> sample_maintain.log
set SDEFILE=%BUILDINGSDEFILE%
%PROPY% %BUILDINGS%maintainversions.py %BUILDINGEDITVERSION% 
REM echo maintaining geodatabase on %date% at %time% >> sample_maintain.log 
REM set SDEFILE=%ADMINSDEFILE%
REM %PROPY% %BUILDINGS%maintaingeodatabase.py %TARGETFC% 
REM set SDEFILE=%BUILDINGSDEFILE%
REM %PROPY% %BUILDINGS%maintain.py %BUILDINGFC%
REM %PROPY% %BUILDINGS%qa.py %BUILDINGFC% 
REM echo notifying us of QA results on %BUILDINGFC% on %date% at %time% >> sample_maintain.log
REM %PROPY% %BUILDINGS%notify.py "maintenance and QA of %BUILDINGFC% on %SDEFILE%" %NOTIFY%
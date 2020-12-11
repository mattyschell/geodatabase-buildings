set SDEFILE=T:\GIS\Internal\Connections\oracle19c\dev\GIS-ditGSdv1\bldg.sde
set TOILER=C:\matt_projects\geodatabase-toiler\
set BUILDINGS=C:\matt_projects\geodatabase-buildings\
set LOG=C:\Temp\test_import.log
set TARGETFC=BUILDINGSI
set SOURCEFC=C:\matt_projects\database_utils\arcgisconnections\bldg@geocdev.sde\BLDG.BUILDINGSI
set EDITORS=MSCHELL
set PYTHONPATH=%TOILER%\src\py;%BUILDINGS%
echo deleting target %TARGETFC% on %date% at %time% >> %LOG%
REM c:\Progra~1\ArcGIS\Pro\bin\Python\scripts\propy.bat %BUILDINGS%delete.py %TARGETFC% >> %LOG%
c:\Progra~1\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe %BUILDINGS%delete.py %TARGETFC% >> %LOG%
echo importing %TARGETFC% on %date% at %time% >> %LOG%
c:\Progra~1\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe %BUILDINGS%import.py %TARGETFC% %SOURCEFC% %EDITORS% >> %LOG%
echo performing QA on %TARGETFC% on %date% at %time% >> %LOG%
echo exporting geojson %TARGETFC% on %date% at %time% >> %LOG%
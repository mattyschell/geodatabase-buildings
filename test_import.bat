set SDEFILE=T:\GIS\Internal\Connections\oracle19c\dev\GIS-ditGSdv1\bldg.sde
set TARGETFC=BUILDINGSI
set SOURCEFC=C:\matt_projects\database_utils\arcgisconnections\bldg@geocdev.sde\BLDG.BUILDINGSI
set EDITORS=MSCHELL
set NOTIFY=mschell@doitt.nyc.gov
set TARGETLOGDIR=C:\Temp\test_import\
set TOILER=C:\matt_projects\geodatabase-toiler\
set BUILDINGS=C:\matt_projects\geodatabase-buildings\
set PYTHONPATH=%TOILER%\src\py;%BUILDINGS%
set PROPY=c:\Progra~1\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe
set PY27=C:\Python27\ArcGIS10.6\python.exe
echo deleting target %TARGETFC% on %date% at %time% >> test_import.log
%PROPY% %BUILDINGS%delete.py %TARGETFC% 
echo importing %TARGETFC% on %date% at %time% >> test_import.log
%PROPY% %BUILDINGS%import.py %TARGETFC% %SOURCEFC% %EDITORS% 
echo creating versioned view %TARGETFC%_EVW on %date% at %time% >> test_import.log
%PY27% %TOILER%\src\py27\create_versionedviews.py %TARGETFC%
echo performing QA on %TARGETFC% on %date% at %time% >> test_import.log
%PROPY% %BUILDINGS%qa.py %TARGETFC% 
echo notifying us of QA results on %TARGETFC% on %date% at %time% >> test_import.log
%PROPY% %BUILDINGS%notify.py "import and QA of %TARGETFC% on %SDEFILE%" %NOTIFY%
echo exporting geojson %TARGETFC% on %date% at %time% >> %TARGETLOGDIR%test_import.log
REM export here
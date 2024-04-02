set DBENV=xxx
set DBNAME=xxxxxx
set BASEPATH=x:\xxx\
set SDEFILE=%BASEPATH%connections\oracle19c\%DBENV%\GIS-%DBNAME%\bldg.sde
set TARGETFC=BUILDING_HISTORIC
set SOURCEFC=%BASEPATH%connections\oracle19c\xxx\GIS-xxxxxx\bldg.sde\BLDG.%TARGETFC%
set EDITORS=xxx,xxx,xxx
set VIEWERS=xxx,xxx
set NOTIFY=xxx@xxx.xxx.xx
REM set NOTIFY=x
set NOTIFYFROM=xxx@xxx.xxx.xxx
set SMTPFROM=xxx.xxx
set TARGETLOGDIR=%BASEPATH%geodatabase-scripts\logs\building_historic_import\
set TOILER=%BASEPATH%geodatabase-toiler\
set BUILDINGS=%BASEPATH%geodatabase-buildings\
set PYTHONPATH=%TOILER%\src\py;%BUILDINGS%
set PROPY=c:\Progra~1\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe
set PY27=C:\Python27\ArcGIS10.7\python.exe
set BATLOG=%TARGETLOGDIR%building_historic_import.log
echo starting building import to target %TARGETFC% on %date% at %time% > %BATLOG%
%PROPY% %BUILDINGS%delete.py %TARGETFC% && (
  echo. >> %BATLOG% && echo deleted target %TARGETFC% on %date% at %time% > %TARGETLOGDIR%building_historic_import.log
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to delete %TARGETFC% on %SDEFILE%" %NOTIFY% "building_historic_import" && EXIT /B 1
)  
%PROPY% %BUILDINGS%import.py %TARGETFC% %SOURCEFC% && (
  echo. >> %BATLOG% && echo imported %TARGETFC% on %date% at %time% >> %TARGETLOGDIR%building_historic_import.log
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to import %TARGETFC% on %SDEFILE%" %NOTIFY% "building_historic_import" && EXIT /B 1
)  
%PY27% %TOILER%\src\py27\enable_archiving.py %TARGETFC% && (
  echo. >> %BATLOG% && echo enabled archiving on %TARGETFC% on %date% at %time%  >> %TARGETLOGDIR%building_historic_import.log
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to enable archiving for %TARGETFC% on %SDEFILE%" %NOTIFY% "building_import" && EXIT /B 1
) 
%PROPY% %BUILDINGS%grant.py %TARGETFC% %EDITORS% "N" && (
  echo. >> %BATLOG% && echo granted %TARGETFC% edit privileges on %date% at %time% >> %TARGETLOGDIR%building_historic_import.log
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to grant %TARGETFC% edit privileges on %SDEFILE%" %NOTIFY% "building_historic_import" && EXIT /B 1
)  
%PROPY% %BUILDINGS%grant.py %TARGETFC% %VIEWERS% "Y" && (
  echo. >> %BATLOG% && echo granted %TARGETFC% viewing privileges on %date% at %time% >> %TARGETLOGDIR%building_historic_import.log
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to grant %TARGETFC% viewing privileges on %SDEFILE%" %NOTIFY% "building_historic_import" && EXIT /B 1
)   
%PY27% %TOILER%\src\py27\create_versionedviews.py %TARGETFC% && (
  echo. >> %BATLOG% && echo created versioned view for %TARGETFC% on %date% at %time% >> %TARGETLOGDIR%building_historic_import.log
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to create versioned view for %TARGETFC% on %SDEFILE%" %NOTIFY% "building_historic_import" && EXIT /B 1
) 
%PROPY% %BUILDINGS%qa.py %TARGETFC% "shape" && (
  %PROPY% %BUILDINGS%notify.py ": Successfully imported %TARGETFC% to %DBNAME% (%DBENV%)" %NOTIFY% "building_historic_import"
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed QA of imported %TARGETFC% on %DBNAME% (%DBENV%)" %NOTIFY% "qa"
) 


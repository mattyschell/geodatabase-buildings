set SDEFILE=X:\XXX\xxxx\xxxx\xxx\xxxx\xxx.sde
set TARGETFC=BUILDING_HISTORIC
set SOURCEFC=X:\XXX\xxxx\xxxx\xxx\xxxx\xxx.sde\BLDG.BUILDING_HISTORIC
set EDITORS=xxxx,xxxx
set VIEWERS=xxxx
set NOTIFY=xxx@xxx.xxx.xxx
set NOTIFYFROM=xxx@xx.xx.xxx
set SMTPFROM=xxx.xxx
set TARGETLOGDIR=x:\xxx\geodatabase-scripts\logs\building_historic_import\
set TOILER=X:\xxx\geodatabase-toiler\
set BUILDINGS=X:\xxx\geodatabase-buildings\
set PYTHONPATH=%TOILER%\src\py;%BUILDINGS%
set PROPY=c:\Progra~1\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe
set PY27=C:\Python27\ArcGIS10.7\python.exe
echo starting building import to target %TARGETFC% on %date% at %time% > %TARGETLOGDIR%building_import.log
%PROPY% %BUILDINGS%delete.py %TARGETFC% && (
  echo. >> deleted target %TARGETFC% on %date% at %time% > %TARGETLOGDIR%building_historic_import.log
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to delete %TARGETFC% on %SDEFILE%" %NOTIFY% "building_historic_import" && EXIT /B 1
)  
%PROPY% %BUILDINGS%import.py %TARGETFC% %SOURCEFC% && (
  echo. >> imported %TARGETFC% on %date% at %time% >> %TARGETLOGDIR%building_historic_import.log
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to import %TARGETFC% on %SDEFILE%" %NOTIFY% "building_historic_import" && EXIT /B 1
)  
%PROPY% %BUILDINGS%grant.py %TARGETFC% %EDITORS% "N" && (
  echo. >> granted %TARGETFC% edit privileges on %date% at %time% >> %TARGETLOGDIR%building_historic_import.log
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to grant %TARGETFC% edit privileges on %SDEFILE%" %NOTIFY% "building_historic_import" && EXIT /B 1
)  
%PROPY% %BUILDINGS%grant.py %TARGETFC% %VIEWERS% "Y" && (
  echo. >> granted %TARGETFC% viewing privileges on %date% at %time% >> %TARGETLOGDIR%building_historic_import.log
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to grant %TARGETFC% viewing privileges on %SDEFILE%" %NOTIFY% "building_historic_import" && EXIT /B 1
)   
%PY27% %TOILER%\src\py27\create_versionedviews.py %TARGETFC% && (
  echo. >> created versioned view for %TARGETFC% on %date% at %time% >> %TARGETLOGDIR%building_historic_import.log
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to create versioned view for %TARGETFC% on %SDEFILE%" %NOTIFY% "building_historic_import" && EXIT /B 1
) 
%PROPY% %BUILDINGS%qa.py %TARGETFC% "shape" && (
  %PROPY% %BUILDINGS%notify.py ": Successfully imported %TARGETFC% to %SDEFILE%" %NOTIFY% "building_historic_import"
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed QA of imported %TARGETFC% on %SDEFILE%" %NOTIFY% "qa"
) 

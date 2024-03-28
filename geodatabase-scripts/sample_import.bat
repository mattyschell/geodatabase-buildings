REM change these 
set DBENV=DEV
set DBNAME=XXXXXXXX
set BASEPATH=X:\XXX
set SOURCEFC=%BASEPATH%\connections\oracle19c\XXX\GIS-XXXXXXXX\bldg.sde\BLDG.BUILDING
set EDITORS=XXXXXX,XXXXXX
REM unmask these
set NOTIFY=XXXXXX@XXX.nyc.gov
set NOTIFYFROM=XXXXXX@XXX.nyc.gov
set SMTPFROM=XXXXXXXXX.XXXXXX
REM review these
set PY27=C:\Python27\ArcGIS10.7\python.exe
set SDEFILE=%BASEPATH%\connections\oracle19c\%DBENV%\GIS-%DBNAME%\bldg.sde
REM feel, gather, and realize these. Silencio
set VIEWERS=BLDG_READONLY
set TARGETFC=BUILDING
set TARGETLOGDIR=%BASEPATH%\geodatabase-scripts\logs\building_import\
set TOILER=%BASEPATH%\geodatabase-toiler\
set BUILDINGS=%BASEPATH%\geodatabase-buildings\
set PYTHONPATH=%TOILER%\src\py;%BUILDINGS%
set PROPY=c:\Progra~1\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe
set BATLOG=%TARGETLOGDIR%building_import.log
echo starting building import to target %TARGETFC% on %date% at %time% > %TARGETLOGDIR%building_import.log
%PROPY% %BUILDINGS%delete.py %TARGETFC% && (
  echo. deleted target %TARGETFC% on %date% at %time% >> %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to delete %TARGETFC% on %SDEFILE%" %NOTIFY% "building_import" && EXIT /B 1
)  
%PROPY% %BUILDINGS%import.py %TARGETFC% %SOURCEFC% && (
  echo. >> %BATLOG% && echo imported %TARGETFC% on %date% at %time% >> %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to import %TARGETFC% on %SDEFILE%" %NOTIFY% "building_import" && EXIT /B 1
) 
%PY27% %TOILER%\src\py27\enable_archiving.py %TARGETFC% && (
  echo. >> %BATLOG% && echo enabled archiving on %TARGETFC% on %date% at %time%  >> %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to enable archiving for %TARGETFC% on %SDEFILE%" %NOTIFY% "building_import" && EXIT /B 1
) 
%PROPY% %BUILDINGS%grant.py %TARGETFC% %EDITORS% "N" && (
  echo. >> %BATLOG% && echo granted %TARGETFC% edit privileges on %date% at %time% >> %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to grant %TARGETFC% edit privileges on %SDEFILE%" %NOTIFY% "building_import" && EXIT /B 1
)  
%PROPY% %BUILDINGS%grant.py %TARGETFC% %VIEWERS% "Y" && (
  echo. >> %BATLOG% && echo granted %TARGETFC% viewing privileges on %date% at %time% >> %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to grant %TARGETFC% viewing privileges on %SDEFILE%" %NOTIFY% "building_import" && EXIT /B 1
)
%PY27% %TOILER%\src\py27\create_versionedviews.py %TARGETFC% && (
  echo. >> %BATLOG% && echo created versioned view %TARGETFC%_EVW on %date% at %time%  >> %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to create versioned views for %TARGETFC% on %SDEFILE%" %NOTIFY% "building_import" && EXIT /B 1
) 
%PROPY% %BUILDINGS%qa.py %TARGETFC% && (
  echo. >> %BATLOG% && echo QAd target %TARGETFC% on %date% at %time% >> %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to execute QA on %TARGETFC% on %SDEFILE%" %NOTIFY% "building_import" && EXIT /B 1
) 
%PROPY% %BUILDINGS%notify.py "import and QA of %TARGETFC% on %SDEFILE%" %NOTIFY% "qa"

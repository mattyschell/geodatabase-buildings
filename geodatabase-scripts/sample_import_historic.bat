REM change these next two
set DBENV=DEV
set DBNAME=DITGSDV1
REM update this one for each env
set EDITORS=MSCHELL
REM unmask the next three
set NOTIFY=xxxx@yyyy.zzzz.gov
set NOTIFYFROM=aaaa@bbbb.cccc.gov
set SMTPFROM=foo.bar
REM review the rest but should be good if we set paths consistently
set SDEFILE=C:\gis\connections\oracle19c\%DBENV%\GIS-%DBNAME%\bldg.sde
set SOURCEFC=C:\gis\connections\oracle11g\bldg@geoc%DBENV%.sde\BLDG.BUILDING_HISTORIC
set VIEWERS=BLDG_READONLY
set TARGETFC=BUILDING_HISTORIC
set TARGETLOGDIR=C:\gis\geodatabase-scripts\logs\
set TOILER=C:\gis\geodatabase-toiler\
set BUILDINGS=C:\gis\geodatabase-buildings\
set PYTHONPATH=%TOILER%\src\py;%BUILDINGS%
set PROPY=c:\Progra~1\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe
set PY27=C:\Python27\ArcGIS10.6\python.exe
set BATLOG=%TARGETLOGDIR%building_historic_import.log
%PROPY% %BUILDINGS%delete.py %TARGETFC% && (
  echo deleted target %TARGETFC% on %date% at %time% > %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to delete %TARGETFC% on %SDEFILE%" %NOTIFY% "building_historic_import" && EXIT /B 1
)  
%PROPY% %BUILDINGS%import.py %TARGETFC% %SOURCEFC% && (
  echo. >> %BATLOG% && echo imported %TARGETFC% on %date% at %time% >> %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to import %TARGETFC% on %SDEFILE%" %NOTIFY% "building_historic_import" && EXIT /B 1
)  
%PROPY% %BUILDINGS%grant.py %TARGETFC% %EDITORS% "N" && (
  echo. >> %BATLOG% && echo granted %TARGETFC% edit privileges on %date% at %time% >> %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to grant %TARGETFC% edit privileges on %SDEFILE%" %NOTIFY% "building_historic_import" && EXIT /B 1
)  
%PROPY% %BUILDINGS%grant.py %TARGETFC% %VIEWERS% "Y" && (
  echo. >> %BATLOG% && echo granted %TARGETFC% viewing privileges on %date% at %time% >> %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to grant %TARGETFC% viewing privileges on %SDEFILE%" %NOTIFY% "building_historic_import" && EXIT /B 1
)  
%PY27% %TOILER%\src\py27\create_versionedviews.py %TARGETFC% && (
  echo. >> %BATLOG% && echo created versioned view for %TARGETFC% on %date% at %time% >> %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to create versioned view for %TARGETFC% on %SDEFILE%" %NOTIFY% "building_historic_import" && EXIT /B 1
) 
%PROPY% %BUILDINGS%export.py %TARGETFC% && (
  echo. >> %BATLOG% && echo exported %TARGETFC% on to json on %date% at %time% >> %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to export %TARGETFC% to json" %NOTIFY% "building_historic_import" && EXIT /B 1
)  
%PROPY% %BUILDINGS%notify.py ": Successfully imported %TARGETFC% to %SDEFILE%" %NOTIFY% "building_historic_import"

set BUILDINGSDEFILE=T:\GIS\Internal\Connections\oracle19c\dev\GIS-ditGSdv1\bldg.sde
set ADMINSDEFILE=T:\GIS\Internal\Connections\oracle19c\dev\GIS-ditGSdv1\mschell_private\sde.sde
set BUILDINGFC=BUILDING
set BUILDINGEDITVERSION=BLDG_DOITT_EDIT
set NOTIFY=mschell@doitt.nyc.gov
set TARGETLOGDIR=C:\Temp\logpile\
set TOILER=C:\matt_projects\geodatabase-toiler\
set BUILDINGS=C:\matt_projects\geodatabase-buildings\
set PYTHONPATH=%TOILER%\src\py;%BUILDINGS%
set PROPY=c:\Progra~1\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe
set BATLOG=%TARGETLOGDIR%building_maintain.log
echo starting up our work on %BUILDINGFC% %date% at %time% > %BATLOG%
set SDEFILE=%BUILDINGSDEFILE%
%PROPY% %BUILDINGS%maintaindata.py %BUILDINGFC% %BUILDINGEDITVERSION% && (
  echo. >> %BATLOG% && echo updated data in %BUILDINGEDITVERSION% on %SDEFILE% on %date% at %time% > %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to update data in %BUILDINGEDITVERSION% on %SDEFILE%" %NOTIFY% "building_maintain" && EXIT /B 1
)  
%PROPY% %BUILDINGS%maintainversions.py %BUILDINGEDITVERSION% && (
  echo. >> %BATLOG% && echo reconciled and posted %BUILDINGEDITVERSION% on %SDEFILE% on %date% at %time% > %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed version maintenance of %BUILDINGEDITVERSION% on %SDEFILE%" %NOTIFY% "building_maintain" && EXIT /B 1
)  
set SDEFILE=%ADMINSDEFILE%
%PROPY% %BUILDINGS%maintaingeodatabase.py %TARGETFC% && (
    echo. >> %BATLOG% && echo performed geodatabase administrator maintainence of %SDEFILE% on %date% at %time% >> %BATLOG%
) || (
    %PROPY% %BUILDINGS%notify.py ": Failed geodatabase administrator maintenance on %SDEFILE%" %NOTIFY% "building_maintain" && EXIT /B 1
) 
set SDEFILE=%BUILDINGSDEFILE%
%PROPY% %BUILDINGS%maintain.py %BUILDINGFC% && (
    echo. >> %BATLOG% && echo performed feature class maintenance of %BUILDINGFC% on %SDEFILE% on %date% at %time% >> %BATLOG%
) || (
    %PROPY% %BUILDINGS%notify.py ": Failed feature class maintenance of %BUILDINGFC% on %SDEFILE%" %NOTIFY% "building_maintain" && EXIT /B 1
) 
echo. >> %BATLOG% && echo performing %BUILDINGFC% feature class QA on %date% at %time% >> %BATLOG%
%PROPY% %BUILDINGS%qa.py %BUILDINGFC% && (
    %PROPY% %BUILDINGS%notify.py ": Successfully completed maintenance and QA of %BUILDINGFC% on %SDEFILE%" %NOTIFY% "qa"
) || (
    %PROPY% %BUILDINGS%notify.py ": Failed QA of %BUILDINGFC% on %SDEFILE%" %NOTIFY% "qa"
) 
echo. >> %BATLOG% && echo completed notifying the squad of %BUILDINGFC% QA results on %date% at %time% >> %BATLOG%



set BUILDINGSDEFILE=T:\GIS\Internal\Connections\oracle19c\dev\GIS-ditGSdv1\bldg.sde
set ADMINSDEFILE=T:\GIS\Internal\Connections\oracle19c\dev\GIS-ditGSdv1\mschell_private\sde.sde
set BUILDINGFC=BUILDINGSI
set BUILDINGEDITVERSION=BLDG_DOITT_EDIT
set NOTIFY=mschell@doitt.nyc.gov
set TARGETLOGDIR=C:\Temp\logpile\
set TOILER=C:\matt_projects\geodatabase-toiler\
set BUILDINGS=C:\matt_projects\geodatabase-buildings\
set PYTHONPATH=%TOILER%\src\py;%BUILDINGS%
set PROPY=c:\Progra~1\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe
echo starting up our work on %BUILDINGFC% %date% at %time% >> sample_maintain.log
set SDEFILE=%BUILDINGSDEFILE%
%PROPY% %BUILDINGS%maintainversions.py %BUILDINGEDITVERSION% && (
  echo reconciled and posted %BUILDINGEDITVERSION% on %SDEFILE% on %date% at %time% >> sample_maintain.log 
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed version maintenance of %BUILDINGEDITVERSION% on %SDEFILE%" %NOTIFY%
)  
set SDEFILE=%ADMINSDEFILE%
%PROPY% %BUILDINGS%maintaingeodatabase.py %TARGETFC% && (
    echo performed geodatabase administrator maintainence of %SDEFILE% on %date% at %time% >> sample_maintain.log
) || (
    %PROPY% %BUILDINGS%notify.py ": Failed geodatabase administrator maintenance on %SDEFILE%" %NOTIFY%
) 
set SDEFILE=%BUILDINGSDEFILE%
%PROPY% %BUILDINGS%maintain.py %BUILDINGFC% && (
    echo performed feature class maintenance of %BUILDINGFC% on %SDEFILE% on %date% at %time% >> sample_maintain.log
) || (
    %PROPY% %BUILDINGS%notify.py ": Failed feature class maintenance of %BUILDINGFC% on %SDEFILE%" %NOTIFY%
) 
echo performing %BUILDINGFC% feature class QA on %date% at %time% >> sample_maintain.log
%PROPY% %BUILDINGS%qa.py %BUILDINGFC% && (
    %PROPY% %BUILDINGS%notify.py ": Successfully completed maintenance and QA of %BUILDINGFC% on %SDEFILE%" %NOTIFY%
) || (
    %PROPY% %BUILDINGS%notify.py ": Failed QA of %BUILDINGFC% on %SDEFILE%" %NOTIFY%
) 
echo completed notifying the squad of %BUILDINGFC% QA results on %date% at %time% >> sample_maintain.log




-- 1. Manually create the badbbls version under the edit version
-- 2. Select and copy and paste-special buildings to be deleted 
--    from building to building_historic (layer not template option)
-- 3. Run this script
-- 4. Reconcile and post and delete the badbbls versions

call sde.version_util.set_current_version('badbbls');

--start editing
call sde.version_user_ddl.edit_version ('badbbls', 1);

update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2022 where doitt_id = 62762;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2022 where doitt_id = 67775;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2018 where doitt_id = 71332;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2022 where doitt_id = 117979;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2019 where doitt_id = 119378;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2019 where doitt_id = 134630;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2022 where doitt_id = 172093;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2020 where doitt_id = 174191; 
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2018 where doitt_id = 201419;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2021 where doitt_id = 226208;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2022 where doitt_id = 236813;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2022 where doitt_id = 244592;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2019 where doitt_id = 274729;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2020 where doitt_id = 275044;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2019 where doitt_id = 286586;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2020 where doitt_id = 329795;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2022 where doitt_id = 359899;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2019 where doitt_id = 361007;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2022 where doitt_id = 369022;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2022 where doitt_id = 402202;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2018 where doitt_id = 405259;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2018 where doitt_id = 431965;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2020 where doitt_id = 448052;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2019 where doitt_id = 449463;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2020 where doitt_id = 453776;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2022 where doitt_id = 456413;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2019 where doitt_id = 478605;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2015 where doitt_id = 517729;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2021 where doitt_id = 533023;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2020 where doitt_id = 536263;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2022 where doitt_id = 537217;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2019 where doitt_id = 541933;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2020 where doitt_id = 559298;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2022 where doitt_id = 569876;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2020 where doitt_id = 577280;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2019 where doitt_id = 579778;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2022 where doitt_id = 584223;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2020 where doitt_id = 584290;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2019 where doitt_id = 593850;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2022 where doitt_id = 598885;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2022 where doitt_id = 615591;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2022 where doitt_id = 629153;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2018 where doitt_id = 700514;
update bldg.building_historic_evw set last_status_type = 'Demolition', demolition_year = 2022 where doitt_id = 827702;

commit;

delete from bldg.building_evw where doitt_id = 62762;
delete from bldg.building_evw where doitt_id = 67775;
delete from bldg.building_evw where doitt_id = 71332;
delete from bldg.building_evw where doitt_id = 117979;
delete from bldg.building_evw where doitt_id = 119378;
delete from bldg.building_evw where doitt_id = 134630;
delete from bldg.building_evw where doitt_id = 172093;
delete from bldg.building_evw where doitt_id = 174191;
delete from bldg.building_evw where doitt_id = 201419;
delete from bldg.building_evw where doitt_id = 226208;
delete from bldg.building_evw where doitt_id = 236813;
delete from bldg.building_evw where doitt_id = 244592;
delete from bldg.building_evw where doitt_id = 274729;
delete from bldg.building_evw where doitt_id = 275044;
delete from bldg.building_evw where doitt_id = 286586;
delete from bldg.building_evw where doitt_id = 329795;
delete from bldg.building_evw where doitt_id = 359899;
delete from bldg.building_evw where doitt_id = 361007;
delete from bldg.building_evw where doitt_id = 369022;
delete from bldg.building_evw where doitt_id = 402202;
delete from bldg.building_evw where doitt_id = 405259;
delete from bldg.building_evw where doitt_id = 431965;
delete from bldg.building_evw where doitt_id = 448052;
delete from bldg.building_evw where doitt_id = 449463;
delete from bldg.building_evw where doitt_id = 453776;
delete from bldg.building_evw where doitt_id = 456413;
delete from bldg.building_evw where doitt_id = 478605;
delete from bldg.building_evw where doitt_id = 517729;
delete from bldg.building_evw where doitt_id = 533023;
delete from bldg.building_evw where doitt_id = 536263;
delete from bldg.building_evw where doitt_id = 537217;
delete from bldg.building_evw where doitt_id = 541933;
delete from bldg.building_evw where doitt_id = 559298;
delete from bldg.building_evw where doitt_id = 569876;
delete from bldg.building_evw where doitt_id = 577280;
delete from bldg.building_evw where doitt_id = 579778;
delete from bldg.building_evw where doitt_id = 584223;
delete from bldg.building_evw where doitt_id = 584290;
delete from bldg.building_evw where doitt_id = 593850;
delete from bldg.building_evw where doitt_id = 598885;
delete from bldg.building_evw where doitt_id = 615591;
delete from bldg.building_evw where doitt_id = 629153;
delete from bldg.building_evw where doitt_id = 700514;
delete from bldg.building_evw where doitt_id = 827702;


commit;

call sde.version_user_ddl.edit_version ('badbbls', 2);

--reconcile and post badbbls
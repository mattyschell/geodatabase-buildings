
--manually create badbbls version under edit version

call sde.version_util.set_current_version('badbbls');

--start editing
call sde.version_user_ddl.edit_version ('badbbls', 1);

update bldg.building_evw set base_bbl = 1013960048 where doitt_id = 25863;
update bldg.building_evw set base_bbl = 3086720033 where doitt_id = 28022;
update bldg.building_evw set base_bbl = 2032710150 where doitt_id = 28156;
update bldg.building_evw set base_bbl = 4161560128 where doitt_id = 29621;
update bldg.building_evw set base_bbl = 4102190102 where doitt_id = 33256;
update bldg.building_evw set base_bbl = 3026840116 where doitt_id = 41546;
update bldg.building_evw set base_bbl = 3056330034 where doitt_id = 41555;
update bldg.building_evw set base_bbl = 3023270023 where doitt_id = 46131;
update bldg.building_evw set base_bbl = 3023270023 where doitt_id = 47155;
update bldg.building_evw set base_bbl = 3002800015 where doitt_id = 49281;
update bldg.building_evw set base_bbl = 2024230038 where doitt_id = 54496;
update bldg.building_evw set base_bbl = 4035600029 where doitt_id = 55878;
update bldg.building_evw set base_bbl = 4096570001 where doitt_id = 58688;
update bldg.building_evw set base_bbl = 1015480146 where doitt_id = 58807;
update bldg.building_evw set base_bbl = 4025990085 where doitt_id = 60269;
update bldg.building_evw set base_bbl = 2050870001 where doitt_id = 63057;
update bldg.building_evw set base_bbl = 3041540028 where doitt_id = 64921;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 66334;
update bldg.building_evw set base_bbl = 5024500539 where doitt_id = 66581;
update bldg.building_evw set base_bbl = 4045400070 where doitt_id = 66730;
update bldg.building_evw set base_bbl = 3023260029 where doitt_id = 68742;
update bldg.building_evw set base_bbl = 3056490046 where doitt_id = 71107;
commit;


call sde.version_user_ddl.edit_version ('badbbls', 2);


--reconcile and post and delete badbbls 

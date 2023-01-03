
--manually create badbbls version under edit version

call sde.version_util.set_current_version('badbbls');

--start editing
call sde.version_user_ddl.edit_version ('badbbls', 1);

update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3013000007 where doitt_id = 680362;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1005050036 where doitt_id = 681631;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3032300006 where doitt_id = 684792;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3032700031 where doitt_id = 684832;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2022890013 where doitt_id = 685676;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2046920061 where doitt_id = 687808;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2025770063 where doitt_id = 689881;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4161560150 where doitt_id = 690793;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3012000027 where doitt_id = 694346;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3022600035 where doitt_id = 694368;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3086720033 where doitt_id = 694884;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3004620006 where doitt_id = 697043;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2027690170 where doitt_id = 697944;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1020300043 where doitt_id = 709534;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4101150053 where doitt_id = 709819;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3066550034 where doitt_id = 710172;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1006090039 where doitt_id = 711768;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3034570049 where doitt_id = 712852;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3023260041 where doitt_id = 713876;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5002000024 where doitt_id = 714247;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5080380010 where doitt_id = 716487;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3030740001 where doitt_id = 719801;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4161560143 where doitt_id = 723269;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4161560152 where doitt_id = 723792;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4028270053 where doitt_id = 723864;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3027390005 where doitt_id = 726354;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3026850054 where doitt_id = 732042;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1008910044 where doitt_id = 738120;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1006090039 where doitt_id = 738412;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4117090050 where doitt_id = 738491;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3056330034 where doitt_id = 740733;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3020200068 where doitt_id = 742046;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1013800017 where doitt_id = 742701;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3071590004 where doitt_id = 746436;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3004620012 where doitt_id = 746910;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3025230031 where doitt_id = 747439;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3023350006 where doitt_id = 747454;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4004020032 where doitt_id = 747494;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2027060082 where doitt_id = 747855;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3027720014 where doitt_id = 748185;

commit;

call sde.version_user_ddl.edit_version ('badbbls', 2);

--reconcile and post and delete badbbls 

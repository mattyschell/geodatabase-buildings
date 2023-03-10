--manually create badbblz version under edit version

-- comment this if not running from sqlplus
WHENEVER SQLERROR EXIT SQL.SQLCODE

begin
    sde.version_util.set_current_version ('badbblz');
exception 
    when others then
    raise;
end;
/


begin
    sde.version_user_ddl.edit_version ('badbblz', 1);
exception 
    when others then
    raise;
end;
/

update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2054160012 where doitt_id = 7734;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4035410054 where doitt_id = 29263;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3050990010 where doitt_id = 57188;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4123140144 where doitt_id = 91306;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3056510034 where doitt_id = 136483;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3051860016 where doitt_id = 181340;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3059180060 where doitt_id = 219032;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3023340020 where doitt_id = 238942;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3078990066 where doitt_id = 241036;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4003770001 where doitt_id = 245457;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4044400057 where doitt_id = 265109;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3068360045 where doitt_id = 294965;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5011270008 where doitt_id = 328925;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1005000036 where doitt_id = 339939;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3050990010 where doitt_id = 354411;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3081220053 where doitt_id = 357096;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3059180060 where doitt_id = 369866;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2056070072 where doitt_id = 455897;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4103020033 where doitt_id = 456468;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1006100025 where doitt_id = 517575;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1006340033 where doitt_id = 522573;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4098130011 where doitt_id = 650062;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1007310040 where doitt_id = 665212;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1007310040 where doitt_id = 679899;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3059180060 where doitt_id = 706038;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1007310040 where doitt_id = 717800;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3020030020 where doitt_id = 738367;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2028620090 where doitt_id = 773205;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3023340020 where doitt_id = 825291;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3051860016 where doitt_id = 831224;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4162820016 where doitt_id = 834809;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1018680038 where doitt_id = 859847;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2056070072 where doitt_id = 897405;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3052960013 where doitt_id = 962310;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3026550008 where doitt_id = 975488;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5062610005 where doitt_id = 1040482;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4153020200 where doitt_id = 1044234;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4098130011 where doitt_id = 1068673;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5075720061 where doitt_id = 1101267;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3000320012 where doitt_id = 1115803;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4153020200 where doitt_id = 1267140;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4038040164 where doitt_id = 1289954;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3018600002 where doitt_id = 1297687;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4055230120 where doitt_id = 1299032;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5032930030 where doitt_id = 1299183;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5032930030 where doitt_id = 1299190;

commit;

begin
    sde.version_user_ddl.edit_version ('badbblz', 2);
exception 
    when others then
    raise;
end;
/

--reconcile and post and delete badbbls 

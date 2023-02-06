--manually create badbblz version under edit version

-- comment this if not running from sqlplus
WHENEVER SQLERROR EXIT SQL.SQLCODE

begin
    sde.version_user_ddl.edit_version ('badbblz', 2);
exception 
    when others then
    raise;
end;
/

begin
    call sde.version_util.set_current_version('badbblz');
exception 
    when others then
    raise;
end;
/

begin
    call sde.version_user_ddl.edit_version ('badbblz', 1);
exception 
    when others then
    raise;
end;
/

update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2025230141 where doitt_id = 1100826;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4039000001 where doitt_id = 1105786;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1005050024 where doitt_id = 1108002;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2023890049 where doitt_id = 1108334;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1200909999 where doitt_id = 1110371;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1200929999 where doitt_id = 1110902;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3011400046 where doitt_id = 1118470;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2023710052 where doitt_id = 1154771;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5026290001 where doitt_id = 1155464;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5200149999 where doitt_id = 1161065;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4066050035 where doitt_id = 1165897;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4100270010 where doitt_id = 1172433;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5008540008 where doitt_id = 1186267;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3070900048 where doitt_id = 1187037;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3039460045 where doitt_id = 1188024;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2023140066 where doitt_id = 1192411;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4096150125 where doitt_id = 1207326;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2033040136 where doitt_id = 1209786;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5008540008 where doitt_id = 1214470;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4096150123 where doitt_id = 1215568;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4117900039 where doitt_id = 1215667;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3032520045 where doitt_id = 1223249;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2033440052 where doitt_id = 1225712;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3084110150 where doitt_id = 1227596;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4097360141 where doitt_id = 1228012;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4015910081 where doitt_id = 1228970;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3071590037 where doitt_id = 1231879;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1018190203 where doitt_id = 1233241;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3055010061 where doitt_id = 1234095;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3200109999 where doitt_id = 1234271;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5042640040 where doitt_id = 1234694;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5035880035 where doitt_id = 1236719;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3017620018 where doitt_id = 1240944;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4100270010 where doitt_id = 1242305;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3086670762 where doitt_id = 1242777;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4096150122 where doitt_id = 1243608;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3084110149 where doitt_id = 1249973;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4046870021 where doitt_id = 1254320;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4046870121 where doitt_id = 1254321;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4046870021 where doitt_id = 1254322;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4046870121 where doitt_id = 1254324;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4120760104 where doitt_id = 1259532;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4108290129 where doitt_id = 1261546;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4108290128 where doitt_id = 1261547;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4108290127 where doitt_id = 1261548;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4108290126 where doitt_id = 1261549;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3056330034 where doitt_id = 1261815;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3056330034 where doitt_id = 1261816;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4044870200 where doitt_id = 1268070;

commit;

begin
    call sde.version_user_ddl.edit_version ('badbblz', 2);
exception 
    when others then
    raise;
end;
/

--reconcile and post and delete badbbls 

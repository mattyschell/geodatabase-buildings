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

update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2027800002 where doitt_id = 1269007;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1021800027 where doitt_id = 1269449;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1018190203 where doitt_id = 1269695;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2028690053 where doitt_id = 1269784;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1018190040 where doitt_id = 1269787;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1018190040 where doitt_id = 1269838;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3007150001 where doitt_id = 1271144;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3007150001 where doitt_id = 1271558;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3044300001 where doitt_id = 1272043;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4033930062 where doitt_id = 1272139;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3066860048 where doitt_id = 1272478;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1011710154 where doitt_id = 1272858;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1007590026 where doitt_id = 1275797;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4115440100 where doitt_id = 1281115;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4115440100 where doitt_id = 1281116;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4115440100 where doitt_id = 1281117;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3072120006 where doitt_id = 1282766;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1012710050 where doitt_id = 1283376;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2024100044 where doitt_id = 1283848;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1008190039 where doitt_id = 1284577;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3001080009 where doitt_id = 1284730;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2052630348 where doitt_id = 1287329;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2052630352 where doitt_id = 1287330;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2052630345 where doitt_id = 1287332;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2052630347 where doitt_id = 1287333;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2052630351 where doitt_id = 1287334;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5005150098 where doitt_id = 1288283;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5031250003 where doitt_id = 1288568;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5008370302 where doitt_id = 1288675;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3011170001 where doitt_id = 1289122;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3067670077 where doitt_id = 1289420;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3051080061 where doitt_id = 1289422;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3066440075 where doitt_id = 1289625;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3057050056 where doitt_id = 1289736;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4163500400 where doitt_id = 1289867;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4033040164 where doitt_id = 1289954;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3044520281 where doitt_id = 1290340;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2028630017 where doitt_id = 1290524;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5077920317 where doitt_id = 1290670;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3032560001 where doitt_id = 1290738;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1008840112 where doitt_id = 1290745;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5056210036 where doitt_id = 1290865;
commit;

begin
    sde.version_user_ddl.edit_version ('badbblz', 2);
exception 
    when others then
    raise;
end;
/

--reconcile and post and delete badbbls 

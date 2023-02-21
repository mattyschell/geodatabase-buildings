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

update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5068960131 where doitt_id = 1290958;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3089070638 where doitt_id = 1290962;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5051200066 where doitt_id = 1291011;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5005270001 where doitt_id = 754086;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2025770063 where doitt_id = 756471;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3025620015 where doitt_id = 766311;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3056330034 where doitt_id = 769142;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3071310072 where doitt_id = 770841;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3008490040 where doitt_id = 773045;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5078900090 where doitt_id = 780546;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5026290001 where doitt_id = 781524;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3073230043 where doitt_id = 788189;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1017340001 where doitt_id = 791046;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3087160073 where doitt_id = 793385;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4101150053 where doitt_id = 797590;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1001670001 where doitt_id = 802547;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2033440084 where doitt_id = 806298;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4013200027 where doitt_id = 807923;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1015280045 where doitt_id = 814393;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3020730010 where doitt_id = 817653;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3062530028 where doitt_id = 1291017;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5077920441 where doitt_id = 1291043;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5003020011 where doitt_id = 1291108;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5038370032 where doitt_id = 1291122;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5061460152 where doitt_id = 1291135;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4044400021 where doitt_id = 1291403;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4044400021 where doitt_id = 1291404;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4052480036 where doitt_id = 1291458;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4076870062 where doitt_id = 1291538;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4163400050 where doitt_id = 1291636;                                                                      
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4163400050 where doitt_id = 1291637;                                                               
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4024440004 where doitt_id = 1291820;                                                               
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4163500400 where doitt_id = 1291983;                                                              
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4161560156 where doitt_id = 1292043;                                                              
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3072680213 where doitt_id = 1292438;                                                                   
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2023190160 where doitt_id = 1292490;                                                              
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3025320024 where doitt_id = 1292954;                                                                 
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3027710019 where doitt_id = 1293627;                                                              
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4000320035 where doitt_id = 1293629;                                                              
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4000320035 where doitt_id = 1293630;                                                              
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1021010055 where doitt_id = 1294178;                                                                 
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1021010055 where doitt_id = 1294179;                                                                 
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5011700020 where doitt_id = 1294584;                                                                       
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4094150077 where doitt_id = 1294633;                                                              
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3040620031 where doitt_id = 1294825;                                                                 
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 5001980068 where doitt_id = 1295281;                                                                 
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3013430003 where doitt_id = 1295415;                                                                 
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2054220036 where doitt_id = 1295897;                                                              
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2054220036 where doitt_id = 1295898;                                                              
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2054220036 where doitt_id = 1295899;                                                              
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2054220036 where doitt_id = 1295901;                                                              
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 1005650021 where doitt_id = 1295940;
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3023790035 where doitt_id = 1296119;                                                              
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 2046550008 where doitt_id = 1296759;                                                                 
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 3066180027 where doitt_id = 1297651;                                                                                                                       
update bldg.building_evw set mappluto_bbl = NULL, condo_flags = NULL, base_bbl = 4018609102 where doitt_id = 1297989; 
commit;

begin
    sde.version_user_ddl.edit_version ('badbblz', 2);
exception 
    when others then
    raise;
end;
/

--reconcile and post and delete badbbls 

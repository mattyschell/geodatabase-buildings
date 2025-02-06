create table 
    building_historic_bak
as 
select * from 
    building_historic;
truncate table 
    building_historic;
 --
ALTER TABLE 
    building_historic 
MODIFY
    (bin NUMBER(7,0));
ALTER TABLE 
    building_historic
MODIFY 
    (base_bbl NUMBER(10,0));
ALTER TABLE 
    building_historic
MODIFY 
    (mappluto_bbl NUMBER(10,0));
ALTER TABLE 
    building_historic
MODIFY 
    (height_roof NUMBER(4,0));
ALTER TABLE 
    building_historic
MODIFY 
    (construction_year NUMBER(4,0));
ALTER TABLE 
    building_historic
MODIFY 
    (ground_elevation NUMBER(4,0));
ALTER TABLE 
    building_historic
MODIFY 
    (alteration_year NUMBER(4,0));
ALTER TABLE 
    building_historic
MODIFY 
    (demolition_year NUMBER(4,0));
-- clean building_historic
update 
    building_historic_bak 
set 
    alteration_year = 2022
where 
    alteration_year in (20220,20221);
commit;
update 
    building_historic_bak 
set 
    alteration_year = 2007
where 
    alteration_year = 20007;
commit;
--
insert into 
    building_historic
select 
    objectid
   ,name
   ,bin
   ,base_bbl
   ,ceil(height_roof)
   ,geom_source
   ,last_status_type
   ,doitt_id
   ,construction_year
   ,demolition_year
   ,created_user
   ,created_date
   ,last_edited_user
   ,last_edited_date
   ,round(ground_elevation)
   ,feature_code
   ,mappluto_bbl
   ,alteration_year
   ,se_anno_cad_data
   ,globalid
   ,shape
from
    building_historic_bak;
commit;

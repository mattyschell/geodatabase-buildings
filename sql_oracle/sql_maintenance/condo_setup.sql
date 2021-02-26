-- exploratory
-- sets up local condo table
-- and some data to use in development when proving out the plan
create table condo (
   condo_base_bbl       varchar2(10)
  ,condo_billing_bbl    varchar2(10)
  ,PRIMARY KEY (condo_base_bbl, condo_billing_bbl)
);
--populate with some data like
--select 
--    distinct 'insert into condo values(''' || a.condo_base_bbl || ''',''' || a.condo_billing_bbl || ''');'
--from 
--    dof_taxmap.condo_evw a
--where 
--    a.condo_billing_bbl is not null
--and a.condo_base_bbl is not null
--order by 1

# WinRed 2023 Midyear Filing Queries 

## Single Values
ttl_raised_wr_2023_my<-
"select sum(contribution_amount) 
from winred_2023_my"

## Base Tables

wr_2023_toplines<-
"select 
  count(*) as n_contributions
  , count(distinct lower(contributor_last_name||', '||contributor_first_name||'.'||contributor_zip_code)) as n_donors
  , count(distinct lower(memo_text_description)) as n_committees
  , sum(contribution_amount) as amt_raised
  
  from winred_2023_my"

by_cmte_wr_2023_my<-
" with total_raised_in_filing as (
  select 
    'a' as join_col
    ,sum(contribution_amount) as total_raised 
    from winred_2023_my
    group by 1

), by_cmte as (

select
  'a' as join_col
  , wr.memo_text_description
  , wr.recipient_cmte_id as recipient_cmte_id
  , cmte.CMTE_nm as cmte_nm
  , cmte.CMTE_TP as cmte_tp
  , sum(wr.contribution_amount) as total_raised
  , min(wr.contribution_date) as first_contribution_date
  , max(wr.contribution_date) as last_contribution_date


from winred_2023_my as wr
left join committees_2024 as cmte on wr.recipient_cmte_id=cmte.CMTE_ID

group by 1,2,3,4,5
)

select 
    by_cmte.*
    , by_cmte.total_raised/total_raised_in_filing.total_raised as pct_filing
from by_cmte
left join total_raised_in_filing on by_cmte.join_col=total_raised_in_filing.join_col

group by 1,2,3,4,5
order by 6 desc
"

trump_my<-

"with dailys as 
(select
  wr.memo_text_description
  , wr.recipient_cmte_id
  , cmte.CMTE_NM
  , cmte.CMTE_TP
  , wr.contribution_date
  , sum(wr.contribution_amount) as total_raised


from winred_2023_my as wr
left join committees_2024 as cmte on wr.recipient_cmte_id=cmte.CMTE_ID

where cmte.CMTE_ID in ('C00828541','C00618371','C00618389','C00770941')

group by 1,2,3,4,5
order by 1,5 
)

select * from dailys"

wr_daily<-

"with dailys as 
(select
    wr.contribution_date
    , sum(wr.contribution_amount) as total_raised

from winred_2023_my as wr

group by 1
order by 1
)

select * from dailys"

trump_donor_occ_query<-"Select 
  upper(contributor_occupation) as occupation
  , count(distinct lower(contributor_first_name)||'.'||lower(contributor_last_name)||'.'||contributor_zip_code) as n_donors
 from winred_2023_my
 where recipient_cmte_id in ('C00618371','C00828541','C00618389','C00770941')
 group by 1
 order by 2 desc"
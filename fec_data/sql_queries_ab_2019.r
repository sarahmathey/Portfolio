# ActBlue 2019 Midyear Filing Queries

## Single Values
ttl_raised_ab_2019_my<-
"select sum(contribution_amount) 
from actblue_2019_my"

tips_raised_ab_2019_my<- 
"select sum(contribution_amount) 
 from actblue_2019_my 
 where memo_text_description='CONTRIBUTION TO ACTBLUE'"

## Base tables 

ab_2019_toplines<-
"select 
  count(*) as n_contributions
  , count(distinct lower(contributor_last_name||', '||contributor_first_name||'.'||contributor_zip_code)) as n_donors
  , count(distinct lower(memo_text_description)) as n_committees
  , sum(contribution_amount) as amt_raised
  
  from actblue_2019_my"

by_cmte_ab_2019_my<-
" with total_raised_in_filing as (
  select 
    'a' as join_col
    ,sum(contribution_amount) as total_raised 
    from actblue_2019_my
    group by 1

), by_cmte as (

select
  'a' as join_col
  , ab.memo_text_description
  , coalesce(ab.recipient_cmte_id,ab.recipient_cmte_id_clean) as recipient_cmte_id
  , case when cmte.CMTE_nm is null then ab.memo_text_description 
         else cmte.CMTE_NM end as cmte_nm
  /*Julian Castro, Beto O'Rourke, and Pete Buttigiege all redesignated their 
  presidential committees as PACs after dropping out of the 2020 race*/
  , case when cmte.CMTE_ID in ('C00697441','C00699090','C00693044') then 'P' 
         else cmte.CMTE_TP end as cmte_tp
  , sum(ab.contribution_amount) as total_raised
  , min(ab.contribution_date) as first_contribution_date
  , max(ab.contribution_date) as last_contribution_date

from actblue_2019_my as ab
left join committees_2020 as cmte on ab.recipient_cmte_id=cmte.CMTE_ID

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

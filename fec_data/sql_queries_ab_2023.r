# ActBlue 2023 Midyear Filing Queries

## Single Values
ttl_raised_ab_2023_my<-
"select sum(contribution_amount) 
from actblue_2023_my"
tips_raised_ab_2023_my<- 
"select sum(contribution_amount) 
from actblue_2023_my 
where memo_text_description='CONTRIBUTION TO ACTBLUE'"

## Base Tables

ab_2023_toplines<-
"select 
  count(*) as n_contributions
  , count(distinct lower(contributor_last_name||', '||contributor_first_name)) as n_donors
  , count(distinct lower(memo_text_description)) as n_committees
  , sum(contribution_amount) as amt_raised
  
  from actblue_2023_my"

by_cmte_ab_2023_my<-
" with total_raised_in_filing as (
  select 
    'a' as join_col
    , sum(contribution_amount) as total_raised 
    from actblue_2023_my
    group by 1

), by_cmte as (

select
  'a' as join_col
  , ab.memo_text_description
  , coalesce(ab.recipient_cmte_id,ab.recipient_cmte_id_clean) as recipient_cmte_id
  , case when cmte.CMTE_NM is null then ab.memo_text_description 
         else cmte.CMTE_nm end as cmte_nm
  , cmte.CMTE_TP as cmte_tp
  , sum(ab.contribution_amount) as total_raised
  , min(ab.contribution_date) as first_contribution_date
  , max(ab.contribution_date) as last_contribution_date


from actblue_2023_my as ab
left join committees_2024 as cmte on coalesce(ab.recipient_cmte_id,ab.recipient_cmte_id_clean)=cmte.CMTE_ID

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
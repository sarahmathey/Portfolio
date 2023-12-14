# mixed cycle
ab_pres_launches<-
"with dailys as 
(select
  ab.memo_text_description
  , coalesce(ab.recipient_cmte_id,ab.recipient_cmte_id_clean) as recipient_cmte_id
  , case when cmte.CMTE_NM is null then ab.memo_text_description 
         else cmte.CMTE_nm end as cmte_nm
  , cmte.CMTE_TP
  , ab.contribution_date
  , sum(ab.contribution_amount) as total_raised
  , min(ab.contribution_date) over (partition by ab.memo_text_description) as first_contribution_date

from actblue_2019_my as ab
left join committees_2020 as cmte on ab.recipient_cmte_id=cmte.CMTE_ID

where cmte.CMTE_TP='P'
or cmte.CMTE_ID in ('C00697441','C00699090','C00693044')

group by 1,2,3,4,5
having sum(ab.contribution_amount)>10000


union all

select
  ab.memo_text_description
  , coalesce(ab.recipient_cmte_id,ab.recipient_cmte_id_clean) as recipient_cmte_id
  , case when cmte.CMTE_NM then ab.memo_text_description 
         else cmte.CMTE_nm end as cmte_nm
  , cmte.CMTE_TP
  , ab.contribution_date
  , sum(ab.contribution_amount) as total_raised
  , min(ab.contribution_date) over (partition by ab.memo_text_description) as first_contribution_date

from actblue_2023_my as ab
left join committees_2024 as cmte on ab.recipient_cmte_id=cmte.CMTE_ID

where cmte.CMTE_TP='P'

group by 1,2,3,4,5
having sum(ab.contribution_amount)>10000
)

select * 
from dailys 
where contribution_date=first_contribution_date 
order by total_raised desc
"

biden_my<-

"with dailys as 
(select
  ab.memo_text_description
  , ab.recipient_cmte_id
  , cmte.CMTE_NM
  , cmte.CMTE_TP
  , ab.contribution_date
  , sum(ab.contribution_amount) as total_raised


from actblue_2019_my as ab
left join committees_2020 as cmte on ab.recipient_cmte_id=cmte.CMTE_ID

where cmte.CMTE_ID in ('C00703975','C00744946','C00838912')

group by 1,2,3,4,5

union all 

select
  ab.memo_text_description
  , ab.recipient_cmte_id
  , cmte.CMTE_NM
  , cmte.CMTE_TP
  , ab.contribution_date
  , sum(ab.contribution_amount) as total_raised

from actblue_2023_my as ab
left join committees_2024 as cmte on ab.recipient_cmte_id=cmte.CMTE_ID

where cmte.CMTE_ID in ('C00703975','C00744946','C00838912')

group by 1,2,3,4,5

)

select * from dailys"

ab_daily<-

"with dailys as 
(select
   ab.contribution_date
  , sum(ab.contribution_amount) as total_raised

from actblue_2019_my as ab

group by 1

union all 

select
   ab.contribution_date
  , sum(ab.contribution_amount) as total_raised

from actblue_2023_my as ab

group by 1

)

select * from dailys"

cmte_top_days<-

"with dailys as 
(select
  ab.memo_text_description
  , coalesce(ab.recipient_cmte_id, ab.recipient_cmte_id_clean) as recipient_cmte_id
  , case when cmte.CMTE_NM is null then ab.memo_text_description
         else cmte.CMTE_nm end as cmte_nm
  , cmte.CMTE_TP
  , ab.contribution_date
  , sum(ab.contribution_amount) as total_raised
  , rank() over (partition by ab.memo_text_description order by sum(ab.contribution_amount) desc) as rank_


from actblue_2023_my as ab
left join committees_2024 as cmte on ab.recipient_cmte_id=cmte.CMTE_ID

group by 1,2,3,4,5


union all

select
  wr.memo_text_description
  , wr.recipient_cmte_id as recipient_cmte_id
  , cmte.CMTE_NM as cmte_nm
  , cmte.CMTE_TP
  , wr.contribution_date
  , sum(wr.contribution_amount) as total_raised
  , rank() over (partition by wr.memo_text_description order by sum(wr.contribution_amount) desc) as rank_


from winred_2023_my as wr
left join committees_2024 as cmte on wr.recipient_cmte_id=cmte.CMTE_ID

group by 1,2,3,4,5

)

select * from dailys where rank_=1 order by total_raised desc 
"

cmte_first_days<-

"with dailys as 
(select
  ab.memo_text_description
  , coalesce(ab.recipient_cmte_id, ab.recipient_cmte_id_clean) as recipient_cmte_id
  , case when cmte.CMTE_NM is null then ab.memo_text_description 
         else cmte.CMTE_nm end as cmte_nm
  , cmte.CMTE_TP
  , ab.contribution_date
  , sum(ab.contribution_amount) as total_raised
  , min(ab.contribution_date) over (partition by ab.memo_text_description) as first_contribution_date


from actblue_2023_my as ab
left join committees_2024 as cmte on ab.recipient_cmte_id=cmte.CMTE_ID

group by 1,2,3,4,5
having sum(ab.contribution_amount)>5000


union all

select
  wr.memo_text_description
  , wr.recipient_cmte_id as recipient_cmte_id
  , cmte.CMTE_NM as cmte_nm
  , cmte.CMTE_TP
  , wr.contribution_date
  , sum(wr.contribution_amount) as total_raised
  , min(wr.contribution_date) over (partition by wr.memo_text_description) as first_contribution_date


from winred_2023_my as wr
left join committees_2024 as cmte on wr.recipient_cmte_id=cmte.CMTE_ID

group by 1,2,3,4,5
having sum(wr.contribution_amount)>5000

)

select * from dailys where first_contribution_date=contribution_date order by total_raised desc 
"
select date_format(출발시간,'%Y-%m-%d') as '출발일', count(*) from ticket_view tv group by date_format(출발시간,'%Y-%m-%d') order by 출발시간;

select 예약자, 기차정보 
from ticket_view tv 
where 기차정보 like '누리호%';

select 예약자, convert(출발시간,char(10)) as 출발일, 출발역 
from ticket_view tv 
where 출발역 = '부산역';

select convert(출발시간,char(10)) as 출발일, count(*) as 건수, sum(할인가격) as 매출액 
from ticket_view tv 
group by convert(출발시간,char(10)) 
order by 출발시간;

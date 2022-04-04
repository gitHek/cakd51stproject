drop table purbyyear;
drop table pur14r;
drop table pur15;
drop table purbygap;


CREATE TABLE purbyyear AS
SELECT 고객번호, YEAR, SUM(구매금액) 구매액
FROM purprod2
GROUP BY 고객번호, YEAR
ORDER BY 고객번호;

create table pur14 as
select 고객번호, year ,구매액
from purbyyear
where year = 2014
order by 고객번호;

create table pur15 as
select 고객번호, year ,구매액
from purbyyear
where year = 2015
order by 고객번호;


-- 성별에 따른 구매 감소고객 수 및 성별전체대비 비율
-- 여성 7083명, 남성 1602명
-- 여성 44.55% , 남성 45.97%

select a.성별,감소 감소고객수,round(감소/전체*100,2) 비율
from (select 성별, count(고객번호) 전체 from custdemo
group by 성별
order by 성별) a
join 
(select 성별,count(고객번호) 감소 from custdemo
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%')
group by 성별
order by 성별) b on a.성별 = b.성별;

-- 30대 이상 여성의 전체구매감소고객증감 대비 구매감소량 : 약 77.57% 전체 대비 비율 : 10.77%
select "30대이상여성감고고객",전체구매감소고객,round("30대이상여성감고고객"/전체구매감소고객,4)*100 비율 ,
(select sum(구매금액) from purprod2 where year = 2015) "2015전체매출",
round(abs("30대이상여성감고고객")/(select sum(구매금액) from purprod2 where year = 2015)*100,2) "매출대비비율"
from
(select
((select sum(구매금액) from purprod2 p
join custdemo c on p.고객번호 = c.고객번호
where p.고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2015 
and 성별 = 'F' and 연령대 not in ('19세이하','20세~24세','25세~29세'))
-
(select sum(구매금액) from purprod2 p
join custdemo c on p.고객번호 = c.고객번호
where p.고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2014 
and 성별 = 'F' and 연령대 not in ('19세이하','20세~24세','25세~29세'))) "30대이상여성감고고객"
,
((select sum(구매금액) from purprod2 
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2015)
-
(select sum(구매금액) from purprod2
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2014)) "전체구매감소고객"
from dual);

-- 30대 ~ 40대 여성의 전체구매감소고객증감 대비 구매감소량 : 약 46.24% , 전체 매출대비 비율 : 7.1%
select "30대~40대여성감고고객",전체구매감소고객,round("30대~40대여성감고고객"/전체구매감소고객,4)*100 비율,
(select sum(구매금액) from purprod where year = 2015) "2015전체매출",
round(abs("30대~40대여성감고고객")/(select sum(구매금액) from purprod where year = 2015)*100,2) "매출대비비율"
from
(select
((select sum(구매금액) from purprod p
join custdemo c on p.고객번호 = c.고객번호
where p.고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2015 
and 성별 = 'F' and 연령대 in ('30세~34세','35세~39세','40세~44세','45세~49세'))
-
(select sum(구매금액) from purprod p
join custdemo c on p.고객번호 = c.고객번호
where p.고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2014 
and 성별 = 'F' and 연령대 in ('30세~34세','35세~39세','40세~44세','45세~49세'))) "30대~40대여성감고고객"
,
((select sum(구매금액) from purprod 
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2015)
-
(select sum(구매금액) from purprod 
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2014)) "전체구매감소고객"
from dual);


-- 전체구매감소고객의 구매감소량의 전체 매출대비 비율 : 15.35%

select 전체구매감소고객,
(select sum(구매금액) from purprod where year = 2015) "2015전체매출",
round(abs("전체구매감소고객")/(select sum(구매금액) from purprod where year = 2015)*100,2) "매출대비비율"
from
(select
((select sum(구매금액) from purprod 
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2015)
-
(select sum(구매금액) from purprod 
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2014)) "전체구매감소고객"
from dual);

-- 방문빈도수를 구간별로 나눈 최대값

select 구간,max(빈도) from(
select ntile(100) over (order by 빈도) as 구간, 고객번호, 빈도 from(
select 고객번호, count(*) 빈도 from(
select c.고객번호,구매일자,count(*) "빈도" from custdemo c
join purprod2 p on c.고객번호 = p.고객번호(+)
group by c.고객번호,구매일자
order by c.고객번호)
group by 고객번호
order by 고객번호))
group by 구간
order by 구간;

-- 최근방문일를 구간별로 나눈 최대값

select 구간, max(최근구매일) from(
select ntile(100) over(order by 최근구매일) as 구간,고객번호,최근구매일 from(
select c.고객번호 , max(구매일자) 최근구매일 from purprod2 p
join custdemo c on c.고객번호 = p.고객번호
group by c.고객번호))
group by 구간
order by 구간;

-- 총 구매액을 구간별로 나눈 최대값

select 구간, max(총구매액) from(
select ntile(100) over(order by 총구매액) as 구간,고객번호,총구매액 from(
select c.고객번호 , max(구매금액) 총구매액 from purprod2 p
join custdemo c on c.고객번호 = p.고객번호
group by c.고객번호))
group by 구간
order by 구간;

-- 분기별 라벨 붙이기
create table purprod3 as
(SELECT 제휴사,영수증번호,소분류코드,소분류명,통합분류,소비재분류,고객번호,점포코드,구매일자,구매시간,구매금액,year,월,
CASE WHEN 구매일자 > 20150931 then 'Q8'
WHEN 구매일자 > 20150631 then 'Q7'
WHEN 구매일자 > 20150331 then 'Q6'
WHEN 구매일자 > 20141231 then 'Q5'
WHEN 구매일자 > 20140931 then 'Q4'
WHEN 구매일자 > 20140631 then 'Q3'
WHEN 구매일자 > 20140331 then 'Q2' 
ELSE 'Q1' END AS 분기
FROM purprod2);


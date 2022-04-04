SELECT COUNT(*) FROM PURPROD;
SELECT * FROM CUSTDEMO;
-- 2014년 2015년 사이의 4개 회사 구매 데이터

-- 고객 속성정보 : 19383명(고객 수)
SELECT * FROM CUSTDEMO;
SELECT COUNT(*) FROM CUSTDEMO;


SELECT * FROM COMPET;
SELECT * FROM CHANNEL;
SELECT * FROM MEMBERSHIP;
SELECT * FROM PRODCL;   
SELECT * FROM PURPROD;


 
-- 구매 분석 (매출 분석)
SELECT YEAR, ROUND(SUM(구매금액)) 총금액,ROUND(AVG(구매금액)) 평균구매액
FROM PURPROD
GROUP BY YEAR;

--# 고객 속성
-- 성별, 연령별, 거주지별 다양한 조합별 매출 변화
-- 경쟁사 이용, 멤버십 이용, 온라인 채널에 대한 매출 특이성

--# 구매행동 패턴의 변화
-- 다양한 고객 유형별 구매 증감, 상품 구매 패턴, 구매 형태(시간, 장소 등) 

--# 유통 환경에 대한 이해(도메인)


CREATE TABLE pur_amt AS
SELECT 고객번호 cusno, sum(구매금액) as puramt 
FROM purprod
GROUP BY 고객번호
ORDER BY 고객번호;

ALTER TABLE PURPROD ADD YEAR NUMBER;
UPDATE purprod SET
YEAR = substr(구매일자,1,4);
COMMIT;

ALTER TABLE PURPROD ADD 월 NUMBER;
UPDATE purprod SET
월 = substr(구매일자,5,2);
COMMIT;

select * from purprod;

CREATE TABLE purbyyear AS
SELECT 고객번호, YEAR, SUM(구매금액) 구매액
FROM purprod
GROUP BY 고객번호, YEAR
ORDER BY 고객번호;

SELECT * FROM purbyyear;

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

create table purbygap as
select pur14.고객번호,nvl(pur15.구매액,0)-nvl(pur14.구매액,0) 차이
from pur14
join pur15 on pur14.고객번호 = pur15.고객번호;

select count(*) from purbygap
where 차이 like '-%';

select count(*) from purbygap_old
where 차이 like '-%';




---------------------------------
select 연령대,count(*) from custdemo
group by 연령대
order by 연령대;

select * from (select 고객번호,count(*) from compet
group by 고객번호
order by count(*) desc)
where rownum <=3500;

select round(avg(차이)) from purbygap
where 고객번호 in (select * from (select 고객번호 from compet
group by 고객번호
order by count(*) desc)
where rownum <=200);

select count(차이) from purbygap
where 고객번호 in (select * from (select 고객번호 from compet
group by 고객번호
order by count(*) desc)
where rownum <=2000) and 차이 like '-%';


select round(avg(차이)) from purbygap;
select count(차이) from purbygap
where 차이 like '-%';


select 연령대,round(avg(차이)) from purbygap
join custdemo on custdemo.고객번호 = purbygap.고객번호
where custdemo.성별 = 'F'
group by 연령대;

select 연령대,round(avg(차이)) from purbygap
join custdemo on custdemo.고객번호 = purbygap.고객번호
where custdemo.성별 = 'M'
group by 연령대;

select 소분류명,count(*) from purprod
join prodcl on purprod.소분류코드=prodcl.소분류코드 
join custdemo on custdemo.고객번호 = purprod.고객번호
where purprod.고객번호 in(select 고객번호 from (select compet.고객번호,count(*) from compet
group by compet.고객번호
order by count(*) desc)
where rownum <=100)
group by 소분류명
order by count(*) desc;

select 중분류명,count(*) from purprod
join prodcl on purprod.소분류코드=prodcl.소분류코드 
join custdemo on custdemo.고객번호 = purprod.고객번호
where purprod.고객번호 in(select 고객번호 from (select compet.고객번호,count(*) from compet
group by compet.고객번호
order by count(*) desc)
where rownum <=100)
group by 중분류명
order by count(*) desc;

select 횟수,count(*) from (select 고객번호,count(*) 횟수 from compet
group by 고객번호
order by 횟수 desc)
where rownum <=1000
group by 횟수
order by 횟수;


select * from (select 고객번호,count(*) from compet
group by 고객번호
order by count(*) desc)
where rownum <=3500;

select count(*) from membership
where 고객번호 in (select 고객번호 from (select compet.고객번호,count(*) from compet
group by compet.고객번호
order by count(*) desc)
where rownum <=7000);

-- 거주지역에 따라 매출이 감소한곳이 존재하긴 함
select 거주지역,round(avg(차이)) 차이 from purbygap
join custdemo on custdemo.고객번호 = purbygap.고객번호
group by 거주지역
order by 차이;

select 거주지역,count(*) from custdemo
group by 거주지역
order by 거주지역;

select 중분류명,count(*) from purprod
join prodcl on purprod.소분류코드=prodcl.소분류코드 
join custdemo on custdemo.고객번호 = purprod.고객번호
where custdemo.거주지역 = '079'
group by 중분류명
order by count(*) desc;

select 소분류명,count(*) from purprod
join prodcl on purprod.소분류코드=prodcl.소분류코드 
join custdemo on custdemo.고객번호 = purprod.고객번호
where custdemo.거주지역 = '079' and year = 2014
group by 소분류명
order by count(*) desc;

select 소분류명,count(*) from purprod
join prodcl on purprod.소분류코드=prodcl.소분류코드 
join custdemo on custdemo.고객번호 = purprod.고객번호
where custdemo.거주지역 = '079' and year = 2015
group by 소분류명
order by count(*) desc;

select avg(횟수) from (select custdemo.고객번호,count(*) 횟수 from compet
join custdemo on custdemo.고객번호 = compet.고객번호(+)
where 거주지역 = '079'
group by custdemo.고객번호);

select custdemo.고객번호,count(*) 횟수 from compet
join custdemo on custdemo.고객번호 = compet.고객번호(+)
where 거주지역 = '079'
group by custdemo.고객번호;

select custdemo.고객번호,compet."경쟁사" from compet
join custdemo on custdemo.고객번호 = compet.고객번호(+)
where 거주지역 = '079';

select 고객번호 from custdemo
where 거주지역 = '079';

select 고객번호,count(영수증번호) from (select distinct 영수증번호, 고객번호 from purprod)
where 고객번호 in (select * from (select 고객번호 from compet
group by 고객번호
order by count(*) desc)
where rownum <=1000)
group by 고객번호;

select avg(방문횟수) from (select 고객번호,count(영수증번호) 방문횟수 from (select distinct 영수증번호, 고객번호 from purprod)
where 고객번호 in (select * from (select 고객번호 from compet
group by 고객번호
order by count(*) desc)
where rownum <=1000)
group by 고객번호);

-- 경쟁매장 방문 상위 1000명의 우리 제휴사 방문횟수 평균 576.019

select count(영수증번호) from (select distinct 영수증번호, 고객번호 from purprod);

select * from custdemo;
select * from compet;
select * from purbygap;

select 제휴사 ,year, sum(구매금액) from purprod
group by 제휴사, year
order by 제휴사,year;

select year,월, sum(구매금액) from purprod p
join custdemo d on p.고객번호 = d.고객번호
where 거주지역 = '079'
group by year,월
order by year,월;

select year,월, sum(구매금액) from purprod p
join custdemo d on p.고객번호 = d.고객번호
where 거주지역 = '079'
group by year,월
order by year,월;
-- 2014년 5월과 2014년 9월 이후로 매출이 눈에 띄게 감소함
-- 

select year,월, round(avg(구매금액)) from purprod p
join custdemo d on p.고객번호 = d.고객번호
where 거주지역 = '079'
group by year,월
order by year,월;

select * from membership
order by 가입년월;

-- 통합분류별 구매감소고객의 2014년 대비 2015년 증감액 구하기

create table gapbytong14 as 
select 통합분류, sum(구매금액) 총구매금액 from purprod p
join prodcl_new c on c.소분류코드 = p.소분류코드
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2014
group by 통합분류
order by 총구매금액 desc;

create table gapbytong15 as 
select 통합분류, sum(구매금액) 총구매금액 from purprod p
join prodcl_new c on c.소분류코드 = p.소분류코드
where 고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2015
group by 통합분류
order by 총구매금액 desc;


select g4.통합분류, g5."총구매금액"-g4."총구매금액" 증감 from gapbytong14 g4
join gapbytong15 g5 on g4.통합분류 = g5.통합분류
order by 증감;

-- 통합분류별 성별별 2014년대비 2015년도 구매감소고객매출 증감액

select 통합분류, sum(구매금액) 총구매금액 from purprod p
join prodcl_new c on c.소분류코드 = p.소분류코드
join custdemo d on d.고객번호 = p.고객번호
where p.고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2015 and 성별 = 'F'
group by 통합분류
order by 총구매금액 desc;

select g4.통합분류,nvl(g5."총구매금액",0)-nvl(g4."총구매금액",0) 증감 from
(select 통합분류, sum(구매금액) 총구매금액 from purprod p
join prodcl_new c on c.소분류코드 = p.소분류코드
join custdemo d on d.고객번호 = p.고객번호
where p.고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2014 and 성별 = 'M'
group by 통합분류
order by 총구매금액 desc) g4
join (select 통합분류, sum(구매금액) 총구매금액 from purprod p
join prodcl_new c on c.소분류코드 = p.소분류코드
join custdemo d on d.고객번호 = p.고객번호
where p.고객번호 in (select 고객번호 from purbygap where 차이 like '-%') and year = 2015 and 성별 = 'M'
group by 통합분류
order by 총구매금액 desc) g5 on g4.통합분류 = g5.통합분류
order by 증감;


select 제휴사,멤버십명,sum(구매금액) from purprod p
join membership m on m.고객번호 = p.고객번호
group by 제휴사,멤버십명
order by 제휴사,sum(구매금액) desc;

select 멤버십명,count(*) from membership
group by 멤버십명;

select count(고객번호) from (select 고객번호, count(멤버십명) from membership
group by 고객번호
order by count(멤버십명) desc);
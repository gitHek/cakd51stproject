SELECT COUNT(*) FROM PURPROD;
SELECT * FROM CUSTDEMO;
-- 2014�� 2015�� ������ 4�� ȸ�� ���� ������

-- �� �Ӽ����� : 19383��(�� ��)
SELECT * FROM CUSTDEMO;
SELECT COUNT(*) FROM CUSTDEMO;


SELECT * FROM COMPET;
SELECT * FROM CHANNEL;
SELECT * FROM MEMBERSHIP;
SELECT * FROM PRODCL;   
SELECT * FROM PURPROD;


 
-- ���� �м� (���� �м�)
SELECT YEAR, ROUND(SUM(���űݾ�)) �ѱݾ�,ROUND(AVG(���űݾ�)) ��ձ��ž�
FROM PURPROD
GROUP BY YEAR;

--# �� �Ӽ�
-- ����, ���ɺ�, �������� �پ��� ���պ� ���� ��ȭ
-- ����� �̿�, ����� �̿�, �¶��� ä�ο� ���� ���� Ư�̼�

--# �����ൿ ������ ��ȭ
-- �پ��� �� ������ ���� ����, ��ǰ ���� ����, ���� ����(�ð�, ��� ��) 

--# ���� ȯ�濡 ���� ����(������)


CREATE TABLE pur_amt AS
SELECT ����ȣ cusno, sum(���űݾ�) as puramt 
FROM purprod
GROUP BY ����ȣ
ORDER BY ����ȣ;

ALTER TABLE PURPROD ADD YEAR NUMBER;
UPDATE purprod SET
YEAR = substr(��������,1,4);
COMMIT;

ALTER TABLE PURPROD ADD �� NUMBER;
UPDATE purprod SET
�� = substr(��������,5,2);
COMMIT;

select * from purprod;

CREATE TABLE purbyyear AS
SELECT ����ȣ, YEAR, SUM(���űݾ�) ���ž�
FROM purprod
GROUP BY ����ȣ, YEAR
ORDER BY ����ȣ;

SELECT * FROM purbyyear;

create table pur14 as
select ����ȣ, year ,���ž�
from purbyyear
where year = 2014
order by ����ȣ;

create table pur15 as
select ����ȣ, year ,���ž�
from purbyyear
where year = 2015
order by ����ȣ;

create table purbygap as
select pur14.����ȣ,nvl(pur15.���ž�,0)-nvl(pur14.���ž�,0) ����
from pur14
join pur15 on pur14.����ȣ = pur15.����ȣ;

select count(*) from purbygap
where ���� like '-%';

select count(*) from purbygap_old
where ���� like '-%';




---------------------------------
select ���ɴ�,count(*) from custdemo
group by ���ɴ�
order by ���ɴ�;

select * from (select ����ȣ,count(*) from compet
group by ����ȣ
order by count(*) desc)
where rownum <=3500;

select round(avg(����)) from purbygap
where ����ȣ in (select * from (select ����ȣ from compet
group by ����ȣ
order by count(*) desc)
where rownum <=200);

select count(����) from purbygap
where ����ȣ in (select * from (select ����ȣ from compet
group by ����ȣ
order by count(*) desc)
where rownum <=2000) and ���� like '-%';


select round(avg(����)) from purbygap;
select count(����) from purbygap
where ���� like '-%';


select ���ɴ�,round(avg(����)) from purbygap
join custdemo on custdemo.����ȣ = purbygap.����ȣ
where custdemo.���� = 'F'
group by ���ɴ�;

select ���ɴ�,round(avg(����)) from purbygap
join custdemo on custdemo.����ȣ = purbygap.����ȣ
where custdemo.���� = 'M'
group by ���ɴ�;

select �Һз���,count(*) from purprod
join prodcl on purprod.�Һз��ڵ�=prodcl.�Һз��ڵ� 
join custdemo on custdemo.����ȣ = purprod.����ȣ
where purprod.����ȣ in(select ����ȣ from (select compet.����ȣ,count(*) from compet
group by compet.����ȣ
order by count(*) desc)
where rownum <=100)
group by �Һз���
order by count(*) desc;

select �ߺз���,count(*) from purprod
join prodcl on purprod.�Һз��ڵ�=prodcl.�Һз��ڵ� 
join custdemo on custdemo.����ȣ = purprod.����ȣ
where purprod.����ȣ in(select ����ȣ from (select compet.����ȣ,count(*) from compet
group by compet.����ȣ
order by count(*) desc)
where rownum <=100)
group by �ߺз���
order by count(*) desc;

select Ƚ��,count(*) from (select ����ȣ,count(*) Ƚ�� from compet
group by ����ȣ
order by Ƚ�� desc)
where rownum <=1000
group by Ƚ��
order by Ƚ��;


select * from (select ����ȣ,count(*) from compet
group by ����ȣ
order by count(*) desc)
where rownum <=3500;

select count(*) from membership
where ����ȣ in (select ����ȣ from (select compet.����ȣ,count(*) from compet
group by compet.����ȣ
order by count(*) desc)
where rownum <=7000);

-- ���������� ���� ������ �����Ѱ��� �����ϱ� ��
select ��������,round(avg(����)) ���� from purbygap
join custdemo on custdemo.����ȣ = purbygap.����ȣ
group by ��������
order by ����;

select ��������,count(*) from custdemo
group by ��������
order by ��������;

select �ߺз���,count(*) from purprod
join prodcl on purprod.�Һз��ڵ�=prodcl.�Һз��ڵ� 
join custdemo on custdemo.����ȣ = purprod.����ȣ
where custdemo.�������� = '079'
group by �ߺз���
order by count(*) desc;

select �Һз���,count(*) from purprod
join prodcl on purprod.�Һз��ڵ�=prodcl.�Һз��ڵ� 
join custdemo on custdemo.����ȣ = purprod.����ȣ
where custdemo.�������� = '079' and year = 2014
group by �Һз���
order by count(*) desc;

select �Һз���,count(*) from purprod
join prodcl on purprod.�Һз��ڵ�=prodcl.�Һз��ڵ� 
join custdemo on custdemo.����ȣ = purprod.����ȣ
where custdemo.�������� = '079' and year = 2015
group by �Һз���
order by count(*) desc;

select avg(Ƚ��) from (select custdemo.����ȣ,count(*) Ƚ�� from compet
join custdemo on custdemo.����ȣ = compet.����ȣ(+)
where �������� = '079'
group by custdemo.����ȣ);

select custdemo.����ȣ,count(*) Ƚ�� from compet
join custdemo on custdemo.����ȣ = compet.����ȣ(+)
where �������� = '079'
group by custdemo.����ȣ;

select custdemo.����ȣ,compet."�����" from compet
join custdemo on custdemo.����ȣ = compet.����ȣ(+)
where �������� = '079';

select ����ȣ from custdemo
where �������� = '079';

select ����ȣ,count(��������ȣ) from (select distinct ��������ȣ, ����ȣ from purprod)
where ����ȣ in (select * from (select ����ȣ from compet
group by ����ȣ
order by count(*) desc)
where rownum <=1000)
group by ����ȣ;

select avg(�湮Ƚ��) from (select ����ȣ,count(��������ȣ) �湮Ƚ�� from (select distinct ��������ȣ, ����ȣ from purprod)
where ����ȣ in (select * from (select ����ȣ from compet
group by ����ȣ
order by count(*) desc)
where rownum <=1000)
group by ����ȣ);

-- ������� �湮 ���� 1000���� �츮 ���޻� �湮Ƚ�� ��� 576.019

select count(��������ȣ) from (select distinct ��������ȣ, ����ȣ from purprod);

select * from custdemo;
select * from compet;
select * from purbygap;

select ���޻� ,year, sum(���űݾ�) from purprod
group by ���޻�, year
order by ���޻�,year;

select year,��, sum(���űݾ�) from purprod p
join custdemo d on p.����ȣ = d.����ȣ
where �������� = '079'
group by year,��
order by year,��;

select year,��, sum(���űݾ�) from purprod p
join custdemo d on p.����ȣ = d.����ȣ
where �������� = '079'
group by year,��
order by year,��;
-- 2014�� 5���� 2014�� 9�� ���ķ� ������ ���� ��� ������
-- 

select year,��, round(avg(���űݾ�)) from purprod p
join custdemo d on p.����ȣ = d.����ȣ
where �������� = '079'
group by year,��
order by year,��;

select * from membership
order by ���Գ��;

-- ���պз��� ���Ű��Ұ��� 2014�� ��� 2015�� ������ ���ϱ�

create table gapbytong14 as 
select ���պз�, sum(���űݾ�) �ѱ��űݾ� from purprod p
join prodcl_new c on c.�Һз��ڵ� = p.�Һз��ڵ�
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2014
group by ���պз�
order by �ѱ��űݾ� desc;

create table gapbytong15 as 
select ���պз�, sum(���űݾ�) �ѱ��űݾ� from purprod p
join prodcl_new c on c.�Һз��ڵ� = p.�Һз��ڵ�
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2015
group by ���պз�
order by �ѱ��űݾ� desc;


select g4.���պз�, g5."�ѱ��űݾ�"-g4."�ѱ��űݾ�" ���� from gapbytong14 g4
join gapbytong15 g5 on g4.���պз� = g5.���պз�
order by ����;

-- ���պз��� ������ 2014���� 2015�⵵ ���Ű��Ұ����� ������

select ���պз�, sum(���űݾ�) �ѱ��űݾ� from purprod p
join prodcl_new c on c.�Һз��ڵ� = p.�Һз��ڵ�
join custdemo d on d.����ȣ = p.����ȣ
where p.����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2015 and ���� = 'F'
group by ���պз�
order by �ѱ��űݾ� desc;

select g4.���պз�,nvl(g5."�ѱ��űݾ�",0)-nvl(g4."�ѱ��űݾ�",0) ���� from
(select ���պз�, sum(���űݾ�) �ѱ��űݾ� from purprod p
join prodcl_new c on c.�Һз��ڵ� = p.�Һз��ڵ�
join custdemo d on d.����ȣ = p.����ȣ
where p.����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2014 and ���� = 'M'
group by ���պз�
order by �ѱ��űݾ� desc) g4
join (select ���պз�, sum(���űݾ�) �ѱ��űݾ� from purprod p
join prodcl_new c on c.�Һз��ڵ� = p.�Һз��ڵ�
join custdemo d on d.����ȣ = p.����ȣ
where p.����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2015 and ���� = 'M'
group by ���պз�
order by �ѱ��űݾ� desc) g5 on g4.���պз� = g5.���պз�
order by ����;


select ���޻�,����ʸ�,sum(���űݾ�) from purprod p
join membership m on m.����ȣ = p.����ȣ
group by ���޻�,����ʸ�
order by ���޻�,sum(���űݾ�) desc;

select ����ʸ�,count(*) from membership
group by ����ʸ�;

select count(����ȣ) from (select ����ȣ, count(����ʸ�) from membership
group by ����ȣ
order by count(����ʸ�) desc);
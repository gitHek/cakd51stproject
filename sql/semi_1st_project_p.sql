drop table purbyyear;
drop table pur14r;
drop table pur15;
drop table purbygap;


CREATE TABLE purbyyear AS
SELECT ����ȣ, YEAR, SUM(���űݾ�) ���ž�
FROM purprod2
GROUP BY ����ȣ, YEAR
ORDER BY ����ȣ;

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


-- ������ ���� ���� ���Ұ� �� �� ������ü��� ����
-- ���� 7083��, ���� 1602��
-- ���� 44.55% , ���� 45.97%

select a.����,���� ���Ұ���,round(����/��ü*100,2) ����
from (select ����, count(����ȣ) ��ü from custdemo
group by ����
order by ����) a
join 
(select ����,count(����ȣ) ���� from custdemo
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%')
group by ����
order by ����) b on a.���� = b.����;

-- 30�� �̻� ������ ��ü���Ű��Ұ����� ��� ���Ű��ҷ� : �� 77.57% ��ü ��� ���� : 10.77%
select "30���̻󿩼������",��ü���Ű��Ұ�,round("30���̻󿩼������"/��ü���Ű��Ұ�,4)*100 ���� ,
(select sum(���űݾ�) from purprod2 where year = 2015) "2015��ü����",
round(abs("30���̻󿩼������")/(select sum(���űݾ�) from purprod2 where year = 2015)*100,2) "���������"
from
(select
((select sum(���űݾ�) from purprod2 p
join custdemo c on p.����ȣ = c.����ȣ
where p.����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2015 
and ���� = 'F' and ���ɴ� not in ('19������','20��~24��','25��~29��'))
-
(select sum(���űݾ�) from purprod2 p
join custdemo c on p.����ȣ = c.����ȣ
where p.����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2014 
and ���� = 'F' and ���ɴ� not in ('19������','20��~24��','25��~29��'))) "30���̻󿩼������"
,
((select sum(���űݾ�) from purprod2 
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2015)
-
(select sum(���űݾ�) from purprod2
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2014)) "��ü���Ű��Ұ�"
from dual);

-- 30�� ~ 40�� ������ ��ü���Ű��Ұ����� ��� ���Ű��ҷ� : �� 46.24% , ��ü ������ ���� : 7.1%
select "30��~40�뿩�������",��ü���Ű��Ұ�,round("30��~40�뿩�������"/��ü���Ű��Ұ�,4)*100 ����,
(select sum(���űݾ�) from purprod where year = 2015) "2015��ü����",
round(abs("30��~40�뿩�������")/(select sum(���űݾ�) from purprod where year = 2015)*100,2) "���������"
from
(select
((select sum(���űݾ�) from purprod p
join custdemo c on p.����ȣ = c.����ȣ
where p.����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2015 
and ���� = 'F' and ���ɴ� in ('30��~34��','35��~39��','40��~44��','45��~49��'))
-
(select sum(���űݾ�) from purprod p
join custdemo c on p.����ȣ = c.����ȣ
where p.����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2014 
and ���� = 'F' and ���ɴ� in ('30��~34��','35��~39��','40��~44��','45��~49��'))) "30��~40�뿩�������"
,
((select sum(���űݾ�) from purprod 
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2015)
-
(select sum(���űݾ�) from purprod 
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2014)) "��ü���Ű��Ұ�"
from dual);


-- ��ü���Ű��Ұ��� ���Ű��ҷ��� ��ü ������ ���� : 15.35%

select ��ü���Ű��Ұ�,
(select sum(���űݾ�) from purprod where year = 2015) "2015��ü����",
round(abs("��ü���Ű��Ұ�")/(select sum(���űݾ�) from purprod where year = 2015)*100,2) "���������"
from
(select
((select sum(���űݾ�) from purprod 
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2015)
-
(select sum(���űݾ�) from purprod 
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2014)) "��ü���Ű��Ұ�"
from dual);

-- �湮�󵵼��� �������� ���� �ִ밪

select ����,max(��) from(
select ntile(100) over (order by ��) as ����, ����ȣ, �� from(
select ����ȣ, count(*) �� from(
select c.����ȣ,��������,count(*) "��" from custdemo c
join purprod2 p on c.����ȣ = p.����ȣ(+)
group by c.����ȣ,��������
order by c.����ȣ)
group by ����ȣ
order by ����ȣ))
group by ����
order by ����;

-- �ֱٹ湮�ϸ� �������� ���� �ִ밪

select ����, max(�ֱٱ�����) from(
select ntile(100) over(order by �ֱٱ�����) as ����,����ȣ,�ֱٱ����� from(
select c.����ȣ , max(��������) �ֱٱ����� from purprod2 p
join custdemo c on c.����ȣ = p.����ȣ
group by c.����ȣ))
group by ����
order by ����;

-- �� ���ž��� �������� ���� �ִ밪

select ����, max(�ѱ��ž�) from(
select ntile(100) over(order by �ѱ��ž�) as ����,����ȣ,�ѱ��ž� from(
select c.����ȣ , max(���űݾ�) �ѱ��ž� from purprod2 p
join custdemo c on c.����ȣ = p.����ȣ
group by c.����ȣ))
group by ����
order by ����;

-- �б⺰ �� ���̱�
create table purprod3 as
(SELECT ���޻�,��������ȣ,�Һз��ڵ�,�Һз���,���պз�,�Һ���з�,����ȣ,�����ڵ�,��������,���Žð�,���űݾ�,year,��,
CASE WHEN �������� > 20150931 then 'Q8'
WHEN �������� > 20150631 then 'Q7'
WHEN �������� > 20150331 then 'Q6'
WHEN �������� > 20141231 then 'Q5'
WHEN �������� > 20140931 then 'Q4'
WHEN �������� > 20140631 then 'Q3'
WHEN �������� > 20140331 then 'Q2' 
ELSE 'Q1' END AS �б�
FROM purprod2);


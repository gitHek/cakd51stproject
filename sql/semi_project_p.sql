-- ���� 2014�� ��� 2015�� �ѱ��űݾ� ������ ���̺�� �����
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

select * from purbygap;


-- ������ ���� ���� ���Ұ� �� �� ������ü��� ����
-- ���� 7034��, ���� 1583��
-- ���� 44.2% , ���� 45.4%

select a.����,���� ���Ұ���,round(����/��ü,3) ����
from (select ����, count(����ȣ) ��ü from custdemo
group by ����
order by ����) a
join 
(select ����,count(����ȣ) ���� from custdemo
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%')
group by ����
order by ����) b on a.���� = b.����;

-- ���ɴ뺰 ���� ���� �� �� �� ����

select a.���ɴ�,���� ���Ұ���, round(����/��ü,3) ����
from (select ���ɴ�, count(����ȣ) ��ü from custdemo
group by ���ɴ�
order by ���ɴ�) a
join 
(select ���ɴ�,count(����ȣ) ���� from custdemo
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%')
group by ���ɴ�
order by ���ɴ�) b on a.���ɴ� = b.���ɴ�;

-- ������ ���ɴ뺰 ���� ���� ������

select a.���ɴ�, round(����/��ü,3) 
from (select ���ɴ�, count(����ȣ) ��ü from custdemo
where ���� = 'F'
group by ���ɴ�
order by ���ɴ�) a
join 
(select ���ɴ�,count(����ȣ) ���� from custdemo
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%') and ���� = 'F'
group by ���ɴ�
order by ���ɴ�) b on a.���ɴ� = b.���ɴ�;



-- '079' ���������� ������ 2014�� 2015�� ���� 

select ���޻�,year, sum(���űݾ�) from purprod p
join custdemo d on p.����ȣ = d.����ȣ
where �������� = '079'
group by ���޻�,year
order by ���޻�,year;

-- ����� �̿�� ���� n�� �̱�

select * from (select ����ȣ,count(*) from compet
group by ����ȣ
order by count(*) desc)
where rownum <=3500;

-- ����� �̿�� ���� 1000���� ���� ����

select round(avg(����)) from purbygap
where ����ȣ in (select * from (select ����ȣ from compet
group by ����ȣ
order by count(*) desc)
where rownum <=1000);

-- '079' ���������� B���޻��� ������ ��û���� ���� 

select ���޻�,year, sum(���űݾ�) from purprod p
join custdemo d on p.����ȣ = d.����ȣ
where �������� = '079'
group by ���޻�,year
order by ���޻�,year;

-- ���� ���Ұ����� �������� ī��Ʈ �� ����

select a.��������,����, round(����/��ü,3) ����
from (select ��������, count(����ȣ) ��ü from custdemo
group by ��������
order by ��������) a
join 
(select ��������,count(����ȣ) ���� from custdemo
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%')
group by ��������
order by ��������) b on a.�������� = b.��������
order by ���� desc;


-- ���� ���Ұ����� ���������� ���Ҿ� ��

select ��������, sum(����) from custdemo c
join purbygap p on p.����ȣ = c.����ȣ
where c.����ȣ in (select ����ȣ from purbygap where ���� like '-%')
group by ��������
order by sum(����);

-- ���� ���Ҿ��� ���� ����

select ��������, sum(����) from custdemo c
join purbygap p on p.����ȣ = c.����ȣ
group by ��������
order by sum(����);

-- ���� ���Ұ��� ���޻纰 �⵵�� ���űݾ�

select ���޻�,year, sum(���űݾ�) from purprod p
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%')
group by ���޻�,year
order by ���޻�,year;

-- �� ����������, ������, �⵵�� �����
select �����ڵ�,��������,year,sum(���űݾ�) from purprod p
join custdemo c on p.����ȣ = c.����ȣ
group by �����ڵ�,��������,year
order by �����ڵ�,��������,year;

-- ������ ������ ���Ұ��� ������
create table jumpo_year_2014 as
select �����ڵ�,YEAR,SUM(���űݾ�) ���ž� from PURBYGAP G
join custdemo c on G.����ȣ = c.����ȣ
join purprod p on P.����ȣ = c.����ȣ
where c.����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2014
group by �����ڵ�,YEAR
order by �����ڵ�,YEAR;

create table jumpo_year_2015 as
select �����ڵ�,YEAR,SUM(���űݾ�) ���ž� from PURBYGAP G
join custdemo c on G.����ȣ = c.����ȣ
join purprod p on P.����ȣ = c.����ȣ
where c.����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2015
group by �����ڵ�,YEAR
order by �����ڵ�,YEAR;

select j4.�����ڵ�, j5.���ž�-j4.���ž� ���������� from jumpo_year_2014 j4
join jumpo_year_2015 j5 on j4.�����ڵ� = j5.�����ڵ�
order by ����������;

-- ���պз��� ���Ű��Ұ��� ������ �� ����� ������

create table gapbytong14 as 
select ���պз�, sum(���űݾ�) �ѱ��űݾ� from purprod p
join prodcl_new c on c.�Һз��ڵ� = p.�Һз��ڵ�
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2014
group by ���պз�
order by �ѱ��űݾ� desc;

select * from gapbytong14

create table gapbytong15 as 
select ���պз�, sum(���űݾ�) �ѱ��űݾ� from purprod p
join prodcl_new c on c.�Һз��ڵ� = p.�Һз��ڵ�
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2015
group by ���պз�
order by �ѱ��űݾ� desc;

select * from gapbytong15;

select g4.���պз�, g5."�ѱ��űݾ�"-g4."�ѱ��űݾ�" ���� from gapbytong14 g4
join gapbytong15 g5 on g4.���պз� = g5.���պз�
order by ����;

-- ���պз��� ������ 2014���� 2015�⵵ ���Ű��Ұ����� ������

select ���պз�, sum(���űݾ�) �ѱ��űݾ� from purprod p
join prodcl_new c on c.�Һз��ڵ� = p.�Һз��ڵ�
join custdemo d on d.����ȣ = p.����ȣ
where p.����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2015 and ���� = 'M'
group by ���պз�
order by �ѱ��űݾ� desc;

select g4.���պз�,nvl(g5."�ѱ��űݾ�",0)-nvl(g4."�ѱ��űݾ�",0) ���� from
(select ���պз�, sum(���űݾ�) �ѱ��űݾ� from purprod p
join prodcl_new c on c.�Һз��ڵ� = p.�Һз��ڵ�
join custdemo d on d.����ȣ = p.����ȣ
where p.����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2014 and ���� = 'F'
group by ���պз�
order by �ѱ��űݾ� desc) g4
join (select ���պз�, sum(���űݾ�) �ѱ��űݾ� from purprod p
join prodcl_new c on c.�Һз��ڵ� = p.�Һз��ڵ�
join custdemo d on d.����ȣ = p.����ȣ
where p.����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2015 and ���� = 'F'
group by ���պз�
order by �ѱ��űݾ� desc) g5 on g4.���պз� = g5.���պз�
order by ����;

-- �ο� ��ü�� ���̰� �������� ������ ���Ű��Ұ� �е������� ����
-- ������ �ֿ� ���� ǰ���� �м�,��ǰ,��󸮿� ���õ� �͵鿡�� ���� ���Ұ� ����
-- �̸� ���� �İ�� ����� ������??

-- ���� ���� ������ ��ȭ�ϴ� �׸��� ã�ƺ���?

-- ���Ű��Ұ��� ��� ����� �̿�Ƚ�� : 1.53ȸ
select round(avg(nvl(Ƚ��,0)),2) from(
select c.����ȣ,Ƚ�� from custdemo c
join (select ����ȣ , count(����ȣ) Ƚ�� from compet
group by ����ȣ
order by ����ȣ) d on c.����ȣ = d.����ȣ(+))
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%');

-- ��ü ������ ��� ����� �̿�Ƚ�� : 1.45ȸ
select round(avg(nvl(Ƚ��,0)),2) from(
select c.����ȣ,Ƚ�� from custdemo c
join (select ����ȣ , count(����ȣ) Ƚ�� from compet
group by ����ȣ
order by ����ȣ) d on c.����ȣ = d.����ȣ(+));

-- ������������ ��� ����� �̿�Ƚ�� : 1.39ȸ
select round(avg(nvl(Ƚ��,0)),2) from(
select c.����ȣ,Ƚ�� from custdemo c
join (select ����ȣ , count(����ȣ) Ƚ�� from compet
group by ����ȣ
order by ����ȣ) d on c.����ȣ = d.����ȣ(+))
where ����ȣ not in (select ����ȣ from purbygap where ���� like '-%');

-- ����, �з��� ���Ұ����� �ѱ��űݾ� �� ����Ƚ��, ��ձ��űݾ�

SELECT c.����,���պз�,SUM(���űݾ�) �ѱ��űݾ� , round(sum(���űݾ�)/(
select sum(���űݾ�) from purprod
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%')
),5)*100 "��ü������" ,COUNT(*) ����Ƚ��,ROUND(AVG(���űݾ�)) ��ձ��űݾ� 
FROM custdemo c, purprod p
join prodcl_new n on n.�Һз��ڵ� = p.�Һз��ڵ�
WHERE c.����ȣ = p.����ȣ and C.����ȣ in (select ����ȣ from purbygap where ���� like '-%')
GROUP BY c.����,���պз�
ORDER BY �ѱ��űݾ� desc;

-- ���պз��� 2014���� 2015�⵵ ������
select g4.���պз�,nvl(g5."�ѱ��űݾ�",0)-nvl(g4."�ѱ��űݾ�",0) ���� from
(select ���պз�, sum(���űݾ�) �ѱ��űݾ� from purprod p
join prodcl_new c on c.�Һз��ڵ� = p.�Һз��ڵ�
join custdemo d on d.����ȣ = p.����ȣ
where  year = 2014
group by ���պз�
order by �ѱ��űݾ� desc) g4
join (select ���պз�, sum(���űݾ�) �ѱ��űݾ� from purprod p
join prodcl_new c on c.�Һз��ڵ� = p.�Һз��ڵ�
join custdemo d on d.����ȣ = p.����ȣ
where year = 2015
group by ���պз�
order by �ѱ��űݾ� desc) g5 on g4.���պз� = g5.���պз�
order by ����;

select ���պз�,sum(���űݾ�)
from purprod p
join prodcl_new c on c.�Һз��ڵ� = p.�Һз��ڵ�
group by ���պз�
order by sum(���űݾ�) desc;

-- ��ü ���� 2014���� 2015�� ����� �� �����
select (select sum(���űݾ�) from purprod
where year = 2014) "2014�� ����",
(select sum(���űݾ�) from purprod
where year = 2015) "2015�� ����",
round((1-((select sum(���űݾ�) from purprod
where year = 2014)
/(select sum(���űݾ�) from purprod
where year = 2015)))*100,3) "�����"  from DUAL ;

-- 2015�� �� ����� ���Ű��Ұ��� ���� ���� �� ��
select (select sum(���űݾ�) from purprod
where year = 2015) "2015�� ����",
(select sum(����) from purbygap
where ���� like '-%') "���Ű��Ұ��� 2014�� ��� 2015�� ���� ����" ,
round(abs((select sum(����) from purbygap
where ���� like '-%'))/(select sum(���űݾ�) from purprod
where year = 2015)*100,4) "����"
from dual;

-- ���ɴ뺰 2015�� �� ����� ���Ű��Ҿ� �� ����

select a.���ɴ�,��ü "2015�� ����",���Ҿ� "���Ұ��� ���Ҿ�", round(abs(���Ҿ�)/��ü*100,3) ����
from (select ���ɴ�, sum(���űݾ�) ��ü from custdemo
join purprod on purprod.����ȣ = custdemo.����ȣ
where year = 2015
group by ���ɴ�
order by ���ɴ�) a
join 
(select ���ɴ�,sum(����) ���Ҿ� from custdemo c
join purbygap g on g.����ȣ = c.����ȣ
where ���� like '-%'
group by ���ɴ�
order by ���ɴ�) b on a.���ɴ� = b.���ɴ�;

-- 30��~ 40�� ���� ���Ű��Ұ��� ��ü ���Ű��Ұ��� �����ϴ� ����

select ���ɴ�, sum(����), (
select ���ɴ�,sum(����) from custdemo c
join purbygap g on c.����ȣ = g.����ȣ 
where ���ɴ� in ('30��~34��','35��~39��','40��~44��','45��~49��')
group by ���ɴ�);

SELECT C.�Һ���з�, ROUND(AVG(P.���űݾ�)) ���, MIN(P.���űݾ�) �ּҰ�, MAX(P.���űݾ�) �ִ밪, MEDIAN(P.���űݾ�) �߰���
FROM PURPROD P, PRODCL2 C
WHERE P.�Һз��ڵ� = C.�Һз��ڵ�
GROUP BY C.�Һ���з�
ORDER BY ���;

SELECT C.�Һ���з�, ROUND(AVG(P.���űݾ�)) ���, MIN(P.���űݾ�) �ּҰ�, MAX(P.���űݾ�) �ִ밪, MEDIAN(P.���űݾ�) �߰���
FROM PURPROD P, PRODCL2 C
WHERE P.�Һз��ڵ� = C.�Һз��ڵ�
GROUP BY C.�Һ���з�
ORDER BY ���;

select �ߺз���, round(avg(p.���űݾ�)) from purprod p
join prodcl2 c on c.�Һз��ڵ� = p.�Һз��ڵ�
where �Һ���з� = '����ǰ'
group by �ߺз���
order by avg(p.���űݾ�) desc;

select �Һз���,round(avg(���űݾ�)) from purprod p
join prodcl2 c on c.�Һз��ڵ� = p.�Һз��ڵ�
where c.�ߺз��� = '��������'
group by �Һз���
order by avg(���űݾ�) desc;

-- 30�� �̻� ������ ��ü���Ű��Ұ����� ��� ���Ű��ҷ� : �� 72.72% ��ü ��� ���� : 11.52%
select "30���̻󿩼������",��ü���Ű��Ұ�,round("30���̻󿩼������"/��ü���Ű��Ұ�,4)*100 ���� ,
(select sum(���űݾ�) from purprod where year = 2015) "2015��ü����",
round(abs("30���̻󿩼������")/(select sum(���űݾ�) from purprod where year = 2015)*100,2) "���������"
from
(select
((select sum(���űݾ�) from purprod p
join custdemo c on p.����ȣ = c.����ȣ
where p.����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2015 
and ���� = 'F' and ���ɴ� not in ('19������','20��~24��','25��~29��'))
-
(select sum(���űݾ�) from purprod p
join custdemo c on p.����ȣ = c.����ȣ
where p.����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2014 
and ���� = 'F' and ���ɴ� not in ('19������','20��~24��','25��~29��'))) "30���̻󿩼������"
,
((select sum(���űݾ�) from purprod 
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2015)
-
(select sum(���űݾ�) from purprod 
where ����ȣ in (select ����ȣ from purbygap where ���� like '-%') and year = 2014)) "��ü���Ű��Ұ�"
from dual)  ;

-- 30�� ~ 40�� ������ ��ü���Ű��Ұ����� ��� ���Ű��ҷ� : �� 46.22% , ��ü ������ ���� : 7.32%
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
from dual)  ;

-- ��ü���Ű��Ұ��� ���Ű��ҷ��� ��ü ������ ���� : 15.84%

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
from dual)  ;

select * from purprod p
join prodcl2 c on c.�Һз��ڵ� = p.�Һз��ڵ�
where �Һ���з� = '����ǰ' and �Һз��� = '���ڽ���' and ����ȣ = '06207'
order by �������� desc;

select * from purprod p
join prodcl2 c on c.�Һз��ڵ� = p.�Һз��ڵ�
where ����ȣ = '06207';

select ����ȣ , max(��������) from purprod p
group by ����ȣ
having max(��������) < 20150601
order by ����ȣ;

select ����,max(��) from(
select ntile(100) over (order by �� desc) as ���� , ����ȣ, ��  from (select c.����ȣ,count(*) "��" from custdemo c
join purprod p on c.����ȣ = p.����ȣ
group by c.����ȣ))
group by ����
order by max(��);

select ����ȣ, count(*) from custdemo c
join purprod p on c.����ȣ = p.����ȣ
group by c.����ȣ;

select ����,max(��) from(
select ntile(100) over (order by �� desc) as ���� , ����ȣ, ��  from (select c.����ȣ,count(*) "��" from custdemo c
join purprod p on c.����ȣ = p.����ȣ
group by c.����ȣ,��������))
group by ����
order by max(��);

select P.���޻�,C.�Һз���, P.�Һз��ڵ�, P.����ȣ, P.��������, P.���űݾ�, �Һ���з� from purprod p
join prodcl2 c on c.�Һз��ڵ� = p.�Һз��ڵ�
where �Һ���з� = '����ǰ'
order by ���űݾ� desc;

-- 
select �Һз��� ,avg(���űݾ�) from purprod p
join prodcl2 c on p.�Һз��ڵ� = c.�Һз��ڵ�
where �Һ���з� = '����ǰ'
group by �Һз���
order by avg(���űݾ�);

-- �湮�󵵼��� �������� ���� �ִ밪
select ����,max(��) from(
select ntile(100) over (order by �� desc) as ����, ����ȣ, �� from(
select ����ȣ, count(*) �� from(
select c.����ȣ,��������,count(*) "��" from custdemo c
join purprod p on c.����ȣ = p.����ȣ
group by c.����ȣ,��������
order by c.����ȣ)
group by ����ȣ
order by ����ȣ))
group by ����
order by max(��);

select �Һз���,avg(���űݾ�) from purprod p
join prodcl2 c on c.�Һз��ڵ� = p.�Һз��ڵ�
where p.�Һз��ڵ� = 'C170701'
group by �Һз���;

CREATE TABLE PP2AVG AS
SELECT p.�Һз��ڵ�, �Һз���, ROUND(AVG(���űݾ�)) ��� FROM purprod p 
join prodcl2 c on c.�Һз��ڵ� = p.�Һз��ڵ�
GROUP BY p.�Һз��ڵ�, �Һз���;

-- �뷮���� ������ ����
CREATE TABLE PP11 AS
SELECT p.���޻�,p.��������ȣ,p.�Һз��ڵ�,c.�Һз���,c.���պз�,c.�Һ���з�,p.����ȣ,p.�����ڵ�,p.��������,p.���Žð�,p.���űݾ�,p.year,p.��
FROM purprod P
JOIN PP2AVG A ON P.�Һз��ڵ� = A.�Һз��ڵ�
join prodcl2 c on c.�Һз��ڵ� = p.�Һз��ڵ�
WHERE P.���űݾ� < (A.���*30) or ���պз� in ('��ǰ/���','��������');


CREATE TABLE PP3AVG AS
SELECT �Һз��ڵ�, �Һз���, ROUND(AVG(���űݾ�)) ��� FROM pp11
GROUP BY �Һз��ڵ�, �Һз���;

-- ���� �̻�ġ ������ ����
create table pp12 as
SELECT  p.���޻�,p.��������ȣ,p.�Һз��ڵ�,p.�Һз���,p.���պз�,p.�Һ���з�,p.����ȣ,p.�����ڵ�,p.��������,p.���Žð�,p.���űݾ�,p.year,p.�� FROM PP11 P
JOIN PP3AVG A ON P.�Һз��ڵ� = A.�Һз��ڵ�
WHERE P.���űݾ� > (A.���/50) or p.���űݾ� >= 800
ORDER BY ���űݾ� DESC;



-- �ݱ⺰ �� ���űݾ��Ѿ��� ���ϰ� 14H1 �� 15H1�� ���ؼ� purbygap�� ���� �����
create table purbygap as
select a.����ȣ, "15H1"-"14H1" ���� from custdemo a 
join (select ����ȣ, sum(���űݾ�) "14H1" from pur14H1 group by ����ȣ) b on a.����ȣ = b.����ȣ
join (select ����ȣ, sum(���űݾ�) "15H1" from pur15H1 group by ����ȣ) c on a.����ȣ = c.����ȣ 
join custorigin d on a.����ȣ = d.������;



-- �������� �ƴѻ������ �б⺰ �� ����
select �б�, sum(���űݾ�) from purprod2
where ����ȣ not in (select * from custorigin)
group by �б�
order by �б�;

-- ���Ű��Ұ��� 14�⵵ 1�ݱ� ���� : 90728721758 ��

select sum(���űݾ�) from purprod2 a
join purbydiv b on a.����ȣ = b.����ȣ
where ����� < 1 and (�б� = 'Q1' or �б� = 'Q2');

-- ���Ű��Ұ��� 15�⵵ 1�ݱ� ���� : 62331206475 ��

select sum(���űݾ�) from purprod2 a
join purbydiv b on a.����ȣ = b.����ȣ
where ����� < 1 and (�б� = 'Q5' or �б� = 'Q6');

-- ���Ұ� �� : 9254
select count(*) from custorigin a
join purbydiv b on a.����ȣ=b.����ȣ
where ����� < 1;

-- ���Ű��Ұ��� 14�⵵ 1�ݱ� ���� : 90728721758 ��

select sum(���űݾ�) from purprod2 a
join purbydiv b on a.����ȣ = b.����ȣ
where ����� < 0.7 and (�б� = 'Q1' or �б� = 'Q2');

-- ���Ű��Ұ��� 15�⵵ 1�ݱ� ���� : 62331206475 ��

select sum(���űݾ�) from purprod2 a
join purbydiv b on a.����ȣ = b.����ȣ
where ����� < 0.7 and (�б� = 'Q5' or �б� = 'Q6');

-- ���Ұ� �� : 9254
select count(*) from custorigin a
join purbydiv b on a.����ȣ=b.����ȣ
where ����� < 0.7;

select ���պз�,�б�,avg(��ո���) from ;


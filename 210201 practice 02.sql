/********************���� ���ܿ��*********************************
<oracle ������ JOIN>

1. Inner Join
    1) EQUI JOIN
    2) NON EQUI JOIN
    3) SELF JOIN

2. Outer Join
    (+)
    
<ANSI ������ JOIN>

1. CROSS JOIN

2. INNER JOIN 
    EQUI, NON-EQUI JOIN, SELF JOIN �� ���Ե�
    ����1, ����2(���� �̻��� ���̺� ���ν�)
    
3. OUTER JOIN  
    (==> ORACLE OUTER JOIN �� ����� ����) 
    LEFT, RIGHT, FULL
    
4. NATURAL JOIN
5. USING JOIN


<JOIN �� Ȱ��
    ==> �������Ǹ� Ȱ���ϰԵǸ� ���Ǹ���� �ξ� �����ϰ� ���������.>
*/







/*********************����Ǯ��*********************************
<oracle ������ JOIN>
--���� �ǽ�--


1. Inner Join 
    1) EQUI JOIN
*/

--����) ������� ����̸�, �μ���ȣ, �μ��̸��� ��ȸ�ϼ���.
SELECT
    ename, e.deptno, dname
FROM
    emp e, dept d
WHERE
    e.deptno = d.deptno
;

--����) 81�� �Ի��� ������� �̸�, ����, �Ի���, �μ���ȣ, �μ��̸�, �μ���ġ�� ��ȸ�ϼ���. --�������ǰ� �Ϲ������� ���� �� �� �ִ�.
SELECT
    ename, job, hiredate, e.deptno, dname, loc
FROM
    emp e, dept d
WHERE
    e. deptno = d.deptno
    AND TO_CHAR(hiredate, 'YY') ='81'
;





-- 2) NON EQUI JOIN
-- ����) ������� �̸�, ����, �޿�, �޿������ ��ȸ�ϼ���.
SELECT
    ename, job, sal, grade
FROM
    emp, salgrade
WHERE
    --sal >= losal AND sal <= hisal
    sal BETWEEN losal AND hisal
;

-- ����) ������� �̸�, ����, �޿�, �μ��̸�, �޿������ ��ȸ�ϼ��� (EQUI JOIN +NON EQUI JOIN : �����̻��� ���̺�)
SELECT
    ename, job, sal, dname, grade
FROM
    emp e, dept d, salgrade
WHERE
    e.deptno = d.deptno
    AND sal BETWEEN losal AND hisal
;

--���� �ǽ�--

--���� 1] ������ 'MANAGER'�� ������� �̸� , ����, �Ի���, �޿�, �μ��̸��� ��ȸ�ϼ���.
SELECT
    ename, job, hiredate, sal, dname
FROM
    emp e, dept d
WHERE
    e.deptno = d.deptno
    AND job = 'MANAGER'
;
    

/* ���� 2] �޿��� �������� �����--(�Ϲ�����) �̸�, ����, �Ի���, �޿�, �μ��̸�, �μ���ġ�� ��ȸ�ϼ���--(�����̺� ����) *****
 �ΰ��� ��� ]
    1. �������Ƿ� �ذ��ϴ� ���
    2. ���������� ����� ���̺�ó�� ����ϴ� ���(�ζ��κ���)*****/
    
--1��° ���
SELECT
    ename, job, hiredate, sal, dname, loc
FROM
    emp e, dept d
WHERE
    e.deptno = d.deptno
    AND sal = (SELECT 
                    MIN(sal)
                FROM
                    emp)
;                    
--2��° ���
SELECT
    ename, job, hiredate, sal, dname, loc
FROM
    emp e, dept d,
    (SELECT MIN(sal) min FROM EMP)  ----> ���������� ����� ���̺�ó�� ����ϴ� ���
WHERE
    e.deptno = d.deptno
    AND sal = min
;
    
-- ���� 3] ����̸��� 5������ ������� �̸�, ����, �Ի���, �޿�, �޿������ ��ȸ�ϼ���. --ename, sal (non EQUI)
SELECT
    ename, job, hiredate, sal, grade
FROM
    emp, salgrade
WHERE
    sal BETWEEN losal AND hisal
    AND LENGTH(ename) = 5 -- �Ǵ� ename LIKE '_____'
;


-- ���� 4] �Ի����� 81���̰� ������ 'MANAGER'�� ������� ����̸�, ����, �Ի���, �޿�, �޿����, �μ��̸�, �μ���ġ�� ��ȸ�ϼ���.
SELECT
    ename, job, hiredate, sal, grade, dname, loc
FROM
    emp e, dept d, salgrade
WHERE
    e.deptno = d.deptno --��������
    AND sal BETWEEN losal AND hisal --��������
    AND TO_CHAR(hiredate, 'YY') ='81'--�Ϲ�����
    AND job = 'MANAGER'--�Ϲ�����
;

 --  3) SELF JOIN
 --����) ������� ����̸�, ����, ����̸��� ��ȸ�ϼ��� .-- emp �� mgr �� ����ȣ�� emp �� empno (�Ȱ��� ���� ���̺�)
SELECT
    e.ename, e.job, e.mgr, se.empno, se.ename
FROM
    emp e, emp se
WHERE
    e.mgr = se.empno ---SELF JOIN
;
 
 
--2.Outer join
-- ����) ������� ����̸�, ����, ����ȣ, ����̸��� ��ȸ�ϼ���. ��, ��簡 ���� ����� ǥ�õǰ� �ϼ���.
SELECT
    e.ename, e.job, e.mgr, se.ename
FROM
    emp e, emp se --��� ���̺�, ��� ���̺�(+)
WHERE
     e.mgr = se.empno(+)--'KING'�� ��簡 ���� ����̸���ü�� NULLL�� ǥ���Ǿ���. ������̺� (+)
;

    
--���� �ǽ�--

-- ����1] ������� ����̸�, �޿�, ����̸�, ���޿�, ���޿��ͱ޿��� ������ ��ȸ�ϼ���.
--        ��, ��簡 ���� ����� ��ȸ�ǰ� �ϼ���. -- ���� ���� + �ƿ�������
SELECT
    e.ename, e.sal, se.ename, se.sal, se.sal- e.sal
FROM
    emp e, emp se
WHERE
    e.mgr = se.empno(+)
;
-- ����2] ������� �̸�, ����, �޿�, �μ���ȣ, �μ��̸�, �μ���ġ�� ��ȸ�ϼ���.
--         ��, ����� ���� �μ��� ��ȸ�ǰ� �ϼ���. -- �������� + �ƿ�������
SELECT
    ename, job, sal, e.deptno, dname, loc
FROM
    emp e, dept d
WHERE
    e.deptno(+) = d.deptno ---NULL�� ǥ�õ� ���� �ƿ��� ���� : emp ���̺��� NULL�� �Ǿ���.
;



/*

<ANSI JOIN>
1. INNER JOIN 
*/

--����) ANSI JOIN  ������� �̸�, ����, �μ��̸��� ��ȸ�ϼ��� emp, dept
SELECT
    ename, job, dname
FROM
   emp e INNER JOIN dept d ---�׳� JOIN �� �ᵵ��
ON
    e.deptno = d.deptno
;

--����) 81�� �Ի��� ������� �̸�, ����, �Ի���, �μ��̸�, �μ���ġ�� ��ȸ�ϼ���. emp, dept

SELECT
    ename, job, hiredate, dname, loc
FROM
    emp e JOIN dept d
ON
    e.deptno = d.deptno
WHERE
    TO_CHAR(hiredate,'YY') ='81'
;
--����) ������� ����̸�, �޿�, �μ���ġ, �޿������ ��ȸ�ϼ���. --ANSI �̳� ���� ������ ���̺��� �����ϴ� ��(emp, dept, salgrade)
SELECT
    ename, sal, loc, grade
FROM
    emp e JOIN dept d
ON
    e.deptno = d.deptno
JOIN salgrade
ON sal BETWEEN losal AND hisal
;

--2. OUTER JOIN  
--����) ������� ����̸�, ����, ����ȣ, ����̸��� ��ȸ�ϼ���(self- outer join)
SELECT
    e.ename ����̸�, e.job, e.mgr, se.ename ����̸�
FROM
    emp e LEFT OUTER JOIN emp se ---- emp se RIGHT OUTER JOIN emp e
ON 
    e.mgr = se.empno
;

--3. NATURAL JOIN
--����) ������� ����̸�, ����, �μ��̸��� ��ȸ�ϼ��� --ANSI NATURAL JOIN ����(�����̺� �� deptno�� ����)

SELECT
    ename, job, dname
FROM
    emp NATURAL JOIN dept
;

--4. USING JOIN
SELECT
    ename, job, dname
FROM
    emp JOIN dept
USING
    (deptno)
;



--************************************************�Ʒ����� ���� �ָ��� �ѹ� ��Ǯ�� **************************
/*
<JOIN �� Ȱ��>
--����)  ���μ��� �޿� ��պ��� ���� �޴� ������� ����̸�, �޿�, �μ���ձ޿��� ��ȸ�ϼ���.
*/
SELECT
    ename, sal,
    (
        SELECT
            AVG(sal)
        FROM
            emp
        WHERE
            deptno = e.deptno
    ) �μ���ձ޿�
FROM
    emp e
WHERE
    sal < (
                SELECT
                    AVG(sal)
                FROM
                    emp
                WHERE
                    deptno = e.deptno
            )
;
-----------------------------------------------------
SELECT
    ename, sal,
    avg �μ���ձ޿�
FROM
    emp e, 
    (
        SELECT
            deptno, AVG(sal) avg
        FROM
            emp
        GROUP BY
            deptno
    ) a
WHERE
    e.deptno = a.deptno
    AND sal < avg
;


--����1 ] �� �μ��� �ִ�޿����� ������ ��ȸ�ϼ���. deptno ,MAX(sal)
-- oracle join , ANSI JOIN �ΰ����� ���� ó���ϼ���.

SELECT
    ename, sal, max, e.deptno 
FROM
    emp e,
    (SELECT deptno, MAX(sal) max
     FROM emp
     GROUP BY deptno) 
WHERE
    sal = max
;
--------------------------------------------------------
SELECT
    ename, sal, max, deptno
FROM
    emp JOIN    (
                    --������ �������̺�
                    SELECT
                        deptno dno, MAX(sal) max
                    FROM
                        emp
                    GROUP BY
                        deptno
                )
ON
    deptno = dno
WHERE
    sal = max
ORDER BY
    deptno, ename
;

-- extra ]   �޿��� �հ谡 ���� ���� �μ��� ����� �μ� ��� �޿����� ���� �޴� �������
--           ����̸�, �޿�, �μ���ȣ, �μ��̸�, �μ���ձ޿�, �μ��޿��հ� �� ��ȸ�ϼ���.


-- extra 2 ] �μ������� ���� ���� �μ��� ����� �μ���ձ޿����� ���� �޿��� �޴� �����
--              ����̸�, �μ���ȣ, �޿�, �μ���ձ޿�, �μ��޿��հ�, �μ����� �� ��ȸ�ϼ���.







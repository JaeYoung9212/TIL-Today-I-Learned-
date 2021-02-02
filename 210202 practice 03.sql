/*
 1. < �� >
 ==> ���������� ������� ���� �ʴ� ���̺� : ���� ���ó���� ���� �ս���
     ���̺��� �κ��� �������ִ� â��.
 
 1) �ܼ��� : �ϳ��� ���̺� �̿��ؼ� ���� �� ( DML��� (SELECT, INSERT, UPDATE, DELETE) ������ ����)
        
        - ����] CREATE VIEW ���̸�
               AS
                �信�� �� ���������� ���Ǹ��
               ;
               
        - �ɼ� 1 : �� �� ���� ������ �Է� ���� �ɼ�]
        
             CREATE VIEW ���̸�
             AS
                ���Ǹ��
            WITH CHECK OPTION
            ;
            
         - �ɼ� 2 : ���� �뵵�θ� �����Ǵ� �� �ɼ�(�� ������: ���̺� ������ - ������ü�� ����)]
         
             CREATE VIEW ���̸�
             AS
                ���Ǹ��
            WITH READ ONLY
            ;     
            
        - ��Ģ������ ���̺�ó�� �ߺ��̸� X ��, ���� �̸� �� �־ ����� ��ɾ� O ]
        
            CREATE OR REPLACE �̸�
            AS
                ���Ǹ��
            [WITH �ɼ�]
            ;
            
        - ���̺� �������� �� ���� ����� ��ɾ� - ������ ������ �Բ�(��������) ������ ]
        
            CREATE OR REPLACE FORCE VIEW ���̸� -- �並 ������ ����ڴ�
            AS
               ���Ǹ��
           [WITH �ɼ�]
            ;
            
 2) ���պ� : �ΰ� �̻� ���̺� �������� ���� �� ( DML ��� �Ұ�, SELECT ������ ��ȸ�� ����)
            
           - ����] �ܼ���� ���� �� �ΰ� �̻��� ���̺���� �������� �� 
 
 2. <�ζ��� ��>
    ==> ���� ���̺�, SELECT ���� ����� �����ϸ� ������ ����̸� FROM ������ ���̺�ó�� ���.
        EX) ���̺� �������� �ʴ� �׷��Լ� ����� ���̺�ó�� ���� ���

    *<�� ����>
        DROP VIEW ���̸�;
 
 
 3. < ROWNUM >
    ==> ����Ŭ�� �����ϴ� ���� Į�� / �����Ͱ� ��ȸ�� ������ 1,2,3... �ѹ���
        
        ����] ������ �ʿ��� ����� �ִ�. -> ��ȸ�ϸ� ���� -> ��� ��ü�� �ζ��κ�� -> �ζ��κ� ���̺��� ��ȸ �ϸ� ROWNUM ����
        
        ��? ] �� 100���� ��� / 100���� ROWNUM /���ĵ� ����� 60~70 ��° ���� ROWNUM ���� ã�� �� ����. 
 
 4. < Ʈ������ ó��>
    ==> ����� ������ Ʈ������(�۾�����)�̳� �������� ���Ἲ ���� DML �� ���ۿ� �ö� ó����� �������� ���� X
    
    1) �ڵ� Ʈ������ ó��
        - sqlplus ���� exit
        - DDL / DCL ����� �������� ���� 
        
    2) ���� Ʈ������ ó�� 
        - COMMIT ���
        
 * sqlplus �������� ���� , ������ -> Ʈ������ �ڵ� ������ / ROLLBACK -> Ʈ������ ���� ������
 
 ���� ] <ROLLBACK ���� �����>
 SAVEPOINT �����̸�; -->���� Ʈ������ ó���� ���̺� ����Ʈ�� �ڵ� �ı���
 ROLLBACK TO �����̸� ;
 
*/



-- *************************** ���� *********************************************************

--������ view �� ������ �� �ִ� ������ SYSTEM �������� �����Ͽ� �ο��ϱ�.

    --GRANT CREATE ANY VIEW TO pr;
    
--�ܼ��信 �� ���̺� �����

CREATE TABLE tmp
AS
    SELECT
        *
    FROM
        emp
    ;


--���� ���̺�� �ܼ� �� ���� (����̸�, �޿�)

CREATE VIEW tview
AS
    SELECT
        ename, sal
    FROM
        tmp
;

--�ܼ� ���� �������� ���̺� �����ٲٱ� (SMITH �޿��� 850���� )

UPDATE 
    tview
SET 
    sal = 850
WHERE
    ename = 'SMITH'
;

--���ϰ� ���Ϻ�� �׷��ռ� ����� ��ȸ�ϱ� (�μ��� : �����, �ִ�޿�, �ּұ޿�, �޿����, �޿��հ�)
-- 1. �����
CREATE VIEW tmpCalc
AS
    SELECT
        deptno dno, COUNT(*) cnt, MAX(sal) max, MIN(sal) min , ROUND(AVG(sal),2) avg, SUM(sal) sum
    FROM
        tmp
    GROUP BY
        deptno
;
-- 2. �μ��� ��ձ޿����� �޿��� ���� ������� ����̸�, �޿�, �μ���ձ޿�, �μ����� �� ��ȸ.

SELECT
    ename, sal, avg, cnt
FROM
    tmp, tmpCalc 
WHERE
    deptno = dno -- �������� Į���̸� �޶� ���̺� �˸��ƽ� ��� ��
    AND sal < avg -- �Ϲ�����
;
-- 3. ANSI ���� �������� Ǯ���

SELECT
     ename, sal, avg, cnt
FROM
    tmp JOIN tmpCalc 
ON
    deptno = dno
WHERE
    sal < avg
;

--������� �並 Ȯ���ϱ�(����Ŭ�� ��������ó��, �� ���̺��� ����)

SELECT 
    view_name, --���̸�
    text       --�信�� ����ϴ� ���� ���
FROM
    user_views --����Ŭ������ �� ���̺�
;

/* ����) �μ���ȣ�� 20���� ����� �̸�, ����, �μ���ȣ�� �� �� �ִ� �並 ���弼��.
        ��, ���� �� �� ���� ���� ������ �� ���� �ϼ���. (�ɼ��� ������ �Ǵ����� Ȯ���ϼ���) */
     
CREATE VIEW vd20
AS
    SELECT
        ename, job, deptno
    FROM
        tmp
    WHERE
        deptno = 20
WITH CHECK OPTION
;

-- �ɼ� ���� Ȯ���ϱ�

INSERT INTO 
     vd20
VALUES(
    '��浿', '����', 30
    ); --�μ���ȣ 20 �ƴϹǷ� ���� X

/* ����) ������ 'MANAGER'�� ������� �̸�, ����, �μ���ȣ�� �����ִ� �並 ���弼��.
        ��, ������ �Ұ����ϵ��� �ϼ���. �б��������θ� ���弼��. ( �ɼ��� ������ �Ǵ����� Ȯ���ϼ���) */
       
CREATE VIEW vd30
AS
    SELECT
        ename, job, deptno
    FROM
        tmp
    WHERE
        job = 'MANAGER'
    WITH READ ONLY
;

-- �ɼ� ���� Ȯ���ϱ�

INSERT INTO vd30
VALUES('����','������',30); --cannot perform a DML operation on a read-only view

/* ����) MEMBER ���̺��� ȸ�������� �����ִ� �並 ���弼��. ������ �÷���
         NAME, ID, MAIL ���� ������ �����̴�.
         1. ������ �� �����ϼ���  / 2. ���̺��� ����� ������ ������ ���ּ��� ( �����ͱ��� �־�� ������) */

--1. ���� �� ����
CREATE OR REPLACE FORCE VIEW memb_view
AS
    SELECT
        name, id, mail
    FROM
        member
    ;
    
--2. ���̺� �����
CREATE TABLE member(
    name VARCHAR2(15 CHAR),
    id VARCHAR2(10 CHAR),
    mail VARCHAR2(30 CHAR)
);

--3. ���̺� ������ �־��ָ� ������ ���� �������� ���ֱ�

INSERT INTO member
VALUES('��ο�','increpas','minwoo@increpas.com')
;


/* ���պ� ����) ����� �̸�, ����, �μ��̸�, �޿�, �޿����
   �� �� �� �ִ� ��(view01)�� tmp, dept, salgrade�� �̿��ؼ� ���弼��. */
   
CREATE VIEW view01
AS
    SELECT
        ename, job, dname, sal, grade
    FROM
        tmp t, dept d, salgrade
    WHERE
        t.deptno = d.deptno
        AND sal BETWEEN losal AND hisal
    ;
    
-- ANSI JOIN
CREATE VIEW view01
AS  
    SELECT
        ename, job, dname, sal, grade
    FROM
        tmp t JOIN dept d
    ON
        t.deptno = d.deptno
    JOIN
        salgrade
    ON 
        sal BETWEEN losal AND hisal
;

-- *************************** ���� �ָ��� �ѹ��� Ǯ���/ ��� + only ��������, ���θ��Ἥ*********************************************************
/*
    ���� �������� �ذ��� �並 ���� ó���ϼ���. 
    v10 �̶�� �並 ���� ó��.
*/ --�ʿ��� �׷��Լ����� �־ �並 �����ϸ��.
CREATE VIEW v10
AS
    SELECT
        AVG(sal) avg, MAX(sal) max
    FROM
        emp
;

/*
    ���� 1 ]
        ȸ�� ��� �޿����� �޿��� ���� �޴� �������
            ����̸�, �޿�, ȸ����ձ޿�
        �� ��ȸ�ϼ���.
*/
    SELECT
        ename, sal, avg 
    FROM
        emp, v10 
    WHERE
        sal < avg
    ;

-- �並 ������� �ʰ� ��ȸ��

SELECT
    ename, sal,(SELECT
                    AVG(sal)
                FROM
                    emp)
FROM
    emp
WHERE
    sal < (SELECT
                    AVG(sal)
                FROM
                    emp)
;

/*
    ���� 2 ]
        ȸ�� �ְ� �޿����� 
            �����ȣ, ����̸�, ����, �μ��̸�, �޿�, ȸ���ְ�޿�
        �� ��ȸ�ϼ���.
*/

SELECT
    empno, ename, job, dname, sal, max
FROM
    emp e, dept d, v10
WHERE
    e.deptno = d.deptno
    AND sal = max
;

    -- v02 ��� �並 ���� ó���ϼ���.  
 CREATE VIEW v02
 AS
    SELECT 
        deptno dno, SUM(sal) sum, MAX(sal) max, AVG(sal) avg, COUNT(*) cnt
    FROM
        emp
    GROUP BY
        deptno
;
/*
    ���� 3 ]
        �޿��� ���� ���� �޴� �μ��� �μ�������
            ����̸�, ����, �޿�, �μ��̸�, �μ��޿��հ�
        �� ��ȸ�ϼ���.
*/

SELECT
    ename, job, sal, dname, sum
FROM
    emp e, dept d, v02
WHERE
    e.deptno = d.deptno
    AND e.deptno = dno
    AND sum = ( SELECT
                    MAX(sum)
                FROM
                    v02)
;

--�並 ������� �ʰ� ��ȸ��

SELECT
    ename, job, sal, dname, sum
FROM
    emp e, dept d, 
                    (SELECT
                        deptno, SUM(sal) sum
                    FROM
                        emp
                    GROUP BY
                        deptno) a
WHERE
    e.deptno = d.deptno 
    AND e.deptno = a.deptno
    AND sum = (SELECT
                 Max(sum)
              FROM 
                (SELECT
                        deptno, SUM(sal) sum
                    FROM
                        emp
                    GROUP BY
                        deptno)
                        )
;

/*
    ���� 4 ]
        �μ� ��ձ޿����� �޿��� ���� �޴� �������
            ����̸�, �޿�, �޿����, �μ��̸�, �μ���ձ޿�
        �� ��ȸ�ϼ���.
*/
    SELECT
        ename, sal, grade, dname, avg
    FROM
        emp e, dept d, salgrade,  v02
    WHERE
        e.deptno = d.deptno
        AND e.deptno = dno
        AND sal BETWEEN losal AND hisal
        AND sal > avg
    ;
/*
    ���� 5 ]
        �μ������� ���� ���� �μ��� ����� 
        �μ���ձ޿����� �޿��� ���� �޴� �������
            ����̸�, ����, �޿�, �μ��̸�, �μ���ձ޿�, �μ�����
        �� ��ȸ�ϼ���.
*/
SELECT
    ename, job, sal, dname, avg, cnt
FROM
    emp e, dept d, v02
WHERE
    e.deptno = d.deptno
    AND e.deptno = dno
    AND sal < avg
    AND cnt = (SELECT
                    MAX(cnt)
                FROM
                    v02)
;

-- �������ǰ� ���������� �̿��ؼ� Ǯ���

--*************************** ROWNUM ���� *********************************************************

SELECT
    rownum, ename, sal
FROM
    emp
ORDER BY -------> ������ ó���Ѵ����� order by�� ������. �̹� rownum �� ���̰� �����ϹǷ� rownum ���ڰ� ��������.
    sal
;

-- ������� �޿������� �����ϰ� ROWNUM�� �ٿ�����.

SELECT
    ROWNUM, r.*
FROM
    (SELECT
        sal
    FROM
        emp
    ORDER BY
        sal
    ) r
;

--Ư�� ������ ROWNUM �̱�
/*

���� 6]
    ������� �Ի��� �������� �����ؼ�
    7��°���� 10��°���� �Ի��� ����鸸 
    �����ȣ, ����̸�, ����, �Ի����� ��ȸ�ϼ���
*/
SELECT
    rno, empno, ename, job, hiredate --> ���� ���� ���⼭ ���� ROWNUM �� �ο��ϸ� �ȵǰ�, �ζ��� �� �� �ο��ߴ� ROWNUM �� �˸��ƽ�
FROM
    (SELECT
        ROWNUM rno, r.*
    FROM
        (SELECT
            empno, ename, job, hiredate
        FROM
            emp
        ORDER BY
            hiredate) r)
WHERE
    rno BETWEEN 7 AND 10
;

commit;       
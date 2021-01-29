/*
<DML>
INSERT INTO - VALUES
UPDATE SET WHERE
DELETE FROM

<DDL>                                                                                                                                       
CREATE TABLE- AS  SELECT - FROM : ���̺� ����
CREATE TABLE- AS  SELECT - FROM WHERE ������ ������ ��ȯ�Ǵ� ���ǽ� : ���̺� ����                                                                  
ALTER TABLE ���̺� RENAME TO �������̸�;
ALTER TABLE ���̺��̸� ADD ( �÷��̸� ������Ÿ��(�ִ����) CONSTRAINT ���������߰� );
ALTER TABLE ���̺��̸� MODIFY �ʵ��̸�   ������Ÿ��(�������ִ�ũ��);
ALTER TABLE ���̺��̸� DROP COLUMN �÷��̸�;
ALTER TABLE ���̺��̸� RENAME COLUMN �÷��̸� TO ������̸�;
DROP TABLE ���̺��̸�;
DROP TABLE ���̺��̸� PURGE;
-������ ����-
PURGE RECYCLEBIN;
PURGE TABLE ���̺��̸�;
SHOW RECYCLEBIN;
FLASHBACK TABLE  ���̺��̸� TO BEFORE DROP;
TRUNCATE TABLE ���̺��̸�;

<��������>
NOT NULL -NN
DEFAULT 
UNIQUE -UK
PRIMARY KEY -PK
FOREIGN KEY -FK
CHECK -CK
--------------------------------------
<�������� - ���̺� ���鶧 ����>

1. ��� Į������ ���� (���� ��ȣ)

CREATE TABLE ���̺��̸�(
                    �÷��̸�    ������Ÿ��(�ִ����)
CONSTRAINT ���������̸�   PRIMARY KEY,
                    �÷��̸�    ������Ÿ��(�ִ����) [   DEFAULT ������     ]
CONSTRAINT ���������̸�   NOT NULL
CONSTRAINT ���������̸�   UNIQUE
CONSTRAINT ���������̸�   CHECK (�÷��̸� IN(������1, ������2, ...))
CONSTRAINT ���������̸�  REFERENCES  �������̺��̸�(�����÷��̸�), ...
);

1-1. ��� ���̺��� ���� ..NOT NULL�� ������ �ȉ�. --->���̺��� ���ǿ��� ���������̸��ڿ� �÷��̸� �־����

CREATE TABLE ���̺��̸�(
                    �÷��̸�1    ������Ÿ��(�ִ����),
                    �÷��̸�2    ������Ÿ��(�ִ����),
                    ....,
                    -- ���⼭���� �������� ���
                    CONSTRAINT  ���������̸�  PRIMARY KEY(�÷��̸�1),
                    CONSTRAINT  ���������̸�  FOREIGN KEY(�÷��̸�) REFERENCES �������̺��̸�(�����÷��̸�),
                    CONSTRAINT  ���������̸�  UNIQUE(�÷��̸�1),
                    CONSTRAINT  ���������̸�  CHECK(���ǽ�),
                );

2. ����(���������̸� -����Ŭ- �˾ƺ�����)

CREATE TABLE ���̺��̸�(
                    �÷��̸�    ������Ÿ��(�ִ����) UNIQUE NOT NULL); */

/*
<���̺� ������ ������>
������ PK / UK �� �ִ� �������̺��� ���� ���� �� FK ������ �� ���̺��� �� ���Ŀ� �����
������ FK�� �ִ� ���̺��� ���� �����ϰ� ->������ PK ���̺� ����

<DELETE/TRUNCATE ���̺� ������ ������>
*DELETE (DML)-- ���̺��� ��(����)�� �����
*TRUNCATE(DDL)-- ���̺��� ��(����)��ü�� ���� �ڸ��� - ��Ģ������ ������ �����

<���������̶� ��������>
�����ͺ��̽��� �������� ���Ἲ�� ��Ű������ �����Ͱ� ������ ���� ���¸� �����ϵ��� �ϴ� ��ɹ� �����̴�.
'CONSTRAINT ���������̸�'--> ���̿�
*/


--���� ����--

ALTER TABLE 
 comp
RENAME TO company;

ALTER TABLE 
    company
RENAME TO comp;

ALTER TABLE comp 
RENAME COLUMN isshow TO show;

ALTER TABLE 
    comp
RENAME COLUMN show TO isshow;

CREATE TABLE tmp
AS
    SELECT 
    *
    FROM 
    emp;

TRUNCATE TABLE tmp;

DROP TABLE tmp;
--------------------------------
INSERT INTO 
comp(ename)
VALUES
('��ġ'); ---> pk �� �����ȣ -> ��ġ�� �����ȣ�� ����.

CREATE TABLE tmp
AS
    SELECT
        *
    FROM
        emp
WHERE
    1 = 2;
    
INSERT INTO 
tmp(ename)
VALUES(
'����');

INSERT INTO 
tmp(ename,job)
VALUES(
'����','����');
--------------------------
INSERT INTO 
    comp(empno, ename, deptno)
VALUES(
(SELECT NVL(MAX(empno)+1,1001) FROM comp),
 '����', '50');
 
 CREATE TABLE tmp1(
    no NUMBER(4) PRIMARY KEY,
    name VARCHAR2(15 CHAR) NOT NULL) ;
--------------------------------------------------
CREATE TABLE tmp2(
    no NUMBER(4) 
        CONSTRAINT TMP2_NO_PK PRIMARY KEY,
    name VARCHAR2(15 CHAR) 
        CONSTRAINT TMP2_NAME_NN NOT NULL);

CREATE TABLE tmp3(
    no NUMBER(4),
    name VARCHAR2(15 CHAR),
    dno NUMBER(2),
    isshow CHAR(1) DEFAULT 'Y',
    CONSTRAINT TMP3_NO_PK PRIMARY KEY(no),
    CONSTRAINT TMP3_dno_FK FOREIGN KEY (dno) REFERENCES dept(deptno),
    CONSTRAINT TMP3_SHOW_CK CHECK (isshow IN ('Y','N'))
    );

TRUNCATE TABLE tmp;

ALTER TABLE
    tmp
MODIFY 
    empno PRIMARY KEY;
    
ALTER TABLE 
    tmp
MODIFY
    ename CONSTRAINT TMP_NAME_NN NOT NULL;

--ALTER TABLE ���̺��̸� RENAME COLUMN �÷��̸� TO ������̸�;

ALTER TABLE 
    tmp
RENAME CONSTRAINT SYS_C007072 TO TMP_NO_PK;

ALTER TABLE
    tmp
ADD
    CONSTRAINT TMP_DNO_FK FOREIGN KEY (deptno) REFERENCES dept(deptno);

CREATE TABLE tmp5(
    mno NUMBER(4),
    name VARCHAR2(15 CHAR),
    age NUMBER(3),
    mail VARCHAR2(30 CHAR)
);

INSERT INTO
    tmp5(name)
VALUES(
    'ȫ�浿');
    
DROP TABLE tmp5; 



SHOW RECYCLEBIN;
PURGE RECYCLEBIN;

--mno,name,age,mail : tmp5

CREATE TABLE 
    tmp5(
    mno NUMBER(4),
    name VARCHAR2(15 CHAR),
    age NUMBER(3),
    mail VARCHAR2(30 CHAR)
    );

ALTER TABLE
    tmp5
ADD
    CONSTRAINT TMP5_NO_PK PRIMARY KEY(mno);
    
ALTER TABLE
    tmp5
MODIFY
    name CONSTRAINT TMP5_NAME_NN NOT NULL;

ALTER TABLE
    tmp5
MODIFY
    age CONSTRAINT TMP5_AGE_NN NOT NULL;
    
--tmp 6 mno, name, age, mail

CREATE TABLE tmp6(
    mno NUMBER(4),
    name VARCHAR2(15 CHAR),
    age NUMBER(3),
    mail VARCHAR2(30 CHAR)
    );
-- TMP6.MNO �� TMP6_NO_PK��� �̸����� �⺻Ű �������� �߰�

ALTER TABLE
    tmp6
ADD
    CONSTRAINT TMP6_NO_PK PRIMARY KEY (mno);
    
-- tmp6 ���̺��� name, age �÷��� not null ���������� ����� ������� �߰��ϼ���.
-- ���� ���� �̸��� 
--          TMP6_NAME_NN, TMP6_AGE_NN

ALTER TABLE
    tmp6
MODIFY
    name CONSTRAINT TMP6_NAME_NN NOT NULL;
    
ALTER TABLE
    tmp6
MODIFY  
    age CONSTRAINT TMP6_AGE_NN NOT NULL;
    
ALTER TABLE
    tmp6
ADD (dno NUMBER(2));


/*
    TMP6 ���̺��� DNO �÷���
    TMP6_DNO_NN �̶�� �̸����� NOT NULL ����������
    TMP6_DNO_FK ��� �̸����� ����Ű ���������� �ο��ϼ���.
    ��, ���� ���̺�� �÷��� DEPT���̺��� DEPTNO �÷��� �����մϴ�.
*/
ALTER TABLE tmp6
MODIFY
    dno CONSTRAINT TMP6_DNO_NN NOT NULL;
    
ALTER TABLE tmp6
ADD
    CONSTRAINT TMP6_DNO_FK FOREIGN KEY (dno) REFERENCES dept(deptno); ---����Ű�� �����Ǵ� ���̺��� �⺻Ű�̰ų� / ����Ű

/*
�������� ��ȸ
USER_CONSTRAINTS ���̺��� �÷�
                
                OWNER               - �������� ������(����)
                CONSTRAINT_NAME     - �������� �̸�
                TABLE_NAME          - ���̺��̸�
                CONSTRAINT_TYPE
���Ἲ �������� ���¸� ��Ÿ���� �κ�
                        P   - PRIMARY KEY
                        R   - FOREIGN KEY
                        U   - UNIQUE
                        C   - CHECK �Ǵ� NOT NULL

*/
SELECT
 *
FROM
user_constraints
;

SELECT
    constraint_name, table_name, constraint_type
FROM    
    user_constraints
WHERE
    table_name = 'TMP6';

/*
    ���� ���� �����ϱ�
        
        ���� ]
            ALTER TABLE ���̺��̸�
            DROP CONSTRIANT ���������̸�;
            
        ���� ]
            �⺻����������(PRIMARY KEY)�� ��� �̸��� ���� ������ �� �ִ�.
            ������
                �⺻Ű ���������� ���̺� �Ѱ��� �߰��� �� �ֱ� �����̴�.
                
            �������� ]
                ALTER TABLE ���̺��̸�
                DROP PRIMARY KEY;
*/

ALTER TABLE tmp6
DROP CONSTRAINT TMP6_DNO_FK;

CREATE TABLE buseo
AS
    SELECT
        *
    FROM
        dept ;

ALTER TABLE buseo
ADD
    CONSTRAINT BUSEO_NO_PK PRIMARY KEY(deptno);

ALTER TABLE tmp6
ADD
    CONSTRAINT TMP6_DNO_FK FOREIGN KEY (dno) REFERENCES buseo(deptno);
        


/*
�ñ������� �Խ��� ���̺��� ������̴�. ���̺��� 11���� �����͸� ���� ���̴�.
�Խ����� bno (�۹�ȣ) : PK / bmno(ȸ����ȣ) :FK -> ��� ���̺��� PK: mno(ȸ����ȣ ����) /
��� ���̺��� ano(�ƹ�Ÿ��ȣ) FK -> �ƹ�Ÿ���̺��� PK : ano(�ƹ�Ÿ ��ȣ) ����
-->�� :avatar ���̺� ano��ȣ�� member ���̺��� mno�� ��ȣ�� ���ƾ��ϰ�,
        board ���̺��� bmno ��ȣ�� member ���̺��� mno�� ��ȣ�� ���ƾ��Ѵ�.
        �Խ��� ���̺� 11���� �����͸� ������� avatar �� member ���̺��� 11���� �����Ͱ� �ʿ��ϴ�.
-->�׷��� ������ �Խ��� ���̺� ������ bmno FK �������ǿ���  parent key not found ���� �߻�
*/


--�ƹ�Ÿ ���̺� �����--
CREATE TABLE avatar(
    ano NUMBER(2)
        CONSTRAINT PR_AVT_NO_PK PRIMARY KEY,
    savename VARCHAR2(50 CHAR)
        CONSTRAINT PR_SNAME_UK UNIQUE
        CONSTRAINT PR_SNAME_NN NOT NULL,
    dir VARCHAR2(100 CHAR) DEFAULT '/img/avatar'
        CONSTRAINT PR_DIR_NN NOT NULL,
    gen CHAR(1)
        CONSTRAINT PR_GEN_CK CHECK (gen IN('M', 'F', 'H'))
        CONSTRAINT PR_GEN_NN NOT NULL,
    adate DATE DEFAULT SYSDATE
        CONSTRAINT PR_DATE_NN NOT NULL
);
-- �ƹ�Ÿ ���̺� ����� ������ �����
CREATE SEQUENCE pr_avt_seq 
    START WITH 11;
    
-- �ƹ�Ÿ ���̺� ������ �ֱ�(11��)
INSERT INTO 
    avatar(ano, savename, gen)
VALUES(pr_avt_seq.NEXTVAL, 'img_avatar1.png', 'M')
;
    
INSERT INTO 
    avatar(ano, savename, gen)
VALUES(pr_avt_seq.NEXTVAL, 'img_avatar2.png', 'M')
;

INSERT INTO 
    avatar(ano, savename, gen)
VALUES(pr_avt_seq.NEXTVAL, 'img_avatar3.png', 'M')
;    

INSERT INTO 
    avatar(ano, savename, gen)
VALUES(pr_avt_seq.NEXTVAL, 'img_avatar4.png', 'F')
;

INSERT INTO 
    avatar(ano, savename, gen)
VALUES(pr_avt_seq.NEXTVAL, 'img_avatar5.png', 'F')
;

INSERT INTO 
    avatar(ano, savename, gen)
VALUES(pr_avt_seq.NEXTVAL, 'img_avatar6.png', 'F')
;

INSERT INTO 
    avatar(ano, savename, gen)
VALUES(pr_avt_seq.NEXTVAL, 'noimage.jpg', 'H')
;    

INSERT INTO 
    avatar(ano, savename, gen)
VALUES(pr_avt_seq.NEXTVAL, 'img_avatar8.png', 'M')
; 

INSERT INTO 
    avatar(ano, savename, gen)
VALUES(pr_avt_seq.NEXTVAL, 'img_avatar9.png', 'M')
; 

INSERT INTO 
    avatar(ano, savename, gen)
VALUES(pr_avt_seq.NEXTVAL, 'img_avatar10.png', 'F')
; 

INSERT INTO 
    avatar(ano, savename, gen)
VALUES(pr_avt_seq.NEXTVAL, 'img_avatar11.png', 'F')
; 


--ȸ�� ���̺� �����--
CREATE TABLE MEMBER(
    mno NUMBER(4)
        CONSTRAINT PR_MEM_NO_PK PRIMARY KEY,
    id VARCHAR2(10 CHAR)
        CONSTRAINT PR_MEM_ID_UK UNIQUE
        CONSTRAINT PR_MEM_ID_NN NOT NULL,
    pw VARCHAR2(8 CHAR) 
        CONSTRAINT PR_MEM_PW_NN NOT NULL,
    name VARCHAR2(30 CHAR) 
        CONSTRAINT PR_MEM_NAME_NN NOT NULL,
    tel VARCHAR2(20 CHAR)
        CONSTRAINT PR_MEM_TEL_UK UNIQUE
        CONSTRAINT PR_MEM_TEL_NN NOT NULL,
    mail VARCHAR2(50 CHAR)
        CONSTRAINT PR_MEM_MAIL_UK UNIQUE
        CONSTRAINT PR_MEM_MAIL_NN NOT NULL,
    gen CHAR(1)
        CONSTRAINT PR_MEM_GEN_CK CHECK (gen IN ('M','F','H'))
        CONSTRAINT PR_MEM_GEN_NN NOT NULL,
    ano NUMBER(2)
        CONSTRAINT PR_MEM_ANO_FK REFERENCES avatar(ano)
        CONSTRAINT PR_MEM_ANO_NN NOT NULL,
    bdate CHAR(10)
        CONSTRAINT PR_MEM_BDATE_NN NOT NULL,
    adate DATE DEFAULT sysdate
        CONSTRAINT PR_MEM_ADATE_NN NOT NULL,
    isshow CHAR(1) DEFAULT 'Y'
        CONSTRAINT PR_MEM_SHOW_CK CHECK( isshow IN ('Y','N'))
        CONSTRAINT PR_MEM_SHOW_NN NOT NULL
);
--������̺��� �� ������ �����    
CREATE SEQUENCE PR_M_SEQ01
    START WITH 1001
    MAXVALUE 9999;


--������̺� ������ �ֱ�(11��)      
INSERT INTO 
    member(mno, id, pw, name, tel, mail, gen, ano, bdate)
VALUES(
    PR_M_SEQ01.NEXTVAL, 'jun', '12345', '����', '010-1111-1111', 'jun@increpas.com','M','11','1867/05/05');

INSERT INTO 
    member(mno, id, pw, name, tel, mail, gen, ano, bdate)
VALUES(
    PR_M_SEQ01.NEXTVAL, 'jan', '12345', '��ġ', '010-2222-2222', 'jen@increpas.com','M','12','1878/05/05');

INSERT INTO 
    member(mno, id, pw, name, tel, mail, gen, ano, bdate)
VALUES(
    PR_M_SEQ01.NEXTVAL, 'ben', '12345', '����', '010-3333-3333', 'ben@increpas.com','M','13','1999/05/05');

INSERT INTO 
    member(mno, id, pw, name, tel, mail, gen, ano, bdate)
VALUES(
    PR_M_SEQ01.NEXTVAL, 'cat', '12345', '�����', '010-4444-4444', 'cat@increpas.com','F','14','1997/05/05');

INSERT INTO 
    member(mno, id, pw, name, tel, mail, gen, ano, bdate)
VALUES(
    PR_M_SEQ01.NEXTVAL, 'jane', '12345', '�ϸ�', '010-5555-5555', 'jane@increpas.com','F','15','1867/05/05');

INSERT INTO 
    member(mno, id, pw, name, tel, mail, gen, ano, bdate)
VALUES(
    PR_M_SEQ01.NEXTVAL, 'ron', '12345', '����', '010-6666-6666', 'ron@increpas.com','F','16','1998/05/05');

INSERT INTO 
    member(mno, id, pw, name, tel, mail, gen, ano, bdate)
VALUES(
    PR_M_SEQ01.NEXTVAL, 'maya', '12345', '�Ź�', '010-7777-7777', 'maya@increpas.com','H','17','1981/05/05');
    
INSERT INTO 
    member(mno, id, pw, name, tel, mail, gen, ano, bdate)
VALUES(
    PR_M_SEQ01.NEXTVAL, 'yen', '12345', '����', '010-8888-8888', 'yen@increpas.com','M','18','1977/05/05');
    
INSERT INTO 
    member(mno, id, pw, name, tel, mail, gen, ano, bdate)
VALUES(
    PR_M_SEQ01.NEXTVAL, 'jamie', '12345', '��', '010-9999-9999', 'jamie@increpas.com','M','19','1998/09/05');

INSERT INTO 
    member(mno, id, pw, name, tel, mail, gen, ano, bdate)
VALUES(
    PR_M_SEQ01.NEXTVAL, 'lyn', '12345', '��', '010-1010-1010', 'lyn@increpas.com','F','20','1996/04/05');

INSERT INTO 
    member(mno, id, pw, name, tel, mail, gen, ano, bdate)
VALUES(
    PR_M_SEQ01.NEXTVAL, 'jack', '12345', '���', '010-1100-1100', 'jack@increpas.com','F','21','1979/10/05');
    
    
---------���� �ƹ�Ÿ���̺�� ������̺��� �����ؼ� ��� ��ȸ�ϱ�
SELECT
    mno ȸ����ȣ, id ���̵�, name �̸�, mail ����, tel ��ȭ��ȣ, 
    DECODE(m.gen,'M','����',
                 'F', '����',
                  '���') ����, CONCAT(CONCAT(dir,'/'), savename) �ƹ�Ÿ���
FROM
    avatar a, member m
WHERE
    a.ano = m.ano
;

-- �Խ��� ���̺� �����--
/*
�Խ����� bno (�۹�ȣ) : PK / bmno(ȸ����ȣ) :FK -> ��� ���̺��� PK: mno(ȸ����ȣ ����) /
��� ���̺��� ano(�ƹ�Ÿ��ȣ) FK -> �ƹ�Ÿ���̺��� PK : ano(�ƹ�Ÿ ��ȣ) ����

�Խ��� ���̺� ���� �÷�
bno(�۹�ȣ), title(����), body(����), bmno(�ۼ���), wdate(�ۼ���), click(��ȸ��), isschow(���⿩��)
*/

CREATE TABLE board(
    bno NUMBER(6)
        CONSTRAINT PR_BRD_NO_PK PRIMARY KEY,
    title VARCHAR2(50 CHAR)
        CONSTRAINT PR_BRD_TITLE_NN NOT NULL,
    body VARCHAR2(4000 CHAR) 
        CONSTRAINT PR_BRD_BODY_NN NOT NULL,
    bmno NUMBER(4)
        CONSTRAINT PR_BRD_MNO_FK REFERENCES member(mno)
        CONSTRAINT PR_BRD_MNO_NN NOT NULL,
    wdate DATE DEFAULT sysdate
        CONSTRAINT PR_BRD_DATE_NN NOT NULL,
    click NUMBER(6) DEFAULT 0
        CONSTRAINT PR_BRD_CLIKC_NN NOT NULL,
    isshow CHAR(1) DEFAULT 'Y'
        CONSTRAINT PR_BRD_SHOW_CK CHECK(isshow IN('Y','N'))
        CONSTRAINT PR_BRD_SHOW_NN NOT NULL
    );

-- �Խ��� ���̺� ����� ������ �����--
CREATE SEQUENCE PR_BRD_SEQ;

-- �Խ��� ���̺� ������ �ֱ�(11��)--
INSERT INTO board(
    bno, title, body, bmno)
VALUES(pr_brd_seq.NEXTVAL, '�Խñ� ����1', '�Խñ� ����1', 1001
    );
    
INSERT INTO board(
    bno, title, body, bmno)
VALUES(pr_brd_seq.NEXTVAL, '�Խñ� ����2', '�Խñ� ����2', 1002
    );
    
INSERT INTO board(
    bno, title, body, bmno)
VALUES(pr_brd_seq.NEXTVAL, '�Խñ� ����3', '�Խñ� ����3', 1003
    );
    
INSERT INTO board(
    bno, title, body, bmno)
VALUES(pr_brd_seq.NEXTVAL, '�Խñ� ����4', '�Խñ� ����4', 1004
    );
    
INSERT INTO board(
    bno, title, body, bmno)
VALUES(pr_brd_seq.NEXTVAL, '�Խñ� ����5', '�Խñ� ����5', 1005
    );
    
INSERT INTO board(
    bno, title, body, bmno)
VALUES(pr_brd_seq.NEXTVAL, '�Խñ� ����6', '�Խñ� ����6', 1006
    );

INSERT INTO board(
    bno, title, body, bmno)
VALUES(pr_brd_seq.NEXTVAL, '�Խñ� ����7', '�Խñ� ����7', 1007
    );

INSERT INTO board(
    bno, title, body, bmno)
VALUES(pr_brd_seq.NEXTVAL, '�Խñ� ����8', '�Խñ� ����6', 1008
    );

INSERT INTO board(
    bno, title, body, bmno)
VALUES(pr_brd_seq.NEXTVAL, '�Խñ� ����9', '�Խñ� ����9', 1009
    );
    
INSERT INTO board(
    bno, title, body, bmno)
VALUES(pr_brd_seq.NEXTVAL, '�Խñ� ����10', '�Խñ� ����10', 1010
    );
    
INSERT INTO board(
    bno, title, body, bmno)
VALUES(pr_brd_seq.NEXTVAL, '�Խñ� ����11', '�Խñ� ����11', 1011
    );    
-------------------------------------------------�������� pr �������� �۾�. 
/*
<SQL PLUS ������ ��������, ���� : ������ ���������� ����>

1. ����
CREATE USER �����̸� IDENTIFIED BY ��й�ȣ [ACCOUNT UNLOCK];

2.���Ѻο�
�����  RESOURCE �� CONNECT�� ���� ���̴� ���ѿ� ���� ��
GRANT RESOURCE, CONNECT TO �����̸� [ WITH ADMIN OPTION- ������ ���ѱ��� ����];
GRANT CREATE SESSION TO �����̸� 

3. �ٸ��������� ��ȯ
CONN �����̸�/���;

4. ������ ������ �ƴ� �ش�������� �ٲ۴����� ���̺� �������� �Ѵ�.

-- ���̺��� �����ϴµ� ���̺� �����̽� ������-- ���̺� �����̽� �����ϱ�
ALTER USER �����̸� DEFAULT TABLESPACE  ���̺����̽��̸�; --->SYSTEM ���� �Ǿ������� USERS�� �ٲ���

5. �ٸ� ������ ������ �ִ� ���̺��� �����ؼ� ������

CREATE ������ ���̺� �̸�
AS 
    SELECT
        *
    FROM 
        ������ �����Ͱ� �ִ� ���̺��̸�.������ ���̺�
;

����] �ý��� ������ ����� �� ��� Ǯ��

--sqlplus / as sysdba �� ���� 
--> �ý��� ���� ���� : ���� ��������� ALTER USER system IDENTIFIED BY increpas ACCOUNT UNLOCK;

*/

/*
<SQL DEVELPER ������ ��������, ����: ���� ������ ����>
1. hello / increpas ������ ���弼��
2. SCOTT ������ emp, dept, salgrade, bonus �� �����ؼ� ���̺��� ���弼��
3. ������ ������ ���̺���� ���������� Ȯ���ϰ� ������ ���̺� �ο��ϼ���
*/

-- �ý��� �������� ��ȯ hello ���� �����ϱ�
CREATE USER hello IDENTIFIED BY increaps ACCOUNT UNLOCK;

--������ �ο��ϱ�
GRANT RESOURCE, CONNECT, SELECT ANY TABLE TO hello;

--���� hello ������ + �� ���������� �������ش�.
-- �׽�Ʈ �� ���� hello�� �����ؼ� ���̺� �����
CREATE TABLE emp
AS
    SELECT 
        *
    FROM
        SCOTT.emp
;

CREATE TABLE dept
AS
    SELECT 
        *
    FROM
        SCOTT.dept
;

CREATE TABLE salgrade
AS
    SELECT 
        *
    FROM
        SCOTT.salgrade
;

CREATE TABLE bonus
AS
    SELECT 
        *
    FROM
        SCOTT.bonus
;

--SCOTT ������ ���� ���̺��� �����Ϸ� �������� ��������

ALTER TABLE 
    emp
ADD
    CONSTRAINT HELLO_EMP_ENO_PK PRIMARY KEY(empno);
    
-- ************�߿�:EMP �� FK�� �ɶ� DEPT ���̺��� ���� deptno�� ���� �⺻Ű�� ���������Ŀ� FK�� �� �� ����*******************    
ALTER TABLE
    dept
ADD
    CONSTRAINT HELLO_DEPT_NO_PK PRIMARY KEY(deptno);
    
ALTER TABLE
    emp
ADD
    CONSTRAINT HELLO_EMP_NO_FK FOREIGN KEY (deptno) REFERENCES dept(deptno);

ALTER TABLE
    emp
MODIFY
    ename CONSTRAINT HELLO_EMP_NAME_NN NOT NULL;
    
ALTER TABLE
    emp
MODIFY
    job CONSTRAINT HELLO_EMP_JOB_NN NOT NULL;

ALTER TABLE
    emp
MODIFY
    hiredate CONSTRAINT HELLO_EMP_DATE_NN NOT NULL;
    
ALTER TABLE
    emp
MODIFY
    sal CONSTRAINT HELLO_EMP_SAL_NN NOT NULL;

ALTER TABLE
    emp
MODIFY
    deptno CONSTRAINT HELLO_EMP_DNO_NN NOT NULL;

ALTER TABLE
    salgrade
ADD 
    CONSTRAINT HELLO_SGRD_GRD_PK PRIMARY KEY(grade);
    
ALTER TABLE
    dept
MODIFY
    dname CONSTRAINT HELLO_DEPT_NAME_NN NOT NULL;
    
--���� ] ���̺� ������ nullable �� MODIFY ��ɾ�� NOT NULL�� �ɾ��ٶ�,
-- �ش�Į���� �̹� NULL ���� �����Ѵٸ� NOT NULL �� �ɾ��� �� ����.

--����] ���� �ٸ� �������� �����ؿ� ���̺��� �̸��� ���Ƶ� ���������� �������̺�� �ٸ��� ��������� �Ѵ�.


/*
PR ������ �������
  MEMBER, AVATER, BOARD ���̺��� HELLO ������ �����ؼ� ����� �������Ǳ��� �ο��ϼ���  
*/

-- PR �������� ���̺� �����ؼ� �����
CREATE TABLE member
AS
    SELECT
        *
    FROM
        PR.member
;

CREATE TABLE board
AS
    SELECT
        *
    FROM
        PR.board
;

--�������� �߰�
/* �߿�]******* ���̺� ����� NOT NULL �� ������ �ɷ��ִ� ��� NOT NULL ������ �״�� �ڵ����� ��������,
���������� �̸��� ����Ŭ�� �˾Ƽ� ���ع�����.
*/

ALTER TABLE avatar
ADD
    CONSTRAINT HELLO_AVT_ANO_PK PRIMARY KEY(ano);
    
ALTER TABLE avatar
ADD
    CONSTRAINT HELLO_AVT_SNAME_UK UNIQUE(savename);
    
ALTER TABLE avatar
ADD
    CONSTRAINT HELLO_AVT_GEN_CK CHECK (gen IN ('M','F','H'))
;

ALTER TABLE member
ADD
    CONSTRAINT HELLO_MEM_MNO_PK PRIMARY KEY(mno);

ALTER TABLE member
ADD
    CONSTRAINT HELLO_MEM_ANO_FK FOREIGN KEY (ano) REFERENCES avatar(ano);
    
ALTER TABLE member
ADD
    CONSTRAINT HELLO_MEM_GEN_CH CHECK(gen IN ('M','F','H'));

ALTER TABLE member
ADD 
    CONSTRAINT HELLO_MEM_ID_UK UNIQUE(id);
    
ALTER TABLE member
ADD 
    CONSTRAINT HELLO_MEM_mail_UK UNIQUE(mail);
    
ALTER TABLE member
ADD
    CONSTRAINT HELLO_MEM_SHOW_CK CHECK(isshow IN ('Y','N'));

ALTER TABLE member
ADD
    CONSTRAINT HELLO_MEM_TEL_UK UNIQUE(tel);
    
ALTER TABLE board
ADD
    CONSTRAINT HELLO_BRD_SHOW_CK CHECK (isshow IN ('Y','N'));

ALTER TABLE board
ADD
    CONSTRAINT HELLO_BRD_BNO_PK PRIMARY KEY(bno);

ALTER TABLE board
ADD
    CONSTRAINT HELLO_BRD_MNO_FK FOREIGN KEY(bmno) REFERENCES member(mno);
    
---------------�ڵ����� ������ NULL ���������� �̸� �ٲ��ֱ�--------------
ALTER TABLE avatar
RENAME CONSTRAINT SYS_C007333 TO HELLO_AVT_SNAME_NN;

ALTER TABLE avatar
RENAME CONSTRAINT SYS_C007334 TO HELLO_AVT_DIR_NN;

ALTER TABLE avatar
RENAME CONSTRAINT SYS_C007335 TO HELLO_AVT_GEN_NN;

ALTER TABLE avatar
RENAME CONSTRAINT SYS_C007336 TO HELLO_AVT_DATE_NN;

ALTER TABLE member
RENAME CONSTRAINT SYS_C007323 TO HELLO_MEM_ID_NN;

ALTER TABLE member
RENAME CONSTRAINT SYS_C007324 TO HELLO_MEM_PW_NN;

ALTER TABLE member
RENAME CONSTRAINT SYS_C007325 TO HELLO_MEM_NAME_NN;

ALTER TABLE member
RENAME CONSTRAINT SYS_C007326 TO HELLO_MEM_TEL_NN;

ALTER TABLE member
RENAME CONSTRAINT SYS_C007327 TO HELLO_MEM_MAIL_NN;

ALTER TABLE member
RENAME CONSTRAINT SYS_C007328 TO HELLO_MEM_GEN_NN;

ALTER TABLE member
RENAME CONSTRAINT SYS_C007329 TO HELLO_MEM_ANO_NN;

ALTER TABLE member
RENAME CONSTRAINT SYS_C007330 TO HELLO_MEM_BDATE_NN;

ALTER TABLE member
RENAME CONSTRAINT SYS_C007332 TO HELLO_MEM_SHOW_NN;

ALTER TABLE member
RENAME CONSTRAINT SYS_C007331 TO HELLO_MEM_ADATE_NN;

ALTER TABLE board
RENAME CONSTRAINT SYS_C007337 TO HELLO_BRD_TITLE_NN;

ALTER TABLE board
RENAME CONSTRAINT SYS_C007338 TO HELLO_BRD_BODY_NN;

ALTER TABLE board
RENAME CONSTRAINT SYS_C007339 TO HELLO_BRD_MNO_NN;

ALTER TABLE board
RENAME CONSTRAINT SYS_C007340 TO HELLO_BRD_WDATE_NN;

ALTER TABLE board
RENAME CONSTRAINT SYS_C007341 TO HELLO_BRD_CLICK_NN;

ALTER TABLE board
RENAME CONSTRAINT SYS_C007342 TO HELLO_BRD_SHOW_NN;

--<���ִٰ� ��ħ�� ����>--
/*
�̹� ���� board ���̺��
�Խ��� ���̺� ������ �� 11������ �ֱ�
    �Խ��� ���̺��� ��ȸ�� ��
    �� �������� �� �� �ִ� �Խñ� ���� 3���� �ϰ� (�ʼ�) -->insert
    �� ���������� �̵������� ������ ���� 3���� �ϼ���.(�ɼ�) --> rownum, select
    
    �۹�ȣ | ���� | �ۼ��� | �ۼ���   | ��ȸ�� |
    ------------------------------------------------
    1001    TEST    euns    2021/02/04   0
    1002    TEST    euns    2021/02/04   0
    1003    TEST    euns    2021/02/04   0
    --------------------------------------------------
            [����] [1] [2] [3] [����]  ------> �������� ������ ������ �������;ߴ�
            
            ������ �� ���� : ��ü ���� ������ 3/ �ƿ� �Խñ��� ���� ��쳪 �׷���� +1 �������
            ���������� �Խñ��� 10�� ���������� 10 /3 �׷� ������ 1�� ���� +1�������
            
            ���� FLOOR �� �����κи� �߶��ָ��
            
            ��) select 0 / 3 from dual;
*/

/* �ָ��� ������ (DAY 13 ) , �ε��� (DAY 14) ���� */
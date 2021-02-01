/*
<DML>
INSERT INTO - VALUES
UPDATE SET WHERE
DELETE FROM

<DDL>                                                                                                                                       
CREATE TABLE- AS  SELECT - FROM : 테이블 복사
CREATE TABLE- AS  SELECT - FROM WHERE 무조건 거짓이 반환되는 조건식 : 테이블 복사                                                                  
ALTER TABLE 테이블 RENAME TO 변경할이름;
ALTER TABLE 테이블이름 ADD ( 컬럼이름 데이터타입(최대길이) CONSTRAINT 제약조건추가 );
ALTER TABLE 테이블이름 MODIFY 필드이름   데이터타입(변경할최대크기);
ALTER TABLE 테이블이름 DROP COLUMN 컬럼이름;
ALTER TABLE 테이블이름 RENAME COLUMN 컬럼이름 TO 변경될이름;
DROP TABLE 테이블이름;
DROP TABLE 테이블이름 PURGE;
-휴지통 관련-
PURGE RECYCLEBIN;
PURGE TABLE 테이블이름;
SHOW RECYCLEBIN;
FLASHBACK TABLE  테이블이름 TO BEFORE DROP;
TRUNCATE TABLE 테이블이름;

<제약조건>
NOT NULL -NN
DEFAULT 
UNIQUE -UK
PRIMARY KEY -PK
FOREIGN KEY -FK
CHECK -CK
--------------------------------------
<제약조건 - 테이블 만들때 지정>

1. 명시 칼럼레벨 정의 (가장 선호)

CREATE TABLE 테이블이름(
                    컬럼이름    데이터타입(최대길이)
CONSTRAINT 제약조건이름   PRIMARY KEY,
                    컬럼이름    데이터타입(최대길이) [   DEFAULT 데이터     ]
CONSTRAINT 제약조건이름   NOT NULL
CONSTRAINT 제약조건이름   UNIQUE
CONSTRAINT 제약조건이름   CHECK (컬럼이름 IN(데이터1, 데이터2, ...))
CONSTRAINT 제약조건이름  REFERENCES  참조테이블이름(참조컬럼이름), ...
);

1-1. 명시 테이블레벨 정의 ..NOT NULL은 적용이 안. --->테이블레벨 정의에선 제약조건이름뒤에 컬럼이름 넣어야함

CREATE TABLE 테이블이름(
                    컬럼이름1    데이터타입(최대길이),
                    컬럼이름2    데이터타입(최대길이),
                    ....,
                    -- 여기서부터 제약조건 명시
                    CONSTRAINT  제약조건이름  PRIMARY KEY(컬럼이름1),
                    CONSTRAINT  제약조건이름  FOREIGN KEY(컬럼이름) REFERENCES 참조테이블이름(참조컬럼이름),
                    CONSTRAINT  제약조건이름  UNIQUE(컬럼이름1),
                    CONSTRAINT  제약조건이름  CHECK(조건식),
                );

2. 무명(제약조건이름 -오라클- 알아보기어렵)

CREATE TABLE 테이블이름(
                    컬럼이름    데이터타입(최대길이) UNIQUE NOT NULL); */

/*
<테이블 생성시 주의점>
참조할 PK / UK 가 있는 참조테이블을 먼저 생성 후 FK 조건을 걸 테이블은 그 이후에 만든다
삭제는 FK가 있는 테이블을 먼저 삭제하고 ->참조한 PK 테이블 순서

<DELETE/TRUNCATE 테이블 삭제의 차이점>
*DELETE (DML)-- 테이블의 셀(공간)을 남긴다
*TRUNCATE(DDL)-- 테이블의 셀(공간)자체를 전부 자른다 - 원칙적으로 복구가 어려움

<제약조건이란 문장으로>
데이터베이스의 데이터의 무결성을 지키기위해 데이터가 결함이 없는 상태를 유지하도록 하는 기능및 제약이다.
'CONSTRAINT 제약조건이름'--> 같이옴
*/


--예제 연습--

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
('또치'); ---> pk 는 사원번호 -> 또치는 사원번호가 없음.

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
'희동이');

INSERT INTO 
tmp(ename,job)
VALUES(
'희동이','사장');
--------------------------
INSERT INTO 
    comp(empno, ename, deptno)
VALUES(
(SELECT NVL(MAX(empno)+1,1001) FROM comp),
 '희동이', '50');
 
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

--ALTER TABLE 테이블이름 RENAME COLUMN 컬럼이름 TO 변경될이름;

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
    '홍길동');
    
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
-- TMP6.MNO 에 TMP6_NO_PK라는 이름으로 기본키 제약조건 추가

ALTER TABLE
    tmp6
ADD
    CONSTRAINT TMP6_NO_PK PRIMARY KEY (mno);
    
-- tmp6 테이블의 name, age 컬럼에 not null 제약조건을 명식적 방법으로 추가하세요.
-- 제약 조건 이름은 
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
    TMP6 테이블의 DNO 컬럼에
    TMP6_DNO_NN 이라는 이름으로 NOT NULL 제약조건을
    TMP6_DNO_FK 라는 이름으로 참조키 제약조건을 부여하세요.
    단, 참조 테이블과 컬럼은 DEPT테이블의 DEPTNO 컬럼을 참조합니다.
*/
ALTER TABLE tmp6
MODIFY
    dno CONSTRAINT TMP6_DNO_NN NOT NULL;
    
ALTER TABLE tmp6
ADD
    CONSTRAINT TMP6_DNO_FK FOREIGN KEY (dno) REFERENCES dept(deptno); ---참조키는 참조되는 테이블에서 기본키이거나 / 유일키

/*
제약조건 조회
USER_CONSTRAINTS 테이블의 컬럼
                
                OWNER               - 제약조건 소유자(계정)
                CONSTRAINT_NAME     - 제약조건 이름
                TABLE_NAME          - 테이블이름
                CONSTRAINT_TYPE
무결성 제약조건 형태를 나타내는 부분
                        P   - PRIMARY KEY
                        R   - FOREIGN KEY
                        U   - UNIQUE
                        C   - CHECK 또는 NOT NULL

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
    제약 조건 삭제하기
        
        형식 ]
            ALTER TABLE 테이블이름
            DROP CONSTRIANT 제약조건이름;
            
        참고 ]
            기본기제약조건(PRIMARY KEY)의 경우 이름을 몰라도 삭제할 수 있다.
            이유는
                기본키 제약조건은 테이블에 한개만 추가할 수 있기 때문이다.
                
            삭제형식 ]
                ALTER TABLE 테이블이름
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
        


/*
 1. < 뷰 >
 ==> 물리적으로 만들어져 있지 않는 테이블 : 질의 명령처리를 좀더 손쉽게
     테이블의 부분을 보게해주는 창문.
 
 1) 단순뷰 : 하나의 테이블만 이용해서 만든 뷰 ( DML명령 (SELECT, INSERT, UPDATE, DELETE) 수정도 가능)
        
        - 형식] CREATE VIEW 뷰이름
               AS
                뷰에서 볼 데이터위한 질의명령
               ;
               
        - 옵션 1 : 볼 수 없는 데이터 입력 차단 옵션]
        
             CREATE VIEW 뷰이름
             AS
                질의명령
            WITH CHECK OPTION
            ;
            
         - 옵션 2 : 보는 용도로만 생성되는 뷰 옵션(뷰 수정시: 테이블도 수정됨 - 수정자체를 막음)]
         
             CREATE VIEW 뷰이름
             AS
                질의명령
            WITH READ ONLY
            ;     
            
        - 원칙적으로 테이블처럼 중복이름 X 단, 같은 이름 뷰 있어도 만드는 명령어 O ]
        
            CREATE OR REPLACE 이름
            AS
                질의명령
            [WITH 옵션]
            ;
            
        - 테이블 생성전에 뷰 부터 만들는 명령어 - 컴파일 오류와 함께(빨간딱지) 생성 ]
        
            CREATE OR REPLACE FORCE VIEW 뷰이름 -- 뷰를 강제로 만들겠다
            AS
               질의명령
           [WITH 옵션]
            ;
            
 2) 복합뷰 : 두개 이상 테이블 조인으로 만든 뷰 ( DML 명령 불가, SELECT 문으로 조회만 가능)
            
           - 형식] 단순뷰와 동일 단 두개 이상의 테이블들의 조인조건 들어감 
 
 2. <인라인 뷰>
    ==> 가상 테이블, SELECT 질의 명령을 실행하면 나오는 결과이며 FROM 절에서 테이블처럼 사용.
        EX) 테이블에 실제하지 않는 그룹함수 결과를 테이블처럼 쓰는 경우

    *<뷰 삭제>
        DROP VIEW 뷰이름;
 
 
 3. < ROWNUM >
    ==> 오라클이 제공하는 가상 칼럼 / 데이터가 조회된 순서를 1,2,3... 넘버링
        
        과정] 졍렬이 필요한 결과가 있다. -> 조회하며 정렬 -> 결과 자체를 인라인뷰로 -> 인라인뷰 테이블에서 조회 하며 ROWNUM 붙임
        
        왜? ] 예 100개의 결과 / 100번의 ROWNUM /정렬된 결과중 60~70 번째 값을 ROWNUM 통해 찾을 수 있음. 
 
 4. < 트랜젝션 처리>
    ==> 명령의 한줄이 트렌젝션(작업단위)이나 데이터의 무결성 위해 DML 은 버퍼에 올라가 처리명령 이전까지 실행 X
    
    1) 자동 트랜젝션 처리
        - sqlplus 에서 exit
        - DDL / DCL 명령이 내려지는 순간 
        
    2) 수동 트랜젝션 처리 
        - COMMIT 명령
        
 * sqlplus 비정상적 종료 , 정전등 -> 트랜젝션 자동 버려짐 / ROLLBACK -> 트렌젝션 수동 버려짐
 
 참고 ] <ROLLBACK 시점 만들기>
 SAVEPOINT 지정이름; -->이후 트랜젝션 처리후 세이브 포인트는 자동 파괴
 ROLLBACK TO 지정이름 ;
 
*/



-- *************************** 예제 *********************************************************

--계정에 view 를 생성할 수 있는 권한을 SYSTEM 계정으로 접속하여 부여하기.

    --GRANT CREATE ANY VIEW TO pr;
    
--단순뷰에 쓸 테이블 만들기

CREATE TABLE tmp
AS
    SELECT
        *
    FROM
        emp
    ;


--만들 테이블로 단순 뷰 생성 (사원이름, 급여)

CREATE VIEW tview
AS
    SELECT
        ename, sal
    FROM
        tmp
;

--단순 뷰의 수정으로 테이블 정보바꾸기 (SMITH 급여를 850으로 )

UPDATE 
    tview
SET 
    sal = 850
WHERE
    ename = 'SMITH'
;

--편하게 단일뷰로 그룹합수 결과값 조회하기 (부서별 : 사원수, 최대급여, 최소급여, 급여평균, 급여합계)
-- 1. 뷰생성
CREATE VIEW tmpCalc
AS
    SELECT
        deptno dno, COUNT(*) cnt, MAX(sal) max, MIN(sal) min , ROUND(AVG(sal),2) avg, SUM(sal) sum
    FROM
        tmp
    GROUP BY
        deptno
;
-- 2. 부서의 평균급여보다 급여가 적은 사원들의 사원이름, 급여, 부서평균급여, 부서원수 를 조회.

SELECT
    ename, sal, avg, cnt
FROM
    tmp, tmpCalc 
WHERE
    deptno = dno -- 조인조건 칼럼이름 달라서 테이블 알리아스 없어도 
    AND sal < avg -- 일반조건
;
-- 3. ANSI 조인 조건으로 풀어보기

SELECT
     ename, sal, avg, cnt
FROM
    tmp JOIN tmpCalc 
ON
    deptno = dno
WHERE
    sal < avg
;

--만들어진 뷰를 확인하기(오라클은 제약조건처럼, 뷰 테이블을 가짐)

SELECT 
    view_name, --뷰이름
    text       --뷰에서 사용하는 질의 명령
FROM
    user_views --오라클관리의 뷰 테이블
;

/* 예제) 부서번호가 20번인 사원의 이름, 직급, 부서번호를 볼 수 있는 뷰를 만드세요.
        단, 내가 볼 수 없는 것은 수정할 수 없게 하세요. (옵션이 적용이 되는지도 확인하세요) */
     
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

-- 옵션 적용 확인하기

INSERT INTO 
     vd20
VALUES(
    '고길동', '영업', 30
    ); --부서번호 20 아니므로 적용 X

/* 예제) 직급이 'MANAGER'인 사원들의 이름, 직급, 부서번호를 볼수있는 뷰를 만드세요.
        단, 수정이 불가능하도록 하세요. 읽기전용으로만 만드세요. ( 옵션이 적용이 되는지도 확인하세요) */
       
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

-- 옵션 적용 확인하기

INSERT INTO vd30
VALUES('동수','영업부',30); --cannot perform a DML operation on a read-only view

/* 예제) MEMBER 테이블의 회원정보를 보여주는 뷰를 만드세요. 보여줄 컬럼은
         NAME, ID, MAIL 들을 보여줄 예정이다.
         1. 강제로 뷰 생성하세요  / 2. 테이블을 만들어 컴파일 오류를 없애세요 ( 데이터까지 넣어야 없어짐) */

--1. 강제 뷰 생성
CREATE OR REPLACE FORCE VIEW memb_view
AS
    SELECT
        name, id, mail
    FROM
        member
    ;
    
--2. 테이블 만들기
CREATE TABLE member(
    name VARCHAR2(15 CHAR),
    id VARCHAR2(10 CHAR),
    mail VARCHAR2(30 CHAR)
);

--3. 테이블에 데이터 넣어주며 컴파일 오류 빨간딱지 없애기

INSERT INTO member
VALUES('김민우','increpas','minwoo@increpas.com')
;


/* 복합뷰 예제) 사원의 이름, 직급, 부서이름, 급여, 급여등급
   을 볼 수 있는 뷰(view01)을 tmp, dept, salgrade를 이용해서 만드세요. */
   
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

-- *************************** 문제 주말에 한번더 풀어보기/ 뷰로 + only 서브쿼리, 조인만써서*********************************************************
/*
    다음 문제들을 해결할 뷰를 만들어서 처리하세요. 
    v10 이라는 뷰를 만들어서 처리.
*/ --필요한 그룹함수값을 넣어서 뷰를 생성하면.
CREATE VIEW v10
AS
    SELECT
        AVG(sal) avg, MAX(sal) max
    FROM
        emp
;

/*
    문제 1 ]
        회사 평균 급여보다 급여를 적게 받는 사원들의
            사원이름, 급여, 회사평균급여
        를 조회하세요.
*/
    SELECT
        ename, sal, avg 
    FROM
        emp, v10 
    WHERE
        sal < avg
    ;

-- 뷰를 사용하지 않고 조회시

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
    문제 2 ]
        회사 최고 급여자의 
            사원번호, 사원이름, 직급, 부서이름, 급여, 회사최고급여
        를 조회하세요.
*/

SELECT
    empno, ename, job, dname, sal, max
FROM
    emp e, dept d, v10
WHERE
    e.deptno = d.deptno
    AND sal = max
;

    -- v02 라는 뷰를 만들어서 처리하세요.  
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
    문제 3 ]
        급여를 가장 많이 받는 부서의 부서원들의
            사원이름, 직급, 급여, 부서이름, 부서급여합계
        를 조회하세요.
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

--뷰를 사용하지 않고 조회시

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
    문제 4 ]
        부서 평균급여보다 급여를 많이 받는 사원들의
            사원이름, 급여, 급여등급, 부서이름, 부서평균급여
        를 조회하세요.
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
    문제 5 ]
        부서원수가 가장 많은 부서의 사원중 
        부서평균급여보다 급여를 적게 받는 사원들의
            사원이름, 직급, 급여, 부서이름, 부서평균급여, 부서원수
        를 조회하세요.
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

-- 조인조건과 서브쿼리만 이용해서 풀어보기

--*************************** ROWNUM 연습 *********************************************************

SELECT
    rownum, ename, sal
FROM
    emp
ORDER BY -------> 위까지 처리한다음에 order by를 진행함. 이미 rownum 을 붙이고 정렬하므로 rownum 숫자가 섞여버림.
    sal
;

-- 사원들을 급여순으로 정렬하고 ROWNUM을 붙여보자.

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

--특정 구간의 ROWNUM 뽑기
/*

문제 6]
    사원들을 입사일 기준으로 정렬해서
    7번째에서 10번째까지 입사한 사원들만 
    사원번호, 사원이름, 직급, 입사일을 조회하세요
*/
SELECT
    rno, empno, ename, job, hiredate --> 주의 점은 여기서 새로 ROWNUM 을 부여하면 안되고, 인라인 뷰 내 부여했던 ROWNUM 의 알리아스
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

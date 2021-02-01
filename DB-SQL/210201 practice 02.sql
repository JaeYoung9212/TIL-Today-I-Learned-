/********************수업 간단요약*********************************
<oracle 에서의 JOIN>

1. Inner Join
    1) EQUI JOIN
    2) NON EQUI JOIN
    3) SELF JOIN

2. Outer Join
    (+)
    
<ANSI 에서의 JOIN>

1. CROSS JOIN

2. INNER JOIN 
    EQUI, NON-EQUI JOIN, SELF JOIN 이 포함됨
    형식1, 형식2(세개 이상의 테이블 조인시)
    
3. OUTER JOIN  
    (==> ORACLE OUTER JOIN 과 기능은 같음) 
    LEFT, RIGHT, FULL
    
4. NATURAL JOIN
5. USING JOIN


<JOIN 의 활용
    ==> 서브질의를 활용하게되면 질의명령이 훨씬 간단하게 만들어진다.>
*/







/*********************문제풀이*********************************
<oracle 에서의 JOIN>
--예제 실습--


1. Inner Join 
    1) EQUI JOIN
*/

--예제) 사원들의 사원이름, 부서번호, 부서이름을 조회하세요.
SELECT
    ename, e.deptno, dname
FROM
    emp e, dept d
WHERE
    e.deptno = d.deptno
;

--예제) 81년 입사한 사원들의 이름, 직급, 입사일, 부서번호, 부서이름, 부서위치를 조회하세요. --조인조건과 일반조건을 같이 쓸 수 있다.
SELECT
    ename, job, hiredate, e.deptno, dname, loc
FROM
    emp e, dept d
WHERE
    e. deptno = d.deptno
    AND TO_CHAR(hiredate, 'YY') ='81'
;





-- 2) NON EQUI JOIN
-- 예제) 사원들의 이름, 직급, 급여, 급여등급을 조회하세요.
SELECT
    ename, job, sal, grade
FROM
    emp, salgrade
WHERE
    --sal >= losal AND sal <= hisal
    sal BETWEEN losal AND hisal
;

-- 예제) 사원들의 이름, 직급, 급여, 부서이름, 급여등급을 조회하세요 (EQUI JOIN +NON EQUI JOIN : 세개이상의 테이블)
SELECT
    ename, job, sal, dname, grade
FROM
    emp e, dept d, salgrade
WHERE
    e.deptno = d.deptno
    AND sal BETWEEN losal AND hisal
;

--문제 실습--

--문제 1] 직급이 'MANAGER'인 사원들의 이름 , 직급, 입사일, 급여, 부서이름을 조회하세요.
SELECT
    ename, job, hiredate, sal, dname
FROM
    emp e, dept d
WHERE
    e.deptno = d.deptno
    AND job = 'MANAGER'
;
    

/* 문제 2] 급여가 가장적은 사원의--(일반조건) 이름, 직급, 입사일, 급여, 부서이름, 부서위치를 조회하세요--(두테이블 조인) *****
 두가지 방법 ]
    1. 서브질의로 해결하는 방법
    2. 서브질의의 결과를 테이블처럼 사용하는 방법(인라인뷰사용)*****/
    
--1번째 방법
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
--2번째 방법
SELECT
    ename, job, hiredate, sal, dname, loc
FROM
    emp e, dept d,
    (SELECT MIN(sal) min FROM EMP)  ----> 서브질의의 결과를 테이블처럼 사용하는 방법
WHERE
    e.deptno = d.deptno
    AND sal = min
;
    
-- 문제 3] 사원이름이 5글자인 사원들의 이름, 직급, 입사일, 급여, 급여등급을 조회하세요. --ename, sal (non EQUI)
SELECT
    ename, job, hiredate, sal, grade
FROM
    emp, salgrade
WHERE
    sal BETWEEN losal AND hisal
    AND LENGTH(ename) = 5 -- 또는 ename LIKE '_____'
;


-- 문제 4] 입사일이 81년이고 직급이 'MANAGER'인 사원들의 사원이름, 직급, 입사일, 급여, 급여등급, 부서이름, 부서위치를 조회하세요.
SELECT
    ename, job, hiredate, sal, grade, dname, loc
FROM
    emp e, dept d, salgrade
WHERE
    e.deptno = d.deptno --조인조건
    AND sal BETWEEN losal AND hisal --조인조건
    AND TO_CHAR(hiredate, 'YY') ='81'--일반조건
    AND job = 'MANAGER'--일반조건
;

 --  3) SELF JOIN
 --예제) 사원들의 사원이름, 직급, 상사이름을 조회하세요 .-- emp 의 mgr 의 상사번호는 emp 의 empno (똑같이 같은 테이블)
SELECT
    e.ename, e.job, e.mgr, se.empno, se.ename
FROM
    emp e, emp se
WHERE
    e.mgr = se.empno ---SELF JOIN
;
 
 
--2.Outer join
-- 예제) 사원들의 사원이름, 직급, 상사번호, 상사이름을 조회하세요. 단, 상사가 없는 사원도 표시되게 하세요.
SELECT
    e.ename, e.job, e.mgr, se.ename
FROM
    emp e, emp se --사원 테이블, 상사 테이블(+)
WHERE
     e.mgr = se.empno(+)--'KING'은 상사가 없음 상사이름자체가 NULLL로 표현되야함. 상사테이블에 (+)
;

    
--문제 실습--

-- 문제1] 사원들의 사원이름, 급여, 상사이름, 상사급여, 상사급여와급여의 차액을 조회하세요.
--        단, 상사가 없는 사원도 조회되게 하세요. -- 셀프 조인 + 아우터조인
SELECT
    e.ename, e.sal, se.ename, se.sal, se.sal- e.sal
FROM
    emp e, emp se
WHERE
    e.mgr = se.empno(+)
;
-- 문제2] 사원들의 이름, 직급, 급여, 부서번호, 부서이름, 부서위치를 조회하세요.
--         단, 사원이 없는 부서도 조회되게 하세요. -- 이퀄조인 + 아우터조인
SELECT
    ename, job, sal, e.deptno, dname, loc
FROM
    emp e, dept d
WHERE
    e.deptno(+) = d.deptno ---NULL로 표시된 곳에 아우터 조인 : emp 테이블이 NULL이 되야함.
;



/*

<ANSI JOIN>
1. INNER JOIN 
*/

--예제) ANSI JOIN  사원들의 이름, 직급, 부서이름을 조회하세요 emp, dept
SELECT
    ename, job, dname
FROM
   emp e INNER JOIN dept d ---그냥 JOIN 을 써도
ON
    e.deptno = d.deptno
;

--예제) 81년 입사한 사원들의 이름, 직급, 입사일, 부서이름, 부서위치를 조회하세요. emp, dept

SELECT
    ename, job, hiredate, dname, loc
FROM
    emp e JOIN dept d
ON
    e.deptno = d.deptno
WHERE
    TO_CHAR(hiredate,'YY') ='81'
;
--예제) 사원들의 사원이름, 급여, 부서위치, 급여등급을 조회하세요. --ANSI 이너 조인 세개의 테이블을 조인하는 식(emp, dept, salgrade)
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
--예제) 사원들의 사원이름, 직급, 상사번호, 상사이름을 조회하세요(self- outer join)
SELECT
    e.ename 사원이름, e.job, e.mgr, se.ename 상사이름
FROM
    emp e LEFT OUTER JOIN emp se ---- emp se RIGHT OUTER JOIN emp e
ON 
    e.mgr = se.empno
;

--3. NATURAL JOIN
--예제) 사원들의 사원이름, 직급, 부서이름을 조회하세요 --ANSI NATURAL JOIN 예제(두테이블 다 deptno로 동일)

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



--************************************************아래에서 부터 주말에 한번 더풀기 **************************
/*
<JOIN 의 활용>
--예제)  각부서별 급여 평균보다 적게 받는 사원들의 사원이름, 급여, 부서평균급여을 조회하세요.
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
    ) 부서평균급여
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
    avg 부서평균급여
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


--문제1 ] 각 부서의 최대급여자의 정보를 조회하세요. deptno ,MAX(sal)
-- oracle join , ANSI JOIN 두가지로 각각 처리하세요.

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
                    --조인할 가상테이블
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

-- extra ]   급여의 합계가 가장 높은 부서의 사원중 부서 평균 급여보다 많이 받는 사원들의
--           사원이름, 급여, 부서번호, 부서이름, 부서평균급여, 부서급여합계 를 조회하세요.


-- extra 2 ] 부서원수가 가장 많은 부서의 사원중 부서평균급여보다 많이 급여를 받는 사원의
--              사원이름, 부서번호, 급여, 부서평균급여, 부서급여합계, 부서원수 를 조회하세요.







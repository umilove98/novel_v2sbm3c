/**********************************/
/* Table Name: 카테고리 */
/**********************************/
DROP TABLE cate;

CREATE TABLE cate(
        cateno                              NUMBER(10)       NOT NULL        PRIMARY KEY,
        name                                VARCHAR2(50)         NOT NULL,
        cnt                                 NUMBER(7)        DEFAULT 0       NOT NULL,
        rdate                               DATE         NOT NULL
);

COMMENT ON TABLE cate is '카테고리';
COMMENT ON COLUMN cate.cateno is '카테고리 번호';
COMMENT ON COLUMN cate.name is '카테고리 이름';
COMMENT ON COLUMN cate.cnt is '관련 자료수';
COMMENT ON COLUMN cate.rdate is '등록일';

-- SEQUENCE

DROP SEQUENCE cate_seq;

CREATE SEQUENCE cate_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 999999999 --> NUMBER(10) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지

-- CREATE
INSERT INTO cate(cateno, name, cnt, rdate) 
VALUES (cate_seq.nextval, '고전', 0, sysdate);

INSERT INTO cate(cateno, name, cnt, rdate) 
VALUES (cate_seq.nextval, 'SF', 0, sysdate);

INSERT INTO cate(cateno, name, cnt, rdate) 
VALUES (cate_seq.nextval, '로맨스', 0, sysdate);

INSERT INTO cate(cateno, name, rdate) 
VALUES (cate_seq.nextval, '추리', sysdate); -- default 

-- SELECT 목록
SELECT cateno, name, cnt, rdate
FROM cate
ORDER BY cateno ASC;

-- SELECT 조회
SELECT cateno, name, cnt, rdate
FROM cate
WHERE cateno = 1;

-- UPDATE
UPDATE cate
SET name='고전', cnt=100, rdate=sysdate
WHERE cateno=1;

-- DELETE
DELETE FROM cate
WHERE cateno=1;

-- COUNT(*)
SELECT COUNT(*) AS cnt
FROM cate;
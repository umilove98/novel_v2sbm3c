DROP TABLE attachfile;
DROP TABLE contents CASCADE CONSTRAINTS;
DROP TABLE contents;

CREATE TABLE contents(
        contentsno                            NUMBER(10)         NOT NULL         PRIMARY KEY,
        adminno                              NUMBER(10)     NOT NULL , -- FK
        cateno                                NUMBER(10)         NOT NULL , -- FK
        title                                 VARCHAR2(300)         NOT NULL,
        content                               CLOB                  NOT NULL,
        recom                                 NUMBER(7)         DEFAULT 0         NOT NULL,
        cnt                                   NUMBER(7)         DEFAULT 0         NOT NULL,
        replycnt                              NUMBER(7)         DEFAULT 0         NOT NULL,
        passwd                                VARCHAR2(15)         NOT NULL,
        word                                  VARCHAR2(300)         NULL ,
        rdate                                 DATE               NOT NULL,
        file1                                   VARCHAR(100)          NULL,  -- 원본 파일명 image
        file1saved                            VARCHAR(100)          NULL,  -- 저장된 파일명, image
        thumb1                              VARCHAR(100)          NULL,   -- preview image
        size1                                 NUMBER(10)      DEFAULT 0 NULL,  -- 파일 사이즈
        youtube                               VARCHAR2(1000)            NULL,
  FOREIGN KEY (adminno) REFERENCES admin (adminno),
  FOREIGN KEY (cateno) REFERENCES cate (cateno)
);

COMMENT ON TABLE contents is '컨텐츠 - 소설';
COMMENT ON COLUMN contents.contentsno is '컨텐츠 번호';
COMMENT ON COLUMN contents.adminno is '관리자 번호';
COMMENT ON COLUMN contents.cateno is '카테고리 번호';
COMMENT ON COLUMN contents.title is '제목';
COMMENT ON COLUMN contents.content is '내용';
COMMENT ON COLUMN contents.recom is '추천수';
COMMENT ON COLUMN contents.cnt is '조회수';
COMMENT ON COLUMN contents.replycnt is '댓글수';
COMMENT ON COLUMN contents.passwd is '패스워드';
COMMENT ON COLUMN contents.word is '검색어';
COMMENT ON COLUMN contents.rdate is '등록일';
COMMENT ON COLUMN contents.file1 is '메인 이미지';
COMMENT ON COLUMN contents.file1saved is '실제 저장된 메인 이미지';
COMMENT ON COLUMN contents.thumb1 is '메인 이미지 Preview';
COMMENT ON COLUMN contents.size1 is '메인 이미지 크기';
COMMENT ON COLUMN contents.youtube is 'Youtube 영상';

DROP SEQUENCE contents_seq;

CREATE SEQUENCE contents_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지

-- CATE, ADMIN 테이블에 레코드가 없는 경우, adminno: 1, cateno: 1값을 이용할 수가 없음. 등록(X)
-- ORA-02291: integrity constraint (AI8.SYS_C007066) violated - parent key not found
--INSERT INTO contents(contentsno, adminno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
--                              file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt)
--VALUES(contents_seq.nextval, 1, 1, '인터스텔라', '앤헤서웨이 주연', 0, 0, 0, '123', '우주', sysdate,
--            'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000, 2000, 10, 1800, 100, 500);


-- FK 컬럼의 값이 사전에 등록되었는지 확인
--CATE 테이블
--    CATENO NAME                                  CNT RDATE               UDATE                    SEQNO V
------------ ------------------------------ ---------- ------------------- ------------------- ---------- -
--         1 퇴마                                    0 2022-09-06 04:42:46                              1 Y
--         2 SF                                      0 2022-09-06 04:42:46                              2 Y
--         3 드라마                                  0 2022-09-06 04:42:46                              3 Y
--         4 추천 여행지                             0 2022-09-06 04:42:46                              4 Y
--
--ADMIN 테이블
--   ADMINNO ID                  
------------ --------------------
--         1 admin1              
--         2 admin2              
--         3 admin3              
--
--CONTENTS 테이블
--CREATE TABLE contents(
--        contentsno                            NUMBER(10)         NOT NULL         PRIMARY KEY,
--        adminno                              NUMBER(10)     NOT NULL , -- FK
--        cateno                                NUMBER(10)         NOT NULL , -- FK
--        .....
--        FOREIGN KEY (adminno) REFERENCES admin (adminno),
--        FOREIGN KEY (cateno) REFERENCES cate (cateno)

-- 등록 화면 유형 1: 커뮤니티(공지사항, 게시판, 자료실, 갤러리,  Q/A...)글 등록
INSERT INTO contents(contentsno, adminno, cateno, title, content, passwd, word,
                                 file1, file1saved, thumb1, size1, rdate)
VALUES(contents_seq.nextval, 1, 1, 'AI', '주드로 주연', '123', '로봇,인공지능', 
            'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000, sysdate);

-- 유형 1 전체 목록
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1
FROM contents
ORDER BY contentsno ASC;

-- 등록 화면 유형 2 관련 입력 컬럼: 정가, 할인률, 판매가, 포인트, 재고수량
-- 쇼핑몰의 상품 정보 등록
INSERT INTO contents(contentsno, adminno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
                              file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt)
VALUES(contents_seq.nextval, 1, 1, '마션', '멧데이먼 주연 화성 탈출', 0, 0, 0, '123', '우주', sysdate,
            'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000, 2000, 10, 1800, 100, 500);
            
INSERT INTO contents(contentsno, adminno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
                              file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt)
VALUES(contents_seq.nextval, 1, 1, 'AI', '주드로', 0, 0, 0, '123', '로봇,인공지능', sysdate,
            'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000, 2000, 10, 1800, 100, 500);
COMMIT;

-- 유형 2 전체 목록
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt, map, youtube
FROM contents
ORDER BY contentsno ASC;

-- 모든 레코드 삭제
DELETE FROM contents;
commit;

-- 삭제
DELETE FROM contents
WHERE contentsno = 25;
commit;

DELETE FROM contents
WHERE cateno=12 AND contentsno <= 41;

commit;


-- ----------------------------------------------------------------------------------------------------
-- 검색, cateno별 검색 목록
-- ----------------------------------------------------------------------------------------------------
-- 모든글
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
       file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt
FROM contents
ORDER BY contentsno ASC;

-- 카테고리별 목록
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt
FROM contents
WHERE cateno=1
ORDER BY contentsno ASC;

-- 1) 검색
-- ① cateno별 검색 목록
-- word 컬럼의 존재 이유: 검색 정확도를 높이기 위하여 중요 단어를 명시
-- 글에 'swiss'라는 단어만 등장하면 한글로 '스위스'는 검색 안됨.
-- 이런 문제를 방지하기위해 'swiss,스위스,스의스,수의스,유럽' 검색어가 들어간 word 컬럼을 추가함.
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, price, dc, saleprice, point
FROM contents
WHERE cateno=8 AND word LIKE '%스위스%'
ORDER BY contentsno DESC;

-- title, content, word column search
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, price, dc, saleprice, point
FROM contents
WHERE cateno=8 AND (title LIKE '%스위스%' OR content LIKE '%스위스%' OR word LIKE '%스위스%')
ORDER BY contentsno DESC;

-- ② 검색 레코드 갯수
-- 전체 레코드 갯수
SELECT COUNT(*)
FROM contents
WHERE cateno=1;

SELECT COUNT(*) as cnt -- 함수 사용시는 컬럼 별명을 선언하는 것을 권장
FROM contents
WHERE cateno=1;

-- cateno 별 검색된 레코드 갯수
SELECT COUNT(*) as cnt
FROM contents
WHERE cateno=8 AND word LIKE '%스위스%';

SELECT COUNT(*) as cnt
FROM contents
WHERE cateno=1 AND (title LIKE '%유럽%' OR content LIKE '%유럽%' OR word LIKE '%유럽%');

-- SUBSTR(컬럼명, 시작 index(1부터 시작), 길이)
SELECT contentsno, SUBSTR(title, 1, 4)
FROM contents
WHERE cateno=1 AND (content LIKE '%가을%');

-- 대소문자를 구분하여 검색
SELECT contentsno, title, word
FROM contents
WHERE cateno=8 AND (word LIKE '%swiss%');

SELECT contentsno, title, word
FROM contents
WHERE cateno=8 AND (word LIKE '%SWISS%'); -- 대소문자 구분으로 검색 안됨.

SELECT contentsno, title, word
FROM contents
WHERE cateno=8 AND (UPPER(word) LIKE '%SWISS%'); -- 대소문자를 일치 시켜서 검색

SELECT contentsno, title, word
FROM contents
WHERE cateno=8 AND (UPPER(word) LIKE '%' || UPPER('swiss') || '%'); -- 대소문자를 일치 시켜서 검색

SELECT UPPER('한글') FROM dual;

-- ----------------------------------------------------------------------------------------------------
-- 검색 + 페이징 + 메인 이미지
-- ----------------------------------------------------------------------------------------------------
-- step 1
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, price, dc, saleprice, point
FROM contents
WHERE cateno=23 AND (title LIKE '%스위스%' OR content LIKE '%스위스%' OR word LIKE '%스위스%')
ORDER BY contentsno DESC;

-- step 2
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, price, dc, saleprice, point, rownum as r
FROM (
          SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
                     file1, file1saved, thumb1, size1, price, dc, saleprice, point
          FROM contents
          WHERE cateno=23 AND (title LIKE '%스위스%' OR content LIKE '%스위스%' OR word LIKE '%스위스%')
          ORDER BY contentsno DESC
);

-- step 3, 1 page
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, price, dc, saleprice, point, r
FROM (
           SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, price, dc, saleprice, point, rownum as r
           FROM (
                     SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, price, dc, saleprice, point
                     FROM contents
                     WHERE cateno=23 AND (title LIKE '%스위스%' OR content LIKE '%스위스%' OR word LIKE '%스위스%')
                     ORDER BY contentsno DESC
           )          
)
WHERE r >= 1 AND r <= 3;

-- step 3, 2 page
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, price, dc, saleprice, point, r
FROM (
           SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, price, dc, saleprice, point, rownum as r
           FROM (
                     SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, price, dc, saleprice, point
                     FROM contents
                     WHERE cateno=23 AND (title LIKE '%스위스%' OR content LIKE '%스위스%' OR word LIKE '%스위스%')
                     ORDER BY contentsno DESC
           )          
)
WHERE r >= 4 AND r <= 6;

-- ----------------------------------------------------------------------------
-- 조회
-- ----------------------------------------------------------------------------
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt, map, youtube
FROM contents
WHERE contentsno = 1;

-- ----------------------------------------------------------------------------
-- 다음 지도, MAP, 먼저 레코드가 등록되어 있어야함.
-- map                                   VARCHAR2(1000)         NULL ,
-- ----------------------------------------------------------------------------
-- MAP 등록/수정
UPDATE contents SET map='카페산 지도 스크립트' WHERE contentsno=1;

-- MAP 삭제
UPDATE contents SET map='' WHERE contentsno=1;

commit;

-- ----------------------------------------------------------------------------
-- Youtube, 먼저 레코드가 등록되어 있어야함.
-- youtube                                   VARCHAR2(1000)         NULL ,
-- ----------------------------------------------------------------------------
-- youtube 등록/수정
UPDATE contents SET youtube='Youtube 스크립트' WHERE contentsno=1;

-- youtube 삭제
UPDATE contents SET youtube='' WHERE contentsno=1;

commit;


-- 텍스트 수정: 예외 컬럼: 추천수, 조회수, 댓글 수
UPDATE contents
SET title='기차를 타고', content='계획없이 여행 출발',  word='나,기차,생각', 
      price=10000, dc=5, saleprice=9500, point=500, salecnt=100
WHERE contentsno = 1;

-- ERROR
UPDATE contents
SET title='기차를 타고', content="계획없이 '여행' 출발",  word='나,기차,생각', 
      price=10000, dc=5, saleprice=9500, point=500, salecnt=100
WHERE contentsno = 1;
-- ERROR
UPDATE contents
SET title='기차를 타고', content='계획없이 \'여행\' 출발',  word='나,기차,생각', 
      price=10000, dc=5, saleprice=9500, point=500, salecnt=100
WHERE contentsno = 1;

-- SUCCESS
UPDATE contents
SET title='기차를 타고', content='계획없이 ''여행'' 출발',  word='나,기차,생각', 
      price=10000, dc=5, saleprice=9500, point=500, salecnt=100
WHERE contentsno = 1;

-- SUCCESS
UPDATE contents
SET title='기차를 타고', content='계획없이 "여행" 출발',  word='나,기차,생각', 
      price=10000, dc=5, saleprice=9500, point=500, salecnt=100
WHERE contentsno = 1;

-- 파일 수정
UPDATE contents
SET file1='train.jpg', file1saved='train.jpg', thumb1='train_t.jpg', size1=5000
WHERE contentsno = 1;

-- 삭제
DELETE FROM contents
WHERE contentsno = 42;

commit;

-- 추천
UPDATE contents
SET recom = recom + 1
WHERE contentsno = 1;

-- 특정 그룹에 속한 레코드 갯수 산출
SELECT COUNT(*) as cnt 
FROM contents 
WHERE cateno=1;

-- 특정 관리자에 속한 레코드 갯수 산출
SELECT COUNT(*) as cnt 
FROM contents 
WHERE adminno=1;

-- 특정 그룹에 속한 레코드 모두 삭제
DELETE FROM contents
WHERE cateno=1;

-- 특정 관리자에 속한 레코드 모두 삭제
DELETE FROM contents
WHERE adminno=1;

-- 다수의 카테고리에 속한 레코드 갯수 산출: IN
SELECT COUNT(*) as cnt
FROM contents
WHERE cateno IN(1,2,3);

-- 다수의 카테고리에 속한 레코드 모두 삭제: IN
SELECT contentsno, adminno, cateno, title
FROM contents
WHERE cateno IN(1,2,3);

CONTENTSNO    ADMINNO     CATENO TITLE                                                                                                                                                                                                                                                                                                       
---------- ---------- ---------- ------------------------
         3             1                   1           인터스텔라                                                                                                                                                                                                                                                                                                  
         4             1                   2           드라마                                                                                                                                                                                                                                                                                                      
         5             1                   3           컨저링                                                                                                                                                                                                                                                                                                      
         6             1                   1           마션       
         
SELECT contentsno, adminno, cateno, title
FROM contents
WHERE cateno IN('1','2','3');

CONTENTSNO    ADMINNO     CATENO TITLE                                                                                                                                                                                                                                                                                                       
---------- ---------- ---------- ------------------------
         3             1                   1           인터스텔라                                                                                                                                                                                                                                                                                                  
         4             1                   2           드라마                                                                                                                                                                                                                                                                                                      
         5             1                   3           컨저링                                                                                                                                                                                                                                                                                                      
         6             1                   1           마션       





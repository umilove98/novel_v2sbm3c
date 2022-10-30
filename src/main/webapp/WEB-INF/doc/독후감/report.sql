DROP TABLE attachfile;
DROP TABLE report CASCADE CONSTRAINTS;
DROP TABLE report;

CREATE TABLE report(
        reportno                             NUMBER(10)         NOT NULL         PRIMARY KEY,
        memberid                              VARCHAR(20)      NOT NULL ,
        title                                 VARCHAR2(300)         NOT NULL,
        author                                 VARCHAR2(300)         NOT NULL,
        maincharacter                         VARCHAR2(300)         NOT NULL,
        favoriteline                          CLOB                  NOT NULL,
        content                               CLOB                  NOT NULL,
        recom                                 NUMBER(7)         DEFAULT 0         NOT NULL,
        cnt                                   NUMBER(7)         DEFAULT 0         NOT NULL,
        rdate                                 DATE               NOT NULL,
        file1                                   VARCHAR(100)          NULL,  -- 원본 파일명 image
        file1saved                            VARCHAR(100)          NULL,  -- 저장된 파일명, image
        thumb1                              VARCHAR(100)          NULL,   -- preview image
        size1                                 NUMBER(10)      DEFAULT 0 NULL  -- 파일 사이즈
);

COMMENT ON TABLE report is '독후감';
COMMENT ON COLUMN report.reportno is '독후감 번호';
COMMENT ON COLUMN report.memberid is '회원 아이디';
COMMENT ON COLUMN report.title is '제목';
COMMENT ON COLUMN report.author is '저자';
COMMENT ON COLUMN report.maincharacter is '등장인물';
COMMENT ON COLUMN report.favoriteline is '좋아하는 구절';
COMMENT ON COLUMN report.content is '내용';
COMMENT ON COLUMN report.recom is '추천수';
COMMENT ON COLUMN report.cnt is '조회수';
COMMENT ON COLUMN report.rdate is '등록일';
COMMENT ON COLUMN report.file1 is '메인 이미지';
COMMENT ON COLUMN report.file1saved is '실제 저장된 메인 이미지';
COMMENT ON COLUMN report.thumb1 is '메인 이미지 Preview';
COMMENT ON COLUMN report.size1 is '메인 이미지 크기';

DROP SEQUENCE report_seq;

CREATE SEQUENCE report_seq
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
INSERT INTO report(reportno, memberid, title, author, maincharacter, favoriteline, content,
                                 file1, file1saved, thumb1, size1, rdate)
VALUES(contents_seq.nextval, 'user1', '제목', '저자', '주인공이름', '좋아하는구절', '독후감내용',
            'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000, sysdate);

-- 유형 1 전체 목록
SELECT reportno, memberid, title, author, maincharacter, favoriteline, content, cnt,
           file1, file1saved, thumb1, size1
FROM report
ORDER BY reportno ASC;

commit;

-- ----------------------------------------------------------------------------
-- 조회
-- ----------------------------------------------------------------------------
SELECT reportsno, memberid, title, maincharacter, favoriteline, content, recom, cnt, replycnt, passwd,
           file1, file1saved, thumb1, size1
FROM report
WHERE reportsno = 1;

commit;

-- 삭제
DELETE FROM report
WHERE reportno = 9;
commit;

DELETE FROM report
WHERE cateno=12 AND contentsno <= 41;

commit;


-- 텍스트 수정: 예외 컬럼: 추천수, 조회수, 댓글 수
UPDATE report
SET title='수정된제목', maincharacter='수정된주인공', favoriteline='수정된좋아하는구절', content='수정된내용'
WHERE reportno = 1;


-- 파일 수정
UPDATE report
SET file1='train.jpg', file1saved='train.jpg', thumb1='train_t.jpg', size1=5000
WHERE reportsno = 1;

-- 삭제
DELETE FROM report
WHERE contentsno = 42;

commit;

-- 추천
UPDATE report
SET recom = recom + 1
WHERE contentsno = 1;

-- 특정 그룹에 속한 레코드 갯수 산출
SELECT COUNT(*) as cnt 
FROM contents 
WHERE cateno=1;

-- 특정 관리자에 속한 레코드 갯수 산출
SELECT COUNT(*) as cnt 
FROM contents 
WHERE memberno=1;

-- 특정 그룹에 속한 레코드 모두 삭제
DELETE FROM report
WHERE cateno=1;

-- 특정 그룹에 속한 레코드 모두 삭제
DELETE FROM report
WHERE contentsno=1;

-- 특정 관리자에 속한 레코드 모두 삭제
DELETE FROM report
WHERE memberno=1;

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





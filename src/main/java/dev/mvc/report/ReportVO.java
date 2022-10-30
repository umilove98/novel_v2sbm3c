package dev.mvc.report;

import org.springframework.web.multipart.MultipartFile;

/*
CREATE TABLE report(
        reportno                             NUMBER(10)         NOT NULL         PRIMARY KEY,
        memberid                              NUMBER(10)     NOT NULL , -- FK
        title                                 VARCHAR2(300)         NOT NULL,
        maincharacter                         VARCHAR2(300)         NOT NULL,
        favoriteline                          CLOB                  NOT NULL,
        content                               CLOB                  NOT NULL,
        recom                                 NUMBER(7)         DEFAULT 0         NOT NULL,
        cnt                                   NUMBER(7)         DEFAULT 0         NOT NULL,
        replycnt                              NUMBER(7)         DEFAULT 0         NOT NULL,
        rdate                                 DATE               NOT NULL,
        file1                                   VARCHAR(100)          NULL,  -- 원본 파일명 image
        file1saved                            VARCHAR(100)          NULL,  -- 저장된 파일명, image
        thumb1                              VARCHAR(100)          NULL,   -- preview image
        size1                                 NUMBER(10)      DEFAULT 0 NULL,  -- 파일 사이즈
  FOREIGN KEY (memberid) REFERENCES member (memberid)
);
 */
public class ReportVO {
    /** 독후감 번호 */
    private int reportno;
    /** 회원 번호 */
    private String memberid;
    /** 제목 */
    private String title;
    /** 저자 */
    private String author;
    /** 등장인물 */
    private String maincharacter;
    /** 좋아하는 구절 */
    private String favoriteline;
    /** 내용 */
    private String content;
    /** 추천수 */
    private int recom;
    /** 조회수 */
    private int cnt;
    /** 등록일 */
    private String rdate;
    
    /** 메인 이미지 */
    private String file1 = "";
    /** 실제 저장된 메인 이미지 */
    private String file1saved = "";
    /** 메인 이미지 preview */
    private String thumb1 = "";
    /** 메인 이미지 크기 */
    private long size1;
    
    /**
    이미지 파일
    <input type='file' class="form-control" name='file1MF' id='file1MF' 
               value='' placeholder="파일 선택">
    */
   private MultipartFile file1MF;
   
   /** 메인 이미지 크기 단위, 파일 크기 */
   private String size1_label = "";
    
    
    public int getReportno() {
        return reportno;
    }
    public void setReportno(int reportsno) {
        this.reportno = reportsno;
    }
    public String getMemberid() {
        return memberid;
    }
    public void setMemberid(String memberid) {
        this.memberid = memberid;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getMaincharacter() {
        return maincharacter;
    }
    public void setMaincharacter(String maincharacter) {
        this.maincharacter = maincharacter;
    }
    public String getFavoriteline() {
        return favoriteline;
    }
    public void setFavoriteline(String favoriteline) {
        this.favoriteline = favoriteline;
    }
    public int getRecom() {
        return recom;
    }
    public void setRecom(int recom) {
        this.recom = recom;
    }
    public int getCnt() {
        return cnt;
    }
    public void setCnt(int cnt) {
        this.cnt = cnt;
    }
    public String getRdate() {
        return rdate;
    }
    public void setRdate(String rdate) {
        this.rdate = rdate;
    }
    public String getFile1() {
        return file1;
    }
    public void setFile1(String file1) {
        this.file1 = file1;
    }
    public String getFile1saved() {
        return file1saved;
    }
    public void setFile1saved(String file1saved) {
        this.file1saved = file1saved;
    }
    public String getThumb1() {
        return thumb1;
    }
    public void setThumb1(String thumb1) {
        this.thumb1 = thumb1;
    }
    public long getSize1() {
        return size1;
    }
    public void setSize1(long size1) {
        this.size1 = size1;
    }
    public MultipartFile getFile1MF() {
        return file1MF;
    }
    public void setFile1MF(MultipartFile file1mf) {
        file1MF = file1mf;
    }
    public String getSize1_label() {
        return size1_label;
    }

    public void setSize1_label(String size1_label) {
        this.size1_label = size1_label;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public String getAuthor() {
        return author;
    }
    public void setAuthor(String author) {
        this.author = author;
    }
    
    
  
  
}
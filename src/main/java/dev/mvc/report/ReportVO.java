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
        file1                                   VARCHAR(100)          NULL,  -- ���� ���ϸ� image
        file1saved                            VARCHAR(100)          NULL,  -- ����� ���ϸ�, image
        thumb1                              VARCHAR(100)          NULL,   -- preview image
        size1                                 NUMBER(10)      DEFAULT 0 NULL,  -- ���� ������
  FOREIGN KEY (memberid) REFERENCES member (memberid)
);
 */
public class ReportVO {
    /** ���İ� ��ȣ */
    private int reportno;
    /** ȸ�� ��ȣ */
    private String memberid;
    /** ���� */
    private String title;
    /** ���� */
    private String author;
    /** �����ι� */
    private String maincharacter;
    /** �����ϴ� ���� */
    private String favoriteline;
    /** ���� */
    private String content;
    /** ��õ�� */
    private int recom;
    /** ��ȸ�� */
    private int cnt;
    /** ����� */
    private String rdate;
    
    /** ���� �̹��� */
    private String file1 = "";
    /** ���� ����� ���� �̹��� */
    private String file1saved = "";
    /** ���� �̹��� preview */
    private String thumb1 = "";
    /** ���� �̹��� ũ�� */
    private long size1;
    
    /**
    �̹��� ����
    <input type='file' class="form-control" name='file1MF' id='file1MF' 
               value='' placeholder="���� ����">
    */
   private MultipartFile file1MF;
   
   /** ���� �̹��� ũ�� ����, ���� ũ�� */
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
package dev.mvc.report;

import java.util.ArrayList;

import dev.mvc.contents.ContentsVO;

public interface ReportDAOInter {
  /**
   * 등록
   * @param ReportVO
   * @return 등록된 갯수
   */
  public int create(ReportVO reportno);
  
  /**
   *  전체 목록
   *  <xmp><select id="list_all" resultType="dev.mvc.report.ReportVO"></xmp>
   * @return 레코드 전체 목록
   */
  public ArrayList<ReportVO> list_all();  
  
  /**
   *  조회
   *  <xmp><select id="read" resultType="dev.mvc.report.ReportVO"></xmp>
   *  @param reportno
   * @return
   */
  public ReportVO read(int reportno);
  
  
  /**
   *  수정
   *  <xmp><select id="update" resultType="dev.mvc.report.ReportVO"></xmp>
   *  @param reportVO
   * @return 수정된 레코드 갯수
   */
  public int update_text(ReportVO reportno);
  
  /**
   * 파일 정보 수정
   * @param contentsVO
   * @return 처리된 레코드 갯수
   */
  public int update_file(ReportVO reportVO);
  
  /**
   * 삭제 처리 
   * @param reportno
   * @return 삭제된 레코드 갯수
   */
  public int delete(int reportno);
  
  
  /**
   * 조회수 증가
   * @param reportno
   * @return 처리된 레코드 수
   */
  public int update_cnt_add(int reportno);
  
  
}
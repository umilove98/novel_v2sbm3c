package dev.mvc.cate;

import java.util.ArrayList;

public interface CateProcInter {
  /**
   * 등록
   * @param cateVO
   * @return 등록된 갯수
   */
  public int create(CateVO cateVO);
  
  /**
   *  전체 목록
   * @return 레코드 전체 목록
   */
  public ArrayList<CateVO> list_all();  
  
  /**
   *  조회
   *  @param cateno
   * @return
   */
  public CateVO read(int cateno);
  
  
  /**
   *  수정
   *  @param cateVO
   * @return 수정된 레코드 갯수
   */
  public int update(CateVO cateVO);
  
  /**
   * 삭제 처리 
   * @param cateno
   * @return 삭제된 레코드 갯수
   */
  public int delete(int cateno);
  
  /**
   * 출력 순서 올림 (상향, 10등 -> 1등), seqno: 10 -> 1
   * @param cateno
   * @return
   */
  public int update_seqno_up(int cateno);
  
  /**
   * 출력 순서 내림 (상향, 1등 -> 10등), seqno: 1 -> 10
   * @param cateno
   * @return
   */
  public int update_seqno_down(int cateno);
  
  /**
   * 출력 모드: Y
   * @param cateno
   * @return
   */
  public int update_visible_y(int cateno);
  
  /**
   * 출력 모드: X
   * @param cateno
   * @return
   */
  public int update_visible_n(int cateno);
  
  /**
   * visible이 'Y'인 카테고리 출력하기
   * @param cateVO
   * @return 레코드 전체 목록
   */
  public ArrayList<CateVO> list_all_y();
  
  /**
   * 글 수 증가
   * @param cateno
   * @return 처리된 레코드 수
   */
  public int update_cnt_add(int cateno);
  
  /**
   * 글 수 감소
   * @param cateno
   * @return 처리된 레코드 수
   */
  public int update_cnt_sub(int cateno);
  
}
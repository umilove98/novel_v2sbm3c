package dev.mvc.report;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


@Component("dev.mvc.report.ReportProc")
public class ReportProc implements ReportProcInter {

  @Autowired
  private ReportDAOInter reportDAO;
 
  public ReportProc() {
    System.out.println("-> ReportProc created");
  }
  
  @Override
  public int create(ReportVO reportVO) {
    int cnt = this.reportDAO.create(reportVO);
    return cnt;
  }
  
  @Override
  public ArrayList<ReportVO> list_all() {
      ArrayList<ReportVO> list = this.reportDAO.list_all();
      
      return list;
  }
  
  @Override
  public ReportVO read(int reportno) {
      ReportVO reportVO = this.reportDAO.read(reportno);
      return reportVO;
  }

  @Override
  public int update_text(ReportVO reportVO) {
      int cnt = this.reportDAO.update_text(reportVO);
      
      return cnt;
  }

  @Override
  public int delete(int reportno) {
      int cnt = this.reportDAO.delete(reportno);
      return cnt;
  }
  
  @Override
  public int update_file(ReportVO reportVO) {
      int cnt = this.reportDAO.update_file(reportVO);
      return cnt;
  }
  
  @Override
  public int update_cnt_add(int reportno) {
      int cnt = this.reportDAO.update_cnt_add(reportno);
      return cnt;
  }
  


}
package dev.mvc.report;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class ReportCont {
    @Autowired
    @Qualifier("dev.mvc.report.ReportProc")  // @Component("dev.mvc.report.ReportProc")
    private ReportProcInter reportProc;

    public ReportCont() {
        System.out.println("-> ReportCont created.");
    }
    
    /**
     * 등록폼 http://localhost:9092/report/create.do
     * 
     * @return
     */
    @RequestMapping(value = "/report/create.do", method = RequestMethod.GET)
    public ModelAndView create() {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/report/create"); // /webapp/WEB-INF/views/report/create.jsp

      return mav;
    }
    
    /**
     * 등록처리
     * ReportVO reportVO 객체안의 필드들이 <form> 태그에 존재하면 자동으로 setter 호출됨. 
     * http://localhost:9092/report/create.do
     * @return
     */
    @RequestMapping(value = "/report/create.do", method = RequestMethod.POST)
    public ModelAndView create(HttpServletRequest request, ReportVO reportVO) {
      ModelAndView mav = new ModelAndView();
      
   // ------------------------------------------------------------------------------
      // 파일 전송 코드 시작
      // ------------------------------------------------------------------------------
      String file1 = "";          // 원본 파일명 image
      String file1saved = "";   // 저장된 파일명, image
      String thumb1 = "";     // preview image

      // 기준 경로 확인
      String user_dir = System.getProperty("user.dir"); // 시스템 제공
      // System.out.println("-> User dir: " + user_dir);
      //  --> User dir: C:\kd\ws_java\resort_v1sbm3c
      
      // 파일 접근임으로 절대 경로 지정, static 폴더 지정
      // 완성된 경로 C:/kd/ws_java/resort_v1sbm3c/src/main/resources/static/report/storage
      String upDir =  user_dir + "/src/main/resources/static/report/storage/"; // 절대 경로
      // System.out.println("-> upDir: " + upDir);
      
      // 전송 파일이 없어도 file1MF 객체가 생성됨.
      // <input type='file' class="form-control" name='file1MF' id='file1MF' 
      //           value='' placeholder="파일 선택">
      MultipartFile mf = reportVO.getFile1MF();
      
      file1 = Tool.getFname(mf.getOriginalFilename()); // 원본 순수 파일명 산출
      System.out.println("-> file1: " + file1);
      
      long size1 = mf.getSize();  // 파일 크기
      
      if (size1 > 0) { // 파일 크기 체크
        // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
        file1saved = Upload.saveFileSpring(mf, upDir); 
        
        if (Tool.isImage(file1saved)) { // 이미지인지 검사
          // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
          thumb1 = Tool.preview(upDir, file1saved, 200, 150); 
        }
        
      }    
      
      reportVO.setFile1(file1);   // 순수 원본 파일명
      reportVO.setFile1saved(file1saved); // 저장된 파일명(파일명 중복 처리)
      reportVO.setThumb1(thumb1);      // 원본이미지 축소판
      reportVO.setSize1(size1);  // 파일 크기
      // ------------------------------------------------------------------------------
      // 파일 전송 코드 종료
      // ------------------------------------------------------------------------------
      
      
      // ------------------------------------------------------------------------------
      // PK의 return
      // ------------------------------------------------------------------------------
      // System.out.println("--> reportno: " + reportVO.getReportno());
      // mav.addObject("reportno", reportVO.getReportno()); // redirect parameter 적용
      // ------------------------------------------------------------------------------

      int cnt = this.reportProc.create(reportVO);
      // System.out.println("등록 성공");

      mav.addObject("code", "create_success");
      mav.addObject("cnt", cnt);
      mav.addObject("title", reportVO.getTitle());

   // JSP View path
      //spring.mvc.view.prefix=/WEB-INF/views/
      //spring.mvc.view.suffix=.jsp
      if(cnt > 0) {
          mav.setViewName("redirect:/report/list_all.do"); // 콘트롤러의 주소 요청, 자동 이동
      }else {
          mav.setViewName("/report/msg"); // /webapp/WEB-INF/views/report/create.jsp
      }
     
      return mav;
    }
    
    /**
     * 모든 레코드 목록, http://localhost:9092/report/list_all.do
     * @return
     */
    @RequestMapping(value="/report/list_all.do", method=RequestMethod.GET)
    public ModelAndView list_all() {
        ModelAndView mav = new ModelAndView();
        
        ArrayList<ReportVO> list = this.reportProc.list_all();
        mav.addObject("list", list);
        
        
        //System.out.println("-> list size : " + list.size());
        
        mav.setViewName("/report/list_all"); // /webapp/WEB-INF/views/report/list_all.jsp
        
        return mav;
    }
    
    /**
     * 조회, http://localhost:9092/report/read.do?reportno=1
     * @return
     */
    @RequestMapping(value="/report/read.do", method=RequestMethod.GET)
    public ModelAndView read(int reportno) {
      
      ModelAndView mav = new ModelAndView();
      
      ReportVO reportVO = this.reportProc.read(reportno);
      
      long size1 = reportVO.getSize1();
      reportVO.setSize1_label(Tool.unit(size1)); // 93848 -> 92 KB
          
      mav.addObject("reportVO", reportVO);
      
      mav.setViewName("/report/read"); // /webapp/WEB-INF/views/report/read.jsp
      
      return mav;
    }
    
    /**
     * 수정폼, http://localhost:9092/report/read_update.do
     * @return
     */
    @RequestMapping(value="/report/update_text.do", method=RequestMethod.GET)
    public ModelAndView read_update(int reportno) {
        //System.out.println("-> reportno: " + reportno);
        ModelAndView mav = new ModelAndView();
        
        ArrayList<ReportVO> list = this.reportProc.list_all();
        mav.addObject("list", list);
        
        ReportVO reportVO = this.reportProc.read(reportno);
        mav.addObject("reportVO", reportVO);
        
        mav.setViewName("/report/update_text"); // /webapp/WEB-INF/views/report/read_update.jsp
        
        return mav;
    }
    
    // 수정 처리
    // <FORM name='frm' method='POST' action='./read_update.do'>
    // http://localhost:9092/report/read_update.do
    @RequestMapping(value="/report/update_text.do", method = RequestMethod.POST)
    public ModelAndView read_update(ReportVO reportVO) {
        System.out.println("-> reportno: " + reportVO.getReportno());
        System.out.println("-> title: " + reportVO.getTitle());
        
        ModelAndView mav = new ModelAndView();
        
        int cnt = this.reportProc.update_text(reportVO);
        
        if(cnt == 0) {
            mav.addObject("code", "update_fail");
        }
        
        mav.addObject("cnt", cnt);
        
        if(cnt > 0) {   // 정상 등록
            mav.setViewName("redirect:/report/list_all.do"); // 콘트롤러의 주소 요청, 자동 이동
        }else { // 등록 실패
            mav.setViewName("/report/msg"); // /webapp/WEB-INF/views/report/create.jsp
        }
        
        return mav;
    }
    
    /**
     * 파일 수정 폼
     * http://localhost:9092/report/update_file.do?reportno=1
     * 
     * @return
     */
    @RequestMapping(value = "/report/update_file.do", method = RequestMethod.GET)
    public ModelAndView update_file(int reportno) {
      ModelAndView mav = new ModelAndView();
      
      ReportVO reportVO = this.reportProc.read(reportno);
      mav.addObject("reportVO", reportVO);
      
      mav.setViewName("/report/update_file"); // /WEB-INF/views/report/update_file.jsp

      return mav; // forward
    }
    
    /**
     * 파일 수정 처리 http://localhost:9092/report/update_file.do
     * 
     * @return
     */
    @RequestMapping(value = "/report/update_file.do", method = RequestMethod.POST)
    public ModelAndView update_file(ReportVO reportVO) {
      ModelAndView mav = new ModelAndView();

      // 삭제할 파일 정보를 읽어옴, 기존에 등록된 레코드 저장용
      ReportVO reportVO_old = reportProc.read(reportVO.getReportno());
      
      int cnt = 0;

      // -------------------------------------------------------------------
      // 파일 삭제 코드 시작
      // -------------------------------------------------------------------
      String file1saved = reportVO_old.getFile1saved();  // 실제 저장된 파일명
      String thumb1 = reportVO_old.getThumb1();       // 실제 저장된 preview 이미지 파일명
      long size1 = 0;
      boolean sw = false;
          
      // 완성된 경로 C:/kd/ws_java/resort_v1sbm3c/src/main/resources/static/report/storage/
      String upDir =  System.getProperty("user.dir") + "/src/main/resources/static/report/storage/"; // 절대 경로

      sw = Tool.deleteFile(upDir, file1saved);  // 실제 저장된 파일삭제
      sw = Tool.deleteFile(upDir, thumb1);     // preview 이미지 삭제
      // -------------------------------------------------------------------
      // 파일 삭제 종료 시작
      // -------------------------------------------------------------------
          
      // -------------------------------------------------------------------
      // 파일 전송 코드 시작
      // -------------------------------------------------------------------
      String file1 = "";          // 원본 파일명 image

      // 완성된 경로 C:/kd/ws_java/resort_v1sbm3c/src/main/resources/static/report/storage/
      // String upDir =  System.getProperty("user.dir") + "/src/main/resources/static/report/storage/"; // 절대 경로
          
      // 전송 파일이 없어도 file1MF 객체가 생성됨.
      // <input type='file' class="form-control" name='file1MF' id='file1MF' 
      //           value='' placeholder="파일 선택">
      MultipartFile mf = reportVO.getFile1MF();
          
      file1 = mf.getOriginalFilename(); // 원본 파일명
      size1 = mf.getSize();  // 파일 크기
          
      if (size1 > 0) { // 파일 크기 체크
        // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
        file1saved = Upload.saveFileSpring(mf, upDir); 
        
        if (Tool.isImage(file1saved)) { // 이미지인지 검사
          // thumb 이미지 생성후 파일명 리턴됨, width: 250, height: 200
          thumb1 = Tool.preview(upDir, file1saved, 250, 200); 
        }
        
      } else { // 파일이 삭제만 되고 새로 올리지 않는 경우
        file1="";
        file1saved="";
        thumb1="";
        size1=0;
      }
          
      reportVO.setFile1(file1);
      reportVO.setFile1saved(file1saved);
      reportVO.setThumb1(thumb1);
      reportVO.setSize1(size1);
      // -------------------------------------------------------------------
      // 파일 전송 코드 종료
      // -------------------------------------------------------------------
          
      cnt = this.reportProc.update_file(reportVO); // Oracle 처리

      mav.addObject("reportno", reportVO.getReportno());
      mav.setViewName("redirect:/report/read.do"); // request -> param으로 접근 전환
          
      return mav; // forward
    }
    
    /**
     * 삭제폼, http://localhost:9092/report/read_update.do
     * @return
     */
    @RequestMapping(value="/report/delete.do", method=RequestMethod.GET)
    public ModelAndView read_delete(int reportno) {
        //System.out.println("-> reportno: " + reportno);
        ModelAndView mav = new ModelAndView();
        
        ArrayList<ReportVO> list = this.reportProc.list_all();
        mav.addObject("list", list);
        
        ReportVO reportVO = this.reportProc.read(reportno);
        mav.addObject("reportVO", reportVO);
        
        mav.setViewName("/report/delete"); // /webapp/WEB-INF/views/report/read_delete.jsp
        
        return mav;
    }
    
    // 삭제 처리
    // <FORM name='frm' method='POST' action='./delete.do'>
    // http://localhost:9092/report/read_delete.do
    @RequestMapping(value="/report/delete.do", method = RequestMethod.POST)
    public ModelAndView delete(int reportno) {
        
        ModelAndView mav = new ModelAndView();
        
        int cnt = this.reportProc.delete(reportno);
        
        if(cnt == 0) {
            mav.addObject("code", "delete_fail");
        }
        
        mav.addObject("cnt", cnt);
        
        if(cnt > 0) {   // 정상 삭제
            mav.setViewName("redirect:/report/list_all.do"); // 콘트롤러의 주소 요청, 자동 이동
        }else { // 삭제 실패
            mav.setViewName("/report/msg"); // /webapp/WEB-INF/views/report/msg.jsp
        }
        
        return mav;
    }
    
    // 글 수 증가
    // http://localhost:9092/report/update_cnt_add.do?reportno=1
    @RequestMapping(value="/report/update_cnt_add.do", method = RequestMethod.GET)
    public String update_cnt_add(int reportno) {
        
        int cnt = this.reportProc.update_cnt_add(reportno);
        
        return "변경된 글수 : " + cnt;
    }
    

}
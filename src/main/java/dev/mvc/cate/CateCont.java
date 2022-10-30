package dev.mvc.cate;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CateCont {
    @Autowired
    @Qualifier("dev.mvc.cate.CateProc")  // @Component("dev.mvc.cate.CateProc")
    private CateProcInter cateProc;

    public CateCont() {
        System.out.println("-> CateCont created.");
    }
    
    /**
     * 등록폼 http://localhost:9092/cate/create.do
     * 
     * @return
     */
    @RequestMapping(value = "/cate/create.do", method = RequestMethod.GET)
    public ModelAndView create() {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/cate/create"); // /webapp/WEB-INF/views/cate/create.jsp

      return mav;
    }
    
    /**
     * 등록처리
     * CateVO cateVO 객체안의 필드들이 <form> 태그에 존재하면 자동으로 setter 호출됨. 
     * http://localhost:9091/cate/create.do
     * @return
     */
    @RequestMapping(value = "/cate/create.do", method = RequestMethod.POST)
    public ModelAndView create(CateVO cateVO) {
      ModelAndView mav = new ModelAndView();

      int cnt = this.cateProc.create(cateVO);
      // System.out.println("등록 성공");

      mav.addObject("code", "create_success");
      mav.addObject("cnt", cnt);
      mav.addObject("name", cateVO.getName());

   // JSP View path
      //spring.mvc.view.prefix=/WEB-INF/views/
      //spring.mvc.view.suffix=.jsp
      if(cnt > 0) {
          mav.setViewName("redirect:/cate/list_all.do"); // 콘트롤러의 주소 요청, 자동 이동
      }else {
          mav.setViewName("/cate/msg"); // /webapp/WEB-INF/views/cate/create.jsp
      }
     
      return mav;
    }
    
    /**
     * 모든 레코드 목록, http://localhost:9092/cate/list_all.do
     * @return
     */
    @RequestMapping(value="/cate/list_all.do", method=RequestMethod.GET)
    public ModelAndView list_all() {
        ModelAndView mav = new ModelAndView();
        
        ArrayList<CateVO> list = this.cateProc.list_all();
        mav.addObject("list", list);
        
        //System.out.println("-> list size : " + list.size());
        
        mav.setViewName("/cate/list_all"); // /webapp/WEB-INF/views/cate/list_all.jsp
        
        return mav;
    }
    
    /**
     * 수정폼, http://localhost:9091/cate/read_update.do
     * @return
     */
    @RequestMapping(value="/cate/read_update.do", method=RequestMethod.GET)
    public ModelAndView read_update(int cateno) {
        //System.out.println("-> cateno: " + cateno);
        ModelAndView mav = new ModelAndView();
        
        ArrayList<CateVO> list = this.cateProc.list_all();
        mav.addObject("list", list);
        
        CateVO cateVO = this.cateProc.read(cateno);
        mav.addObject("cateVO", cateVO);
        
        mav.setViewName("/cate/read_update"); // /webapp/WEB-INF/views/cate/read_update.jsp
        
        return mav;
    }
    
    // 수정 처리
    // <FORM name='frm' method='POST' action='./read_update.do'>
    // http://localhost:9091/cate/read_update.do
    @RequestMapping(value="/cate/read_update.do", method = RequestMethod.POST)
    public ModelAndView read_update(CateVO cateVO) {
        System.out.println("-> cateno: " + cateVO.getCateno());
        System.out.println("-> name: " + cateVO.getName());
        System.out.println("-> cnt: " + cateVO.getCnt());
        
        
        ModelAndView mav = new ModelAndView();
        
        int cnt = this.cateProc.update(cateVO);
        
        if(cnt == 0) {
            mav.addObject("code", "update_fail");
        }
        
        mav.addObject("cnt", cnt);
        
        if(cnt > 0) {   // 정상 등록
            mav.setViewName("redirect:/cate/list_all.do"); // 콘트롤러의 주소 요청, 자동 이동
        }else { // 등록 실패
            mav.setViewName("/cate/msg"); // /webapp/WEB-INF/views/cate/create.jsp
        }
        
        return mav;
    }
    
    /**
     * 삭제폼, http://localhost:9092/cate/read_update.do
     * @return
     */
    @RequestMapping(value="/cate/read_delete.do", method=RequestMethod.GET)
    public ModelAndView read_delete(int cateno) {
        //System.out.println("-> cateno: " + cateno);
        ModelAndView mav = new ModelAndView();
        
        ArrayList<CateVO> list = this.cateProc.list_all();
        mav.addObject("list", list);
        
        CateVO cateVO = this.cateProc.read(cateno);
        mav.addObject("cateVO", cateVO);
        
        mav.setViewName("/cate/read_delete"); // /webapp/WEB-INF/views/cate/read_delete.jsp
        
        return mav;
    }
    
    // 삭제 처리
    // <FORM name='frm' method='POST' action='./delete.do'>
    // http://localhost:9092/cate/read_delete.do
    @RequestMapping(value="/cate/read_delete.do", method = RequestMethod.POST)
    public ModelAndView delete(int cateno) {
        
        ModelAndView mav = new ModelAndView();
        
        int cnt = this.cateProc.delete(cateno);
        
        if(cnt == 0) {
            mav.addObject("code", "delete_fail");
        }
        
        mav.addObject("cnt", cnt);
        
        if(cnt > 0) {   // 정상 삭제
            mav.setViewName("redirect:/cate/list_all.do"); // 콘트롤러의 주소 요청, 자동 이동
        }else { // 삭제 실패
            mav.setViewName("/cate/msg"); // /webapp/WEB-INF/views/cate/msg.jsp
        }
        
        return mav;
    }
    
 // 출력 순서 올림 (상향, 10등 -> 1등), seqno: 10 -> 1
    // http://localhost:9092/cate/update_seqno_up.do?cateno=1
    @RequestMapping(value="/cate/update_seqno_up.do", method = RequestMethod.GET)
    public ModelAndView update_seqno_up(int cateno) {
        ModelAndView mav = new ModelAndView();
        
        this.cateProc.update_seqno_up(cateno);
        
        mav.setViewName("redirect:/cate/list_all.do"); // 콘트롤러의 주소 요청, 자동 이동
        
        return mav;
    }
    
    // 출력 순서 내림 (상향, 1등 -> 10등), seqno: 1 -> 10
    // http://localhost:9092/cate/update_seqno_down.do?cateno=1
    @RequestMapping(value="/cate/update_seqno_down.do", method = RequestMethod.GET)
    public ModelAndView update_seqno_down(int cateno) {
        ModelAndView mav = new ModelAndView();
        
        this.cateProc.update_seqno_down(cateno);
        
        mav.setViewName("redirect:/cate/list_all.do"); // 콘트롤러의 주소 요청, 자동 이동
        
        return mav;
    }
    
    // 출력 모드: Y
    // http://localhost:9092/cate/update_visible_y.do?cateno=1
    @RequestMapping(value="/cate/update_visible_y.do", method = RequestMethod.GET)
    public ModelAndView update_visible_y(int cateno) {
        ModelAndView mav = new ModelAndView();
        
        this.cateProc.update_visible_y(cateno);
        
        mav.setViewName("redirect:/cate/list_all.do"); // 콘트롤러의 주소 요청, 자동 이동
        
        return mav;
    }
    
    // 출력 모드: N
    // http://localhost:9092/cate/update_visible_n.do?cateno=1
    @RequestMapping(value="/cate/update_visible_n.do", method = RequestMethod.GET)
    public ModelAndView update_visible_n(int cateno) {
        ModelAndView mav = new ModelAndView();
        
        this.cateProc.update_visible_n(cateno);
        
        mav.setViewName("redirect:/cate/list_all.do"); // 콘트롤러의 주소 요청, 자동 이동
        
        return mav;
    }
    
    // 글 수 증가
    // http://localhost:9092/cate/update_cnt_add.do?cateno=1
    @RequestMapping(value="/cate/update_cnt_add.do", method = RequestMethod.GET)
    public String update_cnt_add(int cateno) {
        
        int cnt = this.cateProc.update_cnt_add(cateno);
        
        return "변경된 글수 : " + cnt;
    }
    
    // 글 수 감소
    // http://localhost:9092/cate/update_cnt_sub.do?cateno=1
    @RequestMapping(value="/cate/update_cnt_sub.do", method = RequestMethod.GET)
    public String update_cnt_sub(int cateno) {
        
        int cnt = this.cateProc.update_cnt_sub(cateno);
        
        return "변경된 글수 : " + cnt;
    }

}
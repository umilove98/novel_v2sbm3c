package dev.mvc.novel_v1sbm3c;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.cate.CateProcInter;
import dev.mvc.cate.CateVO;

@Controller
public class HomeCont {
    
    @Autowired
    @Qualifier("dev.mvc.cate.CateProc")  // @Component("dev.mvc.cate.CateProc")
    private CateProcInter cateProc;
    
    public HomeCont() {
        System.out.println("-> HomeCont created.");
    }
    
    // http://localhost:9092/
    // http://localhost:9092/index.do
    @RequestMapping(value = {"/","/index.do"}, method = RequestMethod.GET)
    public ModelAndView home() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/index"); // /WEB-INF/views/index.jsp
        
        return mav;
    }
    
    // http://localhost:9092/menu/top.do
    @RequestMapping(value = {"/menu/top.do"}, method = RequestMethod.GET)
    public ModelAndView top() {
        ModelAndView mav = new ModelAndView();
        
        ArrayList<CateVO> list = this.cateProc.list_all_y();
        mav.addObject("list", list);
        
        mav.setViewName("/menu/top"); // /WEB-INF/views/menu/top.jsp
        
        return mav;
    }
}

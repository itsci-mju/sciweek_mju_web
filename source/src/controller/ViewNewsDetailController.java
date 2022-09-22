package controller;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Pressrelease;
import manager.ViewNewsDetailManager;

@Controller
public class ViewNewsDetailController {

	@RequestMapping(value = "/ViewPressreleaseDetail", method = RequestMethod.GET)
	public ModelAndView viewnewsdetail(HttpSession session, HttpServletRequest request) throws UnsupportedEncodingException {
			int id = Integer.parseInt(request.getParameter("id"));
			ModelAndView mav = new ModelAndView("ViewPressreleaseDetail");
			ViewNewsDetailManager viewNewsDetailManager = new ViewNewsDetailManager();
			Pressrelease pressrelease = viewNewsDetailManager.viewnewsdetailByID(id);
			request.setCharacterEncoding("UTF-8");
			request.setAttribute("pressrelease", pressrelease);
			return mav;
	
	}
	
}
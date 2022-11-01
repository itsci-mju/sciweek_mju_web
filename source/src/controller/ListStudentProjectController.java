package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Admin;
import bean.Project;
import manager.ListStudentProjectManager;

@Controller
public class ListStudentProjectController  {
	
	@RequestMapping(value = "/doViewProject", method = RequestMethod.GET)
	public ModelAndView loadViewProjectPage(HttpSession session, HttpServletRequest request) throws Exception{
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			ListStudentProjectManager vpjm = new ListStudentProjectManager();
			List<Project> listproject = vpjm.getListStudentProject();
			ModelAndView mav = new ModelAndView("ListStudentProject");
			mav.addObject("listproject", listproject);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("admin");
			return mav;
		}
	}
	
	@RequestMapping(value = "/searchproject", method = RequestMethod.POST)
	public ModelAndView searchListlaboratoryInstruments2(HttpSession session,HttpServletRequest request) throws Exception {
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			request.setCharacterEncoding("UTF-8");
			String keyword = request.getParameter("keyword");
			ListStudentProjectManager viewProjectManager = new ListStudentProjectManager();
			List<Project> listproject = viewProjectManager.searchproject(keyword);

			request.setAttribute("listproject", listproject);
			request.setAttribute("keyword", keyword);
			ModelAndView mav = new ModelAndView("ListStudentProject");
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			return mav;
		}
	}
	
	
}

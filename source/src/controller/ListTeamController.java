package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import manager.ListTeamManager;
import manager.ViewTeamDetailManager;
import bean.Admin;
import bean.ProjectType;
import bean.Reviewer;

@Controller
public class ListTeamController {
	
	@RequestMapping(value = "/doViewTeam", method = RequestMethod.GET)
	public ModelAndView loadViewTeamPage(HttpSession session, HttpServletRequest request) throws Exception {
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			ListTeamManager listTeamManager = new ListTeamManager();
			ViewTeamDetailManager viewTeamDetailManager = new ViewTeamDetailManager();
			List<ProjectType> projectTypeList = listTeamManager.getListProjectType();
			List<Reviewer> reviewerList = viewTeamDetailManager.getListReviewer();		
			ModelAndView mav = new ModelAndView("ListTeam");
			mav.addObject("projectTypeList", projectTypeList);
			mav.addObject("reviewerList", reviewerList);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("admin");
			return mav;
		}
	}
	
}

package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import manager.ListTeamManager;
import bean.Admin;
import bean.Team;

@Controller
public class ListTeamController {
	
	@RequestMapping(value = "/doViewTeam", method = RequestMethod.GET)
	public ModelAndView loadViewTeamPage(HttpSession session, HttpServletRequest request) {
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			ListTeamManager vtem = new ListTeamManager();
			List<Team> listteam = vtem.getListTeam();
			ModelAndView mav = new ModelAndView("ListTeam");
			mav.addObject("listteam", listteam);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("admin");
			return mav;
		}
	}
	
}

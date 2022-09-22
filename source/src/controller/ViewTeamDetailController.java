package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Admin;
import bean.Reviewer;
import bean.Project;
import bean.Team;
import manager.ViewTeamDetailManager;

@Controller
public class ViewTeamDetailController {
	
	@RequestMapping(value = "/ViewTeamDetail" , method = RequestMethod.GET)
	public ModelAndView loadViewTeamDetail(HttpSession session, HttpServletRequest request) throws Exception{
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			Integer team_id = Integer.parseInt(request.getParameter("team_id"));
			ViewTeamDetailManager viewTeamDetailManager = new ViewTeamDetailManager();
			Team team = viewTeamDetailManager.getTeamByID(team_id);
			List<Reviewer> listreviewer = viewTeamDetailManager.getListReviewerByTeamID(team_id);
			List<Project> listproject = viewTeamDetailManager.getListProjectByTeamID(team_id);
			ModelAndView mav = new ModelAndView("ViewTeamDetail");
			mav.addObject("team",team);
			mav.addObject("listreviewer", listreviewer);
			mav.addObject("listproject", listproject);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("admin");
			return mav;
		}
	}
	
	@RequestMapping(value = "/doDeleteReviewerByTeamID", method = RequestMethod.GET)
	public ModelAndView doDeleteReviewerByTeamID(HttpSession session, HttpServletRequest request) throws Exception {

		Admin admin = (Admin) session.getAttribute("admin");
		Integer team_id = Integer.parseInt(request.getParameter("team_id"));
		if (admin != null) {
			ModelAndView mav = new ModelAndView("ViewTeamDetail");
			
			ViewTeamDetailManager viewTeamDetailManager = new ViewTeamDetailManager();
			
			if (viewTeamDetailManager.isDeleteReviewerByTeamID(team_id)) {
				mav.addObject("msg", "ลบข้อมูลสำเร็จแล้ว!!!! ");
			} else {
				mav.addObject("msg", "ลบข้อมูลไม่สำเร็จแล้ว!!!! ");
			}

			Team team = viewTeamDetailManager.getTeamByID(team_id);
			List<Reviewer> listreviewer = viewTeamDetailManager.getListReviewerByTeamID(team_id);
			List<Project> listproject = viewTeamDetailManager.getListProjectByTeamID(team_id);
			mav.addObject("team",team);
			mav.addObject("listreviewer", listreviewer);
			mav.addObject("listproject", listproject);
			
			return mav;

		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("admin");
			return mav;
		}
	}

}

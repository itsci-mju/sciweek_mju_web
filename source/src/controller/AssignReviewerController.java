package controller;

import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Admin;
import bean.Project;
import bean.Reviewer;
import bean.Team;
import manager.AssignReviewerManager;
import manager.ViewTeamDetailManager;
import util.ConnectionDB;

@Controller
public class AssignReviewerController {
	
	@RequestMapping(value = "/doAssignReviewer", method = RequestMethod.GET)
	public ModelAndView doAssignReviewer(HttpSession session, HttpServletRequest request) throws Exception {
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			Team team = new Team();	
			team.setTeam_id(Integer.parseInt(request.getParameter("team_id")));
			team.setTeam_name(request.getParameter("team_name"));			
			AssignReviewerManager assignReviewerManager = new AssignReviewerManager();
			List<Reviewer> listreviewer = assignReviewerManager.getListReviewer();
			ModelAndView mav = new ModelAndView("AssignReviewer");
			mav.addObject("team",team);
			mav.addObject("listreviewer", listreviewer);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("admin");
			return mav;
		}
	}
	
	@RequestMapping(value = "/isAssignReviewer", method = RequestMethod.POST)
	public ModelAndView isAssignReviewer(HttpServletRequest request, Model md, HttpSession session) throws Exception {

		ConnectionDB condb = new ConnectionDB();
		Connection conn = condb.getConnection();

		request.setCharacterEncoding("UTF-8");

		Team team = new Team();
		team.setTeam_id(Integer.parseInt(request.getParameter("team_id")));
		team.setTeam_name(request.getParameter("team_name"));

		String[] reviewerIdStrList = request.getParameterValues("chkreviewer");

		if (reviewerIdStrList != null) {
			for (String reviewerIdstr : reviewerIdStrList) {
				int reviewer_id = Integer.parseInt(reviewerIdstr);

				Reviewer reviewer = new Reviewer();
				reviewer.setReviewer_id(reviewer_id);
				reviewer.setTeam(team);

			}
			conn.close();
			ViewTeamDetailManager viewTeamDetailManager = new ViewTeamDetailManager();
			List<Project> listproject = viewTeamDetailManager.getListProject();
			ModelAndView mav = new ModelAndView("AssignProject");
			mav.addObject("team", team);
			mav.addObject("reviewerIdStrList", reviewerIdStrList);
			mav.addObject("listproject", listproject);
			return mav;
		} else {
			team.setTeam_id(Integer.parseInt(request.getParameter("team_id")));
			team.setTeam_name(request.getParameter("team_name"));
			AssignReviewerManager assignReviewerManager = new AssignReviewerManager();
			List<Reviewer> listreviewer = assignReviewerManager.getListReviewer();
			ModelAndView mav = new ModelAndView("AssignReviewer");
			mav.addObject("msg", "กรุณาเลือกประธานคณะกรรมการและคณะกรรมการ!!!!");
			mav.addObject("team", team);
			mav.addObject("listreviewer", listreviewer);
			return mav;
		} 

	}
			

		

}

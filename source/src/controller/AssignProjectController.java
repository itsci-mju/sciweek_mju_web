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
import manager.AssignProjectManager;
import manager.AssignReviewerManager;
import manager.CreateTeamManager;
import manager.ViewTeamDetailManager;
import util.ConnectionDB;

@Controller
public class AssignProjectController {

	@RequestMapping(value = "/doAssignProject", method = RequestMethod.GET)
	public ModelAndView doAssignProject(HttpSession session, HttpServletRequest request) throws Exception {
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			Team team = new Team();
			team.setTeam_id(Integer.parseInt(request.getParameter("team_id")));
			team.setTeam_name(request.getParameter("team_name"));
			AssignProjectManager assignProjectManager = new AssignProjectManager();
			List<Project> listproject = assignProjectManager.getListProject();
			ModelAndView mav = new ModelAndView("AssignProject");
			mav.addObject("team", team);
			mav.addObject("listproject", listproject);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("admin");
			return mav;
		}
	}

	@RequestMapping(value = "/isAssignProject", method = RequestMethod.POST)
	public ModelAndView doAddreviewer(HttpServletRequest request, Model md, HttpSession session) throws Exception {

		ConnectionDB condb = new ConnectionDB();
		Connection conn = condb.getConnection();

		request.setCharacterEncoding("UTF-8");

		CreateTeamManager createTeamManager = new CreateTeamManager();
		ViewTeamDetailManager viewTeamDetailManager = new ViewTeamDetailManager();
		AssignReviewerManager assignReviewerManager = new AssignReviewerManager();
		AssignProjectManager assignProjectManager = new AssignProjectManager();

		Team team = new Team();
		team.setTeam_id(Integer.parseInt(request.getParameter("team_id")));
		team.setTeam_name(request.getParameter("team_name"));

		createTeamManager.isCreateTeam(team);

		String[] reviewerIdStrList = request.getParameterValues("reviewer_id");

		for (String reviewerIdstr : reviewerIdStrList) {
			int reviewer_id = Integer.parseInt(reviewerIdstr);

			Reviewer reviewer = new Reviewer();
			reviewer.setReviewer_id(reviewer_id);
			reviewer.setTeam(team);

			assignReviewerManager.isAssignReviewer(reviewer, conn);

		}

		String[] projectIdStrList = request.getParameterValues("chkproject");

		if (projectIdStrList != null) {
			for (String projectIdstr : projectIdStrList) {
				String project_id = projectIdstr;

				Project project = new Project();
				project.setProject_id(project_id);
				project.setTeam(team);

				assignProjectManager.isAssignProject(project, conn);

			}

			conn.close();

			Team teams = viewTeamDetailManager.getTeamByID(team.getTeam_id());
			List<Reviewer> listreviewer = viewTeamDetailManager.getListReviewerByTeamID(team.getTeam_id());
			List<Project> listproject = viewTeamDetailManager.getListProjectByTeamID(team.getTeam_id());
			ModelAndView mav = new ModelAndView("ViewTeamDetail");
			mav.addObject("team", teams);
			mav.addObject("listreviewer", listreviewer);
			mav.addObject("listproject", listproject);
			return mav;
		} else {
			team.setTeam_id(Integer.parseInt(request.getParameter("team_id")));
			team.setTeam_name(request.getParameter("team_name"));
			List<Project> listproject = assignProjectManager.getListProject();
			ModelAndView mav = new ModelAndView("AssignProject");
			mav.addObject("msg", "กรุณาเลือกโครงานวิทยาศาสตร์!!!!");
			mav.addObject("team", team);
			mav.addObject("listproject", listproject);
			return mav;
		}

	}
}

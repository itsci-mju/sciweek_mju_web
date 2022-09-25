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

import manager.AssignProjectManager;
import manager.AssignReviewerManager;
import manager.CreateTeamManager;
import manager.ListTeamManager;
import manager.ViewTeamDetailManager;
import util.ConnectionDB;
import bean.Admin;
import bean.Project;
import bean.Reviewer;
import bean.Team;

@Controller
public class CreateTeamController {

	@RequestMapping(value = "/doCreateTeam", method = RequestMethod.GET)
	public ModelAndView loadCreateTeamPage(HttpSession session, HttpServletRequest request) throws Exception {
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			ViewTeamDetailManager viewTeamDetailManager = new ViewTeamDetailManager();
			List<Reviewer> listreviewer = viewTeamDetailManager.getListReviewer();		
			List<Project> listproject = viewTeamDetailManager.getListProject();
			ModelAndView mav = new ModelAndView("CreateTeam");
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

	@RequestMapping(value = "/isCreateTeam", method = RequestMethod.POST)
	public ModelAndView isCreateTeam(HttpServletRequest request, Model md, HttpSession session) throws Exception {
		
		ConnectionDB condb = new ConnectionDB();
		Connection conn = condb.getConnection();
		
		request.setCharacterEncoding("UTF-8");
		CreateTeamManager createTeamManager = new CreateTeamManager();
		AssignReviewerManager assignReviewerManager = new AssignReviewerManager();
		AssignProjectManager assignProjectManager = new AssignProjectManager();

		Team team = new Team();	
		team.setTeam_id(createTeamManager.getMaxTeam());
		team.setTeam_name(request.getParameter("team_name"));
		
		createTeamManager.isCreateTeam(team);		
		
		String[] reviewerIdStrList = request.getParameterValues("chkreviewer");
			for (String reviewerIdstr : reviewerIdStrList) {
				
				int reviewer_id = Integer.parseInt(reviewerIdstr);
				Reviewer reviewer = new Reviewer();
				reviewer.setReviewer_id(reviewer_id);
				reviewer.setTeam(team);
				
				assignReviewerManager.isAssignReviewer(reviewer, conn);
		}
		
		String[] projectIdStrList = request.getParameterValues("chkproject");
			for (String projectIdstr : projectIdStrList) {
				
					String project_id = projectIdstr;
					Project project = new Project();
					project.setProject_id(project_id);
					project.setTeam(team);

					assignProjectManager.isAssignProject(project, conn);

			}
			
			conn.close();
			
			ListTeamManager vtem = new ListTeamManager();
			List<Team> teamList = vtem.getListTeam();
			ModelAndView mav = new ModelAndView("ListTeam");
			mav.addObject("teamList", teamList);
			return mav;
	}
	
}

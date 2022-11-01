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
import bean.ProjectType;
import lombok.val;
import manager.AnnounceAwardManager;

@Controller
public class AnnounceAwardController {
	
	@RequestMapping(value = "/doViewAward", method = RequestMethod.GET)
	public ModelAndView loadViewAward(HttpSession session, HttpServletRequest request) throws Exception {
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			
			ProjectType projectType = new ProjectType();
			projectType.setProjecttype_id(0);
			int projecttype_id = projectType.getProjecttype_id();
			
			AnnounceAwardManager announceAwardManager = new AnnounceAwardManager();
			List<Project> listproject = announceAwardManager.getListProjectByProjecttypeID(projecttype_id);
			List<ProjectType> projectTypeList = announceAwardManager.getlistProjectType();
//			Schedules schedules = announceResultManager.getDATE();
			ModelAndView mav = new ModelAndView("AnnounceAward");
			request.setCharacterEncoding("UTF-8");
			request.setAttribute("listproject", listproject);
//			request.setAttribute("years", years);
			request.setAttribute("projectTypeList", projectTypeList);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			return mav;
		}
	}
	
	@RequestMapping(value = "/searchtypeproject", method = RequestMethod.POST)
	public ModelAndView searchListprejectaward(HttpSession session,HttpServletRequest request) throws Exception {
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			request.setCharacterEncoding("UTF-8");
			ProjectType projectType = new ProjectType();
			projectType.setProjecttype_id(0);
			Integer projecttype_id ;
			
			if (request.getParameter("position") == null) {
				projecttype_id = projectType.getProjecttype_id();
			} else {
				projecttype_id = Integer.parseInt(request.getParameter("position"));
			}
		
			AnnounceAwardManager announceAwardManager = new AnnounceAwardManager();
			List<Project> listproject = announceAwardManager.getListProjectByProjecttypeID(projecttype_id);
			List<ProjectType> projectTypeList = announceAwardManager.getlistProjectType();

			request.setAttribute("listproject", listproject);
			request.setAttribute("projectTypeList", projectTypeList);
			ModelAndView mav = new ModelAndView("AnnounceAward");
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			return mav;
		}
	}
	
	@RequestMapping(value = "/isAnnouces", method = RequestMethod.POST)
	public ModelAndView isChooseProject(HttpSession session, HttpServletRequest request) throws Exception {

		request.setCharacterEncoding("UTF-8");

		AnnounceAwardManager announceAwardManager = new AnnounceAwardManager();

		String[] projectIdStrList = request.getParameterValues("project_id");

		for (int i = 0; i < projectIdStrList.length; i++) {

			val project_id = projectIdStrList[i];

			Project project = new Project();
			project.setProject_id(project_id);

			announceAwardManager.isUpdateAward(project);
			
		}

		ModelAndView mav = new ModelAndView("Index");
		return mav;

	}

}

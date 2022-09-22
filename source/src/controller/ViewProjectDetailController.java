package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Report;
import bean.Student;
import bean.StudentProject;
import manager.ViewProjectDetailManager;

@Controller
public class ViewProjectDetailController {

	@RequestMapping(value = "/ViewProjectDetail", method = RequestMethod.GET)
	public ModelAndView loadViewProjectDetail(HttpSession session, HttpServletRequest request) throws Exception {
		Student student = (Student) session.getAttribute("student");
		if (student != null) {
			String project_id = request.getParameter("project_id");
			ViewProjectDetailManager viewProjectDetailManager = new ViewProjectDetailManager();
			Report report = viewProjectDetailManager.getReportByProjectID(project_id);
			StudentProject studentProject = viewProjectDetailManager.getStudentProjectByID(project_id);
			List<StudentProject> listsproject = viewProjectDetailManager.getListStudentProjectByProjectID(project_id);
			ModelAndView mav = new ModelAndView("ViewProjectDetail");
			session.setAttribute("report", report);
			mav.addObject("listsproject", listsproject);
			mav.addObject("studentProject", studentProject);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("student");
			return mav;
		}
	}

}

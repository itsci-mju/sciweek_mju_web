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
import bean.Report;
import bean.Student;
import manager.ReviewProjectManager;
import manager.ViewStudentProjectDetailManager;

@Controller
public class ViewStudentProjectDetailController {
	
	@RequestMapping(value = "/ViewStudentProjectDetail" , method = RequestMethod.GET)
	public ModelAndView loadViewStudentProjectDetail(HttpSession session, HttpServletRequest request) throws Exception {
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			String project_id = request.getParameter("project_id");
			ViewStudentProjectDetailManager viewStudentProjectDetailManager = new ViewStudentProjectDetailManager();
			ReviewProjectManager reviewProjectManager = new ReviewProjectManager();
			Project project = viewStudentProjectDetailManager.getStudentProjectByID(project_id);
			Report report = reviewProjectManager.getReportByProjectID(project_id);
			List<Student> liststudent = viewStudentProjectDetailManager.getListStudent(project_id);
			ModelAndView mav = new ModelAndView("ViewStudentProjectDetail");
			mav.addObject("project",project);
			session.setAttribute("report", report);
			mav.addObject("liststudent",liststudent);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("admin");
			return mav;
		}
	}
	
}

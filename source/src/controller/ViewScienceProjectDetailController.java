package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Project;
import bean.Report;
import bean.Reviewer;
import bean.Student;
import lombok.val;
import manager.ReviseProjectManager;

@Controller
public class ViewScienceProjectDetailController {
	
	@RequestMapping(value = "/ViewScienceProjectDetail" , method = RequestMethod.GET)
	public ModelAndView loadViewStudentProjectDetail(HttpSession session, HttpServletRequest request) throws Exception {
		Reviewer reviewer = (Reviewer) session.getAttribute("reviewer");
		if (reviewer != null) {
			String project_id = request.getParameter("project_id");
			ReviseProjectManager reviseProjectManager = new ReviseProjectManager();
			Report report = reviseProjectManager.getReportByProjectID(project_id);
			Student student = reviseProjectManager.getStudentProjectByID(project_id);
			List<Project> listproject = reviseProjectManager.getListScienceProject(project_id);
			val reviews = reviseProjectManager.getReviewsByReviewerID(reviewer.getReviewer_id(),project_id);
			ModelAndView mav = new ModelAndView("ViewScienceProjectDetail");
			session.setAttribute("report", report);
			mav.addObject("reviewer", reviewer);
			mav.addObject("student", student);
			mav.addObject("listproject", listproject);
			mav.addObject("reviews", reviews);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("reviewer");
			return mav;
		}
	}

}

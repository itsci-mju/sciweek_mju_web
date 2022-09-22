package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Report;
import bean.Reviewer;
import bean.StudentProject;
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
			StudentProject sproject = reviseProjectManager.getStudentProjectByID(project_id);
			List<StudentProject> listsproject = reviseProjectManager.getListScienceProject(project_id);
			val reviews = reviseProjectManager.getReviewsByReviewerID(reviewer.getReviewer_id(),project_id);
			ModelAndView mav = new ModelAndView("ViewScienceProjectDetail");
			session.setAttribute("report", report);
			mav.addObject("reviewer", reviewer);
			mav.addObject("sproject", sproject);
			mav.addObject("listsproject", listsproject);
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

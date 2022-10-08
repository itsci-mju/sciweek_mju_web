package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Reviewer;
import bean.Reviews;
import manager.ViewCommentsManager;


@Controller
public class ViewCommentsController {
	
	@RequestMapping(value = "/ViewComments" , method = RequestMethod.GET)
	public ModelAndView loadViewStudentProjectDetail(HttpSession session, HttpServletRequest request) throws Exception {
		Reviewer reviewer = (Reviewer) session.getAttribute("reviewer");
		if (reviewer != null) {
			String project_id = request.getParameter("project_id");
			ViewCommentsManager viewCommentsManager = new ViewCommentsManager();
			List<Reviews> reviewsList = viewCommentsManager.getCommentsByProjectID(project_id);
			ModelAndView mav = new ModelAndView("ViewComments");
			mav.addObject("reviewsList",reviewsList);
			request.setAttribute("project_id",project_id);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("reviewer");
			return mav;
		}
	}

}

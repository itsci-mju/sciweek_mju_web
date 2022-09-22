package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Admin;
import bean.Reviewer;
import manager.ViewReviewerDetailManager;

@Controller
public class ViewReviewerDetailController {
	
	@RequestMapping(value = "/ViewReviewerDetail" , method = RequestMethod.GET)
	public ModelAndView loadViewReviewerDetail(HttpSession session, HttpServletRequest request) throws Exception {
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			Integer reviewer_id = Integer.parseInt(request.getParameter("reviewer_id"));
			ViewReviewerDetailManager viewReviewerDetailManager = new ViewReviewerDetailManager();
			Reviewer reviewer = viewReviewerDetailManager.getReviewerByID(reviewer_id);
			ModelAndView mav = new ModelAndView("ViewReviewerDetail");
			mav.addObject("reviewer",reviewer);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("admin");
			return mav;
		}
	}
}

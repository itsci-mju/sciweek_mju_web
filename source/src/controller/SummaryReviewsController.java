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
import manager.SummaryReviewsManager;

@Controller
public class SummaryReviewsController {
	
	@RequestMapping(value = "/SummaryReviews" , method = RequestMethod.GET)
	public ModelAndView LoadSummaryReviews(HttpSession session, HttpServletRequest request) throws Exception {
		Reviewer reviewer = (Reviewer) session.getAttribute("reviewer");
		if (reviewer != null) {
			Integer reviewer_id = reviewer.getReviewer_id();
			SummaryReviewsManager summaryReviewsManager = new SummaryReviewsManager();			
			List<Reviews> listreviews = summaryReviewsManager.getListReviewsByReviewerID(reviewer_id);		
			ModelAndView mav = new ModelAndView("SummaryReviews");
			mav.addObject("listreviews",listreviews);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("reviewer");
			return mav;
		}
	}

}

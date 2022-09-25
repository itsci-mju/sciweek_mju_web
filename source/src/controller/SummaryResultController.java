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
import manager.SummaryResultManager;

@Controller
public class SummaryResultController {
	
	@RequestMapping(value = "/SummaryResult" , method = RequestMethod.GET)
	public ModelAndView LoadSummaryReviews(HttpSession session, HttpServletRequest request) throws Exception {
		Reviewer reviewer = (Reviewer) session.getAttribute("reviewer");
		if (reviewer != null) {
			Integer reviewer_id = reviewer.getReviewer_id();
			SummaryResultManager summaryResultManager = new SummaryResultManager();			
			List<Reviews> listreviews = summaryResultManager.getListReviewsByReviewerID(reviewer_id);		
			ModelAndView mav = new ModelAndView("SummaryResult");
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

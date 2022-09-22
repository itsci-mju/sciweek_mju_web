package controller;

// import java.util.ArrayList;
// import java.util.HashMap;
import java.util.List;
// import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Reviewer;
// import bean.Reviews;
// import lombok.val;
import manager.SummaryOfReviewsManager;
import model.ProjectResponse;

@Controller
public class SummaryOfReviewsController {

	@RequestMapping(value = "/SummaryOfReviews", method = RequestMethod.GET)
	public ModelAndView LoadSummaryOfReviews(HttpSession session, HttpServletRequest request) throws Exception {
		Reviewer reviewer = (Reviewer) session.getAttribute("reviewer");
		if (reviewer != null) {
			Integer team_id = reviewer.getTeam().getTeam_id();
			SummaryOfReviewsManager summaryOfReviewsManager = new SummaryOfReviewsManager();
			List<ProjectResponse> projectResponseList = summaryOfReviewsManager.getListReviewsByTeamID(team_id);
//			List<Reviewer> reviewerList = new ArrayList<>();
//			for (val reviews : listreviews) {
//				boolean check = reviewerList.stream()
//						.anyMatch(e -> e.getReviewer_id() == reviews.getReviewer().getReviewer_id());
//				if(!check) {
//					reviewerList.add(reviews.getReviewer());
//				}
//			}
//
//		HashMap<Integer, List<Double>> hashMap = new HashMap<Integer, List<Double>>();
//		for (val reviews : reviewerList) {
//			hashMap.put(reviews.getReviewer_id(), listreviews.stream().filter(e -> e.getReviewer().getReviewer_id() == reviews.getReviewer_id())
//					.map(e -> e.getTotalscore()).collect(Collectors.toList()));
//		}
			ModelAndView mav = new ModelAndView("SummaryOfReviews");
			mav.addObject("projectResponseList", projectResponseList);
//			mav.addObject("reviewerList", reviewerList);
//			mav.addObject("hashMap", hashMap);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("reviewer");
			return mav;
		}
	}
	
	@RequestMapping(value = "/ExportSummaryExcel", method = RequestMethod.GET)
	public ModelAndView LoadExportSummaryExcel(HttpSession session, HttpServletRequest request) throws Exception {
		Reviewer reviewer = (Reviewer) session.getAttribute("reviewer");
		if (reviewer != null) {
			Integer team_id = reviewer.getTeam().getTeam_id();
			SummaryOfReviewsManager summaryOfReviewsManager = new SummaryOfReviewsManager();
			List<ProjectResponse> projectResponseList = summaryOfReviewsManager.getListReviewsByTeamID(team_id);
			ModelAndView mav = new ModelAndView("ExportSummaryExcel");
			mav.addObject("projectResponseList", projectResponseList);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("reviewer");
			return mav;
		}
	}

}

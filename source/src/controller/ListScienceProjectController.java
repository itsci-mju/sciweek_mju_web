package controller;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Reviewer;
import bean.StudentProject;
import manager.ListScienceProjectManager;
import model.ProjectResponse;
import model.ReviewerResponse;

@Controller
public class ListScienceProjectController {
	
	@RequestMapping(value = "/doListScienceProject", method = RequestMethod.GET)
	public ModelAndView loadListScienceProjectPage(HttpSession session, HttpServletRequest request) throws Exception{
		Reviewer reviewer = (Reviewer) session.getAttribute("reviewer");
		if (reviewer != null) {		
			int team_id = reviewer.getTeam().getTeam_id();
			int reviewer_id = reviewer.getReviewer_id();
			ListScienceProjectManager listScienceProjectManager = new ListScienceProjectManager();
			List<ProjectResponse> projectResponseList = listScienceProjectManager.getListProjectByReviewerID(reviewer_id);
			
			List<ReviewerResponse> reviewerResponseList = new ArrayList<>();
			for (ProjectResponse reviews : projectResponseList) {
				if (reviewerResponseList.size() == 0) {
					reviewerResponseList = reviews.getReviewerResponseList();
				} else {
					for (ReviewerResponse reviewerResponse : reviewerResponseList) {
						boolean check = reviewerResponseList.stream()
								.anyMatch(e -> e.getReviewerName() == reviewerResponse.getReviewerName());
						if (!check) {
							reviewerResponseList.add(reviewerResponse);
						}
					}
				}
			}
			
			List<StudentProject> studentProjectList = listScienceProjectManager.getListScienceProjectByTeamID(team_id);
						
			ModelAndView mav = new ModelAndView("ListScienceProject");
			mav.addObject("projectResponseList", projectResponseList);
			mav.addObject("reviewerResponseList", reviewerResponseList);
			mav.addObject("studentProjectList", studentProjectList);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("reviewer");
			return mav;
		}
	}

}

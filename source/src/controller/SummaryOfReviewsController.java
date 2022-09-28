package controller;

import java.util.ArrayList;
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

import bean.Project;
import bean.Reviewer;
import bean.StudentProject;
import manager.ListScienceProjectManager;
// import bean.Reviews;
// import lombok.val;
import manager.SummaryOfReviewsManager;
import model.ProjectResponse;
import model.ReviewerResponse;

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
	
	@RequestMapping(value = "/isChooseProject", method = RequestMethod.POST)
	public ModelAndView isChooseProject(HttpSession session, HttpServletRequest request) throws Exception {
		Reviewer reviewer = (Reviewer) session.getAttribute("reviewer");
		if (reviewer != null) {
			request.setCharacterEncoding("UTF-8");
			
			Integer team_id = Integer.parseInt(request.getParameter("team_id"));		
			Integer reviewer_id = Integer.parseInt(request.getParameter("reviewer_id"));	
			
			SummaryOfReviewsManager summaryOfReviewsManager = new SummaryOfReviewsManager();
			ListScienceProjectManager listScienceProjectManager = new ListScienceProjectManager();
						
			summaryOfReviewsManager.isFailedProject(team_id);
				
			String[] projectIdStrList = request.getParameterValues("chkproject");
				
				for (String projectIdstr : projectIdStrList) {
					
						String project_id = projectIdstr;
						
						System.out.println(project_id);
						
						Project projectTemp = summaryOfReviewsManager.getProjectByProjectID(project_id);
						
						Integer state_project = projectTemp.getState_project();
						
						System.out.println(state_project);
						
						Project project = new Project();
						project.setProject_id(project_id);
						
						summaryOfReviewsManager.isChooseProjectFirst(project);
						System.out.println("===========================");
						System.out.println(project_id);
						System.out.println(state_project);
						
						if (state_project == 2) {
							summaryOfReviewsManager.isChooseProjectSecond(project, team_id);
						}

				}

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

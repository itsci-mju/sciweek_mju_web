package controller;

import java.util.ArrayList;
// import java.util.Arrays;
// import java.util.Collections;
// import java.util.Comparator;
// import java.util.ArrayList;
// import java.util.HashMap;
import java.util.List;
// import java.util.stream.Collectors;
// import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Project;
import bean.Reviewer;
import bean.Schedules;
import lombok.val;
import manager.AnnounceResultManager;
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
			Integer projecttype_id = reviewer.getProjecttype().getProjecttype_id();
			SummaryOfReviewsManager summaryOfReviewsManager = new SummaryOfReviewsManager();
			List<ProjectResponse> projectResponseList = summaryOfReviewsManager.getListReviewsByTeamID(projecttype_id);
			Reviewer reviewers = summaryOfReviewsManager.getCount(projecttype_id);
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
		    mav.addObject("reviewers", reviewers);
//			mav.addObject("hashMap", hashMap);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("reviewer");
			return mav;
		}
	}
	
	@RequestMapping(value = "/isEditSelectFinal", method = RequestMethod.GET)
	public ModelAndView isEditSelectFinal(HttpSession session, HttpServletRequest request) throws Exception {
		Reviewer reviewer = (Reviewer) session.getAttribute("reviewer");
		if (reviewer != null) {
			Integer projecttype_id = reviewer.getProjecttype().getProjecttype_id();
			Integer state_project = Integer.parseInt(request.getParameter("state_project"));
			SummaryOfReviewsManager summaryOfReviewsManager = new SummaryOfReviewsManager();
			
			System.out.println(projecttype_id);
			System.out.println(state_project);
			
			ModelAndView mav = new ModelAndView("SummaryOfReviews");
			if (summaryOfReviewsManager.isEditSelectFinal(state_project,projecttype_id)) {
				mav.addObject("msg", "ย้อนกลับสำเร็จ!!!");
			} else {
				mav.addObject("msg", "ย้อนกลับไม่สำเร็จ!!!");
			}
		
			List<ProjectResponse> projectResponseList = summaryOfReviewsManager.getListReviewsByTeamID(projecttype_id);
			Reviewer reviewers = summaryOfReviewsManager.getCount(projecttype_id);	
			mav.addObject("projectResponseList", projectResponseList);
		    mav.addObject("reviewers", reviewers);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("reviewer");
			return mav;
		}
	}
	
	@RequestMapping(value = "/isEditDecideAwards", method = RequestMethod.GET)
	public ModelAndView isEditDecideAwards(HttpSession session, HttpServletRequest request) throws Exception {
		Reviewer reviewer = (Reviewer) session.getAttribute("reviewer");
		if (reviewer != null) {
			Integer projecttype_id = reviewer.getProjecttype().getProjecttype_id();
			Integer state_project = Integer.parseInt(request.getParameter("state_project"));
			SummaryOfReviewsManager summaryOfReviewsManager = new SummaryOfReviewsManager();
			
			System.out.println(projecttype_id);
			System.out.println(state_project);
			ModelAndView mav = new ModelAndView("SummaryOfReviews");
			
			if (summaryOfReviewsManager.isEditDecideAward(state_project,projecttype_id)) {
				mav.addObject("msg", "ย้อนกลับสำเร็จ!!!");
			} else {
				mav.addObject("msg", "ย้อนกลับไม่สำเร็จ!!!");
			}
			
			List<ProjectResponse> projectResponseList = summaryOfReviewsManager.getListReviewsByTeamID(projecttype_id);
			Reviewer reviewers = summaryOfReviewsManager.getCount(projecttype_id);
			mav.addObject("projectResponseList", projectResponseList);
		    mav.addObject("reviewers", reviewers);
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
			
			Integer projecttype_id = Integer.parseInt(request.getParameter("projecttype_id"));		
			Integer reviewer_id = Integer.parseInt(request.getParameter("reviewer_id"));	
				
			
			AnnounceResultManager announceResultManager = new AnnounceResultManager();
			SummaryOfReviewsManager summaryOfReviewsManager = new SummaryOfReviewsManager();
			ListScienceProjectManager listScienceProjectManager = new ListScienceProjectManager();
									
			String[] state_projectStrList = request.getParameterValues("state_project");			
			String[] projectIdStrList = request.getParameterValues("chkproject");
			String[] awardStrList = request.getParameterValues("award");
			String[] avgscoreStrList = request.getParameterValues("avgscore");
//			List<Project> projectList = new ArrayList<Project>();
			
			for (int i = 0 ; i < projectIdStrList.length; i++) {

				val state_project = Integer.parseInt(state_projectStrList[i]);
				val project_id = projectIdStrList[i];			

				Project project = new Project();
				project.setProject_id(project_id);
				
				if (state_project == 1) {
					double avgscore = Double.parseDouble(avgscoreStrList[i]);
					if (avgscore > 20) {
						summaryOfReviewsManager.isEditChooseProjectFirst(project);
					} else {
						summaryOfReviewsManager.isChooseProjectFirst(project);
						summaryOfReviewsManager.isFailedProject(projecttype_id, state_project);
					}
				}
				
				if (state_project == 2) {
					val award = awardStrList[i];
					summaryOfReviewsManager.isChooseProjectSecond(project, award);
					summaryOfReviewsManager.isFailedProjectSecond(projecttype_id, state_project);
							
//					projectList.add(summaryOfReviewsManager.getProjectByProjectID(project.getProject_id()));
//					
//					projectList.stream()
//		            .sorted(Comparator.comparingDouble(Project::getAvgscore)) 
//		            .filter(x2 -> x2.getAvgscore() <= 1)
//		            .collect(Collectors.toList());
//					
//					for (int a = 0 ; a < projectList.size() ; a++) {
//							
//						if (a == 0) {
//							summaryOfReviewsManager.isFirstAward(projectList.get(a).getProject_id());
//							System.out.println(projectList.get(a).getProject_id());
//							System.out.println(projectList.get(a).getAward());
//						} else if (a == 1) {
//							summaryOfReviewsManager.isSecondAward(projectList.get(a).getProject_id());
//							System.out.println(projectList.get(a).getProject_id());
//							System.out.println(projectList.get(a).getAward());
//						} else if (a == 2) {
//							summaryOfReviewsManager.isThirdAward(projectList.get(a).getProject_id());
//							System.out.println(projectList.get(a).getProject_id());
//							System.out.println(projectList.get(a).getAward());
//						} else {
//							summaryOfReviewsManager.isUpdateFailedProject(projectList.get(a).getProject_id());		
//							System.out.println(projectList.get(a).getProject_id());
//							System.out.println(projectList.get(a).getAward());
//						}
//						
//					}
					
				}
				
			}
			
//				projectList = summaryOfReviewsManager.getProjectByProjectIDList(Arrays.asList(projectIdStrList));
			
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
				
				List<Project> projectList = listScienceProjectManager.getListScienceProjectByTeamID(projecttype_id);
				Schedules schedules = announceResultManager.getDATE();
				ModelAndView mav = new ModelAndView("ListScienceProject");
				mav.addObject("projectResponseList", projectResponseList);
				mav.addObject("reviewerResponseList", reviewerResponseList);
				mav.addObject("projectList", projectList);
				mav.addObject("schedules", schedules);
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
			Integer projecttype_id = Integer.parseInt(request.getParameter("projecttype_id"));
			SummaryOfReviewsManager summaryOfReviewsManager = new SummaryOfReviewsManager();
			List<ProjectResponse> projectResponseList = summaryOfReviewsManager.getListReviewsByTeamID(projecttype_id);
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

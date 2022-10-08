package controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Answer;
import bean.Project;
import bean.Question;
import bean.Report;
import bean.Reviewer;
import bean.Reviews;
import bean.StudentProject;
import bean.Years;
import lombok.val;
import manager.AnnounceResultManager;
import manager.ListScienceProjectManager;
import manager.ReviseProjectManager;
import model.ProjectResponse;
import model.ReviewerResponse;

@Controller
public class ReviseProjectController {
	
	@RequestMapping(value = "/ReviseProject", method = RequestMethod.GET)
	public ModelAndView doReviseProject(HttpSession session, HttpServletRequest request) throws Exception {
		Reviewer reviewer = (Reviewer) session.getAttribute("reviewer");
		if (reviewer != null) {
			String project_id = request.getParameter("project_id");
			ReviseProjectManager reviseProjectManager = new ReviseProjectManager();
			AnnounceResultManager announceResultManager = new AnnounceResultManager(); 
			Report report = reviseProjectManager.getReportByProjectID(project_id);
			StudentProject sproject = reviseProjectManager.getStudentProjectByID(project_id);
			List<StudentProject> listsproject = reviseProjectManager.getListScienceProject(project_id);
			val reviews = reviseProjectManager.getReviewsByReviewerID(reviewer.getReviewer_id(),project_id);
			Years years = announceResultManager.getDATE();
			ModelAndView mav = new ModelAndView("ReviseProject");
			session.setAttribute("report", report);
			mav.addObject("reviewer", reviewer);
			mav.addObject("sproject", sproject);
			mav.addObject("listsproject", listsproject);
			mav.addObject("reviews", reviews);
			mav.addObject("years", years);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("reviewer");
			return mav;
		}
	}
	
	@RequestMapping(value = "/isReviseProject", method = RequestMethod.POST)
	public ModelAndView isReviseProject(HttpServletRequest request, Model md, HttpSession session) throws Exception {

		request.setCharacterEncoding("UTF-8");
		ReviseProjectManager reviseProjectManager = new ReviseProjectManager();
		
		Reviewer reviewer = new Reviewer();
		reviewer.setReviewer_id(Integer.parseInt(request.getParameter("reviewer_id")));
		
		Project project = new Project();
		project.setProject_id(request.getParameter("project_id"));

		Reviews reviews = new Reviews();
		String reviews_id = request.getParameter("review_id");
		reviews.setReviews_id(reviews_id);
		reviews.setComments(request.getParameter("comments"));
		reviews.setReviewer(reviewer);
		reviews.setProject(project);

		boolean statusresult = reviseProjectManager.isReviseProject(reviews);

		String[] questionIdList = request.getParameterValues("question_id");
		String[] answerStrList = request.getParameterValues("answer");

		for (int i = 0 ; i < questionIdList.length ; i++) {
			
			val questionId = Integer.parseInt(questionIdList[i]);
			val answers = Double.parseDouble(answerStrList[i]);

			Answer answer = new Answer();
			answer.setAnswer(answers);
			answer.setQuestion(new Question(questionId));
			answer.setReview(reviews);
			answer.setReviewer(reviewer);
			answer.setProject(project);
			reviseProjectManager.isAnswerRevise(answer);
		}

		if (statusresult) {
			int team_id = Integer.parseInt(request.getParameter("team_id"));
			int reviewer_id = reviewer.getReviewer_id();
			ListScienceProjectManager listScienceProjectManager = new ListScienceProjectManager();
			List<StudentProject> studentProjectList = listScienceProjectManager.getListScienceProjectByTeamID(team_id);
			List<ProjectResponse> projectResponseList = listScienceProjectManager.getListProjectByReviewerID(reviewer_id);
			
			List<ReviewerResponse> reviewerResponseList = new ArrayList<>();
			for (ProjectResponse review : projectResponseList) {
				if (reviewerResponseList.size() == 0) {
					reviewerResponseList = review.getReviewerResponseList();
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
			AnnounceResultManager announceResultManager = new AnnounceResultManager();
			Years years = announceResultManager.getDATE();
			ModelAndView mav = new ModelAndView("ListScienceProject");
			mav.addObject("msg", "แก้ไขประเมินสำเร็จ!!!");
			mav.addObject("studentProjectList", studentProjectList);
			mav.addObject("reviewerResponseList", reviewerResponseList);
			mav.addObject("projectResponseList", projectResponseList);
			mav.addObject("years", years);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("ReviseProject");
			mav.addObject("msg", "แก้ไขประเมินไม่สำเร็จ!!!");
			return mav;
		}
	}

}

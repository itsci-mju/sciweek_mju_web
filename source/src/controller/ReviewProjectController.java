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

import bean.*;
import lombok.val;
import manager.AnnounceResultManager;
import manager.ListScienceProjectManager;
import manager.ReviewProjectManager;
import manager.ReviseProjectManager;
import model.ProjectResponse;
import model.ReviewerResponse;

@Controller
public class ReviewProjectController {

	@RequestMapping(value = "/ReviewProject", method = RequestMethod.GET)
	public ModelAndView LoaddoReviewProject(HttpSession session, HttpServletRequest request) throws Exception {
		Reviewer reviewer = (Reviewer) session.getAttribute("reviewer");
		if (reviewer != null) {
			String project_id = request.getParameter("project_id");
			String reviews_id = request.getParameter("reviews_id");
			ReviewProjectManager reviewProjectManager = new ReviewProjectManager();
			AnnounceResultManager announceResultManager = new AnnounceResultManager(); 
			Reviews reviews = reviewProjectManager.getReviewsByReviewID(reviews_id);		
			Student student = reviewProjectManager.getStudentProjectByID(project_id);
			Question question = reviewProjectManager.getQuestion();
			List<Question> listquestion = reviewProjectManager.getListQuestion();
			Schedules schedules = announceResultManager.getDATE();
			ModelAndView mav = new ModelAndView("ReviewProject");
			mav.addObject("reviews", reviews);
			mav.addObject("reviewer", reviewer);
			mav.addObject("question", question);
			mav.addObject("listquestion", listquestion);
			mav.addObject("student", student);
			mav.addObject("schedules", schedules);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("reviewer");
			return mav;
		}
	}

	@RequestMapping(value = "/isReviewProject", method = RequestMethod.POST)
	public ModelAndView isReviewProject(HttpServletRequest request, Model md, HttpSession session) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		boolean statusresult = false;
		
		Reviewer reviewer = new Reviewer();
		reviewer.setReviewer_id(Integer.parseInt(request.getParameter("reviewer_id")));
		
		Project project = new Project();
		project.setProject_id(request.getParameter("project_id"));	
		
		String reviews_id = request.getParameter("reviews_id");
		
		Integer state_project = Integer.parseInt(request.getParameter("state_project"));
		
		if (state_project == 1) { 
		    
			ReviewProjectManager reviewProjectManager = new ReviewProjectManager();
			
			int id = reviewProjectManager.getMaxReview();
			String report_id = String.valueOf(id);
			
			Reviews reviews = new Reviews();
			
			reviews.setReviews_id(report_id);
			reviews.setComments(request.getParameter("comments"));
			reviews.setReviewer(reviewer);
			reviews.setProject(project);
			
			statusresult = reviewProjectManager.isReviewProject(reviews);	

			String[] questionIdList = request.getParameterValues("question_id");
			String[] answerStrList = request.getParameterValues("answer");

			for (int i = 0 ; i < questionIdList.length ; i++) {
				
				val questionId = Integer.parseInt(questionIdList[i]);
				val answers = Double.parseDouble(answerStrList[i]);

				Answer answer = new Answer();
				answer.setAnswer(answers);
				answer.setQuestion(new Question(questionId));
				answer.setReview(reviews);
				reviewProjectManager.isAnswerReview(answer);
			}
	
		} 
		
		if (state_project == 2) { 
			
			ReviewProjectManager reviewProjectManager = new ReviewProjectManager();
			ReviseProjectManager reviseProjectManager = new ReviseProjectManager();

			Reviews reviews = new Reviews();
			reviews.setReviews_id(reviews_id);
			reviews.setComments(request.getParameter("comments"));
			reviews.setReviewer(reviewer);
			reviews.setProject(project);
			
			statusresult = reviseProjectManager.isUpdateReviewProject(reviews);	

			String[] questionIdList = request.getParameterValues("question_id");
			
			String[] answerStrList = request.getParameterValues("answer");

			for (int i = 0 ; i < questionIdList.length ; i++) {
				
				val questionId = Integer.parseInt(questionIdList[i]);
				val answers = Double.parseDouble(answerStrList[i]);

				Answer answer = new Answer();
				answer.setAnswer(answers);
				answer.setQuestion(new Question(questionId));
				answer.setReview(reviews);
				reviewProjectManager.isAnswerReview(answer);
				
			}
	
		}
		
		if (statusresult) {
			int projecttype_id = Integer.parseInt(request.getParameter("projecttype_id"));
			int reviewer_id = Integer.parseInt(request.getParameter("reviewer_id"));
			ListScienceProjectManager listScienceProjectManager = new ListScienceProjectManager();
			List<Project> projectList = listScienceProjectManager.getListScienceProjectByTeamID(projecttype_id);
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
			Schedules schedules = announceResultManager.getDATE();
			ModelAndView mav = new ModelAndView("ListScienceProject");
			mav.addObject("msg", "ประเมินสำเร็จ");
			mav.addObject("projectList", projectList);
			mav.addObject("reviewerResponseList", reviewerResponseList);
			mav.addObject("projectResponseList", projectResponseList);
			mav.addObject("schedules", schedules);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("ReviewProject");
			mav.addObject("msg", "ประเมินไม่สำเร็จ!!!!");
			return mav;
		}
	}

}

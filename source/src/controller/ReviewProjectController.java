package controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
			Report report = reviewProjectManager.getReportByProjectID(project_id);
			Reviews reviews = reviewProjectManager.getReviewsByReviewID(reviews_id);
			StudentProject sproject = reviewProjectManager.getStudentProjectByID(project_id);
			List<StudentProject> listsproject = reviewProjectManager.getListScienceProject(project_id);
			Question question = reviewProjectManager.getQuestion();
			List<Question> listquestion = reviewProjectManager.getListQuestion();
			Years years = announceResultManager.getDATE();
			ModelAndView mav = new ModelAndView("ReviewProject");
			session.setAttribute("report", report);
			mav.addObject("reviews", reviews);
			mav.addObject("reviewer", reviewer);
			mav.addObject("question", question);
			mav.addObject("listquestion", listquestion);
			mav.addObject("sproject", sproject);
			mav.addObject("listsproject", listsproject);
			mav.addObject("years", years);
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
			
			Date dd = new Date();
		    Calendar c1 = Calendar.getInstance();
		    c1.setTime(dd);
		    c1.add(Calendar.YEAR,543);
		    dd = c1.getTime();
		    String date1 = new SimpleDateFormat("ddMMyyyyHHmmss").format(dd);

			ReviewProjectManager reviewProjectManager = new ReviewProjectManager();
			

			Reviews reviews = new Reviews();
			
			reviews.setReviews_id(date1);
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
				answer.setReviewer(reviewer);
				answer.setProject(project);
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
				answer.setReviewer(reviewer);
				answer.setProject(project);
				reviewProjectManager.isAnswerReview(answer);
				
			}
		
		}
		

		if (statusresult) {
			int team_id = Integer.parseInt(request.getParameter("team_id"));
			int reviewer_id = Integer.parseInt(request.getParameter("reviewer_id"));
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
			mav.addObject("msg", "ประเมินสำเร็จ");
			mav.addObject("studentProjectList", studentProjectList);
			mav.addObject("reviewerResponseList", reviewerResponseList);
			mav.addObject("projectResponseList", projectResponseList);
			mav.addObject("years", years);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("ReviewProject");
			mav.addObject("msg", "ประเมินไม่สำเร็จ!!!!");
			return mav;
		}
	}

}

package controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import manager.AnnounceResultManager;
import manager.ListScienceProjectManager;
import manager.LoginManager;
import manager.ViewScheduleDetailManager;
import model.ProjectResponse;
import model.ReviewerResponse;
import bean.Admin;
import bean.Report;
import bean.Reviewer;
import bean.Student;
import bean.StudentProject;
import bean.Years;

@Controller
public class LoginController {

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String loadIndexPage(HttpServletRequest request, Model model, HttpSession session)throws Exception {
		Student student = (Student) session.getAttribute("student");
		Reviewer reviewer = (Reviewer) session.getAttribute("reviewer");
		Admin admin = (Admin) session.getAttribute("admin");
		LoginManager loginManager = new LoginManager();
		
		if (student != null) {	
			
			Report report = new Report();
			List<StudentProject> listsproject = new Vector<>();
			
			Integer student_id = student.getStudent_id();
			String video = null ;
			String project_id = null ;
			Integer report_id = 0 ;
			Integer errors = 0 ;
			
			// error 0 = กรุณาอัปโหลดเอกสารรายงานและวิดีโอ ;
			// error 1 = กรุณาอัปโหลดวิดีโอ ;
			// error 2 = กรุณาอัปโหลดเอกสารรายงาน ;
			
			Calendar cal = Calendar.getInstance();
			int presentyears = cal.get(Calendar.YEAR);
			
			ViewScheduleDetailManager viewScheduleDetailManager = new ViewScheduleDetailManager();
			Years years = viewScheduleDetailManager.getYearsByID(presentyears);
			
			listsproject = loginManager.getListStudentProjectByStudentID(student_id);
				
			for (StudentProject studentProject : listsproject) {		
				
				project_id = studentProject.getProject().getProject_id();	
				System.out.println(project_id);
					
				video = studentProject.getProject().getVideo();	
				System.out.println(video);
				
				report = loginManager.getReportByProjectID(project_id);	
				
				if (report != null) {
					report_id = report.getReport_id();	
				} else {
					if (video.equals("-") && report_id == 0) {
						errors = 1 ;
						System.out.println(errors);
					} else if (video.equals("-")) {
						errors = 2 ;
						System.out.println(errors);
					} else if (report_id == 0) {
						errors = 3 ;
						System.out.println(errors);
					} else {
						errors = 0 ;
						System.out.println(errors);
					}
				}
	
			}
			
			request.setAttribute("errors", errors);
			request.setAttribute("years", years);
			session.setAttribute("student", student);
		} 
		

		session.setAttribute("student", student);
		session.setAttribute("reviewer", reviewer);
		session.setAttribute("admin", admin);
		return "Index";
	}

	@RequestMapping(value = "/loadlogin", method = RequestMethod.GET)
	public String loadLoginPage() {
		return "LoginPage";
	}

	@RequestMapping(value = "/verifylogin", method = RequestMethod.POST)
	public ModelAndView verifylogin(HttpServletRequest request, Model model, HttpSession session) throws Exception {
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		Student student = new Student();
		student.setEmail(email);
		student.setPassword(password);

		Reviewer reviewer = new Reviewer();
		reviewer.setEmail(email);
		reviewer.setPassword(password);

		Admin admin = new Admin();
		admin.setEmail(email);
		admin.setPassword(password);
		
		LoginManager loginManager = new LoginManager();
		student = loginManager.doLoginStudent(student);
		reviewer = loginManager.doLoginReviewer(reviewer);
		admin = loginManager.doLoginAdmin(admin);

		if (student == null && reviewer == null && admin == null) {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("error_msg", "กรุณาอีเมลหรือรหัสผ่านให้ถูกต้อง");
			return mav;
		} else if (student != null) {	
			Report report = new Report();
			List<StudentProject> listsproject = new Vector<>();
			
			Integer student_id = student.getStudent_id();
			String video = null ;
			String project_id = null ;
			Integer report_id = 0 ;
			Integer errors = 0 ;
			
			// error 0 = กรุณาอัปโหลดเอกสารรายงานและวิดีโอ ;
			// error 1 = กรุณาอัปโหลดวิดีโอ ;
			// error 2 = กรุณาอัปโหลดเอกสารรายงาน ;
			
			Calendar cal = Calendar.getInstance();
			int presentyears = cal.get(Calendar.YEAR);
			
			ViewScheduleDetailManager viewScheduleDetailManager = new ViewScheduleDetailManager();
			Years years = viewScheduleDetailManager.getYearsByID(presentyears);
			
			listsproject = loginManager.getListStudentProjectByStudentID(student_id);
				
			for (StudentProject studentProject : listsproject) {		
				
				project_id = studentProject.getProject().getProject_id();	
					
				video = studentProject.getProject().getVideo();	
				
				report = loginManager.getReportByProjectID(project_id);
				
				if (report != null) {
					report_id = report.getReport_id();	
				} else {
					if (video.equals("-") && report_id == 0) {
						errors = 1 ;
						System.out.println(errors);
					} else if (video.equals("-")) {
						errors = 2 ;
						System.out.println(errors);
					} else if (report_id == 0) {
						errors = 3 ;
						System.out.println(errors);
					} else {
						errors = 0 ;
						System.out.println(errors);
					}
				}
	
			}
			
			request.setAttribute("errors", errors);
			request.setAttribute("years", years);
			session.setAttribute("student", student);
		} else if (reviewer != null) {
			int team_id = reviewer.getTeam().getTeam_id();
			int reviewer_id = reviewer.getReviewer_id();
			ListScienceProjectManager listScienceProjectManager = new ListScienceProjectManager();
			AnnounceResultManager announceResultManager = new AnnounceResultManager();
			List<ProjectResponse> projectResponseList = listScienceProjectManager
					.getListProjectByReviewerID(reviewer_id);
			List<StudentProject> studentProjectList = listScienceProjectManager.getListScienceProjectByTeamID(team_id);

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
			
			Years years = announceResultManager.getDATE();
			
			ModelAndView mav = new ModelAndView("ListScienceProject");
			session.setAttribute("reviewer", reviewer);
			mav.addObject("projectResponseList", projectResponseList);
			mav.addObject("reviewerResponseList", reviewerResponseList);
			mav.addObject("studentProjectList", studentProjectList);
			mav.addObject("years", years);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("CreateSchedule");
			session.setAttribute("admin", admin);
			return mav;
		}
		ModelAndView mav = new ModelAndView("Index");
		return mav;
	}
	

	@RequestMapping(value = "/verifylogout", method = RequestMethod.GET)
	public ModelAndView verifylogout(HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView("Index");
		session.removeAttribute("student");
		session.removeAttribute("reviewer");
		session.removeAttribute("admin");
		return mav;
	}
	
}

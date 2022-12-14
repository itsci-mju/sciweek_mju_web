package controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Project;
import bean.Report;
import bean.Student;
import bean.Schedules;
import manager.AnnounceResultManager;
import manager.IsUploadReportManager;
import manager.ViewProjectDetailManager;

@Controller
public class UploadReportController {
	
	@RequestMapping(value = "/doViewUploadReport", method = RequestMethod.POST)
	public ModelAndView loaddoViewUploadReport(HttpSession session, HttpServletRequest request) throws Exception {
		Student student = (Student) session.getAttribute("student");
		if (student != null) {
			IsUploadReportManager isUploadReportManager = new IsUploadReportManager();
			AnnounceResultManager announceResultManager = new AnnounceResultManager();
			Project project = isUploadReportManager.getStudentProjectByID(student.getStudent_id());
			Schedules schedules = announceResultManager.getDATE();
			ModelAndView mav = new ModelAndView("UploadReport");
			mav.addObject("project", project);
			mav.addObject("schedules", schedules);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("student");
			return mav;
		}
	}
	
	@RequestMapping(value = "/UploadReport", method = RequestMethod.POST)
	public ModelAndView uploadReport(HttpServletRequest request, HttpSession session) throws Exception {
		Student student = (Student) session.getAttribute("student");
		if (student != null) {
			Project projectTemp = new Project();
			Report report = new Report();
			if (ServletFileUpload.isMultipartContent(request)) {
				request.setCharacterEncoding("UTF-8");
				try {
					List<FileItem> data = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
					IsUploadReportManager isUploadReportManager = new IsUploadReportManager();
					int id = isUploadReportManager.getnextreportid();
					String report_id = String.valueOf(id);
								
					Date date = new Date();
				    Calendar calendar = Calendar.getInstance();
				    calendar.setTime(date);
				    calendar.add(Calendar.YEAR,543);
				    date = calendar.getTime();
				    String date1 = new SimpleDateFormat("ddMMyyyyHHmmss").format(date);
													
				    projectTemp.setProject_id(data.get(0).getString("UTF-8"));
				    projectTemp.setVideo(data.get(1).getString("UTF-8"));
					
					isUploadReportManager.isUploadVideo(projectTemp);
																	
					isUploadReportManager.isDeleteUpload(report.getReport_id());
					
					report.setReport_id(id);
					report.setReportname(report_id +"_"+ date1);
					report.setProject(new Project(data.get(0).getString("UTF-8")));
		
					boolean result = isUploadReportManager.isUploadReport(report);
		
					String path = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/report";

					if (result) {
						data.get(2).write(new File(path + File.separator + report.getReportname() +".pdf"));
					}

				} catch (Exception e) {
					e.printStackTrace();
				}
			}		
			ViewProjectDetailManager viewProjectDetailManager = new ViewProjectDetailManager();
			Project project = viewProjectDetailManager.getStudentProjectByID(student.getStudent_id());
			ModelAndView mav = new ModelAndView("ViewProjectDetail");
			mav.addObject("project", project);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			return mav;
		}
	}

}

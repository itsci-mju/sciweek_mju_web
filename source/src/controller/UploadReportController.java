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
import bean.StudentProject;
import manager.IsUploadReportManager;

@Controller
public class UploadReportController {
	
	@RequestMapping(value = "/doViewUploadReport", method = RequestMethod.GET)
	public ModelAndView loaddoViewUploadReport(HttpSession session, HttpServletRequest request) throws Exception {
		Student student = (Student) session.getAttribute("student");
		if (student != null) {
			String project_id = request.getParameter("project_id");
			IsUploadReportManager isUploadReportManager = new IsUploadReportManager();
			StudentProject sproject = isUploadReportManager.getStudentProjectByID(project_id);
			List<StudentProject> listsproject = isUploadReportManager.getListStudentProject(project_id);
			ModelAndView mav = new ModelAndView("UploadReport");
			mav.addObject("sproject", sproject);
			mav.addObject("listsproject", listsproject);
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
			if (ServletFileUpload.isMultipartContent(request)) {
				request.setCharacterEncoding("UTF-8");
				try {
					List<FileItem> data = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
					IsUploadReportManager isUploadReportManager = new IsUploadReportManager();
					int id = isUploadReportManager.getnextreportid();
					String report_id = String.valueOf(id);
					
					isUploadReportManager.isDeleteUpload(report_id);
					
					Date dd = new Date();
				    Calendar c1 = Calendar.getInstance();
				    c1.setTime(dd);
				    c1.add(Calendar.YEAR,543);
				    dd = c1.getTime();
				    String date1 = new SimpleDateFormat("ddMMyyyyHHmmss").format(dd);
									
					Project project = new Project();
					project.setProject_id(data.get(0).getString("UTF-8"));
					project.setVideo(data.get(3).getString("UTF-8"));
					
					isUploadReportManager.isUploadVideo(project);
													
					Report report = new Report();
					report.setReport_id(id);
					report.setReportname(report_id +"_"+ date1);
					report.setProject(new Project(data.get(0).getString("UTF-8")));
		
					boolean result = isUploadReportManager.isUploadReport(report);

					String path = request.getSession().getServletContext().getRealPath("/") + "//WEB-INF/report//";

					if (result) {
						data.get(4).write(new File(path + File.separator + report.getReportname() +".pdf"));
					}

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			ModelAndView mav = new ModelAndView("Index");
			request.setAttribute("student", student);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			return mav;
		}
	}

}

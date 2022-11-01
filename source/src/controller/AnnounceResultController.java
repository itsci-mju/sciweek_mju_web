package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Schedules;
import manager.AnnounceResultManager;
import model.StudentProjectResponse;

@Controller
public class AnnounceResultController {
	
	@RequestMapping(value = "/doViewResult", method = RequestMethod.GET)
	public ModelAndView loadViewResult(HttpSession session, HttpServletRequest request) throws Exception {
		
			Integer projecttype_id = Integer.parseInt(request.getParameter("projecttype_id"));
			
			AnnounceResultManager announceResultManager = new AnnounceResultManager();

			List<StudentProjectResponse> studentProjectResponseList = announceResultManager.getListStudentProject(projecttype_id);
			Schedules schedules = announceResultManager.getDATE();
			ModelAndView mav = new ModelAndView("AnnounceResult");
			request.setCharacterEncoding("UTF-8");
			request.setAttribute("schedules", schedules);
			request.setAttribute("studentProjectResponseList", studentProjectResponseList);
			return mav;
		
	}
	
	@RequestMapping(value = "/ExportAnnounceExcel", method = RequestMethod.GET)
	public ModelAndView ExportResultExcel(HttpSession session, HttpServletRequest request) throws Exception {
		
			Integer projecttype_id = Integer.parseInt(request.getParameter("projecttype_id"));

			AnnounceResultManager announceResultManager = new AnnounceResultManager();

			List<StudentProjectResponse> studentProjectResponseList = announceResultManager.getListStudentProject(projecttype_id);
			Schedules schedules = announceResultManager.getDATE();
			ModelAndView mav = new ModelAndView("ExportAnnounceExcel");
			request.setCharacterEncoding("UTF-8");
			request.setAttribute("studentProjectResponseList", studentProjectResponseList);
			request.setAttribute("schedules", schedules);

			return mav;
		
	}
	
}

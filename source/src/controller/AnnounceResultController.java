package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Project;
import bean.ProjectType;
import bean.Years;
import manager.AnnounceResultManager;

@Controller
public class AnnounceResultController {
	
	@RequestMapping(value = "/doViewResult", method = RequestMethod.GET)
	public ModelAndView loadViewResult(HttpSession session, HttpServletRequest request) throws Exception {

			AnnounceResultManager announceResultManager = new AnnounceResultManager();

			List<Project> listproject = announceResultManager.getListProject();
			List<ProjectType> projectTypeList = announceResultManager.getlistProjectType();
			Years years = announceResultManager.getDATE();
			ModelAndView mav = new ModelAndView("AnnounceResult");
			request.setCharacterEncoding("UTF-8");
			request.setAttribute("listproject", listproject);
			request.setAttribute("years", years);
			request.setAttribute("projectTypeList", projectTypeList);
			return mav;
		
	}
	
	@RequestMapping(value = "/isViewResult", method = RequestMethod.GET)
	public ModelAndView isViewResult(HttpSession session, HttpServletRequest request) throws Exception {

			Integer projecttype_id = Integer.parseInt(request.getParameter("projecttype_id"));

			AnnounceResultManager announceResultManager = new AnnounceResultManager();

			List<Project> listproject = announceResultManager.getListProjectByProjecttypeID(projecttype_id);
			List<ProjectType> projectTypeList = announceResultManager.getlistProjectType();
			Years years = announceResultManager.getDATE();
			ModelAndView mav = new ModelAndView("AnnounceResult");
			request.setCharacterEncoding("UTF-8");
			request.setAttribute("listproject", listproject);
			request.setAttribute("years", years);
			request.setAttribute("projectTypeList", projectTypeList);
			return mav;
		
	}
	
	@RequestMapping(value = "/ExportAnnounceExcel", method = RequestMethod.GET)
	public ModelAndView ExportResultExcel(HttpSession session, HttpServletRequest request) throws Exception {
		
			Integer projecttype_id = Integer.parseInt(request.getParameter("projecttype_id"));

			AnnounceResultManager announceResultManager = new AnnounceResultManager();

			List<Project> listproject = announceResultManager.getListProjectByProjecttypeID(projecttype_id);
			List<ProjectType> projectTypeList = announceResultManager.getlistProjectType();
			Years years = announceResultManager.getDATE();
			ModelAndView mav = new ModelAndView("ExportAnnounceExcel");
			request.setCharacterEncoding("UTF-8");
			request.setAttribute("listproject", listproject);
			request.setAttribute("years", years);
			request.setAttribute("projectTypeList", projectTypeList);
			return mav;
		
	}
	
}

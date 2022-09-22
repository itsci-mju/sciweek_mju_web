package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Admin;
import bean.Project;
import bean.Reviewer;
import bean.Student;
import manager.AnnounceResultManager;

@Controller
public class AnnounceResultController {
	
	@RequestMapping(value = "/doViewResult", method = RequestMethod.GET)
	public ModelAndView loadViewResult(HttpSession session, HttpServletRequest request) throws Exception {
		Reviewer reviewer = (Reviewer) session.getAttribute("reviewer");
		Student student = (Student) session.getAttribute("student");
		Admin admin = (Admin) session.getAttribute("admin");
		if (reviewer != null || student != null || admin != null) {
			AnnounceResultManager announceResultManager = new AnnounceResultManager();

			List<Project> listproject = announceResultManager.getListProject();
			ModelAndView mav = new ModelAndView("AnnounceResult");
			request.setCharacterEncoding("UTF-8");
			request.setAttribute("listproject", listproject);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("reviewer");
			session.removeAttribute("student");
			session.removeAttribute("admin");
			return mav;
		}
	}
	
	@RequestMapping(value = "/isViewResult", method = RequestMethod.GET)
	public ModelAndView isViewResult(HttpSession session, HttpServletRequest request) throws Exception {
		Reviewer reviewer = (Reviewer) session.getAttribute("reviewer");
		Student student = (Student) session.getAttribute("student");
		Admin admin = (Admin) session.getAttribute("admin");
		if (reviewer != null || student != null || admin != null) {
			String classproject = request.getParameter("classproject");
			String projecttype_id = request.getParameter("projecttype_id");

			AnnounceResultManager announceResultManager = new AnnounceResultManager();

			List<Project> listproject = announceResultManager.getListProjectByClassprojectAndProjecttypeID(classproject,
					projecttype_id);
			ModelAndView mav = new ModelAndView("AnnounceResult");
			request.setCharacterEncoding("UTF-8");
			request.setAttribute("listproject", listproject);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("reviewer");
			session.removeAttribute("student");
			session.removeAttribute("admin");
			return mav;
		}
	}
	
	@RequestMapping(value = "/ExportAnnounceExcel", method = RequestMethod.GET)
	public ModelAndView ExportResultExcel(HttpSession session, HttpServletRequest request) throws Exception {
		Reviewer reviewer = (Reviewer) session.getAttribute("reviewer");
		Student student = (Student) session.getAttribute("student");
		Admin admin = (Admin) session.getAttribute("admin");
		if (reviewer != null || student != null || admin != null) {
			AnnounceResultManager announceResultManager = new AnnounceResultManager();

			List<Project> listproject = announceResultManager.getListProject();
			ModelAndView mav = new ModelAndView("ExportAnnounceExcel");
			request.setCharacterEncoding("UTF-8");
			request.setAttribute("listproject", listproject);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("reviewer");
			session.removeAttribute("student");
			session.removeAttribute("admin");
			return mav;
		}
	}
	
}

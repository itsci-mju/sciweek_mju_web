package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Admin;
import bean.Reviewer;
import bean.Project;
import bean.ProjectType;
import manager.ViewTeamDetailManager;

@Controller
public class ViewTeamDetailController {
	
	@RequestMapping(value = "/ViewTeamDetail" , method = RequestMethod.GET)
	public ModelAndView loadViewTeamDetail(HttpSession session, HttpServletRequest request) throws Exception{
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			Integer projecttype_id = Integer.parseInt(request.getParameter("projecttype_id"));
			ViewTeamDetailManager viewTeamDetailManager = new ViewTeamDetailManager();
			ProjectType projecttype = viewTeamDetailManager.getTeamByID(projecttype_id);
			List<Reviewer> listreviewer = viewTeamDetailManager.getListReviewerByTeamID(projecttype_id);
			List<Project> listproject = viewTeamDetailManager.getListProjectByTeamID(projecttype_id);
			ModelAndView mav = new ModelAndView("ViewTeamDetail");
			mav.addObject("projecttype",projecttype);
			mav.addObject("listreviewer", listreviewer);
			mav.addObject("listproject", listproject);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("admin");
			return mav;
		}
	}
	
	@RequestMapping(value = "/doDeleteReviewerByTeamID", method = RequestMethod.GET)
	public ModelAndView doDeleteReviewerByTeamID(HttpSession session, HttpServletRequest request) throws Exception {

		Admin admin = (Admin) session.getAttribute("admin");
		Integer projecttype_id = Integer.parseInt(request.getParameter("projecttype_id"));
		Integer reviewer_id = Integer.parseInt(request.getParameter("reviewer_id"));
		if (admin != null) {
			ModelAndView mav = new ModelAndView("ViewTeamDetail");
			
			ViewTeamDetailManager viewTeamDetailManager = new ViewTeamDetailManager();
			
			if (viewTeamDetailManager.isDeleteReviewerByTeamID(projecttype_id,reviewer_id)) {
				mav.addObject("msg", "ลบข้อมูลสำเร็จแล้ว!!!! ");
			} else {
				mav.addObject("msg", "ลบข้อมูลไม่สำเร็จแล้ว!!!! ");
			}

			ProjectType projecttype = viewTeamDetailManager.getTeamByID(projecttype_id);
			List<Reviewer> listreviewer = viewTeamDetailManager.getListReviewerByTeamID(projecttype_id);
			List<Project> listproject = viewTeamDetailManager.getListProjectByTeamID(projecttype_id);
			mav.addObject("projecttype", projecttype);
			mav.addObject("listreviewer", listreviewer);
			mav.addObject("listproject", listproject);	
			return mav;

		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("admin");
			return mav;
		}
	}

}

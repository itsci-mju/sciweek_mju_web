package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Admin;
import bean.ProjectType;
import bean.Reviewer;
import manager.DeleteTeamManager;
import manager.ListTeamManager;
import manager.ViewTeamDetailManager;

@Controller
public class DeleteTeamController {
	
	@RequestMapping(value = "/doDeleteTeam", method = RequestMethod.GET)
	public ModelAndView doDeleteTeam(HttpSession session, HttpServletRequest request) throws Exception {

		Admin admin = (Admin) session.getAttribute("admin");
		Integer projecttype_id = Integer.parseInt(request.getParameter("projecttype_id"));
		if (admin != null) {
			ModelAndView mav = new ModelAndView("ListTeam");
			
			DeleteTeamManager deleteTeamManager = new DeleteTeamManager();
			if (deleteTeamManager.isDeleteTeam(projecttype_id)) {
				mav.addObject("msg", "ลบข้อมูลทีมสำเร็จแล้ว!!!! ");
			} else {
				mav.addObject("msg", "ลบข้อมูลทีมไม่สำเร็จแล้ว!!!! ");
			}

			ListTeamManager listTeamManager = new ListTeamManager();
			ViewTeamDetailManager viewTeamDetailManager = new ViewTeamDetailManager();
			List<ProjectType> projectTypeList = listTeamManager.getListProjectType();
			List<Reviewer> reviewerList = viewTeamDetailManager.getListReviewer();		
			mav.addObject("projectTypeList", projectTypeList);
			mav.addObject("reviewerList", reviewerList);
			return mav;

		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("admin");
			return mav;
		}
	}

}

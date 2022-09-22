package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Admin;
import bean.Team;
import manager.DeleteTeamManager;
import manager.ListTeamManager;

@Controller
public class DeleteTeamController {
	
	@RequestMapping(value = "/doDeleteTeam", method = RequestMethod.GET)
	public ModelAndView doDeleteTeam(HttpSession session, HttpServletRequest request) {

		Admin admin = (Admin) session.getAttribute("admin");
		Integer team_id = Integer.parseInt(request.getParameter("team_id"));
		if (admin != null) {
			ModelAndView mav = new ModelAndView("ListTeam");
			
			DeleteTeamManager deleteTeamManager = new DeleteTeamManager();
			if (deleteTeamManager.isDeleteTeam(team_id)) {
				mav.addObject("msg", "ลบข้อมูลทีมสำเร็จแล้ว!!!! ");
			} else {
				mav.addObject("msg", "ลบข้อมูลทีมไม่สำเร็จแล้ว!!!! ");
			}

			ListTeamManager vtim = new ListTeamManager();
			List<Team> listteam = vtim.getListTeam();
			request.setAttribute("listteam", listteam);

			return mav;

		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("admin");
			return mav;
		}
	}

}

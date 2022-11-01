package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Admin;
import bean.Schedules;
import manager.ListScheduleManager;

@Controller
public class ListScheduleController {
	
	@RequestMapping(value = "/doViewSchedule", method = RequestMethod.GET)
	public ModelAndView doViewSchedule(HttpSession session, HttpServletRequest request) throws Exception {
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			ListScheduleManager listScheduleManager = new ListScheduleManager();
			List<Schedules> schedulesList = listScheduleManager.getListSchedules();
			ModelAndView mav = new ModelAndView("ListSchedule");
			mav.addObject("schedulesList", schedulesList);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("admin");
			return mav;
		}
	}

}

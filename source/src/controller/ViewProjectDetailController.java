package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Project;
import bean.Student;
import manager.ViewProjectDetailManager;

@Controller
public class ViewProjectDetailController {

	@RequestMapping(value = "/doViewProjectDetail", method = RequestMethod.POST)
	public ModelAndView loadViewProjectDetail(HttpSession session, HttpServletRequest request) throws Exception {
		Student student = (Student) session.getAttribute("student");
		if (student != null) {
			ViewProjectDetailManager viewProjectDetailManager = new ViewProjectDetailManager();
			Project project = viewProjectDetailManager.getStudentProjectByID(student.getStudent_id());
			ModelAndView mav = new ModelAndView("ViewProjectDetail");
			mav.addObject("project", project);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("student");
			return mav;
		}
	}

}

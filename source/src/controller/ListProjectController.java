package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Project;
import bean.Student;
import manager.ListProjectManager;

@Controller
public class ListProjectController {
	
	@RequestMapping(value = "/doListProject", method = RequestMethod.GET)
	public ModelAndView loadListProjectPage(HttpSession session, HttpServletRequest request) throws Exception{
		Student student = (Student) session.getAttribute("student");
		if (student != null) {		
			ListProjectManager listProjectManager = new ListProjectManager();
			Project project = listProjectManager.getStudentProjectByID(student.getStudent_id());
			ModelAndView mav = new ModelAndView("ListProject");
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

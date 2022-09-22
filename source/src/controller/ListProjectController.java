package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Student;
import bean.StudentProject;
import manager.ListProjectManager;

@Controller
public class ListProjectController {
	
	@RequestMapping(value = "/doListProject", method = RequestMethod.GET)
	public ModelAndView loadListProjectPage(HttpSession session, HttpServletRequest request) throws Exception{
		Student student = (Student) session.getAttribute("student");
		if (student != null) {		
			ListProjectManager listProjectManager = new ListProjectManager();
			List<StudentProject> listsproject = listProjectManager.getListStudentProject(student.getStudent_id());
			ModelAndView mav = new ModelAndView("ListProject");
			mav.addObject("listsproject", listsproject);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("student");
			return mav;
		}
	}

}

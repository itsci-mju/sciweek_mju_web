package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Admin;
import bean.Advisor;
import bean.Project;
import bean.Student;
import bean.StudentProject;
import manager.DeleteStudentProjectManager;
import manager.ListStudentProjectManager;

@Controller
public class DeleteStudentProjectController {
	
	@RequestMapping(value = "/doDeleteStudentProject", method = RequestMethod.POST)
	public ModelAndView doDeleteStudentProject(HttpSession session, HttpServletRequest request) throws Exception {		
		Admin admin = (Admin) session.getAttribute("admin");	
		if (admin != null) {
			request.setCharacterEncoding("UTF-8");
			String project_id = request.getParameter("project_id");
			
			Project project = new Project();
			project.setProject_id(project_id);
			
			Integer advisor_id = Integer.parseInt(request.getParameter("advisor_id"));
			
			Advisor advisor = new Advisor();
			advisor.setAdvisor_id(advisor_id);
			
			
			DeleteStudentProjectManager deleteStudentProjectManager = new DeleteStudentProjectManager();
			
			String[] StudentIDStrList = request.getParameterValues("student_id");			
			
			for (String StudentIDStr : StudentIDStrList) {
				int student_id = Integer.parseInt(StudentIDStr);
				
				Student student = new Student();
				student.setStudent_id(student_id);
				
				System.out.println(project_id);
				System.out.println(advisor_id);
				System.out.println(student_id);
				
				
				deleteStudentProjectManager.isDeleteStudentProject(student, project, advisor);
			}
			
			ListStudentProjectManager vpjm = new ListStudentProjectManager();
			List<StudentProject> listsproject = vpjm.getListStudentProject();
			ModelAndView mav = new ModelAndView("ListStudentProject");
			mav.addObject("listsproject", listsproject);

			return mav;

		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("admin");
			return mav;
		}
	}

}



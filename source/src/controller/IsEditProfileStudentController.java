package controller;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Student;
import bean.School;
import manager.IsEditProfileStudentManager;

@Controller
public class IsEditProfileStudentController {
	
	@RequestMapping(value = "/getEditProfileStudent", method = RequestMethod.GET)
	public ModelAndView loadEditProfileStudentPage(HttpSession session, HttpServletRequest request) {
		Student student = (Student) session.getAttribute("student");
		if (student != null) {
			ModelAndView mav = new ModelAndView("EditProfileStudent");
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("student");
			return mav;
		}
	}

	@RequestMapping(value = "/doEditProfileStudent", method = RequestMethod.POST)
	public ModelAndView doEditProfileStudent(HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException, ParseException {
		Student student = (Student) session.getAttribute("student");
		if (student != null) {
			request.setCharacterEncoding("UTF-8");
			Student studentTemp = new Student();
			studentTemp.setStudent_id(Integer.parseInt(request.getParameter("student_id")));
			studentTemp.setPrefix(request.getParameter("prefix"));
			studentTemp.setFirstname(request.getParameter("firstname"));
			studentTemp.setLastname(request.getParameter("lastname"));
			studentTemp.setGrade(request.getParameter("grade"));
			studentTemp.setMobileno(request.getParameter("mobileno"));
			studentTemp.setEmail(request.getParameter("email"));
			studentTemp.setPassword(request.getParameter("password"));
			School school = new School();
			school.setSchool_id(Integer.parseInt(request.getParameter("school_id")));
			school.setSchool_name(request.getParameter("school_name"));
			school.setSchool_address(request.getParameter("school_address"));
			studentTemp.setSchool(school);

			IsEditProfileStudentManager  isEditProfileStudentManager = new IsEditProfileStudentManager();
			ModelAndView mav = new ModelAndView("EditProfileStudent");
			if (isEditProfileStudentManager.isEditProfileStudent(studentTemp)) {
				mav.addObject("msg", "บันทึกข้อมูลสำเร็จ!!!!");
				session.removeAttribute("student");
				session.setAttribute("student", studentTemp);
			} else {
				mav.addObject("msg", "บันทึกข้อมูลไม่สำเร็จ!!!!");
			}
			
			session.setAttribute("student", studentTemp);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("student");
			return mav;
		}

	}

}

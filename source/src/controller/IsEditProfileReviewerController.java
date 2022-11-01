package controller;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.ProjectType;
import bean.Reviewer;
import manager.IsEditProfileReviewerManager;

@Controller
public class IsEditProfileReviewerController {

	@RequestMapping(value = "/getEditProfileReviewer", method = RequestMethod.GET)
	public ModelAndView loadEditProfileReviewerPage(HttpSession session, HttpServletRequest request) {
		Reviewer reviewer = (Reviewer) session.getAttribute("reviewer");
		if (reviewer != null) {
			ModelAndView mav = new ModelAndView("EditProfileReviewer");
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("reviewer");
			return mav;
		}
	}

	@RequestMapping(value = "/doEditProfileReviewer", method = RequestMethod.POST)
	public ModelAndView doEditProfileReviewer(HttpServletRequest request, HttpSession session)throws UnsupportedEncodingException {
		Reviewer reviewer = (Reviewer) session.getAttribute("reviewer");
		if (reviewer != null ) {
			request.setCharacterEncoding("UTF-8");
			Reviewer reviewerTemp = new Reviewer();
			reviewerTemp.setReviewer_id(Integer.parseInt(request.getParameter("reviewer_id")));
			reviewerTemp.setPrefix(request.getParameter("prefix"));
			reviewerTemp.setFirstname(request.getParameter("firstname"));
			reviewerTemp.setLastname(request.getParameter("lastname"));
			reviewerTemp.setFaculty(request.getParameter("faculty"));
			reviewerTemp.setMajor(request.getParameter("major"));
			reviewerTemp.setPosition(request.getParameter("position"));
			reviewerTemp.setLine(request.getParameter("line"));
			reviewerTemp.setFacebook(request.getParameter("facebook"));
			reviewerTemp.setEmail(request.getParameter("email"));
			reviewerTemp.setPassword(request.getParameter("password"));
			
			ProjectType projecttype = new ProjectType();
			projecttype.setProjecttype_id(Integer.parseInt(request.getParameter("projecttype_id")));
			projecttype.setProjecttype_name(request.getParameter("projecttype_name"));
			reviewerTemp.setProjecttype(projecttype);

			IsEditProfileReviewerManager isEditProfileReviewerManager = new IsEditProfileReviewerManager();
			ModelAndView mav = new ModelAndView("Index");
			if (isEditProfileReviewerManager.isEditProfileReviewer(reviewerTemp)) {
				mav.addObject("msg", "บันทึกข้อมูลสำเร็จ!!!!");
				session.removeAttribute("reviewer");
				session.setAttribute("reviewer", reviewerTemp);
			} else {
				mav.addObject("msg", "บันทึกข้อมูลไม่สำเร็จ!!!!");
			}
			session.setAttribute("reviewer", reviewerTemp);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("reviewer");
			return mav;
		}
	}
	
}

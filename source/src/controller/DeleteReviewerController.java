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
import manager.DeleteReviewerManager;

@Controller
public class DeleteReviewerController {
	
	@RequestMapping(value = "/doDeleteReviewer", method = RequestMethod.GET)
	public ModelAndView doDeleteTeam(HttpSession session, HttpServletRequest request) throws Exception {

		Admin admin = (Admin) session.getAttribute("admin");
		Integer reviewer_id = Integer.parseInt(request.getParameter("reviewer_id"));
		if (admin != null) {
			ModelAndView mav = new ModelAndView("CreateTeam");
			DeleteReviewerManager deleteReviewerManager = new DeleteReviewerManager();
			if (deleteReviewerManager.isDeleteReviewer(reviewer_id)) {
				mav.addObject("msg", "ลบข้อมูลกรรมการสำเร็จแล้ว!!!! ");
			} else {
				mav.addObject("msg", "ลบข้อมูลกรรมการไม่สำเร็จแล้ว!!!! ");
			}
				
			List<Reviewer> listreviewer = deleteReviewerManager.getListReviewer();
			request.setAttribute("listreviewer", listreviewer);

			return mav;

		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("admin");
			return mav;
		}
	}

}

package controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Admin;
import bean.Years;
import lombok.val;
import manager.ViewScheduleDetailManager;


@Controller
public class ViewScheduleDetailController {
	
	@RequestMapping(value = "/ViewScheduleDetail" , method = RequestMethod.GET)
	public ModelAndView loadViewTeamDetail(HttpSession session, HttpServletRequest request) throws Exception{
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			Integer yearsTemp = Integer.parseInt(request.getParameter("years"));
			ViewScheduleDetailManager viewScheduleDetailManager = new ViewScheduleDetailManager();
			Years years = viewScheduleDetailManager.getYearsByID(yearsTemp);
			ModelAndView mav = new ModelAndView("ViewScheduleDetail");
			mav.addObject("years",years);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("admin");
			return mav;
		}
	}
	
	@RequestMapping(value = "/isEditSchedule", method = RequestMethod.POST)
	public ModelAndView isEditSchedule(HttpServletRequest request, HttpSession session) throws Exception {
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			request.setCharacterEncoding("UTF-8");
			
			ViewScheduleDetailManager viewScheduleDetailManager = new ViewScheduleDetailManager();
			
			val uploaddate = request.getParameter("uploaddate");
			val expuploaddate = request.getParameter("expuploaddate");
			val reviewdate = request.getParameter("reviewdate");
			val expreviewdate = request.getParameter("expreviewdate");
			val announcedate = request.getParameter("announcedate");
			
			Date d_uploaddate =  new SimpleDateFormat("yyyy-MM-dd'T'hh:mm").parse(uploaddate);
			Date d_expuploaddate =  new SimpleDateFormat("yyyy-MM-dd'T'hh:mm").parse(expuploaddate);
			Date d_reviewdate =  new SimpleDateFormat("yyyy-MM-dd'T'hh:mm").parse(reviewdate);
			Date d_expreviewdate =  new SimpleDateFormat("yyyy-MM-dd'T'hh:mm").parse(expreviewdate);
			Date d_announcedate =  new SimpleDateFormat("yyyy-MM-dd'T'hh:mm").parse(announcedate);
			
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
			val fmt_uploaddate = simpleDateFormat.format(d_uploaddate);
			val fmt_expuploaddate =  simpleDateFormat.format(d_expuploaddate);
			val fmt_reviewdate =  simpleDateFormat.format(d_reviewdate);
			val fmt_expreviewdate =  simpleDateFormat.format(d_expreviewdate);
			val fmt_announcedate =  simpleDateFormat.format(d_announcedate);

			Years years = new Years();
			
			int presentyears = Integer.parseInt(request.getParameter("years"));
			Timestamp ts_uploaddate =  Timestamp.valueOf(fmt_uploaddate);
			Timestamp ts_expuploaddate =  Timestamp.valueOf(fmt_expuploaddate);
			Timestamp ts_reviewdate =  Timestamp.valueOf(fmt_reviewdate);
			Timestamp ts_expreviewdate =  Timestamp.valueOf(fmt_expreviewdate);
			Timestamp ts_announcedate =  Timestamp.valueOf(fmt_announcedate);
			
			System.out.println(presentyears);
			System.out.println(ts_uploaddate);
			System.out.println(ts_expuploaddate);
			System.out.println(ts_reviewdate);
			System.out.println(ts_expreviewdate);
			System.out.println(ts_announcedate);
			
			years.setYears(presentyears);
			years.setUploaddate(ts_uploaddate);
			years.setExpuploaddate(ts_expuploaddate);
			years.setReviewdate(ts_reviewdate);
			years.setExpreviewdate(ts_expreviewdate);
			years.setAnnouncedate(ts_announcedate);		

			ModelAndView mav = new ModelAndView("Index");
			if (viewScheduleDetailManager.isEditSchedule(years)) {
				mav.addObject("msg", "บันทึกข้อมูลสำเร็จ!!!!");
				session.setAttribute("years", years);
			} else {
				mav.addObject("msg", "บันทึกข้อมูลไม่สำเร็จ!!!!");
			}
			session.setAttribute("years", years);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("admin");
			return mav;
		}
	}

}

package controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.*;
import lombok.val;
import manager.*;


@Controller
public class CreateScheduleController {
	
	@RequestMapping(value = "/doCreateSchedule", method = RequestMethod.GET)
	public ModelAndView loadCreateTeamPage(HttpSession session, HttpServletRequest request) throws Exception {
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {	
			ModelAndView mav = new ModelAndView("CreateSchedule");		
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("admin");
			return mav;
		}
	}
	
	@RequestMapping(value = "/isCreateSchedule", method = RequestMethod.POST)
	public ModelAndView isCreateSchedule(HttpServletRequest request, Model md, HttpSession session) throws Exception {
		
		CreateScheduleManager createScheduleManager = new CreateScheduleManager();
		request.setCharacterEncoding("UTF-8");
		
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

		Schedules schedules = new Schedules();
		
		Calendar cal = Calendar.getInstance();
		int presentyears = cal.get(Calendar.YEAR);
		
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
		
		schedules.setYears(presentyears);
		schedules.setUploaddate(ts_uploaddate);
		schedules.setExpuploaddate(ts_expuploaddate);
		schedules.setReviewdate(ts_reviewdate);
		schedules.setExpreviewdate(ts_expreviewdate);
		schedules.setAnnouncedate(ts_announcedate);
	
		boolean statusresult = createScheduleManager.isCreateSchedule(schedules);

		if (statusresult) {
			ModelAndView mav = new ModelAndView("Index");
			mav.addObject("schedules",schedules);
			mav.addObject("msg", "สร้างกำหนดการสำเร็จ");
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("CreateSchedule");
			mav.addObject("msg", "สร้างกำหนดการไม่สำเร็จ!!!!");
			return mav;
		}
		
	}
	

}

package controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Admin;
import bean.Pressrelease;
import manager.AddNewsManager;
import manager.ListNewsManager;

@Controller
public class AddNewsController {
	
	@RequestMapping(value = "/loadAddNewsPage", method = RequestMethod.GET)
	public ModelAndView loadAddNewsPage(HttpSession session, HttpServletRequest request) {
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			ModelAndView mav = new ModelAndView("AddPressrelease");
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			return mav;
		}
	}
	
	@RequestMapping(value = "/addnews", method = RequestMethod.POST)
	public ModelAndView addnews(HttpSession session, HttpServletRequest request) throws Exception {
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			if (ServletFileUpload.isMultipartContent(request)) {
				request.setCharacterEncoding("UTF-8");
				try {
						List<FileItem> data = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
						AddNewsManager addNewsManager = new AddNewsManager();	
						int  id = addNewsManager.getnextpressreleaseid();
						String title =  data.get(0).getString("UTF-8");
						String type = data.get(1).getString("UTF-8");
						String detail  = data.get(2).getString("UTF-8");

						Pressrelease pressrelease = new Pressrelease();
						pressrelease.setNewsid(id);
						pressrelease.setTitle(title);
						pressrelease.setType(type);
						pressrelease.setDetail(detail);

						boolean result = addNewsManager.isAddpressrelease(pressrelease);
						
						String path = request.getSession().getServletContext().getRealPath("/") + "//WEB-INF/news_img//";            
							
						if(result) {
							data.get(3).write(new File(path + File.separator + id +".png"));							
						}
				} catch (Exception e) {
					
				}

			}
			ModelAndView mav = new ModelAndView("ListNews");
			ListNewsManager listNewsManager = new ListNewsManager();
			List<Pressrelease> listnews = listNewsManager.getlistNews();
			request.setCharacterEncoding("UTF-8");
			request.setAttribute("listnews", listnews);
			mav.addObject("msg", "Pass");
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			return mav;
		}
	}

}

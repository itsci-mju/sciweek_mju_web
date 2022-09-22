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
import manager.ListNewsManager;

@Controller
public class ListNewsController {
	
	@RequestMapping(value = "/doViewNews", method = RequestMethod.GET)
	public ModelAndView loadViewNews(HttpSession session, HttpServletRequest request) throws Exception {
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			ModelAndView mav = new ModelAndView("ListNews");
			ListNewsManager listNewsManager = new ListNewsManager();
			List<Pressrelease> listnews = listNewsManager.getlistNews();
			request.setCharacterEncoding("UTF-8");
			request.setAttribute("listnews", listnews);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			return mav;
		}
	}
	
	@RequestMapping(value = "/searchnews", method = RequestMethod.POST)
	public ModelAndView searchListlaboratoryInstruments2(HttpSession session,HttpServletRequest request) throws Exception {
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			request.setCharacterEncoding("UTF-8");
			String keyword = request.getParameter("keyword");
			ListNewsManager lnm = new ListNewsManager();
			List<Pressrelease> listnews = lnm.searchnews(keyword);

			request.setAttribute("listnews", listnews);
			request.setAttribute("keyword", keyword);
			ModelAndView mav = new ModelAndView("ListNews");
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			return mav;
		}
	}
	
	@RequestMapping(value = "/editnews", method = RequestMethod.POST)
	public ModelAndView editnews(HttpSession session, HttpServletRequest request) throws Exception {
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			ListNewsManager lnm = new ListNewsManager();
			ModelAndView mav = new ModelAndView("ListNews");
			if (ServletFileUpload.isMultipartContent(request)) {
				
				request.setCharacterEncoding("UTF-8");
				
				try {
					List<FileItem> data = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);

						int id = Integer.parseInt(data.get(0).getString("UTF-8"));
						String title =  data.get(1).getString("UTF-8");
						String type = data.get(2).getString("UTF-8");	
						String detail  = data.get(3).getString("UTF-8");		
						
						Pressrelease pressrelease = new Pressrelease();
						pressrelease.setNewsid(id);
						pressrelease.setTitle(title);
						pressrelease.setType(type);
						pressrelease.setDetail(detail);

						boolean result = lnm.editpressrelease(pressrelease);
						
						String path = request.getSession().getServletContext().getRealPath("/") + "//WEB-INF/news_img//";
						
						  if(result) { 
							  data.get(2).write(new File(path + File.separator + id +".png"));			
								mav.addObject("msg", "Pass");
							  } else {
								mav.addObject("msg", "Failed");
							  }
							
				} catch (Exception e) {
				}

			}
			
			List<Pressrelease> listnews = lnm.getlistNews();
			request.setCharacterEncoding("UTF-8");
			request.setAttribute("listnews", listnews);
			return mav;
		
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			return mav;
		}
	}
	
	
	
	@RequestMapping(value = "/deletenews", method = RequestMethod.GET)
	public ModelAndView deletenews(HttpSession session, HttpServletRequest request) throws Exception {
		String msg = " ";
		Admin admin = (Admin) session.getAttribute("admin");
		int   id =Integer.parseInt(request.getParameter("id"));
		if (admin != null) {
			
			ListNewsManager lnm = new ListNewsManager();
			boolean status = lnm.isDeleteNews(id);
			System.out.println("Status Delete is "+status);
			if(status) {
			File file = new File("/eclipse-workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/EvaluateSciProject/WEB-INF/news_img/"+ id+".png");
	        if(file.delete()) {
	       System.out.println("File deleted successfully");
	       msg = " ";
	       
	       
	        } else{
	            System.out.println("Failed to delete the file");
	            msg = " ";
	        }
			}
			List<Pressrelease> listnews = lnm.getlistNews();
			request.setCharacterEncoding("UTF-8");
			request.setAttribute("listnews", listnews);
			ModelAndView mav = new ModelAndView("ListNews");
			mav.addObject("msg", msg);
			return mav;
			
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			return mav;
		}
	}
	

}

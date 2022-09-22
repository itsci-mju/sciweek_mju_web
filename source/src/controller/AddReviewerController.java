package controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Admin;
import bean.Reviewer;
import lombok.val;
import manager.AddReviewerManager;
import util.ReadWriteExcel;

@Controller
public class AddReviewerController {

	@RequestMapping(value = "/getAddReviewer", method = RequestMethod.GET)
	public ModelAndView loadAddReviewerPage(HttpSession session, HttpServletRequest request) {

		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			ModelAndView mav = new ModelAndView("AddReviewer");
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("admin");
			return mav;
		}
	}

	@RequestMapping(value = "/doAddReviewer", method = RequestMethod.POST)
	public ModelAndView doAddreviewer(HttpServletRequest request, Model md, HttpSession session) throws Exception {
		
		AddReviewerManager addReviewerManager = new AddReviewerManager();
		request.setCharacterEncoding("UTF-8");
		Reviewer reviewer = new Reviewer();
		
		int  reviewer_id = addReviewerManager.getMaxReviewer();
		reviewer.setReviewer_id(reviewer_id);
		reviewer.setPrefix(request.getParameter("prefix"));
		reviewer.setFirstname(request.getParameter("firstname"));
		reviewer.setLastname(request.getParameter("lastname"));
		reviewer.setFaculty(request.getParameter("faculty"));
		reviewer.setMajor(request.getParameter("major"));
		reviewer.setPosition(request.getParameter("position"));
		reviewer.setLine(request.getParameter("line"));
		reviewer.setFacebook(request.getParameter("facebook"));
		reviewer.setEmail(request.getParameter("email"));
		reviewer.setPassword(request.getParameter("password"));
		
		boolean statusresult = addReviewerManager.isAddReviewer(reviewer);

		if (statusresult) {
			List<Reviewer> listreviewer = addReviewerManager.getListReviewer();
			request.setAttribute("listreviewer", listreviewer);
			ModelAndView mav = new ModelAndView("CreateTeam");
			mav.addObject("msg", "ลงทะเบียนคณะกรรมการสำเร็จ");
			return mav;

		} else {
			ModelAndView mav = new ModelAndView("AddReviewer");
			mav.addObject("msg", "ลงทะเบียนคณะกรรมการไม่สำเร็จ!!!!");
			return mav;
		}
	}
	
	
	@RequestMapping(value = "/ImportReviewer", method = RequestMethod.POST)
	public ModelAndView isImportReviewer(HttpSession session, HttpServletRequest request, HttpServletResponse response)throws Exception {
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			AddReviewerManager addReviewerManager = new AddReviewerManager();
			if (ServletFileUpload.isMultipartContent(request)) {
				request.setCharacterEncoding("UTF-8");		
				try {
//					ImportExcelManager importExcelManager = new ImportExcelManager();
					
					List<FileItem> multiFileItem = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);

					val fileName = multiFileItem.get(0).getName();

					System.out.println("fileName : " + fileName);
					
					String path = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/resources/excels";
					
					val file = path + File.separator + System.currentTimeMillis() +"_"+ fileName;
					
					multiFileItem.get(0).write(new File(file));

					ReadWriteExcel readWriteExcel = new ReadWriteExcel();
					
					System.out.println(file);
					
					try {
						readWriteExcel.xlRead(file, 0);
						// System.out.println(readWriteExcel.getxRows()); 
						String[][] data = readWriteExcel.getData();
						// System.out.println(data[0][0]); 
						for (int i = 1; i < data.length; i++) {

							val reviewer_id = Integer.parseInt(data[i][0]);
							val prefix = data[i][1];
							val firstname = data[i][2];
							val lastname = data[i][3];
							val faculty = data[i][4];
							val major = data[i][5];
							val position = data[i][6];
							val line = data[i][7];
							val facebook = data[i][8];
							val email = data[i][9];
							val password = data[i][10];

							Reviewer reviewer = new Reviewer();
							reviewer.setReviewer_id(reviewer_id);
							reviewer.setPrefix(prefix);
							reviewer.setFirstname(firstname);
							reviewer.setLastname(lastname);
							reviewer.setFaculty(faculty);
							reviewer.setMajor(major);
							reviewer.setPosition(position);
							reviewer.setLine(line);
							reviewer.setFacebook(facebook);
							reviewer.setEmail(email);
							reviewer.setPassword(password);
							
							addReviewerManager.isAddReviewer(reviewer);

						}

					} catch (Exception e) {
						e.printStackTrace();
					}

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			List<Reviewer> listreviewer = addReviewerManager.getListReviewer();
			request.setAttribute("listreviewer", listreviewer);
			ModelAndView mav = new ModelAndView("CreateTeam");
			mav.addObject("msg", "ลงทะเบียนคณะกรรมการสำเร็จ");
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("admin");
			return mav;
		}

	}
	
	
}
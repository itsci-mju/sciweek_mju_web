package controller;

import java.io.*;
import java.util.*;
import lombok.*;
import manager.ImportExcelManager;
import manager.ListStudentProjectManager;
import manager.ListTeamManager;
import manager.ViewTeamDetailManager;
import bean.*;
import util.*;
//import manager.*;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@MultipartConfig
public class ImportExcelController {

//	@RequestMapping(value = "/doAddStudentProject", method = RequestMethod.GET)
//	public ModelAndView doAddStudentProjectPage(HttpSession session, HttpServletRequest request) throws Exception {
//		Admin admin = (Admin) session.getAttribute("admin");
//		if (admin != null) {
//			ImportExcelManager importExcelManager = new ImportExcelManager();
//			List<ProjectType> projectTypeList = importExcelManager.getListProjectType();
//			ModelAndView mav = new ModelAndView("AddStudentProject");
//			mav.addObject("projectTypeList", projectTypeList);
//			return mav;
//		} else {
//			ModelAndView mav = new ModelAndView("LoginPage");
//			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
//			session.removeAttribute("admin");
//			return mav;
//		}
//	}

	@RequestMapping(value = "/ImportExcel", method = RequestMethod.POST)
	public ModelAndView doImportExcel(HttpSession session, HttpServletRequest request, HttpServletResponse response)throws Exception {
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			if (ServletFileUpload.isMultipartContent(request)) {
				request.setCharacterEncoding("UTF-8");
				
				try {
					ImportExcelManager importExcelManager = new ImportExcelManager();
					
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

							val student_id = Integer.parseInt(data[i][0]);
							val prefix = data[i][1];
							val firstname = data[i][2];
							val lastname = data[i][3];
							val grade = data[i][4];
							val mobileno = data[i][5];
							val email = data[i][6];
							val password = data[i][7];
							val school_id = Integer.parseInt(data[i][8]);
							val school_name = data[i][9];
							val school_address= data[i][10];
							val advisor_id= Integer.parseInt(data[i][11]);
							val advprefix= data[i][12];
							val advfirstname= data[i][13];
							val advlastname= data[i][14];
							val advemail= data[i][15];
							val advmobileno= data[i][16];
							val project_id= data[i][17];
							val projectname= data[i][18];
							val video = data[i][19];
							val award = data[i][20];
							val avgscore = Double.parseDouble(data[i][21]);
							val projecttype_id = Integer.parseInt(data[i][22]);
							val projecttype_name = data[i][23];
							
							Student student = new Student();
							School school = new School();
							Advisor advisor = new Advisor();
							Project project = new Project();
							ProjectType projecttype = new ProjectType();
							
							school.setSchool_id(school_id);
							school.setSchool_name(school_name);
							school.setSchool_address(school_address);
									
							advisor.setAdvisor_id(advisor_id);
							advisor.setPrefix(advprefix);
							advisor.setFirstname(advfirstname);
							advisor.setLastname(advlastname);
							advisor.setEmail(advemail);
							advisor.setMobileno(advmobileno);
							
							projecttype.setProjecttype_id(projecttype_id);
							projecttype.setProjecttype_name(projecttype_name);
													
							project.setProject_id(project_id);
							project.setProjectname(projectname);
							project.setVideo(video);
							project.setAward(award);
							project.setAvgscore(avgscore);
							project.setStatus_project(0);
							project.setState_project(1);
							project.setProjecttype(projecttype);
							project.setAdvisor(advisor);
							
							student.setStudent_id(student_id);
							student.setPrefix(prefix);
							student.setFirstname(firstname);
							student.setLastname(lastname);
							student.setGrade(grade);
							student.setMobileno(mobileno);
							student.setEmail(email);
							student.setPassword(password);
							student.setSchool(school);		
							student.setProject(project);
														
							School schoolTemp = importExcelManager.getSchoolByID(school_id);
							Student studentTemp = importExcelManager.getStudentByID(student_id);
							ProjectType projectTypeTemp = importExcelManager.getProjectTypeByID(projecttype_id);
							Project projectTemp = importExcelManager.getProjectByID(project_id);
							Advisor advisorTemp = importExcelManager.getAdvisorByID(advisor_id);
							
							if (schoolTemp.getSchool_id() != school_id) {
								importExcelManager.isImportSchool(school);
							};
							
							if (advisorTemp.getAdvisor_id() != advisor_id) {
								importExcelManager.isImportAdvisor(advisor);
							};
							
							if (projectTypeTemp.getProjecttype_id() != projecttype_id) {
								importExcelManager.isImportProjectType(projecttype);
							};
							
							if (projectTemp.getProject_id() != project_id) {
								importExcelManager.isImportProject(project);
							};
							
							if (studentTemp.getStudent_id() != student_id) {
								importExcelManager.isImportStudent(student);
							};
																
						}

					} catch (Exception e) {
						e.printStackTrace();
					}

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			ListStudentProjectManager vpjm = new ListStudentProjectManager();
			List<Project> listproject = vpjm.getListStudentProject();
			ModelAndView mav = new ModelAndView("ListStudentProject");
			mav.addObject("listproject", listproject);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("admin");
			return mav;
		}

	}
	
	@RequestMapping(value = "/ImportReviewer", method = RequestMethod.POST)
	public ModelAndView isImportReviewer(HttpSession session, HttpServletRequest request, HttpServletResponse response)throws Exception {
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			ImportExcelManager importExcelManager = new ImportExcelManager();
			ListTeamManager listTeamManager = new ListTeamManager();
			ViewTeamDetailManager viewTeamDetailManager = new ViewTeamDetailManager();
			
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
							val projecttype_id = Integer.parseInt(data[i][11]);
							
							ProjectType projecttype = new ProjectType();
							projecttype.setProjecttype_id(projecttype_id);

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
							reviewer.setProjecttype(projecttype);
							
							importExcelManager.isAddReviewer(reviewer);

						}

					} catch (Exception e) {
						e.printStackTrace();
					}

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			List<ProjectType> projectTypeList = listTeamManager.getListProjectType();
			List<Reviewer> reviewerList = viewTeamDetailManager.getListReviewer();		
			ModelAndView mav = new ModelAndView("ListTeam");
			mav.addObject("projectTypeList", projectTypeList);
			mav.addObject("reviewerList", reviewerList);
			mav.addObject("msg", "นำเข้าข้อมูลคณะกรรมการสำเร็จ");
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("LoginPage");
			mav.addObject("msg", "กรุณาเข้าสู่ระบบใหม่อีกครั้ง!!!!");
			session.removeAttribute("admin");
			return mav;
		}

	}

}

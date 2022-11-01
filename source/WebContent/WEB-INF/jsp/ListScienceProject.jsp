<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*,model.*, java.sql.Timestamp"%>
<%
	Reviewer reviewer = null;
	Schedules schedules = null; 
	List<ProjectResponse> projectResponseList  = null;
	List<ReviewerResponse> reviewerResponseList = null;
	List<Project> projectList = null;

	try {
		reviewer = (Reviewer) session.getAttribute("reviewer");
	} catch (Exception e) {

	}
	
	try {
		schedules = (Schedules) request.getAttribute("schedules");
	} catch (Exception e) {

	}
	
	try {
		projectList = (List<Project>) request.getAttribute("projectList");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
 	try {
		reviewerResponseList = (List<ReviewerResponse>) request.getAttribute("reviewerResponseList");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try {
		projectResponseList = (List<ProjectResponse>) request.getAttribute("projectResponseList");
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SciWeek | มหาวิทยาลัยแม่โจ้</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="./image/logo.png" rel="icon">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/e18a64822c.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Kanit' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="./css/web_css.css">
</head>
<body  style="background-image: url('./image/hero-bg.png') ; background-repeat: no-repeat ; background-attachment: fixed ; background-size: 100% 100%">

	<jsp:include page="common/navbar.jsp"></jsp:include>
	
	<%
	
	String errors ;
	String fmt_expreviewdate ;
	String fmt_expreviewtime ;
	
	Date presentdate = new Date();
	Timestamp presenttimestamp = new Timestamp(presentdate.getTime());
	
	if (presenttimestamp.after(schedules.getExpreviewdate())) {
		
		fmt_expreviewdate = new SimpleDateFormat("dd MMMM yyyy", new Locale("th", "TH")).format(schedules.getExpreviewdate());
		fmt_expreviewtime = new SimpleDateFormat("HH:mm").format(schedules.getExpreviewdate()); 
		
		errors = "สิ้นสุดเวลาการประเมิน" ;
		
	} else {
		
		fmt_expreviewdate = new SimpleDateFormat("dd MMMM yyyy", new Locale("th", "TH")).format(schedules.getExpreviewdate());
		fmt_expreviewtime = new SimpleDateFormat("HH:mm").format(schedules.getExpreviewdate()); 
		
		errors = "กรุณาประเมินโครงงานก่อนวันสิ้นสุดการประเมิน" ;
	}
	
	
	
	%>
	<div class="container" style="margin-top: 35px;">
		<section id="content">
			<div class="container" style="margin-top: -20px">
				<div class="row">
					<div class="col-lg-12">
						<br>
						<h3><i class="fa-solid fa-file-pen">&nbsp;</i>ประเมินโครงงานวิทยาศาสตร์</h3>
						<hr class="colorgraph">
						<h5>ข้อมูลคณะกรรมการ</h5>
						<br>			
						<div class="form-group row">
							<label class="col-sm-2 col-form-label text-right">ชื่อ - นามสกุล</label>
							<div class="col-sm-3">
								<input type="text" id="prefix" name="prefix" class="form-control data" value="<%=reviewer.getPrefix()%> <%=reviewer.getFirstname()%>  <%=reviewer.getLastname()%>" style="background-color: #ffffee" readonly>
							</div>
							<div class="col-sm-1">
								<input type="hidden" id="prefix" name="prefix" class="form-control data" value="<%=reviewer.getPrefix()%>">
							</div>
							<div class="col-sm-3">
								<input type="hidden" id="firstname" name="firstname" class="form-control data" value="<%=reviewer.getFirstname()%>">
							</div>
							<div class="col-sm-3">
								<input type="hidden" id="lastname" name="lastname" class="form-control data" value="<%=reviewer.getLastname()%>">
							</div>
						</div>


						<div class="form-group row">
							<label class="col-sm-2 col-form-label text-right">อีเมล</label>
							<div class="col-sm-3">
								<input type="text" id="student_id" name="student_id" class="form-control data" value="<%=reviewer.getEmail()%>" style="background-color: #ffffee" readonly>
							</div>
						</div>

						<div class="form-group row">
							<label class="col-sm-2 col-form-label text-right">คณะ </label>
							<div class="col-sm-3">
								<input type="text" id="faculty" name="faculty" class="form-control data" value="<%=reviewer.getFaculty()%>" style="background-color: #ffffee" readonly>
							</div>
							<label class="col-sm-2 col-form-label text-right">สาขา </label>
							<div class="col-sm-3">
								<input type="text" id="major" name="major" class="form-control data" value="<%=reviewer.getMajor()%>" style="background-color: #ffffee" readonly>
							</div>
						</div>
						<%
							String projecttype_name = null;
					
							if (reviewer.getProjecttype().getProjecttype_name() == null) {
								projecttype_name = "ไม่มีกลุ่ม";
							} else {
								projecttype_name = reviewer.getProjecttype().getProjecttype_name();
							}
						%>
						<div class="form-group row">
							<label class="col-sm-2 col-form-label text-right">กลุ่ม</label>
							<div class="col-sm-4">
								<input type="hidden" id="projecttype_id" name="projecttype_id" class="form-control data" value="<%=reviewer.getProjecttype().getProjecttype_name()%>">
								<input type="text" id="projecttype_name" name="projecttype_name" class="form-control data" value="<%=projecttype_name%>" style="background-color: #ffffee" readonly>
							</div>
						</div>

						<div class="form-group row">
							<label class="col-sm-2 col-form-label text-right">ตำแหน่ง</label>
							<div class="col-sm-3">
								<input type="text" id="position" name="position" class="form-control data" value="<%=reviewer.getPosition()%>" style="background-color: #ffffee" readonly>
							</div>
						</div>

						<div class="alert alert-danger" role="alert" style="text-align:center; font-weight:bold;">
							<strong class="font__weight-semibold">แจ้งเตือน !!!</strong>&nbsp;สิ้นสุดการประเมิน
							วันที่ : <%=fmt_expreviewdate%> เวลา <%=fmt_expreviewtime%> น. &nbsp; <i class="fa-solid fa-hand-point-right">&nbsp;</i><%=errors%>
						</div>

					
						<h5>รายการโครงงานวิทยาศาสตร์</h5>
						<hr class="colorgraph">
						<table class="table table-bordered  table-hover" id=myTable>
							<thead class="table-info" align="center" style="white-space: nowrap">
								<tr>
									<th>รหัสโครงงาน</th>
									<th>ชื่อโครงงาน/สิ่งประดิษฐ์</th>
									<th width="150">สถานะ</th>
									<th colspan="3"></th>
								</tr>
							</thead>
							<%
								if ( projectList.size() != 0 ) {
							%>

							<%
								for (int i = 0 ; i < projectList.size() ; i++) {					
							%>	
									
							<%
								if (reviewer != null && projectList.get(i).getReport().getReport_id() != 0 && projectList.get(i).getState_project() == 1) {
							%>
							<tbody>
								<tr>
									<td align="center"><%=projectList.get(i).getProject_id()%></td>
									<td><%=projectList.get(i).getProjectname()%></td>

									<%
												String error = null;
												String bug = null;
												String klass = null;
												String status = null;

												ListScienceProjectManager listScienceProjectManager = new ListScienceProjectManager();

												List<Reviews> reviewList = listScienceProjectManager.getListReviewsByProjectIDAndReviewerID(projectList.get(i).getProject_id(), reviewer.getReviewer_id());
												
												Date date = new Date();  
								                Timestamp timestamp = new Timestamp(date.getTime());  
								                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 

												if (reviewList.size() != 0) {						

													for (Reviews reviews : reviewList) {
														
														if (reviews.getState().equals("ประเมินสำเร็จ")) {
															error = "disabled";
															klass = "btn btn-success";
															status = reviews.getState();
														} else if (reviews.getState().equals("กำลังประเมิน")) {
															bug = "disabled";
															klass = "btn btn-warning";
															status = reviews.getState();
														} else {
															bug = "disabled";
															klass = "btn btn-danger";
															status = "ยังไม่ได้ประเมิน";
														}
														
														if (timestamp.after(schedules.getExpreviewdate())) {
															bug = "disabled";
															error = "disabled";
															klass = "btn btn-danger";
															status = "หมดเวลา";
														} 
									%>
	
									<td align="center"><button name="button" class="<%=klass%>" disabled><%=status%></button></td>
											
											<% } %>
									
									<%
												} else if (timestamp.after(schedules.getExpreviewdate())) {
													bug = "disabled";
													error = "disabled";
													klass = "btn btn-danger";
													status = "หมดเวลา";
									%>
									
									<td align="center"><button name="button" class="<%=klass%>" disabled><%=status%></button></td>
									
									<% } else {
													bug = "disabled";
													klass = "btn btn-danger";
													status = "ยังไม่ได้ประเมิน";
									%>
									
									<td align="center"><button name="button" class="<%=klass%>" disabled><%=status%></button></td>
									
									<% } %>

									<td align="center" width="35">
										<button name="button" class="btn btn-link"
											onclick="window.location.href='ReviewProject?project_id=<%=projectList.get(i).getProject_id()%>';"
											<%=error%>>(ประเมิน)</button>
									</td>

									<td align="center" width="40">
										<button name="button" class="btn btn-link"
											onclick="window.location.href='ReviseProject?project_id=<%=projectList.get(i).getProject_id()%>&state_project=<%=projectList.get(i).getState_project()%>';"
											<%=bug%>>(แก้ไข)</button>
									</td>

									<td align="center" width="30">
										<button name="button" class="btn btn-warning"
											onclick="window.location.href='ViewScienceProjectDetail?project_id=<%=projectList.get(i).getProject_id()%>';"
											<%=bug%>>
											<i class="fa fa-eye"></i>
										</button>
									</td>

								</tr>

									<%
										}
									%>
									
							<%
								if (reviewer != null && projectList.get(i).getState_project() == 2) {
							%>
							<tbody>
								<tr>
									<td align="center"><%=projectList.get(i).getProject_id()%></td>
									<td><%=projectList.get(i).getProjectname()%></td>

									<%
												String error = null;
												String bug = null;
												String klass = null;
												String status = null;
												String reviews_id = null ;

												ListScienceProjectManager listScienceProjectManager = new ListScienceProjectManager();

												List<Reviews> reviewList = listScienceProjectManager
													.getListReviewsByProjectIDAndReviewerID(projectList.get(i).getProject_id(), reviewer.getReviewer_id());
												
												Date date = new Date();  
								                Timestamp timestamp = new Timestamp(date.getTime());  
								                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

												if (reviewList.size() != 0) {		
													
													for (Reviews reviews : reviewList) {
														
														reviews_id = reviews.getReviews_id();													
																											
														 if (reviews.getState().equals("ประเมินสำเร็จ")) {
															error = "disabled";
															klass = "btn btn-success";
															status = reviews.getState();
														} else if (reviews.getState().equals("กำลังประเมิน")) {
															bug = "disabled";
															klass = "btn btn-warning";
															status = reviews.getState();
														} else {
															bug = "disabled";
															klass = "btn btn-danger";
															status = "ยังไม่ได้ประเมิน";
														}
														 
														 if (timestamp.after(schedules.getExpreviewdate())) {
																error = "disabled";
																bug = "disabled";
																klass = "btn btn-danger";
																status = "หมดเวลา";
														}
									%>
									<td align="center"><button name="button" class="<%=klass%>" disabled><%=status%></button></td>
									<% } %>
									
									<%
												} else if (timestamp.after(schedules.getExpreviewdate())) {
													bug = "disabled";
													error = "disabled";
													klass = "btn btn-danger";
													status = "หมดเวลา";
									%>
									
									<td align="center"><button name="button" class="<%=klass%>" disabled><%=status%></button></td>
									
									<% } else {
													bug = "disabled";
													klass = "btn btn-danger";
													status = "ยังไม่ได้ประเมิน";
									%>
									
									<td align="center"><button name="button" class="<%=klass%>" disabled><%=status%></button></td>
									
									<% } %>

									<td align="center" width="35">
										<button name="button" class="btn btn-link"
											onclick="window.location.href='ReviewProject?project_id=<%=projectList.get(i).getProject_id()%>&reviews_id=<%=reviews_id%> ';"
											<%=error%>>(ประเมิน)</button>
									</td>

									<td align="center" width="40">
										<button name="button" class="btn btn-link"
											onclick="window.location.href='ReviseProject?project_id=<%=projectList.get(i).getProject_id()%>&state_project=<%=projectList.get(i).getState_project()%>';"
											<%=bug%>>(แก้ไข)</button>
									</td>

									<td align="center" width="30">
										<button name="button" class="btn btn-warning"
											onclick="window.location.href='ViewScienceProjectDetail?project_id=<%=projectList.get(i).getProject_id()%>';"
											<%=bug%>>
											<i class="fa fa-eye"></i>
										</button>
									</td>

								</tr>

									<%
										}
									%>
									
									
									<%
								if (reviewer != null && projectList.get(i).getState_project() == 3) {
							%>
							<tbody>
								<tr>
									<td align="center"><%=projectList.get(i).getProject_id()%></td>
									<td><%=projectList.get(i).getProjectname()%></td>

									<%
												String error = null;
												String bug = null;
												String klass = null;
												String status = null;
												String reviews_id = null ;

												ListScienceProjectManager listScienceProjectManager = new ListScienceProjectManager();

												List<Reviews> reviewList = listScienceProjectManager
													.getListReviewsByProjectIDAndReviewerID(projectList.get(i).getProject_id(), reviewer.getReviewer_id());
												
												Date date = new Date();  
								                Timestamp timestamp = new Timestamp(date.getTime());  
								                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

												if (reviewList.size() != 0) {		
													
													for (Reviews reviews : reviewList) {
														
														reviews_id = reviews.getReviews_id();														
																																																								
														if (reviews.getState().equals("ประเมินสำเร็จ")) {
															error = "disabled";
															bug = "disabled";
															klass = "btn btn-success";
															status = reviews.getState();
														} else {
															error = "disabled";
															//bug = "disabled";
															klass = "btn btn-danger";
															status = "ยังไม่ได้ประเมิน" ;
														}
														
														
									%>
									<td align="center"><button name="button" class="<%=klass%>" disabled><%=status%></button></td>
												 <%  } %>
									
									<%
												} else {
													bug = "disabled";
													klass = "btn btn-danger";
													status = "ยังไม่ได้ประเมิน";
									%>
									<td align="center"><button name="button"
											class="<%=klass%>" disabled><%=status%></button></td>
									<%
										}
									%>

									<td align="center" width="35">
										<button name="button" class="btn btn-link"
											onclick="window.location.href='ReviewProject?project_id=<%=projectList.get(i).getProject_id()%>&reviews_id=<%=reviews_id%> ';"
											<%=error%>>(ประเมิน)</button>
									</td>

									<td align="center" width="40">
										<button name="button" class="btn btn-link"
											onclick="window.location.href='ReviseProject?project_id=<%=projectList.get(i).getProject_id()%>&state_project=<%=projectList.get(i).getState_project()%>';"
											<%=bug%>>(แก้ไข)</button>
									</td>

									<td align="center" width="30">
										<button name="button" class="btn btn-warning" onclick="window.location.href='ViewScienceProjectDetail?project_id=<%=projectList.get(i).getProject_id()%>';">
											<i class="fa fa-eye"></i>
										</button>
									</td>

								</tr>

									<%
										}
									%> 
									
									<%
										}
									%>
															
								<%						
									} else { 
								%>
								<tr align="center">
									<td colspan="5"><h2>ไม่มีข้อมูล</h2></td>
								</tr>
								<%
									}
								%>

							</tbody>
						</table>
					</div>
				</div>
			</div>
		</section>
	</div>

	<jsp:include page="common/footer.jsp"></jsp:include>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*"%>
<%
	Reviewer reviewer = null;
	List<Reviews> listreviews = null; 
	
	try {
		reviewer = (Reviewer) session.getAttribute("reviewer");
	} catch (Exception e) {

	}
	
	try {
		listreviews = (List<Reviews>) request.getAttribute("listreviews");
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
<body style="background-image: url('./image/hero-bg.png')">

	<jsp:include page="common/navbar.jsp"></jsp:include>

	<div class="container" style="margin-top: 35px;">
			<section id="content">
				<div class="container" style="margin-top: -20px">
					<div class="row">
						<div class="col-lg-12">
							<br>
							<h3><i class="fa-solid fa-square-poll-vertical">&nbsp;</i>ข้อมูลโครงงานวิทยาศาสตร์</h3>
							<hr class="colorgraph">				
							<h5>ข้อมูลคณะกรรมการ</h5>	
							<br>
								<div class="form-group row">
									<input type="hidden" id="reviewer_id" name="reviewer_id" class="form-control data" value="<%=reviewer.getReviewer_id()%>" >
									<label class="col-sm-2 col-form-label text-right">ชื่อ - นามสกุล</label>
									<div class="col-sm-3">
										<input type="text" id="prefix" name="prefix" class="form-control data" value="<%=reviewer.getPrefix()%> <%=reviewer.getFirstname()%>  <%=reviewer.getLastname()%>" readonly>
									</div>
									<div class="col-sm-1">
										<input type="hidden" id="prefix" name="prefix" class="form-control data" value="<%=reviewer.getPrefix()%>" >
									</div>
									<div class="col-sm-3">					
										<input type="hidden" id="firstname" name="firstname" class="form-control data" value="<%=reviewer.getFirstname()%>" >
									</div>
									<div class="col-sm-3">								
										<input type="hidden" id="lastname" name="lastname" class="form-control data" value="<%=reviewer.getLastname()%>" >
									</div>									
								</div>
								
												
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">อีเมล</label>
									<div class="col-sm-3">
										<input type="text" id="student_id" name="student_id" class="form-control data" value="<%=reviewer.getEmail()%>" readonly>
									</div>
								</div>
																		
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">คณะ
									</label>
									<div class="col-sm-3">
										<input type="text" id="faculty" name="faculty" class="form-control data" value="<%=reviewer.getFaculty()%>" readonly>
									</div>
									<label class="col-sm-2 col-form-label text-right">สาขา
									</label>
									<div class="col-sm-3">
										<input type="text" id="major" name="major" class="form-control data" value="<%=reviewer.getMajor()%>" readonly>
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
							<div class="col-sm-3">
								<input type="hidden" id="projecttype_id" name="projecttype_id" class="form-control data" value="<%=reviewer.getProjecttype().getProjecttype_id()%>">
								<input type="text" id="projecttype_name" name="projecttype_name" class="form-control data" value="<%=projecttype_name%>" readonly>
							</div>
						</div>

						<div class="form-group row">																
									<label class="col-sm-2 col-form-label text-right">ตำแหน่ง</label>
									<div class="col-sm-3">								
										<input type="text" id="position" name="position" class="form-control data" value="<%=reviewer.getPosition()%>" readonly>
									</div>					
								</div>
																																						
							</div>
						</div>
					</div>
			</section>
	
	<br>
	<h5>สรุปคำวิจารณ์ที่ได้รับและความคิดเห็น</h5>
	<hr class="colorgraph">
	</div>
	<div style="margin-left: 8%; margin-right: 8%;">
		<table class="table table-bordered  table-hover" id=myTable>
			<thead class="table-info" align="center">
				<tr>
					<th width="70">ลำดับ</th>
					<th width="190">วันเวลาประเมิน</th>
					<th>ชื่อโครงงาน/สิ่งประดิษฐ์</th>
					<th width="230">โรงเรียน</th>
					<th width="95">รวมคะแนน</th>
					<th width="70">อันดับ</th>
				</tr>
			</thead>
			<%
				if (listreviews.size() != 0) {
			%>

			<%
				for (int i = 0 ; i < listreviews.size() ; i++ ) {
					int num = i + 1 ;
					
					String project_id = listreviews.get(i).getProject().getProject_id() ;
					
					SummaryReviewsManager summaryReviewsManager = new SummaryReviewsManager();
					
					List<StudentProject> studentProjectList = summaryReviewsManager.getListStudentProjectByProjectID(project_id);
			%>
			<tbody align="center">
				<tr>
					<td><%=listreviews.get(i).getProject().getProject_id()%></td>
					<td><%=listreviews.get(i).getReviewdate()%></td>
					<td align="left"><%=listreviews.get(i).getProject().getProjectname()%></td>
					<% for (StudentProject studentProject : studentProjectList) { %>
					<td align="center"><%=studentProject.getStudent().getSchool().getSchool_name()%></td>
					<% } %>
					<td><%=listreviews.get(i).getTotalscore()%></td>
					<% if (num == 1) { %>
					<td style="background-color: #C6EFCE"><%=num%></td>
					<%} else if (num == 2) { %>
					<td style="background-color: #B7DEE8"><%=num%></td>
					<%} else if (num == 3) { %>
					<td style="background-color: #B8CCE4"><%=num%></td>
					<%} else if (num == 4) { %>
					<td style="background-color: #CCC0DA"><%=num%></td>
					<%} else if (num == 5) { %>
					<td style="background-color: #FFFFCC"><%=num%></td>
					<%} else if (num == 6) { %>
					<td style="background-color: #FDE9D9"><%=num%></td>
					<%}  else if (num == 7) { %>
					<td style="background-color: #FCD5B4"><%=num%></td>
					<%} else { %>
					<td style="background-color: #FFC7CE"><%=num%></td>
					<% } %>
				</tr>
				<%
					}
				%>
				<%
					} else {
				%>
				<tr align="center">
					<td colspan="6"><h2>ไม่มีข้อมูล</h2></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</div>


	<jsp:include page="common/footer.jsp"></jsp:include>

</body>
</html>
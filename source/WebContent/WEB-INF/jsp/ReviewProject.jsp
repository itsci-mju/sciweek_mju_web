<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*"%>
<%
	Report report = null;
	Reviewer reviewer = null ;
	StudentProject sproject = null;
	List<StudentProject> listsproject = new Vector<>();
	List<Question> listquestion = new Vector<>();
	
	try {
		reviewer = (Reviewer) session.getAttribute("reviewer");
	} catch (Exception e) {

	}
	
	try {
		report = (Report) session.getAttribute("report");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try {
		listquestion = (List<Question>) request.getAttribute("listquestion");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try {
		listsproject = (List<StudentProject>) request.getAttribute("listsproject");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try {
		sproject = (StudentProject) request.getAttribute("sproject");
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
		<form name="frm" action=isReviewProject method="post">
		
		<section id="content">
			<div class="container" style="margin-top: 35px">
				<div class="row">
					<div class="col-lg-12">
						<div class="container">
							<h3>ข้อมูลโครงงานวิทยาศาสตร์</h3>
							<hr class="colorgraph">
							<h5>ข้อมูล</h5>
							<br>
								
								<input type="hidden" id="reviewer_id" name="reviewer_id" class="form-control data" value="<%=reviewer.getReviewer_id()%>" >
								<input type="hidden" id="team_id" name="team_id" class="form-control data" value="<%=reviewer.getTeam().getTeam_id()%>" >
				
								<div class="form-group row">
									<label class="col-sm-3 col-form-label text-left">รหัสโครงงานวิทยาศาสตร์</label>
									<div class="col-sm-3" style="margin-left: -105px">
										<input type="text" id="project_id" name="project_id" class="form-control data" value="<%=sproject.getProject().getProject_id()%>" readonly>
									</div>
								</div>
										
								<div class="form-group row">
									<label class="col-sm-3 col-form-label text-left">ชื่อโครงงานวิทยาศาสตร์</label>
									<div class="col-sm-7" style="margin-left: -105px">
										<input type="text" id="projectname" name="projectname" class="form-control data" value="<%=sproject.getProject().getProjectname()%>" readonly>
									</div>
								</div>
								
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">ชื่อผู้จัดทำ</label>
									<%
									for (int i = 0 ; i < listsproject.size() ; i++) {					
									%>		
									<div class="col-sm-3 text-left">
										<input type="hidden" id="student_id" name="student_id" class="form-control data" value="<%=listsproject.get(i).getStudent().getStudent_id()%>">
										<input type="text" id="studentname" name="studentname" class="form-control data" value="<%=listsproject.get(i).getStudent().getPrefix() +" "+listsproject.get(i).getStudent().getFirstname() +" "+ listsproject.get(i).getStudent().getLastname()%>" readonly>																																
									</div>
									<%
									}
									%>																	
								</div>
								
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">โรงเรียน</label>
									<div class="col-sm-3">
										<input type="text" id="schoolname" name="schoolname" class="form-control data" value="<%=sproject.getStudent().getSchool().getSchool_name()%>" readonly>
									</div>
								</div>
								
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">ที่ปรึกษา</label>
									<div class="col-sm-3">
										<input type="text" id="advisorname" name="advisorname" class="form-control data" value="<%=sproject.getAdvisor().getPrefix() +" "+ sproject.getAdvisor().getFirstname() +" "+ sproject.getAdvisor().getLastname()%>" readonly>
									</div>
									<label class="col-sm-2 col-form-label text-right">เบอร์โทรศัพท์</label>
									<div class="col-sm-3">
										<input type="text" id="advisorno" name="advisorno" class="form-control data" value="<%=sproject.getAdvisor().getMobileno()%>" readonly>
									</div>
								</div>
								
								<% 
									String video = null ;

									if (sproject.getProject().getVideo() == null ) {
										video = "#";
									} else {
										video = sproject.getProject().getVideo();
									}
									
									String file = null ;

									if (report.getReportname() == null) {
										file = "#";
									} else {
										file = "./report/"+report.getReportname()+".pdf";
									}
								%>

							<div class="form-group row">
								<label class="col-sm-2 col-form-label text-right">วีดิโอ</label>
								<div class="col-sm-2">
									<a href="<%=video%>" target="_blank" class="btn btn-link" role="button" style="margin-left: -13px;"><i
										class="fa fa-file-video-o" aria-hidden="true">&nbsp;&nbsp;</i>ไฟล์วิดีโอ</a>							
								</div>
								<label class="col-sm-2 col-form-label text-right">เอกสารรายงาน</label>
								<div class="col-sm-3">
									<a href="<%=file%>" target="_blank" class="btn btn-link" role="button" style="margin-left: -13px;"><i class="fa-solid fa-file-pdf">&nbsp;&nbsp;</i>ไฟล์เอกสารรายงาน</a>
								</div>
							</div>						

							<br>
							<h4>ประเมินโครงงานวิทยาศาสตร์</h4>
							<hr class="colorgraph">						
							<br>
							<table class="table table-bordered  table-hover" id=myTable style="width: 75%; align:center" >
								<thead class="table-info" align="center">
									<tr>
										<th width="100px">ลำดับ</th>
										<th>รายการประเมิน</th>
										<th colspan="2">คะแนน</th>								
									</tr>
								</thead>
								
								<%
								
									for (int i = 0 ; i < listquestion.size() ; i++) {
					
								%>
								
								<input type="hidden"  id="question_id"  name="question_id" class="form-control data" value="<%=listquestion.get(i).getQuestion_id()%>">
								
								<tbody>
									<tr>
										<td align="center"><%=listquestion.get(i).getQuestion_id()%></td>
										<td><%=listquestion.get(i).getQuestion()%></td>
										<td width="50px"><input type="text" name="answer" id="answer" class="form-control data" style="width: 100px" maxlength="4" ></td>	
										<td align="center" width="130px">&nbsp;&nbsp;/&nbsp; <%=listquestion.get(i).getFullscore()%></td>						
									</tr>
								</tbody>
								
								<% } %>
								
							</table>
			
							<div class="form-group row">
								<label class="col-sm-3 col-form-label text-left">ความคิดเห็นเพิ่มเติม (*)</label>																			
							</div>	
							<div class="form-group row">						
								<textarea id="comments" name="comments" rows="4" cols="50"  class="form-control data" style="margin-left: 15px; width: 600px"></textarea>
							</div>				
							<br>
							<div class="form-group row">
									<div class="col-sm-12 text-left">
										<button type="submit" class="btn btn-success">ส่งผลประเมิน</button>									
										<a class="btn btn-danger" href="doListScienceProject" role="button">ยกเลิก</a>	
									</div>
								</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		</form>
	</div>

	<jsp:include page="common/footer.jsp"></jsp:include>

</body>
</html>
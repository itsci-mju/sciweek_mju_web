<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*"%>
<%
	Student student = null;
	StudentProject studentProject = null;
	Report report = null;
	List<StudentProject> listsproject = new Vector<>();
	
	try {
		report = (Report) session.getAttribute("report");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try {
		studentProject = (StudentProject) request.getAttribute("studentProject");
		session.setAttribute("key",studentProject.getProject().getProject_id());
	} catch (Exception e) {
		e.printStackTrace();
	}

	try {
		student = (Student) session.getAttribute("student");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try {
		listsproject = (List<StudentProject>) request.getAttribute("listsproject");
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
<%	
		String video = null ;
		String award = null;
		
		if (studentProject.getProject().getAward().equals("-") && studentProject.getProject().getAward().equals("ยังไม่มีรางวัล") && studentProject.getProject().getAvgscore() == 0) {
			award = "ยังไม่มีรางวัล" ;
		} else { 
			award = studentProject.getProject().getAward() ;
		}

		if (studentProject.getProject().getVideo().equals("-")) {
			video = "กรุณาอัปโหลดวิดีโอ" ;
		} else {
			video = studentProject.getProject().getVideo();
		}
	%>
<body style="background-image: url('./image/hero-bg.png')">
	<jsp:include page="common/navbar.jsp"></jsp:include>

	<div class="container" style="margin-top: 35px;">
		<section id="content">
			<div class="container" style="margin-top: 35px">
				<div class="row">
					<div class="col-lg-12">
						<div class="container">
							<h3><i class="fa-solid fa-clipboard">&nbsp;</i>ข้อมูลโครงงานวิทยาศาสตร์</h3>
							<hr class="colorgraph">
							<h5>ข้อมูล</h5>
							<br>
												
							<div class="form-group row">
								<label class="col-sm-3 col-form-label text-right">รหัสโครงงานวิทยาศาสตร์</label>
								<div class="col-sm-2">
									<input type="text" name="project_id" id="project_id" class="form-control data" value="<%=studentProject.getProject().getProject_id()%>" style="background-color: white" readonly>
								</div>
							</div>

							<div class="form-group row">
								<label class="col-sm-3 col-form-label text-right">ชื่อโครงงานวิทยาศาสตร์</label>
								<div class="col-sm-8">
									<input type="text" name="projectname" id="projectname" class="form-control data" value="<%=studentProject.getProject().getProjectname()%>" style="background-color: white" readonly>
								</div>
							</div>

							<div class="form-group row">
								<label class="col-sm-3 col-form-label text-right">ประเภทโครงงานวิทยาศาสตร์</label>
								<div class="col-sm-4">
									<input type="text" name="projecttype_name" id="projecttype_name" class="form-control data" value="<%=studentProject.getProject().getProjecttype().getProjecttype_name()%>" style="background-color: white" readonly>
								</div>
							</div>

							<div class="form-group row">
								<label class="col-sm-2 col-form-label text-right">วีดิโอ</label>
								<div class="col-sm-6">
									<button name="button" class="btn btn-link"  onclick="window.location.href='<%=studentProject.getProject().getVideo()%>';">
										<i class="fa fa-file-video-o">&nbsp;&nbsp;</i>วิดีโอ
									</button>											
								</div>
							</div>
							
							<div class="form-group row">
								<label class="col-sm-2 col-form-label text-right">เอกสารรายงาน</label>
								<div class="col-sm-6">
									<button name="button" class="btn btn-link"  onclick="window.location.href='./report/<%=report.getReportname()%>.pdf';" >
										<i class="fa-solid fa-file-pdf">&nbsp;&nbsp;</i>เอกสารรายงาน
									</button>
								</div>
							</div>

							<div class="form-group row">						
								<label class="col-sm-2 col-form-label text-right">รางวัล</label>
								<div class="col-sm-3">
									<input type="text" name="award" id="award" class="form-control data" value="<%=award%>" style="background-color: white" readonly>
								</div>
								<label class="col-sm-2 col-form-label text-right">คะแนน</label>
								<div class="col-sm-1">
									<input type="text" name="avgscore" id="avgscore" class="form-control data" value="<%=studentProject.getProject().getAvgscore()%>" style="background-color: white" readonly>
								</div>
							</div>

							<%
									for (int i = 0 ; i < listsproject.size() ; i++) {
							%>
							
							<h5>นักเรียนคนที่&nbsp;<%=i + 1%></h5>
							<hr class="colorgraph">
							<div class="form-group row">
								<label class="col-sm-2 col-form-label text-right">ชื่อ - นามสกุล</label>
								<div class="col-sm-4">
									<input type="text" name="fullname" id="fullname" class="form-control data" value="<%=listsproject.get(i).getStudent().getPrefix() +" "+ listsproject.get(i).getStudent().getFirstname() +" "+ listsproject.get(i).getStudent().getLastname()%>" style="background-color: white"  readonly>
								</div>
								<input type="hidden" name="prefix" id="prefix" class="form-control data" value="<%=listsproject.get(i).getStudent().getPrefix()%>" readonly>
								<input type="hidden" name="firstname" id="firstname" class="form-control data" value="<%=listsproject.get(i).getStudent().getFirstname()%>" readonly>
								<input type="hidden" name="lastname" id="lastname" class="form-control data" value="<%=listsproject.get(i).getStudent().getLastname()%>" readonly>
							</div>

							<div class="form-group row">
							<label class="col-sm-2 col-form-label text-right">อีเมล</label>
								<div class="col-sm-3">
									<input type="text" name="email" id="email" class="form-control data" value="<%=listsproject.get(i).getStudent().getEmail()%>" style="background-color: white" readonly>
								</div>
								<label class="col-sm-2 col-form-label text-right">เบอร์โทรศัพท์</label>
								<div class="col-sm-3">
									<input type="text" name="mobileno" id="mobileno" class="form-control data" value="<%=listsproject.get(i).getStudent().getMobileno()%>" style="background-color: white" readonly>
								</div>
							</div>

							<div class="form-group row">
								<label class="col-sm-2 col-form-label text-right">ระดับชั้น</label>
								<div class="col-sm-3">
									<input type="text" name="grade" id="grade" class="form-control data" value="<%=listsproject.get(i).getStudent().getGrade()%>" style="background-color: white"  readonly>
								</div>
								<label class="col-sm-2 col-form-label text-right">โรงเรียน</label>
								<div class="col-sm-4">
									<input type="text" name="school_name" id="school_name" class="form-control data" value="<%=listsproject.get(i).getStudent().getSchool().getSchool_name()%>" style="background-color: white"  readonly>
								</div>
							</div>
							<br>
							
							<%
								}
							%>
							
							<h5>อาจารย์ที่ปรึกษา</h5>
							<hr class="colorgraph">

							<div class="form-group row">
								<label class="col-sm-2 col-form-label text-right">ชื่อ - นามสกุล</label>
								<div class="col-sm-4">
									<input type="text" name="fullnamead" id="fullnamead" class="form-control data" value="<%=studentProject.getAdvisor().getPrefix() +" "+ studentProject.getAdvisor().getFirstname() +" "+  studentProject.getAdvisor().getLastname()%>"  style="background-color: white" readonly>							
								</div>
								<input type="hidden" name="prefixad" id="prefixad" class="form-control data" value="<%=studentProject.getAdvisor().getPrefix()%>" readonly>
								<input type="hidden" name="firstnamead" id="firstnamead" class="form-control data" value="<%=studentProject.getAdvisor().getFirstname()%>" readonly>
								<input type="hidden" name="lastnamead" id="lastnamead" class="form-control data" value="<%=studentProject.getAdvisor().getLastname()%>" readonly>
							</div>
		
							<div class="form-group row">
								<label class="col-sm-2 col-form-label text-right">อีเมล</label>
								<div class="col-sm-3">
									<input type="text" name="emailad" id="emailad" class="form-control data" value="<%=studentProject.getAdvisor().getEmail()%>" style="background-color: white"  readonly>
								</div>
								<label class="col-sm-2 col-form-label text-right">เบอร์โทรศัพท์</label>
								<div class="col-sm-3">
									<input type="text" name="phonead" id="phonead" class="form-control data" value="<%=studentProject.getAdvisor().getMobileno()%>" style="background-color: white"  readonly>
								</div>
							</div>
							<br>
							<br>
						</div>				
					</div>
				</div>
			</div>
		</section>
	</div>

	<jsp:include page="common/footer.jsp"></jsp:include>
		
</body>
</html>
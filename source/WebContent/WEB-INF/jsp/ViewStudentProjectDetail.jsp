<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*"%>
<%
	Admin admin = null;
	Report report = null;
	StudentProject sproject = null;
	List<StudentProject> listsproject = new Vector<>();
	
	try {
		report = (Report) session.getAttribute("report");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try {
		sproject = (StudentProject) request.getAttribute("sproject");
		session.setAttribute("key",sproject.getProject().getProject_id());
	} catch (Exception e) {
		e.printStackTrace();
	}

	try {
		listsproject = (List<StudentProject>) request.getAttribute("listsproject");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try {
		admin = (Admin) session.getAttribute("admin");
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
<script type="text/javascript">

</script>

<body style="background-image: url('./image/hero-bg.png')">
	<jsp:include page="common/navbar.jsp"></jsp:include>
	
	<div class="container" style="margin-top: 35px;">
		<form name="frm" action="doDeleteStudentProject" method="post">
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
									<label class="col-sm-2 col-form-label text-right">รหัสโครงงานวิทยาศาสตร์</label>
									<div class="col-sm-2">
										<input type="text" name="project_id" id="project_id" class="form-control data" value="<%=sproject.getProject().getProject_id()%>" style="background-color: white" readonly>
									</div>
								</div>
								
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">ชื่อโครงงานวิทยาศาสตร์</label>
									<div class="col-sm-8">
										<input type="text" name="projectname" id="projectname" class="form-control data" value="<%=sproject.getProject().getProjectname()%>" style="background-color: white" readonly>
									</div>
								</div>
								
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">ประเภทโครงงานวิทยาศาสตร์</label>
									<div class="col-sm-4">
										<input type="text" name="projecttype_name" id="projecttype_name" class="form-control data" value="<%=sproject.getProject().getProjecttype().getProjecttype_name()%>" style="background-color: white" readonly>
									</div>									
								</div>
								
								<% 
									String video = null ;
									String vname = null;
									String fname = null;
									String disabled = null ;

									if (sproject.getProject().getVideo().equals("-") || sproject.getProject().getVideo() == null) {
										video = "#";
										vname = "ยังไม่ได้อัปโหลดวิดีโอ" ;
										disabled = "disabled" ;
									} else {
										video = sproject.getProject().getVideo();
										vname = "วิดีโอ" ;
									}
									
									String file = null ;

									if (report.getReportname() == null) {
										file = "#";
										fname = "ยังไม่ได้อัปโหลดเอกสาร" ;
										disabled = "disabled" ;
									} else {
										file = "./report/"+report.getReportname()+".pdf";
										fname = "เอกสารรายงาน" ;
									}
								%>
								
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">ไฟล์วีดิโอ</label>
									<div class="col-sm-4">
										<a href="<%=video%>" target="_blank" class="btn btn-link" type="button" style="margin-left: -13px;" ><i class="fa fa-file-video-o">&nbsp;&nbsp;</i><%=vname%></a>
									</div>
									<label class="col-sm-2 col-form-label text-right">ไฟล์รายงาน</label>
									<div class="col-sm-4">							
										<a href="<%=file%>" target="_blank" class="btn btn-link" type="button" style="margin-left: -13px ; "><i class="fa-solid fa-file-pdf">&nbsp;&nbsp;</i><%=fname%></a>
									</div>
								</div>
								
								<% String award = null;
								
								if (sproject.getProject().getAward().equals("-") || sproject.getProject().getAvgscore() == 0) {
									award = "ยังไม่มีรางวัล" ;
								} else { 
									award = sproject.getProject().getAward() ;
								}
								%>
								
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">รางวัล</label>
									<div class="col-sm-4">
										<input type="text" name="award" id="award" class="form-control data" value="<%=award%>" style="background-color: white" readonly>
									</div>
								</div>
								
								<%
									for (int i = 0; i < listsproject.size(); i++) {
								%>
							<h5>
								นักเรียนคนที่&nbsp;<%=i + 1%></h5>
							<hr class="colorgraph">
							<input type="hidden" name="student_id" id="student_id" class="form-control data" value="<%=listsproject.get(i).getStudent().getStudent_id()%>" readonly>
							<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">ชื่อ - นามสกุล</label>
									<div class="col-sm-3">
										<input type="text" name="fullname" id="fullname" class="form-control data" value="<%=listsproject.get(i).getStudent().getPrefix() +" "+ listsproject.get(i).getStudent().getFirstname() +" "+ listsproject.get(i).getStudent().getLastname()%>" style="background-color: white" readonly>
									</div>
									<input type="hidden" name="prefix" id="prefix" class="form-control data" value="<%=listsproject.get(i).getStudent().getPrefix()%>" readonly>
									<input type="hidden" name="firstname" id="firstname" class="form-control data" value="<%=listsproject.get(i).getStudent().getFirstname()%>" readonly>
									<input type="hidden" name="lastname" id="lastname" class="form-control data" value="<%=listsproject.get(i).getStudent().getLastname()%>" readonly>
								</div>

							<div class="form-group row">
								<label class="col-sm-2 col-form-label text-right">เบอร์โทรศัพท์</label>
								<div class="col-sm-3">
									<input type="text" name="mobileno" id="mobileno" class="form-control data" value="<%=listsproject.get(i).getStudent().getMobileno()%>" style="background-color: white" readonly>
								</div>
							</div>

							<div class="form-group row">
								<label class="col-sm-2 col-form-label text-right">ระดับชั้น</label>
								<div class="col-sm-3">
									<input type="text" name="grade" id="grade" class="form-control data" value="<%=listsproject.get(i).getStudent().getGrade()%>" style="background-color: white" readonly>
								</div>
								<label class="col-sm-2 col-form-label text-right">โรงเรียน</label>
								<div class="col-sm-3">
									<input type="text" name="school_name" id="school_name" class="form-control data" value="<%=listsproject.get(i).getStudent().getSchool().getSchool_name()%>" style="background-color: white" readonly>
								</div>
							</div>
							<br>
							<%
									}
							%>
							<h5>อาจารย์ที่ปรึกษา</h5>
							<hr class="colorgraph">
							<input type="hidden" name="advisor_id" id="advisor_id" class="form-control data" value="<%=sproject.getAdvisor().getAdvisor_id()%>" readonly>
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">อาจารย์ที่ปรึกษา</label>
										<div class="col-sm-4">
											<input type="text" name="advisorname" id="advisorname" class="form-control data" value="<%=sproject.getAdvisor().getPrefix() +" "+ sproject.getAdvisor().getFirstname() +" "+ sproject.getAdvisor().getLastname()%>" style="background-color: white" readonly>
										</div>								
								</div>
								<br>
								<br>							
								<div class="form-group row">
									<div class="col-sm-12 ">
										<span class="form-control-input"> <input id="checkBox2" type="checkbox" name="checkBox2" onclick="return edit(this)">
											<label for="checkBox2">&nbsp;ลบข้อมูล (เมื่อตรวจข้อมูลเสร็จสิ้น จากนั้นกดปุ่ม "ลบข้อมูล")</label>
										</span>
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-12 text-center">										
										<button type="submit" class="btn btn-danger" name="delete" id="delete" disabled="disabled" onclick="return confirm('คุณต้องการลบโครงงานวิทยาศาสตร์นี้หรือไม่ ');">ลบข้อมูล</button>
										<a class="btn btn-warning" href="doViewProject" role="button">ยกเลิก</a>	
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
	
	<script type="text/javascript">
	
		function edit(ck) {
			if (ck.checked) {
				document.getElementById('delete').disabled = false;
			} else {			
				document.getElementById('delete').disabled = true;
			}
		}
	</script>
	
</body>
</html>
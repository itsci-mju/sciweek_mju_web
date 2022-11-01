<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*, manager.*, bean.*, java.text.*, java.sql.Timestamp"%>
<%
	Student student = null ;
	Project project = null ;
	Schedules schedules = null ;
	
	try {
		project = (Project) request.getAttribute("project");
	} catch (Exception e) {
		e.printStackTrace();
	}

	try {
		student = (Student) session.getAttribute("student");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try {
		schedules = (Schedules) request.getAttribute("schedules");
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
<link rel="stylesheet" href="./css/multi_step_form.css">
<script type="module" src="./js/multi_step_form.js"></script>
</head>
<body style="background-image: url('./image/hero-bg.png') ; background-repeat: no-repeat ; background-attachment: fixed ; background-size: 100% 100%">
<script type="text/javascript">

	function validateForm(frm) {
		
		if (frm.filepdf.value == "") {
			alert("<!-- กรุณาอัปโหลดเอกสารรายงาน -->");
			return false;
		}

	}
		
</script>
	<%	
		Date date = new Date();  
		Timestamp timestamp = new Timestamp(date.getTime());  
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss"); 
	
		String video = null ;
		String disabled = null ;
	
		if (project.getVideo().equals("-")) {
			video = "กรุณาอัปโหลดวิดีโอ" ;
		} else {
			video = project.getVideo();
		}
		
	%>
	<jsp:include page="common/navbar.jsp"></jsp:include>
					
	<div class="container" style="margin-top: 35px;">
		<form action="UploadReport" id="frm" method="POST" enctype="multipart/form-data" >
		<div>
			<h1><i class="fa-solid fa-cloud-arrow-up">&nbsp;</i>อัปโหลดเอกสารรายงานและวิด๊โอ</h1>
			<div id="multi-step-form-container">
				<!-- Form Steps / Progress Bar -->
				<ul class="form-stepper form-stepper-horizontal text-center mx-auto pl-0">
					<!-- Step 1 -->
					<li class="form-stepper-active text-center form-stepper-list" step="1">
						<a class="mx-2"> 
							<span class="form-stepper-circle"> 
								<span>1</span>
							</span>
							<div class="label">อัปโหลดลิงค์วิดีโอ</div>
						</a>
					</li>
					<!-- Step 2 -->
					<li class="form-stepper-unfinished text-center form-stepper-list" step="2">
						<a class="mx-2"> 
							<span class="form-stepper-circle text-muted"> 
								<span>2</span>
							</span>
							<div class="label text-muted">อัปโหลดเอกสารรายงาน</div>
						</a>
					</li>
					<!-- Step 3 -->
					<!-- <li class="form-stepper-unfinished text-center form-stepper-list"
						step="3"><a class="mx-2"> <span
							class="form-stepper-circle text-muted"> <span>3</span>
						</span>
							<div class="label text-muted">ข้อมูลรายละเอียดโครงงานวิทยาศาสตร์</div>
						</a>
					</li> -->
				</ul>
				<!-- Step Wise Form Content -->
				<!-- Step 1 Content -->
				
				<% if (schedules.getExpuploaddate() != null ) { %>
				
					 <%
					 	if (timestamp.after(schedules.getExpuploaddate())) { 
						 	disabled = "disabled";
						}
					 %>
						
				
				<% } %>
				
				<section id="step-1" class="form-step">
					<h2 class="font-normal">ขั้นตอนที่ 1 : อัปโหลดลิงค์วิดีโอ</h2>
					<!-- Step 1 input fields -->
					<div class="mt-3">
						<h6 style="color: red"><i class="fa-solid fa-hand-point-right">&nbsp;</i><strong class="font__weight-semibold">ชี้แจง !!!</strong>&nbsp;ตัวอย่างลิงก์ https://www.youtube.com/embed/XXX..<br><br>
						<% if (schedules.getExpuploaddate() != null ) { 
							
							String fmt_expuploaddate = new SimpleDateFormat("EEEE ที่ dd เดือน MMMM พ.ศ. yyyy", new Locale("th", "TH")).format(schedules.getExpuploaddate());
							String fmt_expuploadtime = new SimpleDateFormat("HH:mm").format(schedules.getExpuploaddate()); 
							
						%>
						<i class="fa-solid fa-hand-point-right">&nbsp;</i><strong class="font__weight-semibold">แจ้งเตือน !!!</strong>&nbsp;สิ้นสุดการส่งเอกสาร
								<%=fmt_expuploaddate%> เวลา <%=fmt_expuploadtime%> น. &nbsp; 
						<% } %>	
						</h6>				
							<div class="form-group row">
								<div class="col-sm-4">
									<label style="color: green; text-align: left;">${msg}</label>
									<input type="hidden" name="project_id" id="project_id" class="form-control data" value="<%=project.getProject_id()%>">
									<input type="text" name="filevideo" id="filevideo" class="form-control data" placeholder="<%=video%>" <%=disabled%>>
								</div>			
								<br>
							</div>
					</div>
					<div class="mt-3">
						<a class="button btn-navigate-form-step" type="button" step_number="2" style="text-decoration: none;">ต่อไป</a>
					</div>
				</section>
				<!-- Step 2 Content, default hidden on page load. -->
				<section id="step-2" class="form-step d-none">
					<h2 class="font-normal">ขั้นตอนที่ 2 : อัปโหลดเอกสารรายงาน</h2>
					<!-- Step 2 input fields -->
					<div class="mt-3">
						<h6 style="color: red"><i class="fa-solid fa-hand-point-right">&nbsp;</i><strong class="font__weight-semibold">ชี้แจง !!!</strong>&nbsp;กรุณาอัปโหลดข้อมูลไฟล์รายงานเป็นนามสกุล .pdf..<br><br>
						<% if (schedules.getExpuploaddate() != null ) { 
							
							String fmt_expuploaddate = new SimpleDateFormat("EEEE ที่ dd เดือน MMMM พ.ศ. yyyy", new Locale("th", "TH")).format(schedules.getExpuploaddate());
							String fmt_expuploadtime = new SimpleDateFormat("HH:mm").format(schedules.getExpuploaddate()); 
							
						%>
							<i class="fa-solid fa-hand-point-right">&nbsp;</i><strong class="font__weight-semibold">แจ้งเตือน !!!</strong>&nbsp;สิ้นสุดการส่งเอกสาร
								<%=fmt_expuploaddate%> เวลา <%=fmt_expuploadtime%> น. &nbsp; 
						<% } %> 
						</h6>
						<br>
						<div class="form-group row">
								<div class="col-sm-4">
									<input class="form-control" type="file" name="filepdf" id="filepdf" accept=".pdf" required <%=disabled%>>
								</div>
								<br> <label style="color: green; text-align: left;">${msg}</label>
							</div>
					</div>
					<div class="mt-3">
						<a class="button btn-navigate-form-step" type="button" step_number="1" style="text-decoration: none;">ย้อนกลับ</a>
						<button class="button submit-btn" type="submit" onclick ="return validateForm(frm)" <%=disabled%>>บันทึก</button>
					</div>
				</section>

				<!-- Step 3 Content, default hidden on page load. -->
				<!--  <section id="step-3" class="form-step d-none">
                <h2 class="font-normal">ขั้นตอนที่ 3 : บันทึกข้อมูลโครงงานวิทยาศาสตร์</h2>
                Step 3 input fields
                <div class="mt-3">
                    
                </div>
                <div class="mt-3">
                    <button class="button btn-navigate-form-step" type="button" step_number="2">กลับ</button>
                    <button class="button submit-btn" type="submit">บันทึก</button>
                </div>
            </section>  -->
            
			</div>
		</div>
		</form>
	</div>

	<jsp:include page="common/footer.jsp"></jsp:include>

</body>
</html>
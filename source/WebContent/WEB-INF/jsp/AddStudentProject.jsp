<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "bean.* , util.* , java.util.*, manager.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%
	Admin admin = null;
	List<ProjectType> projectTypeList = new Vector<>();

	try {
		admin = (Admin) session.getAttribute("admin");
	} catch (Exception e) {

	}
	
	try {
		projectTypeList = (List<ProjectType>) request.getAttribute("projectTypeList");
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
<link rel="stylesheet"href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/e18a64822c.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Kanit' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="./css/web_css.css">
</head>
<body style="background-image: url('./image/hero-bg.png')">

	<jsp:include page="common/navbar.jsp"></jsp:include>
	
	<div class="container" style="margin-top: 35px;">
		<form action="doAddReviewer" name="frm" method="post" >
			<section id="content">
				<div class="container" style="margin-top: -20px">
					<div class="row">
						<div class="col-lg-12">
							<div class="container">
							
								<h3>ลงทะเบียนคณะกรรมการ</h3>
								<hr class="colorgraph">

								<h5>ข้อมูล</h5>
								<hr>
								
								<div class="form-group row">
								<label class="col-sm-3 col-form-label text-right">รหัสโครงงานวิทยาศาสตร์</label>
								<div class="col-sm-2">
									<input type="text" name="project_id" id="project_id" class="form-control data" required>								
								</div>
								<label class="col-form-label" style="color : red ">*** มตก =  "มัธยมต้นกายภาพ" ***</label>
							</div>

							<div class="form-group row">
								<label class="col-sm-3 col-form-label text-right">ชื่อโครงงานวิทยาศาสตร์</label>
								<div class="col-sm-8">
									<input type="text" name="projectname" id="projectname" class="form-control data" required>
								</div>
							</div>

							<div class="form-group row">
								<label class="col-sm-3 col-form-label text-right">ประเภทโครงงานวิทยาศาสตร์</label>
								<div class="col-sm-4">						
									<select class="form-control" name="projecttype_name" id="projecttype_name" required>
										<option selected disabled >--กรุณาเลือกประเภท--</option>
										<% for(ProjectType projectType : projectTypeList){ %>
										<option value="<%=projectType.getProjecttype_id()%>"><%=projectType.getProjecttype_name()%></option>
										<% } %>
									</select>
								</div>
							</div>
							<br>
							
							<h5>นักเรียน</h5>
							<hr class="colorgraph">
							<div class="form-group row">
								<label class="col-sm-2 col-form-label text-right">คำนำหน้าชื่อ</label>
								<div class="col-sm-3">
									<select class="form-control" name="prefix" id="prefix" required>
										<option selected disabled >--กรุณาเลือกคำนำหน้าชื่อ--</option>
										<option value="นาย">นาย</option>
										<option value="นางสาว">นางสาว</option>
										<option value="เด็กชาย">เด็กชาย</option>					
										<option value="เด็กหญิง">เด็กหญิง</option>								
									</select>
								</div>
								<label class="col-form-label">ชื่อ</label>	
								<div class="col-sm-3">							
									<input type="text" name="firstname" id="firstname" class="form-control data" required>				
								</div>	
								<label class="col-form-label">นามสกุล</label>
								<div class="col-sm-3">
									<input type="text" name="lastname" id="lastname" class="form-control data"  required>
								</div>				
							</div>

							<div class="form-group row">
							<label class="col-sm-2 col-form-label text-right">อีเมล</label>
								<div class="col-sm-3">
									<input type="text" name="email" id="email" class="form-control data" required>
								</div>
								<label class="col-sm-2 col-form-label text-right">เบอร์โทรศัพท์</label>
								<div class="col-sm-3">
									<input type="text" name="mobileno" id="mobileno" class="form-control data" required>
								</div>
							</div>

							<div class="form-group row">
								<label class="col-sm-2 col-form-label text-right">ระดับชั้น</label>
								<div class="col-sm-3">
									<select class="form-control" name="grade" id="grade" required>
										<option selected disabled >--กรุณาเลือกระดับชั้น--</option>
										<option value="มัธยมศึกษาตอนต้น">มัธยมศึกษาตอนต้น</option>
										<option value="มัธยมศึกษาตอนปลาย">มัธยมศึกษาตอนปลาย</option>
									</select>
								</div>							
							</div>
							<br>
							
							<h5>โรงเรียน</h5>
							<hr class="colorgraph">			
							<div class="form-group row">
								<label class="col-sm-2 col-form-label text-right">โรงเรียน</label>
								<div class="col-sm-4">
									<input type="text" name="school_name" id="school_name" class="form-control data" required>
								</div>
							</div>
							
							<div class="form-group row">							
								<label class="col-sm-2 col-form-label text-right">ที่อยู่โรงเรียน</label>
								<div class="col-sm-6">
									<textarea name="school_address" id="school_address"  rows="5" cols="60" class="form-control data" required></textarea>
								</div>
							</div>
							
							<h5>อาจารย์ที่ปรึกษา</h5>
							<hr class="colorgraph">

							<div class="form-group row">
								<label class="col-sm-2 col-form-label text-right">คำนำหน้าชื่อ</label>
								<div class="col-sm-3">
									<select class="form-control" name="prefixad" id="prefixad" required>
											<option selected disabled >--กรุณาเลือกคำนำหน้าชื่อ--</option>
											<option value="อ.">อ.</option>
											<option value="ผศ.">ผศ.</option>
											<option value="ผศ.">รศ.</option>					
											<option value="ศ.">ศ.</option>								
											<option value="อ.ดร.">อ.ดร.</option>
											<option value="ผศ.ดร.">ผศ.ดร.</option>
											<option value="รศ.ดร.">รศ.ดร.</option>							
											<option value="ศ.ดร.">ศ.ดร.</option>
										</select>
								</div>	
								<label class="col-form-label">ชื่อ</label>
								<div class="col-sm-3">							
									<input type="text" name="firstnamead" id="firstname" class="form-control data" required>				
								</div>	
								<label class="col-form-label">นามสกุล</label>
								<div class="col-sm-3">
									<input type="text" name="lastnamead" id="lastname" class="form-control data"  required>
								</div>	
							</div>
		
							<div class="form-group row">
								<label class="col-sm-2 col-form-label text-right">อีเมล</label>
								<div class="col-sm-3">
									<input type="text" name="emailad" id="emailad" class="form-control data"  required>
								</div>
								<label class="col-sm-2 col-form-label text-right">เบอร์โทรศัพท์</label>
								<div class="col-sm-3">
									<input type="text" name="phonead" id="phonead" class="form-control data"  required>
								</div>
							</div>

										
								<br>
								<div class="form-group row">
									<div class="col-sm-12 text-center">
										<button type="submit" class="btn btn-success">ลงทะเบียน</button>
										<a class="btn btn-warning" href="doCreateTeam" role="button">ยกเลิก</a>							
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
	
<c:if test="${msg != null }">
	<script type="text/javascript">
		var msg = '${msg}';
		alert(msg);
	</script>
</c:if>	

</body>
</html>
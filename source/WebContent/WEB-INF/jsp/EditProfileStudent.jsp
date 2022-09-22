<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*"%>
<%

	Student student = null;

	try {
		student = (Student) session.getAttribute("student");
	} catch (Exception e) {

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
		<form action="doEditProfileStudent" name="frm" method="post">
			<section id="content">
				<div class="container" style="margin-top: -20px">
					<div class="row">
						<div class="col-lg-12">
							<div class="container">
								<h3>แก้ไขข้อมูลส่วนตัว</h3>
								<hr class="colorgraph">

								<h5>ข้อมูล</h5>
								<br>
								<div class="form-group row">
									<!-- <label class="col-sm-2 col-form-label text-right">รหัสนักเรียน</label> -->
									<div class="col-sm-2">
										<input type="hidden" name="student_id" id="student_id" class="form-control data" value="<%=student.getStudent_id()%>" readonly>
									</div>
								</div>
								
								<div class="form-group row">
								<div class="input-group" >
									<label class="col-sm-2 col-form-label text-right">คำนำหน้าชื่อ</label>
									<div class="col-sm-2" style="margin-left: -10px">
										<select class="form-select" name="prefix" id="prefix" required>
											<option value="นาย" <%if (student.getPrefix().equals("นาย")) {%> selected <%}%>>นาย</option>
											<option value="นางสาว" <%if (student.getPrefix().equals("นางสาว")) {%> selected <%}%>>นางสาว</option>
											<option value="เด็กหญิง" <%if (student.getPrefix().equals("เด็กหญิง")) {%> selected  <%}%>>เด็กหญิง</option>
											<option value="เด็กชาย" <%if (student.getPrefix().equals("เด็กชาย")) {%> selected <%}%>>เด็กชาย</option>			
										</select>
									</div>
									<label class="col-form-label">ชื่อ</label>
									<div class="col-sm-2">
										<input type="text" name="firstname" id="firstname" class="form-control data" value="<%=student.getFirstname()%>" pattern="^[ก-๏\s]+$" title="กรุณากรอกชื่อเป็นภาษาไทยเท่านั้น" required>
									</div>
									<label class="col-form-label">นามสกุล</label>
									<div class="col-sm-2">
										<input type="text" name="lastname" id="lastname" class="form-control data" value="<%=student.getLastname()%>" pattern="^[ก-๏\s]+$" title="กรุณากรอกนามสกุลเป็นภาษาไทยเท่านั้น" required>
									</div>
								</div>
							</div>					

								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">เบอร์โทรศัพท์</label>
									<div class="col-sm-4">
										<input type="text" name="mobileno" id="mobileno" class="form-control data" value="<%=student.getMobileno()%>"  maxlength="10" pattern="/((\+66|0)(\d{1,2}\-?\d{3}\-?\d{3,4}))|((\+๖๖|๐)([๐-๙]{1,2}\-?[๐-๙]{3}\-?[๐-๙]{3,4}))" title="กรุณากรอกเบอร์โทรศัพท์เป็นตัวเลขเท่านั้น" required>
									</div>
								</div>
								
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">ระดับชั้น</label>
									<div class="col-sm-3">
										<select class="form-control" name="grade" id="grade" required>
											<option value="มัธยมศึกษาตอนต้น" <%if (student.getGrade().equals("มัธยมศึกษาตอนต้น")) {%> selected <%}%>>มัธยมศึกษาตอนต้น</option>
											<option value="มัธยมศึกษาตอนปลาย" <%if (student.getGrade().equals("มัธยมศึกษาตอนปลาย")) {%> selected <%}%>>มัธยมศึกษาตอนปลาย</option>
	
										</select>
									</div>
								</div>
																												
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">อีเมล</label>
									<div class="col-sm-3">
										<input type="email" name="email" id="email" class="form-control data" value="<%=student.getEmail()%>" pattern="/^[_a-zA-Z0-9-]+(\.[_a-zA-Z0-9-]+)*\@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.([a-zA-Z]){2,4})$/" title="กรุณากรอกอีเมลให้ถูกต้อง" required>
									</div>
								</div>
								
								<div class="form-group row">								
									<label class="col-sm-2 col-form-label text-right">รหัสผ่าน</label>
									<div class="col-sm-3">
										<input type="password" name="password" id="password" class="form-control data" value="<%=student.getPassword()%>" color: black;" required>
									</div>
								</div>
								
								
								<h5>โรงเรียน</h5>
								<hr>
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right"></label>
									<div class="col-sm-2">
										<input type="hidden" name="school_id" id="school_id" class="form-control data" value="<%=student.getSchool().getSchool_id()%>">
									</div>
								</div>
								<div class="form-group row">						
									<label class="col-sm-2 col-form-label text-right">ชื่อโรงเรียน</label>
									<div class="col-sm-4">										
										<input type="text" name="school_name" id="school_name" class="form-control data" value="<%=student.getSchool().getSchool_name()%>" readonly>
									</div>
								</div>
								
								<div class="form-group row">						
									<label class="col-sm-2 col-form-label text-right">ที่อยู่โรงเรียน</label>
									<div class="col-sm-8">													
										<textarea id="school_address" name="school_address" rows="5" cols="60" class="form-control data" readonly><%=student.getSchool().getSchool_address()%></textarea>
									</div>
								</div>
								<br>
								<hr class="colorgraph">
								<br>
								<div class="form-group row">
									<div class="col-sm-12 text-center">
										<button type="submit" class="btn btn-success">บันทึก</button>
										<a href="index" class="btn btn-danger" role="button">ยกเลิก</a>									
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
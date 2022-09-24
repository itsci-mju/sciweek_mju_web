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
	
	boolean error_msg = false;
	try {
		error_msg = (boolean) request.getAttribute("error_msg");
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
<script type="text/javascript">

	function validateForm(frm) {
		
		var regex_phoneno = /^[0]{1}[8|9|6]{1}[0-9]{8}/;
		var regex_name = /^[ก-์|]{2,50}$/;
		var regex_email = /^[_a-zA-Z0-9-]+(.[_a-zA-Z0-9-]+)@[a-zA-Z0-9-]+(.[a-zA-Z0-9-]+)(.([a-zA-Z]){2,4})$/;
		var regex_password = /^[A-Za-z|0-9]{8,16}$/;
		
	// prefix
		if (frm.prefix.value == "") {
			alert("<!-- กรุณาเลือกคำหน้าชื่อ --> ");
			return false;
		}
	// firstname
		if (frm.firstname.value == "") {
			alert("<!-- กรุณากรอกชื่อ -->");
			return false;
		}
		if (regex_name.test(frm.firstname.value) == false) {
			alert("<!-- กรุณากรอกชื่อเป็นภาษาไทยเท่านั้น -->");
			frm.firstname.value = "";
			return false;
		} 		
	// lastname	
		if (frm.lastname.value == "") {
			alert("<!-- กรุณากรอกนามสกุล -->");
			return false;
		} 	
		if (regex_name.test(frm.lastname.value) == false) {
			alert("<!-- กรุณากรอกนามสกุลเป็นภาษาไทยเท่านั้น -->");
			frm.lastname.value = "";
			return false;
		}
	// phone
		if (frm.mobileno.value == "") {
			alert('<!-- กรุณากรอกเบอร์โทรศัพท์ให้ถูกต้อง -->');
		return false;
		}
		if (!regex_phoneno.test(frm.mobileno.value)) {
			alert("<!-- กรุณากรอกเบอร์โทรศัพท์เริ่มต้นด้วย 06,08,09 เเละ กรอกให้ครบ 10 ตัว");
		return false ;
		}
	// email
		if(frm.email.value == "") {
			alert('<!-- กรุณากรอกอีเมล -->');
			return false;
		}
		if(regex_email.test(frm.email.value) == false) {
			alert("<!-- กรุณากรอกอีเมลให้ถูกต้อง -->");
			return false ;
		}
	// password
		if(frm.password.value == "") {
			alert('<!-- กรุณากรอกรหัสผ่าน -->');
			return false;
		}
		if(regex_password.test(frm.password.value) == false) {
			alert("<!-- กรุณากรอกรหัสผ่าน มีความยาวอย่างน้อย 8 - 16 ตัวอักษร --> \n <!-- กรุณากรอกรหัสผ่าน ต้องเป็นตัวอักษรภาษาอังกฤษกับตัวเลขเท่านั้น -->");
			return false ;
		}
		
	}
</script>
<body style="background-image: url('./image/hero-bg.png')">

	<jsp:include page="common/navbar.jsp"></jsp:include>

	<div class="container" style="margin-top: 35px;">
		<form action="doEditProfileStudent" name="frm" id="frm" method="post">
			<section id="content">
				<div class="container" style="margin-top: -20px">
					<div class="row">
						<div class="col-lg-12">
							<div class="container">						
								<h3><i class="fa-solid fa-pen-to-square">&nbsp;</i>แก้ไขข้อมูลส่วนตัว</h3>
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
										<select class="form-select" name="prefix" id="prefix" >
											<option value="นาย" <%if (student.getPrefix().equals("นาย")) {%> selected <%}%>>นาย</option>
											<option value="นางสาว" <%if (student.getPrefix().equals("นางสาว")) {%> selected <%}%>>นางสาว</option>
											<option value="เด็กหญิง" <%if (student.getPrefix().equals("เด็กหญิง")) {%> selected  <%}%>>เด็กหญิง</option>
											<option value="เด็กชาย" <%if (student.getPrefix().equals("เด็กชาย")) {%> selected <%}%>>เด็กชาย</option>			
										</select>
									</div>
									<label class="col-form-label">ชื่อ</label>
									<div class="col-sm-2">
										<input type="text" name="firstname" id="firstname" class="form-control data" value="<%=student.getFirstname()%>" >
									</div>
									<label class="col-form-label">นามสกุล</label>
									<div class="col-sm-2">
										<input type="text" name="lastname" id="lastname" class="form-control data" value="<%=student.getLastname()%>" >
									</div>
								</div>
							</div>					

								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">เบอร์โทรศัพท์</label>
									<div class="col-sm-4">
										<input type="text" name="mobileno" id="mobileno" class="form-control data" value="<%=student.getMobileno()%>"  maxlength="10">
									</div>
								</div>
								
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">ระดับชั้น</label>
									<div class="col-sm-3">
										<select class="form-control" name="grade" id="grade" >
											<option value="มัธยมศึกษาตอนต้น" <%if (student.getGrade().equals("มัธยมศึกษาตอนต้น")) {%> selected <%}%>>มัธยมศึกษาตอนต้น</option>
											<option value="มัธยมศึกษาตอนปลาย" <%if (student.getGrade().equals("มัธยมศึกษาตอนปลาย")) {%> selected <%}%>>มัธยมศึกษาตอนปลาย</option>
	
										</select>
									</div>
								</div>
																												
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">อีเมล</label>
									<div class="col-sm-3">
										<input type="email" name="email" id="email" class="form-control data" value="<%=student.getEmail()%>"  required>
									</div>
								</div>
								
								<div class="form-group row">								
									<label class="col-sm-2 col-form-label text-right">รหัสผ่าน</label>
									<div class="col-sm-3">
										<input type="password" name="password" id="password" class="form-control data" value="<%=student.getPassword()%>" required>
									</div>
								</div>
								
								
								<h5>โรงเรียน</h5>
								<hr class="colorgraph">
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right"></label>
									<div class="col-sm-2">
										<input type="hidden" name="school_id" id="school_id" class="form-control data" value="<%=student.getSchool().getSchool_id()%>">
									</div>
								</div>
								<div class="form-group row">						
									<label class="col-sm-2 col-form-label text-right">ชื่อโรงเรียน</label>
									<div class="col-sm-4">										
										<input type="text" name="school_name" id="school_name" class="form-control data" value="<%=student.getSchool().getSchool_name()%>" >
									</div>
								</div>
								
								<div class="form-group row">						
									<label class="col-sm-2 col-form-label text-right">ที่อยู่โรงเรียน</label>
									<div class="col-sm-8">													
										<textarea id="school_address" name="school_address" rows="4" cols="50" class="form-control data" ><%=student.getSchool().getSchool_address()%></textarea>
									</div>
								</div>
								<br>
								<hr class="colorgraph">
								<br>
								<div class="form-group row">
									<div class="col-sm-12 text-center">
										<button type="submit" class="btn btn-success" OnClick ="return validateForm(frm)">บันทึก</button>
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
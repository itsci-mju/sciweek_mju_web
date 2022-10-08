<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*"%>
<%
	IsEditProfileReviewerManager  isEditProfileReviewerManager = new IsEditProfileReviewerManager();

	Reviewer reviewer = null;

	try {
		reviewer = (Reviewer) session.getAttribute("reviewer");
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
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" >
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Kanit' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="./css/web_css.css">
</head> 
<script type="text/javascript">

	function validateForm(frm) {
		
		var regexp =/^[ก-์|]{2,32}$/;
		var regex_password = /^[A-Za-z|0-9]{8,16}$/;
		var regex_email = /^[_a-zA-Z0-9-]+(.[_a-zA-Z0-9-]+)@[a-zA-Z0-9-]+(.[a-zA-Z0-9-]+)(.([a-zA-Z]){2,4})$/;
		
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
		if (regexp.test(frm.firstname.value) == false) {
			alert("<!-- กรุณากรอกชื่อเป็นภาษาไทยเท่านั้น -->");
			frm.firstname.value = "" ;
			return false;
		} 		
		
	// lastname	
		if (frm.lastname.value == "") {
			alert("<!-- กรุณากรอกนามสกุล -->");
			return false;
		} 	
		if (regexp.test(frm.lastname.value) == false) {
			alert("<!-- กรุณากรอกนามสกุลเป็นภาษาไทยเท่านั้น -->");
			frm.lastname.value = "" ;
			return false;
		}
		
	// faculty
		if (frm.faculty.value == "") {
			alert("<!-- กรุณากรอกคณะ -->");
			return false;
		}
		if (regexp.test(frm.faculty.value) == false) {
			alert("<!-- กรุณากรอกคณะเป็นภาษาไทยเท่านั้น -->");
			return false;
		} 
		
	// position	
		if (frm.position.value == "") {
			alert("<!-- กรุณาเลือกตำแหน่ง --> ");
			return false;
		}
		
	// line
		if (frm.line.value == "") {
			alert("<!-- ถ้าไม่มีกรุณากรอก ' - ' --> ");
			return false;
		}
	
	// facebook
		if (frm.facebook.value == "") {
			alert("<!-- ถ้าไม่มีกรุณากรอก ' - ' --> ");
			return false;
		}
	
	// email
		if (frm.email.value == "") {
			alert('<!-- กรุณากรอกอีเมล -->');
			return false;
		}
		if (regex_email.test(frm.email.value) == false) {
			alert("<!-- กรุณากรอกอีเมลให้ถูกต้อง -->");
			return false ;
		}
		
		// password
		if (frm.password.value == "") {
			alert('<!-- กรุณากรอกรหัสผ่าน -->');
			return false;
		}
		if (regex_password.test(frm.password.value) == false) {
			alert("<!-- กรุณากรอกรหัสผ่าน มีความยาวอย่างน้อย 8 - 16 ตัวอักษร --> \n <!-- กรุณากรอกรหัสผ่าน ต้องเป็นตัวอักษรภาษาอังกฤษกับตัวเลขเท่านั้น -->");
			return false ;
		}
		
	}
</script>
<body style="background-image: url('./image/hero-bg.png')">
	
	<jsp:include page="common/navbar.jsp"></jsp:include>

	<div class="container" style="margin-top: 35px;">

		<form action="doEditProfileReviewer" name="frm" id="frm" method="post">
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
									<!-- <label class="col-sm-2 col-form-label text-right">รหัสคณะกรรมการ</label> -->
									<div class="col-sm-4">
										<input type="hidden" name="reviewer_id" id="reviewer_id" class="form-control data" value="<%=reviewer.getReviewer_id()%>" style="background-color: white" readonly>
									</div>																								
								</div>

								<div class="form-group row">
									<div class="input-group">
										<label class="col-sm-2 col-form-label text-right">คำนำหน้าชื่อ</label>
										<div class="col-sm-2" style="margin-left: -10px">
											<select class="form-select" name="prefix" id="prefix">
												<option selected disabled>--กรุณาเลือกคำนำหน้าชื่อ--</option>
												<option value="อ."
													<%if (reviewer.getPrefix().equals("อ.")) {%> selected 
													<%}%>>อ.</option>
												<option value="อ.ดร."
													<%if (reviewer.getPrefix().equals("อ.ดร.")) {%> selected
													<%}%>>อ.ดร.</option>
												<option value="ศ."
													<%if (reviewer.getPrefix().equals("ศ.")) {%> selected <%}%>>ศ.</option>
												<option value="รศ.ดร."
													<%if (reviewer.getPrefix().equals("รศ.ดร.")) {%> selected
													<%}%>>รศ.ดร.</option>
												<option value="ผศ.ดร."
													<%if (reviewer.getPrefix().equals("ผศ.ดร.")) {%> selected
													<%}%>>ผศ.ดร.</option>
												<option value="ศ.ดร."
													<%if (reviewer.getPrefix().equals("ศ.ดร.")) {%> selected
													<%}%>>ศ.ดร.</option>
											</select>
										</div>
										<label class="col-form-label">ชื่อ</label>
										<div class="col-sm-2">
											<input type="text" name="firstname" id="firstname" class="form-control data" value="<%=reviewer.getFirstname()%>" style="background-color: white">
										</div>
										<label class="col-form-label">นามสกุล</label>
										<div class="col-sm-2">
											<input type="text" name="lastname" id="lastname" class="form-control data" value="<%=reviewer.getLastname()%>" style="background-color: white">
										</div>
									</div>
								</div>

								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">ตำแหน่ง</label>
									<div class="col-sm-3">
										<select class="form-select" name="position" id="position" >
											<option selected disabled >--กรุณาเลือกตำแหน่ง--</option>
											<option value="ประธานคณะกรรมการ"
												<%if (reviewer.getPosition().equals("ประธานคณะกรรมการ")) {%> selected
												<%}%>>ประธานคณะกรรมการ</option>
											<option value="คณะกรรมการ"
												<%if (reviewer.getPosition().equals("คณะกรรมการ")) {%> selected
												<%}%>>คณะกรรมการ</option>										
										</select>										
									</div>														
								</div>							
								
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">คณะ</label>
									<div class="col-sm-3">
										<input type="text" name="faculty" id="faculty" class="form-control data" value="<%=reviewer.getFaculty()%>" style="background-color: white">
									</div>
									<label class="col-sm-2 col-form-label text-right">สาขา </label>
									<div class="col-sm-3">
										<select name="major" id="major" class="form-select" >
											<option selected disabled >--กรุณาเลือกสาขา--</option>
											<option value="วิทยาการคอมพิวเตอร์" 
											<%if (reviewer.getMajor().equals("วิทยาการคอมพิวเตอร์")) {%> selected
											<%}%>>วิทยาการคอมพิวเตอร์</option>
											<option value="เทคโนโลยีชีวภาพ"
											<%if (reviewer.getMajor().equals("เทคโนโลยีชีวภาพ")) {%> selected
											<%}%>>เทคโนโลยีชีวภาพ</option>
											<option value="เคมี"
											<%if (reviewer.getMajor().equals("เคมี")) {%> selected
											<%}%>>เคมี</option>
											<option value="นวัตกรรมเคมีอุตสาหกรรม"
											<%if (reviewer.getMajor().equals("นวัตกรรมเคมีอุตสาหกรรม")) {%> selected
											<%}%>>นวัตกรรมเคมีอุตสาหกรรม</option>
											<option value="เทคโนโลยีสารสนเทศ"
											<%if (reviewer.getMajor().equals("เทคโนโลยีสารสนเทศ")) {%> selected
											<%}%>>เทคโนโลยีสารสนเทศ</option>
											<option value="นวัตกรรมวัสดุ"
											<%if (reviewer.getMajor().equals("นวัตกรรมวัสดุ")) {%> selected
											<%}%>>นวัตกรรมวัสดุ</option>
											<option value="คณิตศาสตร์"
											<%if (reviewer.getMajor().equals("คณิตศาสตร์")) {%> selected
											<%}%>>คณิตศาสตร์</option>
											<option value="ฟิสิกส์ประยุกต์"
											<%if (reviewer.getMajor().equals("ฟิสิกส์ประยุกต์")) {%> selected
											<%}%>>ฟิสิกส์ประยุกต์</option>
											<option value="สถิติและการจัดการสารสนเทศ"
											<%if (reviewer.getMajor().equals("สถิติและการจัดการสารสนเทศ")) {%> selected
											<%}%>>สถิติและการจัดการสารสนเทศ</option>
										</select>
									</div>
								</div>
								
								<%	String line = null ;
								
										if (reviewer.getLine() == null) {
											line = "-" ;
										} else { 
											line = reviewer.getLine();
										}					
								%>
								
								<%	String facebook = null ;
								
										if (reviewer.getFacebook() == null) {
											facebook = "-" ;
										} else { 
											facebook = reviewer.getFacebook();
										}					
								%>
								
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right"><i class="fab fa-line" style="color : #33FF00">&nbsp;</i>Line</label>
									<div class="col-sm-3">
										<input type="text" name="line" id="line" class="form-control data" value="<%=line%>" style="background-color: white">									
									</div>		
									<label class="col-sm-2 col-form-label text-right"><i class="fa fa-facebook-official" style="color : #0066FF">&nbsp;</i>Facebook</label>
									<div class="col-sm-3">
										<input type="text" name="facebook" id="facebook" class="form-control data" value="<%=facebook%>" style="background-color: white">
									</div>																			
								</div>	
								
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">อีเมล</label>
									<div class="col-sm-3">
										<input type="text" name="email" id="email" class="form-control data" value="<%=reviewer.getEmail()%>" style="background-color: white" required>
									</div>
									<label class="col-sm-2 col-form-label text-right">รหัสผ่าน</label>
									<div class="col-sm-3">
										<input type="password" name="password" id="password" class="form-control data" value="<%=reviewer.getPassword()%>" style="background-color: white" required>								
									</div>
								</div>
								
								<%	String team_name = null ;
								
										if (reviewer.getTeam().getTeam_name() == null) {
											team_name = "ไม่มีกลุ่ม" ;
										} else { 
											team_name = reviewer.getTeam().getTeam_name();
										}					
								%>
								
								<div class="form-group row">								
									<label class="col-sm-2 col-form-label text-right">ทีม</label>
									<div class="col-sm-4">
										<input type="hidden" name="team_id" id="team_id" class="form-control data" value="<%=reviewer.getTeam().getTeam_id()%>">
										<input type="text" name="team_name" id="team_name" class="form-control data" value="<%=team_name%>" readonly>
									</div>
								</div>
								
								<br>
								<hr class="colorgraph">
								<br>
								<div class="form-group row">
									<div class="col-sm-12 text-center">
										<button type="submit" class="btn btn-success" OnClick ="return validateForm(frm)">บันทึก</button>
										<a class="btn btn-danger" href="index" role="button">ยกเลิก</a>	
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
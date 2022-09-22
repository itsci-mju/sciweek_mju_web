<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "bean.* , util.* , java.util.*, manager.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%
	Admin admin = null;

	try {
		admin = (Admin) session.getAttribute("admin");
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
								<br>
								
								<div class="form-group row">
									<div class="input-group">
										<label class="col-sm-2 col-form-label text-right">คำนำหน้าชื่อ</label>
										<div class="col-sm-2" style="margin-left: -10px">
											<select class="form-select" name="prefix" id="prefix" required>
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
										<div class="col-sm-2">
										<input type="text" name="firstname" id="firstname" class="form-control data" required>
										</div>
										<label class="col-form-label">นามสกุล</label>
										<div class="col-sm-2">
											<input type="text" name="lastname" id="lastname" class="form-control data" required>
										</div>
									</div>
								</div>					
								
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">คณะ</label>
									<div class="col-sm-3">
										<input type="text" name="faculty" id="faculty" class="form-control data" value="วิทยาศาสตร์" readonly>
									</div>
									<label class="col-sm-2 col-form-label text-right">สาขา</label>
									<div class="col-sm-3">								
										<select name="major" id="major" class="form-select data" required>
											<option selected disabled >--กรุณาเลือกสาขา--</option>
											<option value="วิทยาการคอมพิวเตอร์">วิทยาการคอมพิวเตอร์</option>
											<option value="เทคโนโลยีชีวภาพ">เทคโนโลยีชีวภาพ</option>
											<option value="เคมี">เคมี</option>
											<option value="นวัตกรรมเคมีอุตสาหกรรม">นวัตกรรมเคมีอุตสาหกรรม</option>
											<option value="เทคโนโลยีสารสนเทศ">เทคโนโลยีสารสนเทศ</option>
											<option value="นวัตกรรมวัสดุ">นวัตกรรมวัสดุ</option>
											<option value="คณิตศาสตร์">คณิตศาสตร์</option>
											<option value="ฟิสิกส์ประยุกต์">ฟิสิกส์ประยุกต์</option>
											<option value="สถิติและการจัดการสารสนเทศ">สถิติและการจัดการสารสนเทศ</option>
										</select>
									</div>						
								</div>	
								
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">ตำแหน่ง</label>
									<div class="col-sm-4">
										<select name="position" id="position" class="form-select data" required>
											<option selected disabled >--กรุณาเลือกตำแหน่ง--</option>
											<option value="ประธานคณะกรรมการ">ประธานคณะกรรมการ</option>
											<option value="คณะกรรมการ">คณะกรรมการ</option>											
										</select>
									</div>														
								</div>
								
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right"><i class="fab fa-line" style="color : #33FF00">&nbsp;</i>Line</label>
									<div class="col-sm-3">
										<input type="text" name="line" id="line" class="form-control data" >
									</div>
									<label class="col-sm-2 col-form-label text-right"><i class="fa fa-facebook-official" style="color : #0066FF">&nbsp;</i>Facebook</label>
									<div class="col-sm-3">
										<input type="text" name="facebook" id="facebook" class="form-control data" >
									</div>											
								</div>			
								
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">อีเมล</label>
									<div class="col-sm-3">
										<input type="text" name="email" id="email" class="form-control data" required>
									</div>
									<label class="col-sm-2 col-form-label text-right">รหัสผ่าน</label>
									<div class="col-sm-3">
										<input type="password" name="password" id="password" class="form-control data" required>								
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
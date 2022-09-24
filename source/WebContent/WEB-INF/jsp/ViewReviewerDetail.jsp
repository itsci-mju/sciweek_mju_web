<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*"%>
<%
	Admin admin = null;
	Reviewer reviewer = null;
	
	try {
		reviewer = (Reviewer) request.getAttribute("reviewer");
		session.setAttribute("key",reviewer.getReviewer_id()); 
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
<body style="background-image: url('./image/hero-bg.png')">
	<jsp:include page="common/navbar.jsp"></jsp:include>

	<div class="container" style="margin-top: 35px;">
			<section id="content">
				<div class="container" style="margin-top: 35px">
					<div class="row">
						<div class="col-lg-12">
							<div class="container">
								<h3><i class="fa-solid fa-clipboard">&nbsp;</i>ข้อมูลคณะกรรมการ</h3>
								<hr class="colorgraph">
								<h5>ข้อมูล</h5>
								<br>					
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">รหัสคณะกรรมการ</label>
									<div class="col-sm-2">
										<input type="text" name="reviewer_id" id="reviewer_id" class="form-control data" value="<%=reviewer.getReviewer_id()%>" readonly>
									</div>																								
								</div>

							<div class="form-group row">
								<div class="input-group" >
									<label class="col-sm-2 col-form-label text-right">คำนำหน้าชื่อ</label>
									<div class="col-sm-2" style="margin-left: -10px">
										<select class="form-select" name="prefix" id="prefix" disabled>
											<option selected disabled>--กรุณาเลือกคำนำหน้าชื่อ--</option>
											<option value="อ." <%if (reviewer.getPrefix().equals("อ.")) {%> selected <%}%>>อ.</option>
											<option value="อ.ดร." <%if (reviewer.getPrefix().equals("อ.ดร.")) {%> selected <%}%>>อ.ดร.</option>
											<option value="ศ." <%if (reviewer.getPrefix().equals("ศ.")) {%> selected <%}%>>ศ.</option>
											<option value="รศ.ดร." <%if (reviewer.getPrefix().equals("รศ.ดร.")) {%> selected <%}%>>รศ.ดร.</option>
											<option value="ผศ.ดร." <%if (reviewer.getPrefix().equals("ผศ.ดร.")) {%> selected <%}%>>ผศ.ดร.</option>
											<option value="ศ.ดร." <%if (reviewer.getPrefix().equals("ศ.ดร.")) {%> selected <%}%>>ศ.ดร.</option>
										</select>
									</div>
									<label class="col-form-label">ชื่อ</label>
									<div class="col-sm-2">
										<input type="text" name="firstname" id="firstname" class="form-control data" value="<%=reviewer.getFirstname()%>" readonly>
									</div>
									<label class="col-form-label">นามสกุล</label>
									<div class="col-sm-2">
										<input type="text" name="lastname" id="lastname" class="form-control data" value="<%=reviewer.getLastname()%>" readonly>
									</div>
								</div>
							</div>
							
							<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">ตำแหน่ง</label>
									<div class="col-sm-4">
										<select class="form-control" name="position" id="position" disabled>
											<option selected disabled >--กรุณาเลือกตำแหน่ง--</option>
											<option value="ประธานคณะกรรมการ" <%if (reviewer.getPosition().equals("ประธานคณะกรรมการ")) {%> selected <%}%>>ประธานคณะกรรมการ</option>
											<option value="คณะกรรมการ" <%if (reviewer.getPosition().equals("คณะกรรมการ")) {%> selected <%}%>>คณะกรรมการ</option>										
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
									<label class="col-sm-2 col-form-label text-right">คณะ</label>
									<div class="col-sm-4">
										<input type="text" name="faculty" id="faculty" class="form-control data" value="<%=reviewer.getFaculty()%>" readonly>
									</div>
									<label class="col-sm-2 col-form-label text-right">สาขา </label>
									<div class="col-sm-4">
										<select name="major" id="major" class="form-select data" readonly>
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
								
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right" ><i class="fab fa-line" style="color : #33FF00">&nbsp;</i>Line</label>
									<div class="col-sm-4">
										<input type="text" name="line" id="line" class="form-control data" value="<%=line%>" readonly>									
									</div>
									<label class="col-sm-2 col-form-label text-right"><i class="fa fa-facebook-official" style="color : #0066FF">&nbsp;</i>Facebook</label>
									<div class="col-sm-4">
										<input type="text" name="facebook" id="facebook" class="form-control data" value="<%=facebook%>" readonly>
									</div>											
								</div>	
								
								
								
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">อีเมล</label>
									<div class="col-sm-4">
										<input type="text" name="email" id="email" class="form-control data" value="<%=reviewer.getEmail()%>" readonly>
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
										<input type="hidden" name="team_id" id="team_id" class="form-control data" value="<%=reviewer.getTeam().getTeam_id()%>" readonly>
										<input type="text" name="team_name" id="team_name" class="form-control data" value="<%=team_name%>" readonly>
									</div>
								</div>																				
								<br>						
								<hr class="colorgraph">				
								<br>
								<div class="form-group row">
									<div class="col-sm-12 ">
										<span class="form-control-input"> 
											<input type="checkbox" name="checkBox2" id="checkBox2" onclick="return edit(this)">
											<label for="checkBox2">&nbsp;ลบข้อมูล (เมื่อตรวจสอบข้อมูลเสร็จสิ้น จากนั้นกดปุ่ม "ลบข้อมูล")</label>
										</span>
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-12 text-center">
										<a href="doDeleteReviewer?reviewer_id=<%=reviewer.getReviewer_id()%>">
											<input type="button" name="delete" id="delete" value="ลบข้อมูล" class="btn btn-danger" disabled="disabled" onclick="return confirm('คุณต้องการลบคณะกรรมการนี้หรือไม่');">
										</a>
										<a class="btn btn-warning" href="doCreateTeam" role="button">ยกเลิก</a>	
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
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
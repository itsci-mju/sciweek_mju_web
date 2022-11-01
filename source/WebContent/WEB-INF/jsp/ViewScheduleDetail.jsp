<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*"%>
<%
	Admin admin = null;
	Schedules schedules = null;

	try {
		admin = (Admin) session.getAttribute("admin");
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
</head>
<script type="text/javascript">

	function validateForm(frm) {

		if (frm.uploaddate.value == "") {
			alert("<!-- กรุณาเลือกวันที่อัปโหลดเอกสารรายงาน --> ");
			return false;
		}
		
		if (frm.expuploaddate.value == "") {
			alert("<!-- กรุณาเลือกวันที่สิ้นสุดอัปโหลดเอกสารรายงาน --> ");
			return false;
		} else if (frm.expuploaddate.value <= frm.uploaddate.value) {
			alert("<!-- กรุณาเลือกวันที่สิ้นสุดอัปโหลดเอกสารให้มากกว่าวันที่อัปโหลดเอกสารรายงาน --> ");
			return false;
		} 
		
		if (frm.reviewdate.value == "") {
			alert("<!-- กรุณาเลือกวันที่เริ่มประเมินโครงงานวิทยาศาสตร์ --> ");
			return false;
		} else if (frm.reviewdate.value <= frm.expuploaddate.value) {
			alert("<!-- กรุณาเลือกวันที่เริ่มประเมินโครงงานวิทยาศาสตร์ให้มากกว่าวันที่สิ้นสุดอัปโหลดเอกสารรายงาน --> ");
			return false;
		} 
		
		if (frm.expreviewdate.value == "") {
			alert("<!-- กรุณาเลือกวันที่สิ้นสุดการประเมินโครงงานวิทยาศาสตร์ --> ");
			return false;
		} else if (frm.expreviewdate.value <= frm.reviewdate.value) {
			alert("<!-- กรุณาเลือกวันที่สิ้นสุดการประเมินโครงงานวิทยาศาสตร์ให้มากกว่าวันที่เริ่มประเมินโครงงานวิทยาศาสตร์ --> ");
			return false;
		} 
		
		if (frm.announcedate.value == "") {
			alert("<!-- กรุณาเลือกวันที่ประกาศผลรางวัลโครงงานวิทยาศาสตร์ --> ");
			return false;
		} else if (frm.announcedate.value <= frm.expreviewdate.value) {
			alert("<!-- กรุณาเลือกวันที่ประกาศผลรางวัลโครงงานวิทยาศาสตร์ให้มากกว่าวันที่สิ้นสุดการประเมินโครงงานวิทยาศาสตร์ --> ");
			return false;
		} 
		
	}
</script>
<body style="background-image: url('./image/hero-bg.png') ; background-repeat: no-repeat ; background-attachment: fixed ; background-size: 100% 100%">

	<jsp:include page="common/navbar.jsp"></jsp:include>

	<div class="container" style="margin-top: 35px;">
		<section id="content">
			<div class="container" style="margin-top: 35px">
				<div class="row">
					<div class="col-lg-12">
						<div class="container">
							<h3><i class="fa-solid fa-calendar-days">&nbsp;</i>ข้อมูลกำหนดการ</h3>
							<hr class="colorgraph">
							<h5>ข้อมูล</h5>
							<br>

							<form action="isEditSchedule" name="frm" id="frm" method="post">
							
								<div class="form-group row">
									<label class="col-sm-3 col-form-label text-right">ปี</label>
									<div class="col-sm-3">
										<input type="text" class="form-control" id="years" name="years" value="<%=schedules.getYears()%>" style="background-color: #ffffee" readonly>
									</div>
								</div>
	
								<br>
	
								<div class="form-group row">
									<label class="col-sm-3 col-form-label text-right">วันอัปโหลดเอกสารรายงาน</label>
									<div class="col-sm-3">
										<input type="datetime-local" class="form-control"
											id="uploaddate" name="uploaddate" value="<%=schedules.getUploaddate()%>" style="background-color: #ffffee" required="required">
									</div>
									<label class="col-sm-3 col-form-label text-right">วันสิ้นสุดอัปโหลดเอกสารรายงาน</label>
									<div class="col-sm-3">
										<input type="datetime-local" class="form-control"
											id="expuploaddate" name="expuploaddate" value="<%=schedules.getExpuploaddate()%>" style="background-color: #ffffee" required="required">
									</div>
								</div>

								<br>

								<div class="form-group row">
									<label class="col-sm-3 col-form-label text-right">วันเริ่มประเมินโครงงานวิทยาศาสตร์</label>
									<div class="col-sm-3">
										<input type="datetime-local" class="form-control"
											id="reviewdate" name="reviewdate" value="<%=schedules.getReviewdate()%>" style="background-color: #ffffee" required="required">
									</div>
									<label class="col-sm-3 col-form-label text-right">วันสิ้นสุดประเมินโครงงานวิทยาศาสตร์</label>
									<div class="col-sm-3">
										<input type="datetime-local" class="form-control"
											id="expreviewdate" name="expreviewdate" value="<%=schedules.getExpreviewdate()%>" style="background-color: #ffffee" required="required">
									</div>
								</div>

								<br>

								<div class="form-group row">
									<label class="col-sm-3 col-form-label text-right">วันประกาศผลรางวัล</label>
									<div class="col-sm-3">
										<input type="datetime-local" class="form-control"
											id="announcedate" name="announcedate" value="<%=schedules.getAnnouncedate()%>" style="background-color: #ffffee" required="required">
									</div>
								</div>

								<br>

								<div class="form-group row">
									<div class="col-sm-12 text-center">
										<button type="submit" class="btn btn-success" onclick="return validateForm(frm)">บันทึก</button>
										<a class="btn btn-danger" href="doViewSchedule" role="button">ยกเลิก</a>
									</div>
								</div>

							</form>

						</div>
					</div>
				</div>
			</div>
		</section>
	</div>

	<jsp:include page="common/footer.jsp"></jsp:include>

</body>
</html>
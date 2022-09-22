<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<script src="//cdn.ckeditor.com/4.6.2/standard/ckeditor.js"></script>
<link href="./image/logo.png" rel="icon">
<link rel="stylesheet"	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/e18a64822c.js"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Kanit'	rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="./css/web_css.css">
<link rel="stylesheet" href="./css/rte_theme_default.css">

<script	src="./js/all_plugins.js"></script>
<script	src="./js/patch.js"></script>
<script	src="./js/rte.js"></script>
</head>
<body style="background-image: url('./image/hero-bg.png')">

	<jsp:include page="common/navbar.jsp"></jsp:include>

	<div class="container" style="margin-top: 35px;">

		<form action="addnews" method="POST" enctype="multipart/form-data" name="addform" class="form-horizontal" id="addform">
			<section id="content" >
				<div class="container">
					<div class="row">
						<div class="col-lg-12">
							<div class="container">
								<h3>เพิ่มข่าวสาร</h3>
								<hr class="colorgraph">
								
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">หัวข้อข่าว</label>
									<div class="col-sm-8">
										<input type="text" name="title" id="title" class="form-control data">
									</div>
								</div>
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">ประเภท</label>
									<div class="col-sm-8">
										<select class="form-control" name="type" id="type" required>
											<option selected disabled >--กรุณาเลือกประเภท--</option>
											<option value="ข่าวกิจกรรม.">ข่าวกิจกรรม</option>
											<option value="ข่าวจากแหล่งอื่น">ข่าวจากแหล่งอื่น</option>
											<option value="ข่าวสารประชาสัมพันธ์">ข่าวสารประชาสัมพันธ์</option>											
										</select>
									</div>
								</div>


								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">รายละเอียด</label>
									<div class="col-sm-8" align="left">
										<textarea name="article_detail" id="div_editor1" rows="10" cols="60"></textarea>
										<script type="text/javascript">
											var editor1 = new RichTextEditor("#div_editor1");
										</script>
									</div>
								</div>
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">รูปภาพปก</label>
									<div class="col-sm-8" align="left">
										<input type="file" name="img" id="img" accept=".png" required>
									</div>
								</div>


								<div class="form-group row">
									<div class="col-sm-2"></div>
									<div class="col-sm-6">
										<button type="submit" class="btn btn-success" id="btn">บันทึก</button>
										<a href="doViewNews" class="btn btn-danger">ยกเลิก</a>
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
	
</body>
</html>
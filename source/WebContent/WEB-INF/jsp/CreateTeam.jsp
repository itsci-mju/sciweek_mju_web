<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "bean.* , util.* , java.util.*, manager.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%
	Admin admin = null;
	List<Reviewer> listreviewer = new Vector<>();
	List<Team> teamList = new Vector<>();
	try {
		admin = (Admin) session.getAttribute("admin");
	} catch (Exception e) {
		e.printStackTrace();
	}
		
	try {
		listreviewer = (List<Reviewer>) request.getAttribute("listreviewer");
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
<style type="text/css">
.container1 {
  padding: 50px 10%;
}

.box {
  position: relative;
  background: #FCFAF1;
  width: 100%;
}

.box-header {
  color: #444;
  display: block;
  padding: 10px;
  position: relative;
  border-bottom: 1px solid #f4f4f4;
  margin-bottom: 10px;
}

.box-tools {
  position: absolute;
  right: 10px;
  top: 5px;
}

.dropzone-wrapper {
  border: 2px dashed #91b0b3;
  color: #92b0b3;
  position: relative;
  height: 150px;
}

.dropzone-desc {
  position: absolute;
  margin: 0 auto;
  left: 0;
  right: 0;
  text-align: center;
  width: 40%;
  top: 50px;
  font-size: 16px;
}

.dropzone,
.dropzone:focus {
  position: absolute;
  outline: none !important;
  width: 50%;
  height: 150px;
  cursor: pointer;
  opacity: 0;
  
}

.dropzone-wrapper:hover,
.dropzone-wrapper.dragover {
  background: #ecf0f5;
}

.preview-zone {
  text-align: center;
}

.preview-zone .box {
  box-shadow: none;
  border-radius: 0;
  margin-bottom: 0;
}

</style>
</head>

<script type="text/javascript">

	function validateImportForm(frmexcel) {
		
		if (frmexcel.fileexcel.value == "") {
			alert("<!-- กรุณาอัปโหลดไฟล์ Excel -->");
			return false;
		}

	}
		
</script>
<script type="text/javascript">
	function validateForm(frm) {

		if (frm.team_name.value == "") {
			alert("<!-- กรุณาเลือกกลุ่ม --> ");
			return false;
		}

		var checkBox = document.getElementById('chkreviewer');

		if (checkBox.checked === false) {
			alert("<!-- กรุณาเลือกประธานคณะกรรมการและคณะกรรมการ --> ");
			return false;
		}

	}
</script>
<body style="background-image: url('./image/hero-bg.png')">
	<jsp:include page="common/navbar.jsp"></jsp:include>

	<div class="container" style="margin-top: 35px;">
		<div class="row">
			<div class="col-lg-12">
				<h3><i class="fa-solid fa-clipboard-list">&nbsp;</i>สร้างทีม</h3>

				<hr class="colorgraph">
				<br>
				
				<div class="container">
					<form action="ImportReviewer" id="frmexcel" method="post" class="row g-3" enctype="multipart/form-data">
						<section id="content">
							<div class="container" style="margin-top: -20px">
								<div class="row">
									<div class="col-lg-12">
										<div class="container">
											<br>
											<div class="form-group" align="center">
												<div class="col-sm-6">
													<div class="preview-zone hidden">
														<div class="box box-solid">
															<div class="box-header with-border">
																<div class="box-tools pull-right"></div>
															</div>
															<div class="box-body"></div>
														</div>
														<br>
													</div>

													<div class="dropzone-wrapper">
														<div class="dropzone-desc">
															<i class="glyphicon glyphicon-download-alt"></i>
															<p>
																<i class='fa-solid fa-file-excel' style='font-size: 36px'></i>
															</p>
															<p>เลือกไฟล์หรือลากมาที่นี่.</p>
														</div>
														<input type="file" name="fileexcel" id="fileexcel" class="dropzone" accept=".csv, application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
													</div>
												</div>
											</div>
											<script src="assets/app.js"></script>
											<script>
												function readFile(input) {
													if (input.files
															&& input.files[0]) {
														var reader = new FileReader();

														reader.onload = function(
																e) {
															var htmlPreview = '<img width="200" src="' + e.target.result + '" />'
																	+ '<p>'
																	+ input.files[0].name
																	+ '</p>';
															var wrapperZone = $(
																	input)
																	.parent();
															var previewZone = $(
																	input)
																	.parent()
																	.parent()
																	.find(
																			'.preview-zone');
															var boxZone = $(
																	input)
																	.parent()
																	.parent()
																	.find(
																			'.preview-zone')
																	.find(
																			'.box')
																	.find(
																			'.box-body');

															wrapperZone
																	.removeClass('dragover');
															previewZone
																	.removeClass('hidden');
															boxZone.empty();
															boxZone
																	.append(htmlPreview);
														};

														reader
																.readAsDataURL(input.files[0]);
													}
												}

												function reset(e) {
													e.wrap('<form>').closest(
															'form').get(0)
															.reset();
													e.unwrap();
												}

												$(".dropzone").change(
														function() {
															readFile(this);
														});

												$('.dropzone-wrapper')
														.on(
																'dragover',
																function(e) {
																	e
																			.preventDefault();
																	e
																			.stopPropagation();
																	$(this)
																			.addClass(
																					'dragover');
																});

												$('.dropzone-wrapper')
														.on(
																'dragleave',
																function(e) {
																	e
																			.preventDefault();
																	e
																			.stopPropagation();
																	$(this)
																			.removeClass(
																					'dragover');
																});

												$('.remove-preview')
														.on(
																'click',
																function() {
																	var boxZone = $(
																			this)
																			.parents(
																					'.preview-zone')
																			.find(
																					'.box-body');
																	var previewZone = $(
																			this)
																			.parents(
																					'.preview-zone');
																	var dropzone = $(
																			this)
																			.parents(
																					'.form-group')
																			.find(
																					'.dropzone');
																	boxZone
																			.empty();
																	previewZone
																			.addClass('hidden');
																	reset(dropzone);
																});
											</script>

											<script>
												$(document)
														.ready(
																function() {
																	$(
																			'.customer-logos')
																			.slick(
																					{
																						slidesToShow : 6,
																						slidesToScroll : 1,
																						autoplay : true,
																						autoplaySpeed : 1500,
																						arrows : false,
																						dots : false,
																						pauseOnHover : false,
																						responsive : [
																								{
																									breakpoint : 768,
																									settings : {
																										slidesToShow : 4
																									}
																								},
																								{
																									breakpoint : 520,
																									settings : {
																										slidesToShow : 3
																									}
																								} ]
																					});
																});
											</script>



											<br>
											<br>
											<div class="form-group row">
												<div class="col-sm-12 text-center">
													<button type="submit" class="btn btn-success" onclick ="return validateImportForm(frmexcel)" >นำเข้าข้อมูลคณะกรรมการ</button>										
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</section>
					</form>
				</div>
				
				<hr class="colorgraph">
				<br>
				<form action="isCreateTeam" name="frm" id="frm" method="post">
					<div class="form-group row">
						<label class="col-sm-2 col-form-label text-right">กลุ่ม</label>
						<div class="col-sm-6">
							<select class="form-select" name="team_name" id="team_name" required>
								<option value="" selected>--กรุณาเลือกกลุ่ม--</option>
								<option value="มัธยมศึกษาตอนต้นสาขาวิทยาศาสตร์กายภาพ">มัธยมศึกษาตอนต้นสาขาวิทยาศาสตร์กายภาพ</option>
								<option value="มัธยมศึกษาตอนต้นสาขาวิทยาศาสตร์ชีวภาพ">มัธยมศึกษาตอนต้นสาขาวิทยาศาสตร์ชีวภาพ</option>
								<option value="มัธยมศึกษาตอนต้นสาขาวิทยาศาสตร์ประยุกต์">มัธยมศึกษาตอนต้นสาขาวิทยาศาสตร์ประยุกต์</option>
								<option value="มัธยมศึกษาตอนปลายสาขาวิทยาศาสตร์กายภาพ">มัธยมศึกษาตอนปลายสาขาวิทยาศาสตร์กายภาพ</option>
								<option value="มัธยมศึกษาตอนปลายสาขาวิทยาศาสตร์ชีวภาพ">มัธยมศึกษาตอนปลายสาขาวิทยาศาสตร์ชีวภาพ</option>
								<option value="มัธยมศึกษาตอนปลายสาขาวิทยาศาสตร์ประยุกต์">มัธยมศึกษาตอนปลายสาขาวิทยาศาสตร์ประยุกต์</option>
							</select>
						</div>
					</div>

					<br>
					<div class="container">
						<div class="form-group row">
							<div class="col-auto">
								<h5>ประธานคณะกรรมการ</h5>
							</div>
							<div class="col-auto" style="margin-left: 67%;">
								<a href="getAddReviewer" class="btn btn-warning"><i
									class="fa-solid fa-user-tie">&nbsp;</i>ลงทะเบียนคณะกรรมการ</a>
							</div>
						</div>
					</div>
					<hr class="colorgraph">
					<table class="table table-bordered  table-hover" id=myTable>
						<thead class="table-info" align="center">
							<tr>
								<th width="55"></th>
								<th width="250">รหัสคณะกรรมการ</th>
								<th>ชื่อคณะกรรมการ</th>
								<th width="55"></th>
							</tr>
						</thead>
						<tbody align="center">
							<%
								if (listreviewer.size() != 0) {
							%>
							<%
								for (int i = 0; i < listreviewer.size(); i++) {

										if (listreviewer.get(i).getTeam().getTeam_id() == 0
												&& listreviewer.get(i).getPosition().equals("ประธานคณะกรรมการ")) {
							%>
							<tr>
								<td><input type="checkbox" id="chkreviewer" name="chkreviewer" value="<%=listreviewer.get(i).getReviewer_id()%>"></td>
								<td><%=listreviewer.get(i).getReviewer_id()%></td>
								<td><%=listreviewer.get(i).getPrefix() + "  " + listreviewer.get(i).getFirstname() + "  " + listreviewer.get(i).getLastname()%></td>
								<td>
									<a href="ViewReviewerDetail?reviewer_id=<%=listreviewer.get(i).getReviewer_id()%>" class="btn btn-warning"> 
										<i class="fa fa-eye" aria-hidden="true"></i>
									</a>
								</td>
							</tr>
							<%
								}
									}
							%>
							<%
								} else {
							%>
							<tr align="center">
								<td colspan="5"><h2>ไม่มีข้อมูล</h2></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>

					<br>
					<div class="container">
						<div class="form-group row">
							<h5>คณะกรรมการ</h5>
						</div>
					</div>
					<hr class="colorgraph">
					<table class="table table-bordered  table-hover" id=myTable>
						<thead class="table-info" align="center">
							<tr>
								<th width="55"></th>
								<th width="270">รหัสคณะกรรมการ</th>
								<th>ชื่อคณะกรรมการ</th>
								<th width="55"></th>
							</tr>
						</thead>
						<tbody align="center">
							<%
								if (listreviewer.size() != 0) {
							%>
							<%
								for (int i = 0; i < listreviewer.size(); i++) {

										if (listreviewer.get(i).getTeam().getTeam_id() == 0
												&& listreviewer.get(i).getPosition().equals("คณะกรรมการ")) {
							%>
							<tr>
								<td><input type="checkbox" id="chkreviewer" name="chkreviewer" value="<%=listreviewer.get(i).getReviewer_id()%>"></td>
								<td><%=listreviewer.get(i).getReviewer_id()%></td>
								<td><%=listreviewer.get(i).getPrefix() + "  " + listreviewer.get(i).getFirstname() + "  " + listreviewer.get(i).getLastname()%></td>
								<td>
									<a href="ViewReviewerDetail?reviewer_id=<%=listreviewer.get(i).getReviewer_id()%>" class="btn btn-warning">
										<i class="fa fa-eye" aria-hidden="true"></i>
									</a>
								</td>
							</tr>
							<%
								}
									}
							%>
							<%
								} else {
							%>
							<tr align="center">
								<td colspan="5"><h2>ไม่มีข้อมูล</h2></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>

					<br>

					<div class="form-group row">
						<div class="col-sm-12 text-center">
							<button type="submit" class="btn btn-success" onclick="return validateForm(frm)">ต่อไป</button>
							<a class="btn btn-danger" href="doViewTeam" role="button">ยกเลิก</a>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<jsp:include page="common/footer.jsp"></jsp:include>

	<c:if test="${msg != null }">
		<script type="text/javascript">
			var msg = '${msg}';
			alert(msg);
		</script>
	</c:if>

	<script type="text/javascript">
		$(document).ready(
				function() {
					$('#myTable2').after(
							'<div id="nav" class="pagination"></div>');
					var rowsShown = 12;
					var rowsTotal = $('#myTable2 tbody tr').length;
					var numPages = rowsTotal / rowsShown;
					for (i = 0; i < numPages; i++) {
						var pageNum = i + 1;
						$('#nav')
								.append(
										'<a href="#" rel="'+i+'" >' + pageNum
												+ '</a> ');
					}
					$('#myTable2 tbody tr').hide();
					$('#myTable2 tbody tr').slice(0, rowsShown).show();
					$('#nav a:first').addClass('active');
					$('#nav a').bind(
							'click',
							function() {
								$('#nav a').removeClass('active');
								$(this).addClass('active');
								var currPage = $(this).attr('rel');
								var startItem = currPage * rowsShown;
								var endItem = startItem + rowsShown;
								$('#myTable2 tbody tr').css('opacity', '0.0')
										.hide().slice(startItem, endItem).css(
												'display', 'table-row')
										.animate({
											opacity : 1
										}, 300);
							});
				});
	</script>

</body>
</html>
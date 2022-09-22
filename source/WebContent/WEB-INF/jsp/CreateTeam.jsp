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
</head>
<body style="background-image: url('./image/hero-bg.png')">
	<jsp:include page="common/navbar.jsp"></jsp:include>
	
	<div class="container" style="margin-top: 35px;">
				<div class="row">
						<div class="col-lg-12">
						
							<form action="ImportReviewer" method="post" class="row g-3" enctype="multipart/form-data">
								<div class="col-auto">
									<h3><i class="fa-solid fa-clipboard-list">&nbsp;</i>สร้างทีม</h3>
								</div>
								<div class="col-auto text-center" style="margin-left: 559px;">
									<input class="form-control" type="file" name="fileexcel" id="fileexcel" accept=".csv, application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
								</div>
								<div class="col-auto text-left">
									<button type="submit" name="upload" class="btn btn-success"><i class="fa-solid fa-file-excel">&nbsp;</i>Import Reviewer Data</button>
								</div>
							</form>
							<hr class="colorgraph">
								<br>
								<form action="isCreateTeam" name="frm" method="post" >
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">กลุ่ม</label>
									<div class="col-sm-6">									
										<select class="form-select" name="team_name" id="team_name" required>
											<option selected disabled >--กรุณาเลือกกลุ่ม--</option>
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
										<div class="col-auto" style="margin-left: 909px;">
											<a href="getAddReviewer" class="btn btn-warning" ><i class="fa-solid fa-user-tie">&nbsp;</i>เพิ่มคณะกรรมการ</a>
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
												if(listreviewer.get(i).getTeam().getTeam_id() == 0 && listreviewer.get(i).getPosition().equals("ประธานคณะกรรมการ")) {
										%>
										<tr>		
											<td><input type="checkbox" id="chkreviewer" name="chkreviewer" value="<%=listreviewer.get(i).getReviewer_id()%>"></td>														
											<td><%=listreviewer.get(i).getReviewer_id()%></td>
											<td><%=listreviewer.get(i).getPrefix() + "  " + listreviewer.get(i).getFirstname() + "  " + listreviewer.get(i).getLastname()%></td>
											<td><a href="ViewReviewerDetail?reviewer_id=<%=listreviewer.get(i).getReviewer_id()%>" class="btn btn-warning">
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
												if(listreviewer.get(i).getTeam().getTeam_id() == 0 && listreviewer.get(i).getPosition().equals("คณะกรรมการ")) {
										%>
										<tr>			
											<td><input type="checkbox" id="chkreviewer" name="chkreviewer" value="<%=listreviewer.get(i).getReviewer_id()%>"></td>																		
											<td><%=listreviewer.get(i).getReviewer_id()%></td>
											<td><%=listreviewer.get(i).getPrefix() + "  " + listreviewer.get(i).getFirstname() + "  " + listreviewer.get(i).getLastname()%></td>
											<td><a href="ViewReviewerDetail?reviewer_id=<%=listreviewer.get(i).getReviewer_id()%>" class="btn btn-warning">
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
										<button type="submit" class="btn btn-success">ต่อไป</button>
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
					$('#myTable2').after('<div id="nav" class="pagination"></div>');
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
										.hide().slice(startItem, endItem).css('display', 'table-row')
										.animate({
											opacity : 1
										}, 300);
							});
				});
	</script>
	
</body>
</html>
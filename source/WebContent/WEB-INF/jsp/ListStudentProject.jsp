<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*"%>
<%
	Admin admin = null;
	List<StudentProject> listsproject = new Vector<>();
	String keyword = "";
	
	try {
		admin = (Admin) session.getAttribute("admin");
	} catch (Exception e) {
		e.printStackTrace();
	}

	try {
		listsproject = (List<StudentProject>) request.getAttribute("listsproject");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try {
		keyword = (String) request.getAttribute("keyword");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	if (keyword == null) {
		keyword = "";
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
	
		<form action="searchproject" method="post" class="row g-3" >
			<div class="col-auto">
				<h3><i class="fa-solid fa-folder-open">&nbsp;</i>นำเข้าข้อมูลโครงงานวิทยาศาสตร์</h3>			
			</div>	
			<div class="col-auto text-center" style="margin-left : 529px;">
					<input type="text" class="form-control" name="keyword" value="<%=keyword%>" placeholder="ค้นหาโครงงานวิทยาศาสตร์....." title="Projects">
			</div>
			<div class="col-auto text-left">
				<button type="submit" class="btn btn-success"> <i class="fa fa-search">&nbsp;</i>ค้นหา</button>
			</div>
		</form>	
		
		<hr class="colorgraph">
		
		<form action="ImportExcel" name="frm" method="post" enctype="multipart/form-data">
			<div class="form-group row">
				<div class="col-sm-4">
					<input class="form-control" type="file" name="fileexcel" id="fileexcel" accept=".csv, application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
				</div>		
				<div class="col-sm-3" >
					<button type="submit" name="upload" class="btn btn-success"><i class="fa-solid fa-file-excel">&nbsp;</i>นำเข้าข้อมูลโครงงาน</button>
				</div>
			</div>
		</form>
		
		<%
				if (listsproject.size() != 0) {
		%>
		
		<table class="table table-bordered  table-hover" id=myTable > 
			<thead class="table-info">
				<tr>
					<th style="white-space: nowrap">รหัสโครงงานวิทยาศาสตร์</th>
					<th style="white-space: nowrap">ชื่อโครงงานวิทยาศาสตร์</th>
					<th style="white-space: nowrap">ข้อมูลโครงงานวิทยาศาสตร์</th>
				</tr>
			</thead>
			<tbody>
				
				<%
					for (StudentProject studentProject : listsproject) {
						Project project = studentProject.getProject();
				%>
				<tr>
					<td><%=project.getProject_id()%></td>
					<td ><%=project.getProjectname()%></td>
					<td align="center"><a href="ViewStudentProjectDetail?project_id=<%=project.getProject_id()%>">
							<button name="button" class="btn btn-warning">
								<i class="fa fa-eye"></i>&nbsp;ดูรายละเอียด
							</button></a>
					</td>
				</tr>
				<%
					}
				%>
				<%
					} 
				%>		
			</tbody>
		</table>
	</div>

	<jsp:include page="common/footer.jsp"></jsp:include>

	<script type="text/javascript">
		$(document).ready(
				function() {
					$('#myTable').after(
							'<div id="nav" class="pagination" align="center"></div>');
					var rowsShown = 10;
					var rowsTotal = $('#myTable tbody tr').length;
					var numPages = rowsTotal / rowsShown;
					for (i = 0; i < numPages; i++) {
						var pageNum = i + 1;
						$('#nav')
								.append(
										'<a href="#" rel="'+i+'" >' + pageNum
												+ '</a> ');
					}
					$('#myTable tbody tr').hide();
					$('#myTable tbody tr').slice(0, rowsShown).show();
					$('#nav a:first').addClass('active');
					$('#nav a').bind(
							'click',
							function() {

								$('#nav a').removeClass('active');
								$(this).addClass('active');
								var currPage = $(this).attr('rel');
								var startItem = currPage * rowsShown;
								var endItem = startItem + rowsShown;
								$('#myTable tbody tr').css('opacity', '0.0')
										.hide().slice(startItem, endItem).css(
												'display', 'table-row')
										.animate({
											opacity : 1
										}, 300);
							});
				});
	</script>

	<c:if test="${msg != null }">
		<script type="text/javascript">
			var msg = '${msg}';
			alert(msg);
		</script>
	</c:if>
</body>
</html>
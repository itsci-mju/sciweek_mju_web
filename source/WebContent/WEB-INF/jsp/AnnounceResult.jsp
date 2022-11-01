<%@page import="model.StudentResponse"%>
<%@page import="model.StudentProjectResponse"%>
<%@page import="org.hibernate.query.criteria.internal.expression.function.AggregationFunction.MAX"%>
<%@page import="com.sun.xml.txw2.Document"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*,java.sql.Timestamp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	Admin admin = null;
	Schedules schedules = null;
	List<StudentProjectResponse> studentProjectResponseList = new Vector<>();
	Student student = null;
	Reviewer reviewer = null;

	try {
		reviewer = (Reviewer) session.getAttribute("reviewer");
	} catch (Exception e) {

	}

	try {
		student = (Student) session.getAttribute("student");
	} catch (Exception e) {

	}
	
	try {
		admin = (Admin) session.getAttribute("admin");
	} catch (Exception e) {

	}
	
	try {
		schedules = (Schedules) request.getAttribute("schedules");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try {
		studentProjectResponseList = (List<StudentProjectResponse>) request.getAttribute("studentProjectResponseList");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	Date date = new Date();  
	Timestamp timestamp = new Timestamp(date.getTime());  
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
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
<link rel="stylesheet" href="./css/index_css.css">
</head>
<body  style="background-image: url('./image/hero-bg.png') ; background-repeat: no-repeat ; background-attachment: fixed ; background-size: 100% 100%">

	<jsp:include page="common/navbar.jsp"></jsp:include>

	<div class="container" style="margin-top: 35px;">
		<div class="form-group row">
			<div class="col-auto">
				<h3><i class="fa-solid fa-trophy">&nbsp;</i>ผลรางวัล</h3>
			</div>	
			<!-- <div class="col-auto">
				<a href="ExportAnnounceExcel" class="btn btn-success mb-3" style="margin-left: 639px;"><i class="fa-solid fa-file-excel">&nbsp;</i>Export Files</a>
			</div> -->		
		</div>		
		<hr class="colorgraph">	
		<%String announce = "";%>
		ประกาศข้อมูล : <%=announce = new SimpleDateFormat("EEEE ที่ dd เดือน MMMM พ.ศ. yyyy เวลา hh:mm น.", new Locale("th", "TH")).format(schedules.getAnnouncedate())%>
		&nbsp;&nbsp; &nbsp;&nbsp; ที่มา : สัปดาห์วิทยาศาสตร์ คณะวิทยาศาสตร์ มหาวิทยาลัยแม่โจ้
		<br>			
	</div>
	
	<%
		if (schedules.getAnnouncedate() != null) {
	%>
						
		<%
			if (timestamp.after(schedules.getAnnouncedate())) {
		%>
						
		<div style="margin-top: 20px ; margin-left: 2% ; margin-right: 2% ;">
		<table class="table table-bordered  table-hover" id=myTable>
			<thead class="table-info" align="center">
				<tr>
					<th style="white-space: nowrap ; width: 90 " >รหัสโครงงาน</th>
					<th>ชื่อโครงงาน/สิ่งประดิษฐ์</th>			
					<th style="white-space: nowrap " colspan="3" >ชื่อผู้จัดทำ</th>
					<th style="white-space: nowrap " >ที่ปรึกษา</th>		
					<th style="white-space: nowrap " >โรงเรียน</th>		
					<th style="white-space: nowrap" >รางวัล</th>
				</tr>
			</thead>
				<% if (studentProjectResponseList.size() != 0) {	 %>
						<% for (int i = 0 ; i < studentProjectResponseList.size() ; i ++)  { %>
			<tbody style="font-size: 12px;">
				<tr>
					<td align="center" ><%=studentProjectResponseList.get(i).getProjectID()%></td>
					<td><%=studentProjectResponseList.get(i).getProjectName()%></td>
					<% 
						List<StudentResponse> studentList = studentProjectResponseList.get(i).getStudentResponseList();
							for (int x = 0 ; x < studentList.size() ; x++) {
					%>
					<td width="190" align="center" ><%=studentList.get(x).getStudentName()%></td>
					<% } %>
					<% 
						int round ;
						for (round = studentProjectResponseList.get(i).getStudentResponseList().size() ; round < 3 ; round++) {%>
						<td width="190" align="center"> - </td>
					<% } %>
					<td align="center" style="white-space: nowrap "><%=studentProjectResponseList.get(i).getAdvisorName()%></td>
					<td align="center" style="white-space: nowrap "><%=studentProjectResponseList.get(i).getSchoolName()%></td>
					<td align="center" style="white-space: nowrap "><%=studentProjectResponseList.get(i).getAwardProject()%></td>
				</tr>			
				<% } %>
				<% } else { %>
				<tr align="center">
					<td colspan="8" align="center"><h2>ไม่มีข้อมูล</h2></td>
				</tr>
				<% } %>
			</tbody>
		</table>
	</div>
	<% } %>
	
	<% } %>
	
	<jsp:include page="common/footer.jsp"></jsp:include>
	
	<script type="text/javascript">
		$(document).ready(
				function() {
					$('#myTable').after(
							'<div id="nav" class="pagination" ></div>');
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
	
</body>
</html>

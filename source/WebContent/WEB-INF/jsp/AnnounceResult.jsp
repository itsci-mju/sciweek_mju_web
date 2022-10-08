<%@page import="org.hibernate.query.criteria.internal.expression.function.AggregationFunction.MAX"%>
<%@page import="com.sun.xml.txw2.Document"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*, java.sql.Timestamp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	Admin admin = null;
	Years years = null;
	List<Project> listproject = new Vector<>();
	List<ProjectType> projectTypeList = new Vector<>();
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
		years = (Years) request.getAttribute("years");
	} catch (Exception e) {
		e.printStackTrace();
	}

	try {
		listproject = (List<Project>) request.getAttribute("listproject");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try {
		projectTypeList = (List<ProjectType>) request.getAttribute("projectTypeList");
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
</head>
<body style="background-image: url('./image/hero-bg.png')">

	<jsp:include page="common/navbar.jsp"></jsp:include>
	
	<div class="container" style="margin-top: 35px;">
		<div class="form-group row">
			<div class="col-auto">
				<h3><i class="fa fa-bullhorn" aria-hidden="true">&nbsp;</i>ผลสรุปการประเมินโครงงานวิทยาศาสตร์</h3>
			</div>	
			<!-- <div class="col-auto">
				<a href="ExportAnnounceExcel" class="btn btn-success mb-3" style="margin-left: 639px;"><i class="fa-solid fa-file-excel">&nbsp;</i>Export Files</a>
			</div> -->		
		</div>						
		
		<hr class="colorgraph">
		
		<% if (years.getAnnouncedate() != null) {%>
						
		<% if (timestamp.after(years.getAnnouncedate())) {%>
						
		<div class="form-group row" style="margin-left: 210px;">
		<%  for (int p = 0 ; p < projectTypeList.size() ; p++) { %>
		
			<% if (p == 0) { %>
			<div class="col-sm-3">
				<button name="button" class="btn btn-primary" onclick="window.location.href='isViewResult?projecttype_id=<%=projectTypeList.get(p).getProjecttype_id()%>';" >
					<i class="fa-sharp fa-solid fa-seedling">&nbsp;</i><%=projectTypeList.get(p).getProjecttype_name()%>
				</button>	
			</div>
			<% } %>
			
			<% if (p == 1) { %>
			<div class="col-sm-3">
				<button name="button" class="btn btn-success" onclick="window.location.href='isViewResult?projecttype_id=<%=projectTypeList.get(p).getProjecttype_id()%>';" >
					<i class="fa-sharp fa-solid fa-frog">&nbsp;</i><%=projectTypeList.get(p).getProjecttype_name()%>
				</button>
			</div>
			<% } %>
			
			<% if (p == 2) { %>
			<div class="col-sm-3">
				<button name="button" class="btn btn-info" onclick="window.location.href='isViewResult?projecttype_id=<%=projectTypeList.get(p).getProjecttype_id()%>';" >
					<i class="fa-solid fa-bolt">&nbsp;</i><%=projectTypeList.get(p).getProjecttype_name()%>
				</button>		
			</div>
			<% } %>	
			
		<% } %>		
		</div>
		
		<div class="form-group row" style="margin-left: 210px;">
		<%  for (int p = 3 ; p < projectTypeList.size() ; p++) { %>
		
		<% if (p == 3) { %>
			<div class="col-sm-3" >
				<button name="button" class="btn btn-danger" onclick="window.location.href='isViewResult?projecttype_id=<%=projectTypeList.get(p).getProjecttype_id()%>';" style="color:white">
					<i class="fa-solid fa-atom">&nbsp;</i><%=projectTypeList.get(p).getProjecttype_name()%>
				</button>	
			</div>
			<% } %>
			
			<% if (p == 4) { %>
			<div class="col-sm-3">
				<button name="button" class="btn btn-warning" onclick="window.location.href='isViewResult?projecttype_id=<%=projectTypeList.get(p).getProjecttype_id()%>';" >
					<i class="fa-sharp fa-solid fa-hippo">&nbsp;</i><%=projectTypeList.get(p).getProjecttype_name()%>
				</button>
			</div>
			<% } %>
			
			<% if (p == 5) { %>
			<div class="col-sm-3">
				<button name="button" class="btn btn-secondary" onclick="window.location.href='isViewResult?projecttype_id=<%=projectTypeList.get(p).getProjecttype_id()%>';" >
					<i class="fa-solid fa-computer">&nbsp;</i><%=projectTypeList.get(p).getProjecttype_name()%>
				</button>		
			</div>	
		</div>
		<% } %>	
		
	<% } %>	
	</div>

		<div style="margin-top: 15px ; margin-left: 6% ; margin-right: 6% ;">
		<table class="table table-bordered  table-hover" id=myTable>
			<thead class="table-info" align="center">
				<tr>
					<th style="white-space: nowrap ; width: 90 " >รหัสโครงงานวิทยาศาสตร์</th>
					<th>ชื่อโครงงานวิทยาศาสตร์</th>
					<th style="white-space: nowrap " >โรงเรียน</th>			
					<th style="white-space: nowrap" >รางวัล</th>
				</tr>
			</thead>
				<%							
					if (listproject.size() != 0) {	
						
						for (int i = 0 ; i < listproject.size() ; i ++)  {	
							
							String project_id = listproject.get(i).getProject_id() ;
							
							AnnounceResultManager announceResultManager = new AnnounceResultManager();
					
							List<StudentProject> studentProjectList = announceResultManager.getListStudentProjectByProjectID(project_id);
				%>
				
			<tbody>
				<tr>
					<td align="center"><%=listproject.get(i).getProject_id()%></td>
					<td><%=listproject.get(i).getProjectname()%></td>
					<% for (StudentProject studentProject : studentProjectList) { %>
					<td align="left" style="white-space: nowrap " ><%=studentProject.getStudent().getSchool().getSchool_name()%></td>
					<% } %>
					<td align="center" style="white-space: nowrap "><%=listproject.get(i).getAward()%></td>
				</tr>			
				<%										
						}
	
					} else {
				%>
				<tr align="center">
					<td colspan="5"><h2>ไม่มีข้อมูล</h2></td>
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
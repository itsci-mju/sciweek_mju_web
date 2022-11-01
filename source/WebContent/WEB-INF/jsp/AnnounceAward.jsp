<%@page import="org.hibernate.query.criteria.internal.expression.function.AggregationFunction.MAX"%>
<%@page import="com.sun.xml.txw2.Document"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*, java.sql.Timestamp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	Admin admin = null;
	List<Project> listproject = new Vector<>();
	List<ProjectType> projectTypeList = new Vector<>();
	
	try {
		admin = (Admin) session.getAttribute("admin");
	} catch (Exception e) {

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
			
	// position	
		if (frm.position.value == "") {
			alert("<!-- กรุณาเลือกประเภทโครงงานวิทยาศาสตร์ --> ");
			return false;
		}
	
	}
</script>
<body  style="background-image: url('./image/hero-bg.png') ; background-repeat: no-repeat ; background-attachment: fixed ; background-size: 100% 100%">

	<jsp:include page="common/navbar.jsp"></jsp:include>

	<div class="container" style="margin-top: 35px;">
		<div class="form-group row">
			<div class="col-auto">
				<h3>
					<i class="fa fa-bullhorn" aria-hidden="true">&nbsp;</i>ประกาศผลรางวัล
				</h3>
			</div>
		</div>
		<hr class="colorgraph">
		<div class="alert alert-danger" role="alert" style="text-align:center; font-weight:bold;">
  			ชี้แจ้ง : กรุณาเลือกประเภทโครงงานวิทยาศาสตร์..
		</div>
		
		<br>
		
	<form action="searchtypeproject" id="frm" method="post" class="row g-3">
		<div class="form-group row">
			<label class="col-sm-2 col-form-label text-right">ประเภทโครงงานวิทยาศาสตร์</label>
			<div class="col-sm-4">
				<select class="form-select" name="position" id="position">
					<option selected disabled>--กรุณาเลือกประเภทโครงงานวิทยาศาสตร์--</option>
					<% for (ProjectType projectType : projectTypeList) { %>
					<option value="<%=projectType.getProjecttype_id()%>"><%=projectType.getProjecttype_name()%></option>
					<% } %>
				</select>
			</div>
			<div class="col-sm-1">
				<button type="submit" class="btn btn-success" onclick="return validateForm(frm)">
					<i class="fa fa-search">&nbsp;</i>ค้นหา
				</button>
			</div>
		</div>
	</form>

	</div>

	


	<div style="margin-top: 15px ; margin-left: 6% ; margin-right: 6% ;">
		<form action="isAnnouces" name="frm" id="frm" method="post">
			<table class="table table-bordered  table-hover" id=myTable>
				<thead class="table-info" align="center">
					<tr>
						<th style="width: 90">รหัสโครงงาน</th>
						<th>ชื่อโครงงาน/สิ่งประดิษฐ์</th>
						<th style="white-space: nowrap">โรงเรียน</th>
						<th style="white-space: nowrap">คะแนน</th>
						<th style="white-space: nowrap">รางวัล</th>
					</tr>
				</thead>
				<%							
					if (listproject.size() != 0) {	
						
						for (int i = 0 ; i < listproject.size() ; i ++)  {	
							
							String project_id = listproject.get(i).getProject_id() ;				
							
							AnnounceResultManager announceResultManager = new AnnounceResultManager();
					
							List<Student> studentList = announceResultManager.getListStudentProjectByProjectID(project_id);
				%>

				<input type="hidden" name="project_id" id="project_id" class="form-control data" value="<%=project_id%>">

				<tbody>
					<tr>
						<td align="center"><%=listproject.get(i).getProject_id()%></td>
						<td><%=listproject.get(i).getProjectname()%></td>
						<% for (Student student : studentList) { %>
						<td align="center" style="white-space: nowrap"><%=student.getSchool().getSchool_name()%></td>
						<% } %>
						<td align="center" style="white-space: nowrap"><%=listproject.get(i).getAvgscore()%></td>
						<td align="center" style="white-space: nowrap"><%=listproject.get(i).getAward()%></td>
					</tr>
					<%										
						}
						
					} else {
				%>
					<tr align="center">
						<td colspan="5"><h2>กรุณาเลือกประเภทโครงงานวิทยาศาสตร์</h2></td>
					</tr>
					<% } %>
				</tbody>
			</table>

			<div class="form-group row">
				<div class="col-sm-12 text-center">
					<button type="submit" class="btn btn-success">ประกาศ</button>
					<a class="btn btn-danger" href="index" role="button">ยกเลิก</a>
				</div>
			</div>
			
		</form>
	</div>


	<jsp:include page="common/footer.jsp"></jsp:include>
	
	

</body>
</html>
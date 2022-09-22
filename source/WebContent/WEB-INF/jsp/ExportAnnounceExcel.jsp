<%@page import="com.sun.xml.txw2.Document"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	Admin admin = null;
	List<Project> listproject = new Vector<>();
	
	try {
		admin = (Admin) session.getAttribute("admin");
	} catch (Exception e) {

	}
	
	try {
		listproject = (List<Project>) request.getAttribute("listproject");
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

<%response.setContentType("application/vnd.ms-excel"); %> 
<%response.setHeader("Content-Disposition", "inline; filename=ExportResultFile.xls"); %>

	<div class="container" style="margin-top: 35px;">
	
		<div class="container">
			<div class="form-group row">
				<h3><i class="fa fa-bullhorn" aria-hidden="true">&nbsp;</i>ผลสรุปการประเมินโครงงานวิทยาศาสตร์</h3>				
			</div>						
		</div>
		
		<hr class="colorgraph">
		
		<div class="form-group row" style="margin-left: 210px;">
			<div class="col-sm-3">
				<button name="button" class="btn btn-primary" onclick="window.location.href='isViewResult?classproject=มัธยมศึกษาตอนต้น&projecttype_id=1';" >
					<i class="fa-sharp fa-solid fa-seedling">&nbsp;</i>มัธยมศึกษาตอนต้นสาขาวิทยาศาสตร์กายภาพ
				</button>	
			</div>
			<div class="col-sm-3">
				<button name="button" class="btn btn-success" onclick="window.location.href='isViewResult?classproject=มัธยมศึกษาตอนต้น&projecttype_id=2';" >
					<i class="fa-sharp fa-solid fa-frog">&nbsp;</i>มัธยมศึกษาตอนต้นสาขาวิทยาศาสตร์ชีวภาพ
				</button>
			</div>
			<div class="col-sm-3">
				<button name="button" class="btn btn-info" onclick="window.location.href='isViewResult?classproject=มัธยมศึกษาตอนต้น&projecttype_id=3';" >
					<i class="fa-solid fa-bolt">&nbsp;</i>มัธยมศึกษาตอนต้นสาขาวิทยาศาสตร์ประยุกต์
				</button>		
			</div>			
		</div>
		
		<div class="form-group row" style="margin-left: 210px;">
			<div class="col-sm-3" >
				<button name="button" class="btn btn-warning" onclick="window.location.href='isViewResult?classproject=มัธยมศึกษาตอนปลาย&projecttype_id=1';" style="color:white">
					<i class="fa-solid fa-atom">&nbsp;</i>มัธยมศึกษาตอนปลายสาขาวิทยาศาสตร์กายภาพ
				</button>	
			</div>
			<div class="col-sm-3">
				<button name="button" class="btn btn-danger" onclick="window.location.href='isViewResult?classproject=มัธยมศึกษาตอนปลาย&projecttype_id=2';" >
					<i class="fa-sharp fa-solid fa-hippo">&nbsp;</i>มัธยมศึกษาตอนปลายสาขาวิทยาศาสตร์ชีวภาพ</button>
			</div>
			<div class="col-sm-3">
				<button name="button" class="btn btn-dark" onclick="window.location.href='isViewResult?classproject=มัธยมศึกษาตอนปลาย&projecttype_id=3';" >
					<i class="fa-solid fa-computer">&nbsp;</i>มัธยมศึกษาตอนปลายสาขาวิทยาศาสตร์ประยุกต์</button>		
			</div>	
		</div>
		
	</div>

		
		<div style="margin-top: 15px ; margin-left: 6% ; margin-right: 6% ;">
		<table class="table table-bordered  table-hover" id=myTable>
			<thead class="table-info" align="center">
				<tr>
					<th style="white-space: nowrap ; width: 90 " >รหัสโครงงานวิทยาศาสตร์</th>
					<th>ชื่อโครงงานวิทยาศาสตร์</th>
					<th  style="white-space: nowrap " >โรงเรียน</th>
					<th  style="white-space: nowrap" >คะแนน</th>				
					<th style="white-space: nowrap" >รางวัล</th>
				</tr>
			</thead>
				<%
					String award = null ;
					
					if (listproject != null) {	
						
						for (int i = 0 ; i < listproject.size() ; i ++)  {	
							
							String project_id = listproject.get(i).getProject_id() ;
							
							AnnounceResultManager announceResultManager = new AnnounceResultManager();
					
							List<StudentProject> studentProjectList = announceResultManager.getListStudentProjectByProjectID(project_id);
											
							int rank = i + 1 ;
							
							if (listproject.get(i).getAvgscore() <= 0.0) {
								award = "ยังไม่มีรางวัล";	
							} else {
								if (rank ==  1) {
									award = "รางวัลชนะเลิศอันดับที่ 1" ;
								} else if (rank == 2) {
									award = "รางวัลรองชนะเลิศอันดับที่ 1" ;
								} else if (rank == 3) {
									award = "รางวัลรองชนะเลิศอันดับที่ 2" ;
								} else {
									award = "รางวัลชมเชย" ;
								}	
							}
				%>
			<tbody>
				<tr>
					<td align="center"><%=listproject.get(i).getProject_id()%></td>
					<td><%=listproject.get(i).getProjectname()%></td>
					<% for (StudentProject studentProject : studentProjectList) { %>
					<td align="center"><%=studentProject.getStudent().getSchool().getSchool_name()%></td>
					<% } %>
					<td align="center"><%=listproject.get(i).getAvgscore()%></td>
					<td align="center" ><%=award%></td>
				</tr>			
				<%	
						}
						
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
	</div>

</body>
</html>
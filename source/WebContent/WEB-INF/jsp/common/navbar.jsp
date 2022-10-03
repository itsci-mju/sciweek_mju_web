<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*,manager.*,bean.*"%>
<%
	Reviewer reviewer = null;
	Student student = null;
	Admin admin = null;

	try {
		student = (Student) session.getAttribute("student");
	} catch (Exception e) {

	}
	try {
		reviewer = (Reviewer) session.getAttribute("reviewer");
	} catch (Exception e) {

	}
	try {
		admin = (Admin) session.getAttribute("admin");
	} catch (Exception e) {

	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/e18a64822c.js"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href='https://fonts.googleapis.com/css?family=Kanit'	rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="./css/web_css.css">
</head>
<body>
	<div>
		<header>
			<div class="navbar navbar-default navbar-static-top">		
				<div class="navbar-header">
					<a class="navbar-brand" href="index"> <img src="./image/header-basic.png" class="hidden-xs" alt="" width="" height="100" style="margin-left: 5px;"></a>
				</div>
			</div>
		</header>
		<%
			if (reviewer == null && student == null && admin == null) {
		%>
		<div style="width: 100%; background-color: #FF9900;">
			<nav class="navbar navbar-expand-sm navbar-dark container">
				<ul class="navbar-nav">
					<li class="nav-item active "><a href="index" class="nav-link"><span style="color: white;"><i class="fa fa-home">&nbsp;</i>หน้าแรก</span></a></li>
					<li class="nav-item active"><a href="doViewResult" class="nav-link"><span style="color: white;"><i class="fa-solid fa-trophy">&nbsp;</i>รางวัล</span></a></li>	
				</ul>
				<div class="navbar-nav ml-auto">
					<div class="hidden-lg hidden-md hidden-sm">
						<div style="height: 40px; line-height: 40px; text-align: left">
						
						</div>
					</div>
				</div>
				<ul class="nav navbar-nav navbar-right">
					<li class="nav-item dropdown active">
						<a class="btn btn-success" href="${pageContext.request.contextPath}/loadlogin" role="button"><i class="fa fa-sign-in">&nbsp;</i>เข้าสู่ระบบ</a>				
					</li>
				</ul>
			</nav>
		</div>
		<%
			} else {
		%>

		<%
			if (student != null) {
		%>
		<div style="width: 100%; background-color: #FF9900;">
			<nav class="navbar navbar-expand-sm navbar-dark container">
				<ul class="navbar-nav">
					<li class="nav-item active"><a href="index" class="nav-link"><span style="color: white;"><i class="fa fa-home">&nbsp;</i>หน้าแรก</span></a></li>
					<li class="nav-item  active"><a href="doListProject" class="nav-link"><span style="color: white;"><i class="fa fa-th-list">&nbsp;</i>รายการโครงงานวิทยาศาสตร์</span></a></li>
					<li class="nav-item active"><a href="doViewResult" class="nav-link"><span style="color: white;"><i class="fa-solid fa-trophy">&nbsp;</i>รางวัล</span></a></li>	
				</ul>
				<div class="navbar-nav ml-auto">
					<div class="hidden-lg hidden-md hidden-sm">
						<div style="height: 40px; line-height: 40px; text-align: left">					
						</div>
					</div>
				</div>
				<ul class="nav navbar-nav navbar-right">
					<li class="nav-item dropdown active">
						<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 
							<span style="color: white;"><i class="fa fa-user">&nbsp;</i>ผู้ใช้งานระบบ : <%=student.getPrefix() + "  " + student.getFirstname() + "  " + student.getLastname()%></span> 
						</a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
							<a class="dropdown-item" href="getEditProfileStudent"><span style="color: black;"><i class="fa fa-address-card">&nbsp;</i>ข้อมูลส่วนตัว</span></a>
							<a class="dropdown-item" href="verifylogout"><span style="color: black;"><i class="fa fa-sign-out">&nbsp;</i>ออกจากระบบ</span></a>
						</div>				
					</li>							
				</ul>			
			</nav>
		</div>
		<%
			}
		%>

		<%
			if (reviewer != null && reviewer.getPosition().equals("ประธานคณะกรรมการ")) {
		%>
		<div style="width: 100%; background-color: #FF9900;">
			<nav class="navbar navbar-expand-sm navbar-dark container">
				<ul class="nav navbar-nav pull-center">		
					<li class="nav-item  active"><a href="doListScienceProject" class="nav-link"><span style="color: white;"><i class="fa fa-pencil-square-o">&nbsp;</i>ประเมินโครงงานวิทยาศาสตร์</span></a></li>
					<li class="nav-item  active"><a href="SummaryResult" class="nav-link"><span style="color: white;"><i class="fas fa-poll">&nbsp;</i>ผลการประเมินโครงงาน</span></a></li>
					<li class="nav-item  active"><a href="SummaryOfReviews" class="nav-link"><span style="color: white;"><i class="fas fa-poll-h">&nbsp;</i>สรุปผลรวมการประเมินโครงงาน</span></a></li>
				</ul>
				<div class="navbar-nav ml-auto">
					<div class="hidden-lg hidden-md hidden-sm">
						<div style="height: 40px; line-height: 40px; text-align: left">
						
						</div>
					</div>
				</div>
				<ul class="nav navbar-nav navbar-right">
					<li class="nav-item dropdown active">
						<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <span style="color: white;"><i class="fa fa-user">&nbsp;</i>ผู้ใช้งานระบบ : <%=reviewer.getPrefix() + "  " + reviewer.getFirstname()+ "  " + reviewer.getLastname()%></span> </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
							<a class="dropdown-item" href="getEditProfileReviewer"><span style="color: black;"><i class="fa fa-address-card">&nbsp;</i>ข้อมูลส่วนตัว</span></a> 
							<a class="dropdown-item" href="verifylogout"><span style="color: black;"><i class="fa fa-sign-out">&nbsp;</i>ออกจากระบบ</span></a>
						</div>
					</li>							
				</ul>											
			</nav>
		</div>
		<%
			} 
		%>
		<%
			if (reviewer != null && reviewer.getPosition().equals("คณะกรรมการ")) {
		%>
		<div style="width: 100%; background-color: #FF9900;">
			<nav class="navbar navbar-expand-sm navbar-dark container">
				<ul class="nav navbar-nav pull-center">		
					<li class="nav-item  active"><a href="doListScienceProject" class="nav-link"><span style="color: white;"><i class="fa fa-pencil-square-o">&nbsp;</i>ประเมินโครงงานวิทยาศาสตร์</span></a></li>
					<li class="nav-item  active"><a href="SummaryResult" class="nav-link"><span style="color: white;"><i class="fas fa-poll">&nbsp;</i>ผลการประเมินโครงงาน</span></a></li>
				</ul>
				<div class="navbar-nav ml-auto">
					<div class="hidden-lg hidden-md hidden-sm">
						<div style="height: 40px; line-height: 40px; text-align: left">
						
						</div>
					</div>
				</div>
				<ul class="nav navbar-nav navbar-right">
					<li class="nav-item dropdown active">
						<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <span style="color: white;"><i class="fa fa-user">&nbsp;</i>ผู้ใช้งานระบบ : <%=reviewer.getPrefix() + "  " + reviewer.getFirstname()+ "  " + reviewer.getLastname()%></span> </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
							<a class="dropdown-item" href="getEditProfileReviewer"><span style="color: black;"><i class="fa fa-address-card">&nbsp;</i>ข้อมูลส่วนตัว</span></a> 
							<a class="dropdown-item" href="verifylogout"><span style="color: black;"><i class="fa fa-sign-out">&nbsp;</i>ออกจากระบบ</span></a>
						</div>
					</li>							
				</ul>											
			</nav>
		</div>
		<%
			}
		%>
		
		<%
			if (admin != null) {
		%>
		<div style="width: 100%; background-color: #FF9900;">
			<nav class="navbar navbar-expand-sm navbar-dark container">
				<ul class="nav navbar-nav pull-center">
					<li class="nav-item  active "><a href="index" class="nav-link "><span style="color: white;"><i class="fa fa-home">&nbsp;</i>หน้าแรก</span></a></li>
					<li class="nav-item  active"><a href="doViewProject" class="nav-link"><span style="color: white;"><i class="fa fa-th-list">&nbsp;</i>โครงงานวิทยาศาสตร์</span></a></li>
					<li class="nav-item  active"><a href="doViewTeam" class="nav-link"><span style="color: white;"><i class="fa-solid fa-people-group">&nbsp;</i>กลุ่มประเมินโครงงานวิทยาศาสตร์</span></a></li>
					<li class="nav-item  active"><a href="doViewNews" class="nav-link"><span style="color: white;"><i class="fa fa-newspaper-o">&nbsp;</i>ข่าวสาร</span></a></li>
					<li class="nav-item active"><a href="doViewResult" class="nav-link"><span style="color: white;"><i class="fa-solid fa-trophy">&nbsp;</i>รางวัล</span></a></li>								
				</ul>
				<div class="navbar-nav ml-auto">
					<div class="hidden-lg hidden-md hidden-sm">
						<div style="height: 40px; line-height: 40px; text-align: left">
							
						</div>
					</div>
				</div>
				<ul class="nav navbar-nav navbar-right">
					<li class="nav-item dropdown active">
						<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 
							<span style="color: white;"><i class="fa fa-user">&nbsp;</i>ผู้ใช้งานระบบ : <%=admin.getAdminname()%></span>
						</a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">						 
							<a class="dropdown-item" href="verifylogout"><span style="color: black;"><i class="fa fa-sign-out">&nbsp;</i>ออกจากระบบ</span></a>
						</div>
					</li>							
				</ul>
			</nav>
		</div>
		<%
			}
		%>
		<%
			}
		%>
	</div>
</body>
</html>
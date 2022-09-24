<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*"%>
<%
	Admin admin = null;
	ProjectType projecttype = null;
	List<Project> listproject = new Vector<>();
	List<Reviewer> listreviewer = new Vector<>();

	try {
		admin = (Admin) session.getAttribute("admin");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try {
		projecttype = (ProjectType) request.getAttribute("projecttype");
		session.setAttribute("key",projecttype.getProjecttype_id()); 
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try {
		listproject = (List<Project>) request.getAttribute("listproject");
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
			<section id="content">
				<div class="container" style="margin-top: 35px">
					<div class="row">
						<div class="col-lg-12">
							<div class="container">
								<h3>ข้อมูลทีม</h3>
								<hr class="colorgraph">
								<h5>ข้อมูล</h5>
								<br>
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">รหัสทีม</label>
									<div class="col-sm-4">
										<input type="text" name="team_id" id="team_id" class="form-control data" value="<%=projecttype.getProjecttype_id()%>" disabled="disabled">
									</div>
								</div>
								
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">ชื่อทีม</label>
									<div class="col-sm-4">
										<input type="text" name="team_name" id="team_name" class="form-control data" value="<%=projecttype.getProjecttype_name()%>" disabled="disabled">
									</div>
								</div>
								<br>
								<div class="container">
									<div class="form-group row">
										<h5>ประธานคณะกรรมการ</h5>								
									</div>							
								</div>							
								<hr class="colorgraph">
								<table class="table table-bordered  table-hover" id=myTable>
									<thead class="table-info" align="center">
										<tr>									
											<th width="150">รหัสคณะกรรมการ</th>
											<th>ชื่อคณะกรรมการ</th>
											<th width="200">ตำแหน่ง</th>
											<!-- <th width="75"></th> -->														
										</tr>
									</thead>
									<tbody align="center">
										<%
											if (listreviewer != null) {
										%>
										<%
											for (int i = 0; i < listreviewer.size(); i++) {
												if(listreviewer.get(i).getPosition().equals("ประธานคณะกรรมการ")) {
										%>
										<tr>																		
											<td><%=listreviewer.get(i).getReviewer_id()%></td>
											<td><%=listreviewer.get(i).getPrefix() + "  " + listreviewer.get(i).getFirstname() + "  " + listreviewer.get(i).getLastname()%></td>
											<td><%=listreviewer.get(i).getPosition()%></td>
											<%-- <td>
												<button name="button" class="btn btn-danger" onclick="window.location.href='doDeleteReviewerByTeamID?team_id=<%=listreviewer.get(i).getTeam().getTeam_id()%>&reviewer_id=<%=listreviewer.get(i).getReviewer_id()%>';">
													<i class="fa-solid fa-trash-can"></i>
												</button>
											</td>	 --%>							
										</tr>
										<%
											}
											}
										%>
										<%
											} else {
										%>
										<tr align="center">
											<td colspan="3"><h2>ไม่มีข้อมูล</h2></td>
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
											<th width="150">รหัสคณะกรรมการ</th>
											<th>ชื่อคณะกรรมการ</th>
											<th width="200">ตำแหน่ง</th>	
											<!-- <th width="75"></th>	 -->							
										</tr>
									</thead>
									<tbody align="center">
										<%
											if (listreviewer != null) {
										%>
										<%
											for (int i = 0; i < listreviewer.size(); i++) {
												if(listreviewer.get(i).getPosition().equals("คณะกรรมการ")) {
										%>
										<tr>										
											<td><%=listreviewer.get(i).getReviewer_id()%></td>
											<td><%=listreviewer.get(i).getPrefix() + "  " + listreviewer.get(i).getFirstname() + "  " + listreviewer.get(i).getLastname()%></td>	
											<td><%=listreviewer.get(i).getPosition()%></td>
											<%-- <td>
												<button name="button" class="btn btn-danger" onclick="window.location.href='doDeleteReviewerByTeamID?team_id=<%=listreviewer.get(i).getTeam().getTeam_id()%>&reviewer_id=<%=listreviewer.get(i).getReviewer_id()%>';">
													<i class="fa-solid fa-trash-can"></i>
												</button>
											</td>	 --%>								
										</tr>
										<%
											}
											}
										%>
										<%
											} else {
										%>
										<tr align="center">
											<td colspan="3"><h2>ไม่มีข้อมูล</h2></td>
										</tr>
										<%
											}
										%>
									</tbody>
								</table>
								
								<br>
								
								<div class="container">
									<div class="form-group row">
										<h5>โครงงานวิทยาศาสตร์</h5>														
									</div>		
								</div>										
								<hr class="colorgraph">
								<table class="table table-bordered  table-hover" id=myTable>
									<thead class="table-info" align="center">
										<tr>										
											<th width="125px">รหัสโครงงาน</th>
											<th>ชื่อโครงงาน</th>
											<th width="205px">ประเภทโครงงาน</th>													
										</tr>
									</thead>
									<tbody> 
										<%
											if (listproject != null) {
										%>
										<%
										for (int i = 0; i < listproject.size(); i++) {
										%>
										<tr>									
											<td align="center"><%=listproject.get(i).getProject_id()%></td>
											<td><%=listproject.get(i).getProjectname()%></td>	
											<td align="center"><%=listproject.get(i).getProjecttype().getProjecttype_name()%></td>													
										</tr>
										<%
											}
										%>
										<%
											} else {
										%>
										<tr align="center">
											<td colspan="2"><h2>ไม่มีข้อมูล</h2></td>
										</tr>
										<%
											}
										%>
									</tbody>
								</table>	
								<br>
								<br>
								<div class="form-group row">
									<div class="col-sm-12 ">
										<span class="form-control-input"> <input id="checkBox2" type="checkbox" name="checkBox2" onclick="return edit(this)"> 
											<label for="checkBox2">&nbsp;กดเพื่อต้องการลบข้อมูล (จากนั้นกดปุ่ม "ลบข้อมูล")</label>
										</span>
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-12 text-center">									
										<a href="doDeleteTeam?projecttype_id=<%=projecttype.getProjecttype_id()%>"> 
											<input type="button" name="delete" id="delete" value="ลบข้อมูล"
											class="btn btn-danger" disabled="disabled" onclick="return confirm('คุณต้องการลบโครงงานวิทยาศาสตร์นี้หรือไม่ ');">
										</a>
										<a class="btn btn-warning" href="doViewTeam" role="button">ยกเลิก</a>	
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>

	<jsp:include page="common/footer.jsp"></jsp:include>
	
	<script type="text/javascript">
		function edit(ck) {
			if (ck.checked) {
				document.getElementById('team_id').disabled = true;
				document.getElementById('team_name').disabled = true;				
				document.getElementById('delete').disabled = false;
			} else {
				document.getElementById('team_id').disabled = true;
				document.getElementById('team_name').disabled = true;
				document.getElementById('delete').disabled = true;
			}
		}
	</script>
	
</body>
</html>
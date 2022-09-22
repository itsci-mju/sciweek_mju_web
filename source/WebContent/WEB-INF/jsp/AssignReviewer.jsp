<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*"%>
<%
	Admin admin = null;
	Team team = null;
	String[] reviewerIdStrList = null;
	List<Reviewer> listreviewer = new Vector<>();
	
	try{
		reviewerIdStrList = (String[]) request.getAttribute("reviewerIdStrList");
	} catch (Exception e) {
		e.printStackTrace();
	}

	try {
		admin = (Admin) session.getAttribute("admin");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try {
		team = (Team) request.getAttribute("team");
		session.setAttribute("key",team.getTeam_id()); 
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
		<form name="frm" action="isAssignReviewer" method="post">
			<section id="content">
				<div class="container" style="margin-top: 35px">
					<div class="row">
						<div class="col-lg-12">
							<div class="container">
								<h3>ข้อมูลทีม</h3>
								<hr class="colorgraph">
								<br>
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">รหัสทีม</label>
									<div class="col-sm-4">
										<input type="text" name="team_id" id="team_id" class="form-control data" value="<%=team.getTeam_id()%>" readonly>
									</div>
								</div>
								
								<div class="form-group row">
									<label class="col-sm-2 col-form-label text-right">ชื่อทีม</label>
									<div class="col-sm-4">
										<input type="text" name="team_name" id="team_name" class="form-control data" value="<%=team.getTeam_name()%>" readonly>
									</div>
								</div>
								<br>
								<div class="container">
									<div class="form-group row">
										<div class="col-auto">
											<h5>ประธานคณะกรรมการ</h5>
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
										<!-- 	<th width="55"></th>	 -->											
										</tr>
									</thead>
									<tbody align="center">
										<%
											if (listreviewer != null) {
										%>
										<%
											for (int i = 0; i < listreviewer.size(); i++) {
												if(listreviewer.get(i).getTeam().getTeam_id() == 0 && listreviewer.get(i).getPosition().equals("ประธานคณะกรรมการ")) {
										%>
										<tr>										
											<td><input type="checkbox" id="chkreviewer" name="chkreviewer" value="<%=listreviewer.get(i).getReviewer_id()%>"></td>
											<td><%=listreviewer.get(i).getReviewer_id()%></td>
											<td><%=listreviewer.get(i).getPrefix() + "  " + listreviewer.get(i).getFirstname() + "  " + listreviewer.get(i).getLastname()%></td>
											<%-- <td><a href="ViewReviewerDetail?reviewer_id=<%=listreviewer.get(i).getReviewer_id()%>" class="btn btn-warning">
													<i class="fa fa-eye" aria-hidden="true"></i>
												</a>
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
											<th width="250">รหัสคณะกรรมการ</th>
											<th>ชื่อคณะกรรมการ</th>
											<!-- <th width="55"></th> -->												
										</tr>
									</thead>
									<tbody align="center">
										<%
											if (listreviewer != null) {
										%>
										<%
											for (int i = 0; i < listreviewer.size(); i++) {
												if(listreviewer.get(i).getTeam().getTeam_id() == 0 && listreviewer.get(i).getPosition().equals("คณะกรรมการ")) {
										%>
										<tr>										
											<td><input type="checkbox" id="chkreviewer" name="chkreviewer" value="<%=listreviewer.get(i).getReviewer_id()%>"></td>
											<td><%=listreviewer.get(i).getReviewer_id()%></td>
											<td><%=listreviewer.get(i).getPrefix() + "  " + listreviewer.get(i).getFirstname() + "  " + listreviewer.get(i).getLastname()%></td>
											<%-- <td><a href="ViewReviewerDetail?reviewer_id=<%=listreviewer.get(i).getReviewer_id()%>" class="btn btn-warning">
													<i class="fa fa-eye" aria-hidden="true"></i>
												</a>
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
											<td colspan="5"><h2>ไม่มีข้อมูล</h2></td>
										</tr>
										<%
											}
										%>
									</tbody>
								</table>
				
								<br>							
								<hr class="colorgraph">			
								<br>				
								<div class="form-group row">
									<div class="col-sm-12 text-center">
										<button type="submit" id="btn" class="btn btn-success">ต่อไป</button>										
										<a class="btn btn-warning" href="doCreateTeam?team_id=<%=team.getTeam_id()%>&team_name=<%=team.getTeam_name()%>" role="button">ย้อนกลับ</a>	
										<a class="btn btn-danger" href="doViewTeam" role="button">ยกเลิก</a>	
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
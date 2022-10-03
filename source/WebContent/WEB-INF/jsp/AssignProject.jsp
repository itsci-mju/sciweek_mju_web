<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "bean.* , util.* , java.util.*, manager.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%
	Admin admin = null;
	Team team = null;
	String[] reviewerIdStrList = null;
	List<Project> listproject = new Vector<>();
		
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

<script type="text/javascript">
	function validateForm(frm) {
		
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
		<form action="isAssignProject" name="frm" method="post" >
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
										<h5>โครงงานวิทยาศาสตร์</h5>										
									</div>		
								</div>										
								<hr class="colorgraph">
								<table class="table table-bordered  table-hover" id=myTable>
									<thead class="table-info" align="center">
										<tr>
											<th width="55"></th>
											<th width="250">รหัสโครงงานวิทยาศาสตร์</th>
											<th>ชื่อโครงงานวิทยาศาสตร์</th>											
										</tr>
									</thead>
									<tbody> 
										<%
											String teamName = team.getTeam_name();
											if (listproject.size() != 0) {
										%>
										<%
											for (int i = 0 ; i < listproject.size() ; i++) {
																														
												if ( listproject.get(i).getTeam().getTeam_id() == 0 && listproject.get(i).getProjecttype().getProjecttype_name().equalsIgnoreCase(teamName)) {
																									
										%>
										<tr>
											<td align="center"><input type="checkbox" id="chkproject" name="chkproject" value="<%=listproject.get(i).getProject_id()%>"  checked></td>
											<td align="center"><%=listproject.get(i).getProject_id()%></td>
											<td><%=listproject.get(i).getProjectname()%></td>										
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

								<%
									String reviewer_id = null;
									for (String reviewerIdStr : reviewerIdStrList) { 
										reviewer_id = reviewerIdStr;	
										System.out.println(reviewer_id);
																
								%>
								<input type="hidden" name="reviewer_id" id="reviewer_id" class="form-control data" value="<%=reviewer_id%>">		
								<%
									}	
								%>					
								<div class="form-group row">
									<div class="col-sm-12 text-center">
										<button type="submit" class="btn btn-success" onclick ="return validateForm(frm)">บันทึกข้อมูล</button>									
										<a class="btn btn-warning" href="doCreateTeam" role="button">ย้อนกลับ</a>	
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

	<c:if test="${msg != null }">
		<script type="text/javascript">
			var msg = '${msg}';
			alert(msg);
		</script>
	</c:if>

</body>
</html>
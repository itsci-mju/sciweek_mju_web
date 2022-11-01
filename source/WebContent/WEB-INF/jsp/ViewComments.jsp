<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*"%>
<%
	Reviewer reviewer = null;
	List<Reviews> reviewsList = null;
	String project_id = null;

	try {
		reviewer = (Reviewer) session.getAttribute("reviewer");
	} catch (Exception e) {

	}

	try {
		reviewsList = (List<Reviews>) request.getAttribute("reviewsList");
	} catch (Exception e) {

	}
	
	try {
		project_id = (String) request.getAttribute("project_id");
	} catch (Exception e) {

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
<body style="background-image: url('./image/hero-bg.png') ; background-repeat: no-repeat ; background-attachment: fixed ; background-size: 100% 100%">

	<jsp:include page="common/navbar.jsp"></jsp:include>

	<div class="container" style="margin-top: 35px;">
		<section id="content">
			<div class="container" style="margin-top: -20px">
				<div class="row">
					<div class="col-lg-12">
						<br>
						<h3> <i class="fa-solid fa-clipboard">&nbsp;</i>สรุปคำวิจารณ์ที่ได้รับและความคิดเห็น </h3>
						<hr class="colorgraph">
					</div>
				</div>
			</div>
		</section>

		<br>
		
		<table class="table table-bordered  table-hover" id=myTable style="width: 85%" >
			<thead >
				<tr align="center">
					<th class="table-info">รหัสโครงงาน</th>
					<td colspan=2><%=project_id%></td>
				</tr>
			</thead>
			<tr class="table-info" align="center">
				<th>ผู้ประเมิน</th>
				<th>วันเวลาประเมิน</th>
				<th>ความคิดเห็น</th>
			</tr>
			<tbody>			
				<% for (Reviews reviews : reviewsList) { %>
				<tr>
					<td width="225" align="left">&nbsp;&nbsp;<%=reviews.getReviewer().getPrefix() +" "+ reviews.getReviewer().getFirstname() +" "+ reviews.getReviewer().getLastname()%></td>
					<td width="200" align="center"><%=reviews.getReviewdate()%></td>
					<td align="left" width="650">&nbsp;&nbsp; >> &nbsp;&nbsp;<%=reviews.getComments()%></td>
				</tr>	
				<% } %>	
			</tbody>
		</table>
		
	</div>

	<jsp:include page="common/footer.jsp"></jsp:include>

</body>
</html>
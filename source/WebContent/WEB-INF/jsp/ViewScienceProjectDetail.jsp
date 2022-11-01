<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*"%>
<%
Reviewer reviewer = null ;
Project project = null;
List<Project> listproject = new Vector<>();
Reviews reviews = new Reviews();

try {
	reviewer = (Reviewer) session.getAttribute("reviewer");
} catch (Exception e) {

}

try {
	reviews = (Reviews)  request.getAttribute("reviews");
} catch (Exception e) {

}

try {
	listproject = (List<Project>) request.getAttribute("listproject");
} catch (Exception e) {
	e.printStackTrace();
}

try {
	project = (Project) request.getAttribute("project");
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
<body style="background-image: url('./image/hero-bg.png') ; background-repeat: no-repeat ; background-attachment: fixed ; background-size: 100% 100%">

	<jsp:include page="common/navbar.jsp"></jsp:include>

	<div class="container" style="margin-top: 35px;">
		<section id="content">
			<div class="container" style="margin-top: -20px">
				<div class="row">
					<div class="col-lg-12">
						<br>
						<h3>
							<i class="fa-solid fa-clipboard">&nbsp;</i>ข้อมูลโครงงานวิทยาศาสตร์
						</h3>
						<hr class="colorgraph">
						<h5>ข้อมูลคณะกรรมการ</h5>
						<br>
						<div class="form-group row">
							<label class="col-sm-2 col-form-label text-right">ชื่อ -
								นามสกุล</label>
							<div class="col-sm-3">
								<input type="text" id="prefix" name="prefix"
									class="form-control data"
									value="<%=reviewer.getPrefix()%> <%=reviewer.getFirstname()%>  <%=reviewer.getLastname()%>"
									style="background-color: #ffffee" readonly>
							</div>
							<div class="col-sm-1">
								<input type="hidden" id="prefix" name="prefix"
									class="form-control data" value="<%=reviewer.getPrefix()%>">
							</div>
							<div class="col-sm-3">
								<input type="hidden" id="firstname" name="firstname"
									class="form-control data" value="<%=reviewer.getFirstname()%>">
							</div>
							<div class="col-sm-3">
								<input type="hidden" id="lastname" name="lastname"
									class="form-control data" value="<%=reviewer.getLastname()%>">
							</div>
						</div>


						<div class="form-group row">
							<label class="col-sm-2 col-form-label text-right">อีเมล</label>
							<div class="col-sm-3">
								<input type="text" id="student_id" name="student_id"
									class="form-control data" value="<%=reviewer.getEmail()%>"
									style="background-color: #ffffee" readonly>
							</div>
						</div>

						<div class="form-group row">
							<label class="col-sm-2 col-form-label text-right">คณะ </label>
							<div class="col-sm-3">
								<input type="text" id="faculty" name="faculty"
									class="form-control data" value="<%=reviewer.getFaculty()%>"
									style="background-color: #ffffee" readonly>
							</div>
							<label class="col-sm-2 col-form-label text-right">สาขา </label>
							<div class="col-sm-3">
								<input type="text" id="major" name="major"
									class="form-control data" value="<%=reviewer.getMajor()%>"
									style="background-color: #ffffee" readonly>
							</div>
						</div>
						<%	String projecttype_name = null ;
								
										if (reviewer.getProjecttype().getProjecttype_name() == null) {
											projecttype_name = "ไม่มีกลุ่ม" ;
										} else { 
											projecttype_name = reviewer.getProjecttype().getProjecttype_name();
										}					
								%>
						<div class="form-group row">
							<label class="col-sm-2 col-form-label text-right">กลุ่ม</label>
							<div class="col-sm-4">
								<input type="hidden" id="team_id" name="team_id"
									class="form-control data"
									value="<%=reviewer.getProjecttype().getProjecttype_id()%>"> <input
									type="text" id="team_name" name="team_name"
									class="form-control data" value="<%=projecttype_name%>"
									style="background-color: #ffffee" readonly>
							</div>
						</div>

						<div class="form-group row">
							<label class="col-sm-2 col-form-label text-right">ตำแหน่ง</label>
							<div class="col-sm-3">
								<input type="text" id="position" name="position"
									class="form-control data" value="<%=reviewer.getPosition()%>"
									style="background-color: #ffffee" readonly>
							</div>
						</div>

					</div>
				</div>
			</div>
		</section>

		<br>
		
		<% if (reviews.getProject().getState_project() == 1) { %>
		
		<h5>สรุปคำวิจารณ์ที่ได้รับและความคิดเห็น</h5>
		<hr class="colorgraph">
		<table class="table table-bordered  table-hover" id=myTable>
			<thead class="table-info" align="center">
				<tr>
					<th width="200">วันเวลาประเมิน</th>
					<th>ชื่อโครงงาน/สิ่งประดิษฐ์</th>
					<th width="70">รายงาน</th>
					<th width="70">รวมคะแนน</th>
				</tr>
			</thead>
			<%
				if (reviews.getReviews_id() != null ) {	
					
					String fmt_expreviewdate = new SimpleDateFormat("dd MMM yyyy", new Locale("th", "TH")).format(reviews.getReviewdate());
					String fmt_expreviewtime = new SimpleDateFormat("HH:mm").format(reviews.getReviewdate()); 
					
			%>

			<tbody>
				<tr>
					<td align="center"><%=fmt_expreviewdate%> เวลา <%=fmt_expreviewtime%> น.</td>
					<td><%=reviews.getProject().getProjectname()%></td>

					<%
						List<Answer> answerList = reviews.getListanswer()  ;

						for (Answer answer : answerList) {
							Question question = answer.getQuestion();
					%>
					<td align="center"><%=answer.getAnswer() %></td>
					<% } %>

					<% if (reviews.getTotalscore() >= 80) { %>
					<td align="center" style="background-color: #C6EFCE"><%=reviews.getTotalscore()%></td>
					<%} else if (reviews.getTotalscore() >= 75) { %>
					<td align="center" style="background-color: #B7DEE8"><%=reviews.getTotalscore()%></td>
					<%} else if (reviews.getTotalscore() >= 70) { %>
					<td align="center" style="background-color: #B8CCE4"><%=reviews.getTotalscore()%></td>
					<%} else if (reviews.getTotalscore() >= 65) { %>
					<td align="center" style="background-color: #CCC0DA"><%=reviews.getTotalscore()%></td>
					<%} else if (reviews.getTotalscore() >= 60) { %>
					<td align="center" style="background-color: #FFFFCC"><%=reviews.getTotalscore()%></td>
					<%} else if (reviews.getTotalscore() >= 55) { %>
					<td align="center" style="background-color: #FDE9D9"><%=reviews.getTotalscore()%></td>
					<%}  else if (reviews.getTotalscore() >= 50) { %>
					<td align="center" style="background-color: #FCD5B4"><%=reviews.getTotalscore()%></td>
					<%} else { %>
					<td align="center" style="background-color: #FFC7CE"><%=reviews.getTotalscore()%></td>
					<% } %>
				</tr>

				<%
					} else {
				%>
				<tr align="center">
					<td colspan="6"><h2>ไม่มีข้อมูล</h2></td>
				</tr>
				<%
					}
				%>
			</tbody>

		</table>
		<br>
		<table class="table table-bordered  table-hover" id=myTable
			style="width: 70%">
			<thead class="table-info" align="center">
				<tr>
					<th colspan=2>ความคิดเห็น</th>
				</tr>
			</thead>
			<%
				if (reviews.getComments() != null) {
			%>
			<tbody>
				<tr>
					<td width="150" align="center">ความคิดเห็น :</td>
					<td align="left"><%=reviews.getComments()%></td>
				</tr>
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
		
		<% } %>
		
		
		<% if (reviews.getProject().getState_project() == 2) { %>
		
		<h5>สรุปคำวิจารณ์ที่ได้รับและความคิดเห็น</h5>
		<hr class="colorgraph">
		<table class="table table-bordered  table-hover" id=myTable>
			<thead class="table-info" align="center">
				<tr>
					<th width="200">วันเวลาประเมิน</th>
					<th>ชื่อโครงงาน/สิ่งประดิษฐ์</th>
					<th style="white-space: nowrap">รายงาน</th>
					<th style="white-space: nowrap">แสดงโครงงาน</th>
					<th style="white-space: nowrap">การอภิปราย</th>
					<th style="white-space: nowrap">โครงงาน</th>
					<th width="70">รวมคะแนน</th>
				</tr>
			</thead>
			<%
				if (reviews.getReviews_id() != null ) {
					
					String fmt_expreviewdate = new SimpleDateFormat("dd MMM yyyy", new Locale("th", "TH")).format(reviews.getReviewdate());
					String fmt_expreviewtime = new SimpleDateFormat("HH:mm").format(reviews.getReviewdate()); 
					
			%>

			<tbody>
				<tr>
					<td align="center"><%=fmt_expreviewdate%> เวลา <%=fmt_expreviewtime%> น.</td>
					<td><%=reviews.getProject().getProjectname()%></td>

					<%
						List<Answer> answerList = reviews.getListanswer()  ;

						for (Answer answer : answerList) {
							Question question = answer.getQuestion();
					%>
					<td align="center"><%=answer.getAnswer() %></td>
					<% } %>

					<% if (reviews.getTotalscore() >= 80) { %>
					<td align="center" style="background-color: #C6EFCE"><%=reviews.getTotalscore()%></td>
					<%} else if (reviews.getTotalscore() >= 75) { %>
					<td align="center" style="background-color: #B7DEE8"><%=reviews.getTotalscore()%></td>
					<%} else if (reviews.getTotalscore() >= 70) { %>
					<td align="center" style="background-color: #B8CCE4"><%=reviews.getTotalscore()%></td>
					<%} else if (reviews.getTotalscore() >= 65) { %>
					<td align="center" style="background-color: #CCC0DA"><%=reviews.getTotalscore()%></td>
					<%} else if (reviews.getTotalscore() >= 60) { %>
					<td align="center" style="background-color: #FFFFCC"><%=reviews.getTotalscore()%></td>
					<%} else if (reviews.getTotalscore() >= 55) { %>
					<td align="center" style="background-color: #FDE9D9"><%=reviews.getTotalscore()%></td>
					<%}  else if (reviews.getTotalscore() >= 50) { %>
					<td align="center" style="background-color: #FCD5B4"><%=reviews.getTotalscore()%></td>
					<%} else { %>
					<td align="center" style="background-color: #FFC7CE"><%=reviews.getTotalscore()%></td>
					<% } %>
				</tr>

				<%
					} else {
				%>
				<tr align="center">
					<td colspan="6"><h2>ไม่มีข้อมูล</h2></td>
				</tr>
				<%
					}
				%>
			</tbody>

		</table>
		<br>
		<table class="table table-bordered  table-hover" id=myTable
			style="width: 70%">
			<thead class="table-info" align="center">
				<tr>
					<th colspan=2>ความคิดเห็น</th>
				</tr>
			</thead>
			<%
				if (reviews.getComments() != null) {
			%>
			<tbody>
				<tr>
					<td width="150" align="center">ความคิดเห็น :</td>
					<td align="left"><%=reviews.getComments()%></td>
				</tr>
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
		
		<% } %>
		
		
		
		<% if (reviews.getProject().getState_project() == 3) { %>
		
		<h5>สรุปคำวิจารณ์ที่ได้รับและความคิดเห็น</h5>
		<hr class="colorgraph">
		<table class="table table-bordered  table-hover" id=myTable>
			<thead class="table-info" align="center">
				<tr>
					<th width="200">วันเวลาประเมิน</th>
					<th>ชื่อโครงงาน/สิ่งประดิษฐ์</th>
					<th style="white-space: nowrap">รายงาน</th>
					<th style="white-space: nowrap">แสดงโครงงาน</th>
					<th style="white-space: nowrap">การอภิปราย</th>
					<th style="white-space: nowrap">โครงงาน</th>
					<th width="70">รวมคะแนน</th>
				</tr>
			</thead>
			<%
				if (reviews.getReviews_id() != null ) {	
					
					String fmt_expreviewdate = new SimpleDateFormat("dd MMM yyyy", new Locale("th", "TH")).format(reviews.getReviewdate());
					String fmt_expreviewtime = new SimpleDateFormat("HH:mm").format(reviews.getReviewdate()); 
					
			%>

			<tbody>
				<tr>
					<td align="center"><%=fmt_expreviewdate%> เวลา <%=fmt_expreviewtime%> น.</td>
					<td><%=reviews.getProject().getProjectname()%></td>

					<%
						List<Answer> answerList = reviews.getListanswer()  ;

						for (Answer answer : answerList) {
							Question question = answer.getQuestion();
					%>
					<td align="center"><%=answer.getAnswer() %></td>
					<% } %>

					<% if (reviews.getTotalscore() >= 80) { %>
					<td align="center" style="background-color: #C6EFCE"><%=reviews.getTotalscore()%></td>
					<%} else if (reviews.getTotalscore() >= 75) { %>
					<td align="center" style="background-color: #B7DEE8"><%=reviews.getTotalscore()%></td>
					<%} else if (reviews.getTotalscore() >= 70) { %>
					<td align="center" style="background-color: #B8CCE4"><%=reviews.getTotalscore()%></td>
					<%} else if (reviews.getTotalscore() >= 65) { %>
					<td align="center" style="background-color: #CCC0DA"><%=reviews.getTotalscore()%></td>
					<%} else if (reviews.getTotalscore() >= 60) { %>
					<td align="center" style="background-color: #FFFFCC"><%=reviews.getTotalscore()%></td>
					<%} else if (reviews.getTotalscore() >= 55) { %>
					<td align="center" style="background-color: #FDE9D9"><%=reviews.getTotalscore()%></td>
					<%}  else if (reviews.getTotalscore() >= 50) { %>
					<td align="center" style="background-color: #FCD5B4"><%=reviews.getTotalscore()%></td>
					<%} else { %>
					<td align="center" style="background-color: #FFC7CE"><%=reviews.getTotalscore()%></td>
					<% } %>
				</tr>

				<%
					} else {
				%>
				<tr align="center">
					<td colspan="6"><h2>ไม่มีข้อมูล</h2></td>
				</tr>
				<%
					}
				%>
			</tbody>

		</table>
		<br>
		<table class="table table-bordered  table-hover" id=myTable
			style="width: 70%">
			<thead class="table-info" align="center">
				<tr>
					<th colspan=2>ความคิดเห็น</th>
				</tr>
			</thead>
			<%
				if (reviews.getComments() != null) {
			%>
			<tbody>
				<tr>
					<td width="150" align="center">ความคิดเห็น :</td>
					<td align="left"><%=reviews.getComments()%></td>
				</tr>
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
		
		<% } %>
		

	</div>

	<jsp:include page="common/footer.jsp"></jsp:include>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*,model.*"%>
<%
	Reviewer reviewer = null;
	List<ProjectResponse> projectResponseList = null;

	try {
		reviewer = (Reviewer) session.getAttribute("reviewer");
	} catch (Exception e) {
		e.printStackTrace();
	}

	try {
		projectResponseList = (List<ProjectResponse>) request.getAttribute("projectResponseList");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	List<ReviewerResponse> reviewerList = new ArrayList<>();
	for (ProjectResponse reviews : projectResponseList) {
		if (reviewerList.size() == 0) {
			reviewerList = reviews.getReviewerResponseList();
		} else {
			for (ReviewerResponse reviewerResponse : reviewerList) {
				boolean check = reviewerList.stream()
						.anyMatch(e -> e.getReviewerName() == reviewerResponse.getReviewerName());
				if (!check) {
					reviewerList.add(reviewerResponse);
				}
			}
		}

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
<%response.setHeader("Content-Disposition", "inline; filename=ExportSummaryFile.xls"); %>

	<div class="container" style="margin-top: 35px;">
		<div class="container">
			<div class="form-group row">
				<h3>สรุปผลคะแนนโครงงานวิทยาศาสตร์</h3>
			</div>
		</div>
	</div>

	<div style="margin-left: 6%; margin-right: 6%;">
		<br>
		<table class="table table-bordered  table-hover" id=myTable>
			<thead class="table-info" align="center">
				<tr>
					<th style="white-space: nowrap">ลำดับ</th>
					<th style="white-space: nowrap">วันเวลาประเมิน</th>
					<th style="white-space: nowrap">ชื่อโครงงาน/สิ่งประดิษฐ์</th>
					<%
						for (ReviewerResponse reviewers : reviewerList) {
					%>
					<th  style="white-space: nowrap " ><%=reviewers.getReviewerName()%></th>
					<%
						}
					%>
					<th style="white-space: nowrap">รวมคะแนน</th>
				</tr>
			</thead>
			<%
				for (int i = 0; i < projectResponseList.size(); i++) {
					
					Double total = projectResponseList.get(i).getTotalScore()/projectResponseList.get(i).getReviewerResponseList().size();
					Double avgscore = ( Math.floor(total * 100) / 100 );
									
			%>	
			
			<tbody>
				<tr>
					<td align="center" width="50px"><%=i + 1%></td>
					<td align="center" width="190px" ><%=projectResponseList.get(i).getReviewDate()%></td>
					<td align="left"><%=projectResponseList.get(i).getProjectName()%></td>
					<% for (ReviewerResponse reviewerResponse : projectResponseList.get(i).getReviewerResponseList()) { %>
						<td align="center" width="90px"><%=reviewerResponse.getScore()%></td>
					<% } %>
					
					<% if (total >= 80) { %>
			        	<td style="background-color: #C6EFCE" align="center" width="70px"><%=avgscore%></td>
			      	<%} else if (total >= 75) { %>
			      		<td style="background-color: #B7DEE8" align="center" width="70px"><%=avgscore%></td>
			        <%} else if (total >= 70) { %>
			         	<td style="background-color: #B8CCE4" align="center" width="70px"><%=avgscore%></td>
			        <%} else if (total >= 65) { %>
			        	<td style="background-color: #CCC0DA" align="center" width="70px"><%=avgscore%></td>
			       <%} else if (total >= 60) { %>
			       		<td style="background-color: #FFFFCC" align="center" width="70px"><%=avgscore%></td>
			       <%} else if (total >= 55) { %>
			       		<td style="background-color: #FDE9D9" align="center" width="70px"><%=avgscore%></td>
			       <%}  else if (total >= 50) { %>
			       		<td style="background-color: #FCD5B4" align="center" width="70px"><%=avgscore%></td>
			       <%} else { %>
			        	<td style="background-color: #FFC7CE" align="center" width="70px"><%=avgscore%></td>
			       <% } %>
				</tr>
			</tbody>
			
			<%
				}
			%>
			
			
		</table>
	</div>

</body>
</html>
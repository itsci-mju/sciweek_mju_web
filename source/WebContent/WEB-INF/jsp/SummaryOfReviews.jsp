<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*,model.*"%>
<%
	Reviewer reviewer = null;
	List<ProjectResponse> projectResponseList = null;
	Reviewer reviewers = null;

	try {
		reviewer = (Reviewer) session.getAttribute("reviewer");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try {
		reviewers = (Reviewer) request.getAttribute("reviewers");
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
	
	Integer state_project = 0 ;
	Integer status_project = 0 ;
	String disabled = null ;
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
<body  style="background-image: url('./image/hero-bg.png') ; background-repeat: no-repeat ; background-attachment: fixed ; background-size: 100% 100%">

	<jsp:include page="common/navbar.jsp"></jsp:include>

	<div class="container" style="margin-top: 35px;">
		<section id="content">
			<div class="container" style="margin-top: -20px">
				<br>
					<div class="form-group row">
						<div class="col-auto">
							<h3><i class="fa-solid fa-square-poll-horizontal">&nbsp;</i>ผลสรุปคะแนนโครงงานวิทยาศาสตร์</h3>
						</div>
						<div class="col-auto">
							<a href="ExportSummaryExcel" class="btn btn-success" style="margin-left: 629px;"><i class="fa-solid fa-file-excel">&nbsp;</i>Export File Excel</a>
						</div>
					</div>					
			</div>
		</section>
		<hr class="colorgraph">
		<div class="alert alert-danger" role="alert" style="text-align:center; font-weight:bold;">
			ชี้แจ้ง : กรุณาเลือกโครงงานวิทยาศาสตร์ด้วยความละเอียดถี่ถ้วน..
		</div>
	</div>

	<form action="isChooseProject" name="frm" id="chooseproject" method="post">
	<input type="hidden" class="form-control" name="reviewer_id" id="reviewer_id" value="<%=reviewer.getReviewer_id()%>"> 
	<input type="hidden" class="form-control" name="projecttype_id" id="projecttype_id" value="<%=reviewer.getProjecttype().getProjecttype_id()%>"> 
		<div style="margin-left: 1%; margin-right: 1%;">
			<table class="table table-bordered  table-hover" id=myTable>
				<thead class="table-info" align="center">
					<tr>
						<th style="white-space: nowrap" width="50"></th>
						<th style="white-space: nowrap">อันดับ</th>
						<th style="white-space: nowrap">วันเวลาประเมิน</th>
						<th style="white-space: nowrap">รหัสโครงงาน</th>
						<th style="white-space: nowrap">ชื่อโครงงาน/สิ่งประดิษฐ์</th>										
						<th style="white-space: nowrap">คะแนนเฉลี่ยรวม</th>
						<th style="white-space: nowrap">ผลการประเมิน</th>
					</tr>
				</thead>

				<%
					if (projectResponseList.size() != 0) {

						for (int i = 0; i < projectResponseList.size(); i++) {

							Double total = projectResponseList.get(i).getTotalScore() / projectResponseList.get(i).getReviewerResponseList().size();
							Double avgscore = (Math.floor(total * 100) / 100);

							SummaryOfReviewsManager summaryOfReviewsManager = new SummaryOfReviewsManager();

							summaryOfReviewsManager.isUpdateAVGScore(projectResponseList.get(i).getProjectID(), avgscore);
				%>
				
				<!-- 1 -->
				
				<% 
					if (reviewer != null && projectResponseList.get(i).getStateProject() == 1) { 
						
						int num = i + 1 ;
						
						String fmt_reviewsdate = new SimpleDateFormat("dd MMM yy", new Locale("th", "TH")).format(projectResponseList.get(i).getReviewDate());
						String fmt_reviewstime = new SimpleDateFormat("HH:mm").format(projectResponseList.get(i).getReviewDate()); 
						
						state_project = projectResponseList.get(i).getStateProject() ;
						status_project = projectResponseList.get(i).getStatusProject() ;
				%>
				
				<input type="hidden" name="state_project" id="state_project" value="<%=projectResponseList.get(i).getStateProject()%>">
				<input type="hidden" name="avgscore" id="avgscore" value="<%=avgscore%>">

				<tbody>
					<tr>
						<td align="center"><input type="checkbox" id="chkproject" name="chkproject" value="<%=projectResponseList.get(i).getProjectID()%>"></td>
						<% if (num == 1) { %>
						<td style="background-color: #C6EFCE" align="center" ><%=num%></td>
						<%} else if (num == 2) { %>
						<td style="background-color: #B7DEE8" align="center" ><%=num%></td>
						<%} else if (num == 3) { %>
						<td style="background-color: #B8CCE4" align="center" ><%=num%></td>
						<%} else if (num == 4) { %>
						<td style="background-color: #CCC0DA" align="center" ><%=num%></td>
						<%} else if (num == 5) { %>
						<td style="background-color: #FFFFCC" align="center" ><%=num%></td>
						<%} else if (num == 6) { %>
						<td style="background-color: #FDE9D9" align="center" ><%=num%></td>
						<%}  else if (num == 7) { %>
						<td style="background-color: #FCD5B4" align="center" ><%=num%></td>
						<%} else { %>
						<td style="background-color: #FFC7CE" align="center" ><%=num%></td>
						<% } %>		
					 	<td align="center" width="185px" style="white-space: nowrap"><%=fmt_reviewsdate%> เวลา <%=fmt_reviewstime%> น.</td>	
						<td align="center" width="50px"><%=projectResponseList.get(i).getProjectID()%></td>
						<td align="left"  style="font-size: 14px"><%=projectResponseList.get(i).getProjectName()%>&nbsp;(&nbsp;<%=projectResponseList.get(i).getReviewerResponseList().size()%>&nbsp;/&nbsp;<%=reviewers.getCount()%>&nbsp;)</td>		
						<% if (total >= 80) { %>
						<td style="background-color: #C6EFCE" align="center" width="70px"><%=avgscore%></td>
						<% } else if (total >= 75) { %>
						<td style="background-color: #B7DEE8" align="center" width="70px"><%=avgscore%></td>
						<% } else if (total >= 70) { %>
						<td style="background-color: #B8CCE4" align="center" width="70px"><%=avgscore%></td>
						<% } else if (total >= 65) { %>
						<td style="background-color: #CCC0DA" align="center" width="70px"><%=avgscore%></td>
						<% } else if (total >= 60) { %>
						<td style="background-color: #FFFFCC" align="center" width="70px"><%=avgscore%></td>
						<% } else if (total >= 55) { %>
						<td style="background-color: #FDE9D9" align="center" width="70px"><%=avgscore%></td>
						<% } else if (total >= 50) { %>
						<td style="background-color: #FCD5B4" align="center" width="70px"><%=avgscore%></td>
						<% } else { %>
						<td style="background-color: #FFC7CE" align="center" width="70px"><%=avgscore%></td>
						<% } %>
						<td align="center" width="75px"><a type="button" class="btn btn-success exploder"><span class="fa-solid fa-magnifying-glass"></span></a></td>
					</tr>
					<tr class="explode hide">
						<td colspan="8" style="display: none;">
							<table class="table table-bordered  table-hover">
								<thead class="table-info" align="center">
									<tr>
										<th>ชื่อ - สกุลผู้ประเมิน</th>
										<th>คะแนน</th>
										<th colspan="2">ความคิดเห็น</th>
									</tr>
								</thead>				
								<tbody>
									<%  for (ReviewerResponse reviewerResponse : projectResponseList.get(i).getReviewerResponseList()) { 	%>
									<tr>
										<td style="white-space: nowrap" width="275"><%=reviewerResponse.getReviewerName()%></td>
										<td style="white-space: nowrap" align="center"  width="75"><%=reviewerResponse.getScore()%></td>
										<td width="100">ความคิดเห็น</td>
										<td style="white-space: nowrap">&nbsp;&nbsp; >> &nbsp;&nbsp;<%=reviewerResponse.getComments()%></td>
									</tr>		
									<% } %>	
									
								</tbody>
							</table>
						</td>
					</tr>
				</tbody>
				
				<%
					}
				%>
				
				<!-- 2 -->
				
				<% if (reviewer != null && projectResponseList.get(i).getStateProject() == 2) {
					
						int num = i + 1;

						String fmt_reviewsdate = new SimpleDateFormat("dd MMM yy", new Locale("th", "TH")).format(projectResponseList.get(i).getReviewDate());
						String fmt_reviewstime = new SimpleDateFormat("HH:mm").format(projectResponseList.get(i).getReviewDate());

						state_project = projectResponseList.get(i).getStateProject();
						status_project = projectResponseList.get(i).getStatusProject();
				%>
				
				<input type="hidden" name="state_project" id="state_project" value="<%=projectResponseList.get(i).getStateProject()%>">
				<input type="hidden" name="chkproject" id="chkproject" value="<%=projectResponseList.get(i).getProjectID()%>">

				<tbody>
					<tr>
						<td align="center" width="225"><select class="form-select" name="award" id="award" required >
								<option value="รางวัลชนะเลิศอันดับที่ 1">รางวัลชนะเลิศอันดับที่ 1</option>
								<option value="รางวัลชนะเลิศอันดับที่ 2">รางวัลชนะเลิศอันดับที่ 2</option>
								<option value="รางวัลชนะเลิศอันดับที่ 3">รางวัลชนะเลิศอันดับที่ 3</option>
								<option selected value="รางวัลชมเชย">รางวัลชมเชย</option>
						</select></td>
						<% if (num == 1) { %>
						<td style="background-color: #C6EFCE" align="center" ><%=num%></td>
						<%} else if (num == 2) { %>
						<td style="background-color: #B7DEE8" align="center" ><%=num%></td>
						<%} else if (num == 3) { %>
						<td style="background-color: #B8CCE4" align="center" ><%=num%></td>
						<%} else if (num == 4) { %>
						<td style="background-color: #CCC0DA" align="center" ><%=num%></td>
						<%} else if (num == 5) { %>
						<td style="background-color: #FFFFCC" align="center" ><%=num%></td>
						<%} else if (num == 6) { %>
						<td style="background-color: #FDE9D9" align="center" ><%=num%></td>
						<%}  else if (num == 7) { %>
						<td style="background-color: #FCD5B4" align="center" ><%=num%></td>
						<%} else { %>
						<td style="background-color: #FFC7CE" align="center" ><%=num%></td>
						<% } %>		
						<td align="center"  width="185px"  style="white-space: nowrap"><%=fmt_reviewsdate%> เวลา <%=fmt_reviewstime%> น.</td>
						<td align="center" width="50px"><%=projectResponseList.get(i).getProjectID()%></td>
						<td align="left" style="font-size: 14px"><%=projectResponseList.get(i).getProjectName()%>&nbsp;(&nbsp;<%=projectResponseList.get(i).getReviewerResponseList().size()%>&nbsp;/&nbsp;<%=reviewers.getCount()%>&nbsp;)</td>		
						<% if (total >= 80) { %>
						<td style="background-color: #C6EFCE" align="center" width="70px"><%=avgscore%></td>
						<% } else if (total >= 75) { %>
						<td style="background-color: #B7DEE8" align="center" width="70px"><%=avgscore%></td>
						<% } else if (total >= 70) { %>
						<td style="background-color: #B8CCE4" align="center" width="70px"><%=avgscore%></td>
						<% } else if (total >= 65) { %>
						<td style="background-color: #CCC0DA" align="center" width="70px"><%=avgscore%></td>
						<% } else if (total >= 60) { %>
						<td style="background-color: #FFFFCC" align="center" width="70px"><%=avgscore%></td>
						<% } else if (total >= 55) { %>
						<td style="background-color: #FDE9D9" align="center" width="70px"><%=avgscore%></td>
						<% } else if (total >= 50) { %>
						<td style="background-color: #FCD5B4" align="center" width="70px"><%=avgscore%></td>
						<% } else { %>
						<td style="background-color: #FFC7CE" align="center" width="70px"><%=avgscore%></td>
						<% } %>
						<td align="center" width="75px"><a type="button" class="btn btn-success exploder"><span class="fa-solid fa-magnifying-glass"></span></a></td>
					</tr>
					<tr class="explode hide">
						<td colspan="8" style="display: none;">
							<table class="table table-bordered  table-hover">
								<thead class="table-info" align="center">
									<tr>
										<th>ชื่อ - สกุลผู้ประเมิน</th>
										<th>คะแนน</th>
										<th colspan="2">ความคิดเห็น</th>
									</tr>
								</thead>				
								<tbody>
									<%  for (ReviewerResponse reviewerResponse : projectResponseList.get(i).getReviewerResponseList()) { 	%>
									<tr>
										<td style="white-space: nowrap" width="275"><%=reviewerResponse.getReviewerName()%></td>
										<td style="white-space: nowrap" align="center"  width="75"><%=reviewerResponse.getScore()%></td>
										<td width="100">ความคิดเห็น</td>
										<td style="white-space: nowrap">&nbsp;&nbsp; >> &nbsp;&nbsp;<%=reviewerResponse.getComments()%></td>
									</tr>		
									<% } %>	
								</tbody>
							</table>
						</td>
					</tr>
				</tbody>
				
				<% } %>
				
				<!-- 3 -->
				
				<% if (reviewer != null && projectResponseList.get(i).getStateProject() == 3 ) { 
					
						int num = i + 1 ;
						
						String fmt_reviewsdate = new SimpleDateFormat("dd MMM yy", new Locale("th", "TH")).format(projectResponseList.get(i).getReviewDate());
						String fmt_reviewstime = new SimpleDateFormat("HH:mm ").format(projectResponseList.get(i).getReviewDate()); 
					
						state_project = projectResponseList.get(i).getStateProject() ;
						status_project = projectResponseList.get(i).getStatusProject() ;
				%>

				<tbody>
					<tr>			
						<td align="center" width="175"><%=projectResponseList.get(i).getAwardProject()%></td>		
						<% if (num == 1) { %>
						<td style="background-color: #C6EFCE" align="center" ><%=num%></td>
						<%} else if (num == 2) { %>
						<td style="background-color: #B7DEE8" align="center" ><%=num%></td>
						<%} else if (num == 3) { %>
						<td style="background-color: #B8CCE4" align="center" ><%=num%></td>
						<%} else if (num == 4) { %>
						<td style="background-color: #CCC0DA" align="center" ><%=num%></td>
						<%} else if (num == 5) { %>
						<td style="background-color: #FFFFCC" align="center" ><%=num%></td>
						<%} else if (num == 6) { %>
						<td style="background-color: #FDE9D9" align="center" ><%=num%></td>
						<%}  else if (num == 7) { %>
						<td style="background-color: #FCD5B4" align="center" ><%=num%></td>
						<%} else { %>
						<td style="background-color: #FFC7CE" align="center" ><%=num%></td>
						<% } %>
						<td align="center"  width="185px"  style="white-space: nowrap"><%=fmt_reviewsdate%> เวลา <%=fmt_reviewstime%> น.</td>		
						<td align="center" width="50px"><%=projectResponseList.get(i).getProjectID()%></td>
						<td align="left" style="font-size: 14px"><%=projectResponseList.get(i).getProjectName()%>&nbsp;(&nbsp;<%=projectResponseList.get(i).getReviewerResponseList().size()%>&nbsp;/&nbsp;<%=reviewers.getCount()%>&nbsp;)</td>
						<% if (total >= 80) { %>
						<td style="background-color: #C6EFCE" align="center" width="70px"><%=avgscore%></td>
						<% } else if (total >= 75) { %>
						<td style="background-color: #B7DEE8" align="center" width="70px"><%=avgscore%></td>
						<% } else if (total >= 70) { %>
						<td style="background-color: #B8CCE4" align="center" width="70px"><%=avgscore%></td>
						<% } else if (total >= 65) { %>
						<td style="background-color: #CCC0DA" align="center" width="70px"><%=avgscore%></td>
						<% } else if (total >= 60) { %>
						<td style="background-color: #FFFFCC" align="center" width="70px"><%=avgscore%></td>
						<% } else if (total >= 55) { %>
						<td style="background-color: #FDE9D9" align="center" width="70px"><%=avgscore%></td>
						<% } else if (total >= 50) { %>
						<td style="background-color: #FCD5B4" align="center" width="70px"><%=avgscore%></td>
						<% } else { %>
						<td style="background-color: #FFC7CE" align="center" width="70px"><%=avgscore%></td>
						<% } %>
						<td align="center" width="75px"><a type="button" class="btn btn-success exploder"><span class="fa-solid fa-magnifying-glass"></span></a></td>			
					</tr>
					<tr class="explode hide">
						<td colspan="8" style="display: none;">
							<table class="table table-bordered  table-hover">
								<thead class="table-info" align="center">
									<tr>
										<th>ชื่อ - สกุลผู้ประเมิน</th>
										<th>คะแนน</th>
										<th colspan="2">ความคิดเห็น</th>
									</tr>
								</thead>				
								<tbody>
									<%  for (ReviewerResponse reviewerResponse : projectResponseList.get(i).getReviewerResponseList()) { 	%>
									<tr>
										<td style="white-space: nowrap" width="275"><%=reviewerResponse.getReviewerName()%></td>
										<td style="white-space: nowrap" align="center"  width="75"><%=reviewerResponse.getScore()%></td>
										<td width="100">ความคิดเห็น</td>
										<td style="white-space: nowrap">&nbsp;&nbsp; >> &nbsp;&nbsp;<%=reviewerResponse.getComments()%></td>
									</tr>		
									<% } %>		
								</tbody>
							</table>
						</td>
					</tr>
				</tbody>
					
				<% } %>
				
				<!-- END -->
				
				<%
					}
				%>

				<%
					} else {
				%>
				<tr align="center">
					<td colspan="20"><h2>ไม่มีข้อมูล</h2></td>
				</tr>
				<%
					}
				%>
			</table>		
			<br>
			<div class="form-group row">
				<div class="col-sm-12 text-center">
					<% if (state_project != 3) { %>	
						<button type="submit" class="btn btn-success" OnClick="return validateForm(frm)">เลือก</button>
					<% } %>
					<% if (state_project == 2) { %>	
						<a class="btn btn-warning" href="isEditSelectFinal?state_project=<%=state_project%>" role="button" >แก้ไขการเลือกครั้งที่ 1</a>
					<% } %>
					<% if (state_project == 3 && status_project == 0) { %>	
						<a class="btn btn-warning" href="isEditDecideAwards?state_project=<%=state_project%>" role="button" >แก้ไขการเลือกรางวัล</a>
					<% } %>
					<% if (state_project != 3) { %>	
					<a class="btn btn-danger" href="index" role="button">ยกเลิก</a>
					<% } %>
				</div>
			</div>
		</div>
	</form>

	<jsp:include page="common/footer.jsp"></jsp:include>
	
	<script type="text/javascript">
	
	$(".exploder").click(function(){
		  
		  $(this).toggleClass("btn-success btn-danger");
		  
		  $(this).children("span").toggleClass("fa-regular fa-rectangle-xmark");  
		  
		  $(this).closest("tr").next("tr").toggleClass("hide");
		  
		  if ($(this).closest("tr").next("tr").hasClass("hide")){
		    $(this).closest("tr").next("tr").children("td").slideUp();
		  } else {
		    $(this).closest("tr").next("tr").children("td").slideDown(350);
		  }
		});
	
	</script>
	
</body>
</html>
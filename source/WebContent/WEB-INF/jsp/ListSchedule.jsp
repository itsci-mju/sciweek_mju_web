<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*"%>
<%
	Admin admin = null;
	List<Schedules> schedulesList = new Vector<>();

	try {
		admin = (Admin) session.getAttribute("admin");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try {
		schedulesList = (List<Schedules>) request.getAttribute("schedulesList");
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
<body  style="background-image: url('./image/hero-bg.png') ; background-repeat: no-repeat ; background-attachment: fixed ; background-size: 100% 100%">

	<jsp:include page="common/navbar.jsp"></jsp:include>

	<div class="container" style="margin-top: 35px;">
		<div class="form-group row">
			<div class="col-auto">
				<h3><i class="fa-solid fa-clipboard-list">&nbsp;</i>รายการกำหนดการ</h3>		
			</div>	
			<div class="col-auto text-center" style="margin-left: 65%;">
				
			</div>
			<div class="col-auto text-left" >
				<button name="button" class="btn btn-warning mb-3" onclick="window.location.href='doCreateSchedule';">
					<i class="fa-solid fa-calendar-days">&nbsp;</i>สร้างกำหนดการ
				</button>
			</div>
			<hr class="colorgraph">
		</div>						

		<div class="alert alert-danger" role="alert" style="text-align:center; font-weight:bold;">
			ชี้แจ้ง : กรุณาสร้างกำหนดการ
		</div>
		
		<table class="table table-bordered  table-hover" id=myTable  style="width: 40%; align-self: center;">
			<thead class="table-info" align="center">
				<tr>
					<th width="100">ปี</th>			
					<th width="200">ดูรายละเอียด</th>
				</tr>
			</thead>
			<tbody align="center">
				<%
					if (schedulesList.size() != 0) {
				%>
				<%
					for (Schedules schedule : schedulesList) {
				%>
				<tr>
					<td><%=schedule.getYears()%></td>
					<td><a href="ViewScheduleDetail?years=<%=schedule.getYears()%>">
							<button name="button" class="btn btn-warning">
								<i class="fa fa-eye"></i>&nbsp;ดูรายละเอียด
							</button>
					</a>
				</tr>
				
					<%
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
	</div>

	<jsp:include page="common/footer.jsp"></jsp:include>

	<script type="text/javascript">
		$(document).ready(
				function() {
					$('#myTable').after(
							'<div id="nav" class="pagination"></div>');
					var rowsShown = 30;
					var rowsTotal = $('#myTable tbody tr').length;
					var numPages = rowsTotal / rowsShown;
					for (i = 0; i < numPages; i++) {
						var pageNum = i + 1;
						$('#nav')
								.append(
										'<a href="#" rel="'+i+'" >' + pageNum
												+ '</a> ');
					}
					$('#myTable tbody tr').hide();
					$('#myTable tbody tr').slice(0, rowsShown).show();
					$('#nav a:first').addClass('active');
					$('#nav a').bind(
							'click',
							function() {

								$('#nav a').removeClass('active');
								$(this).addClass('active');
								var currPage = $(this).attr('rel');
								var startItem = currPage * rowsShown;
								var endItem = startItem + rowsShown;
								$('#myTable tbody tr').css('opacity', '0.0')
										.hide().slice(startItem, endItem).css(
												'display', 'table-row')
										.animate({
											opacity : 1
										}, 300);
							});
				});
	</script>

	<c:if test="${msg != null }">
		<script type="text/javascript">
			var msg = '${msg}';
			alert(msg);
		</script>
	</c:if>
	
</body>
</html>
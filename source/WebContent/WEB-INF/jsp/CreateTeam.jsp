<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "bean.* , util.* , java.util.*, manager.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%
	Admin admin = null;
	List<Reviewer> listreviewer = new Vector<>();
	List<Team> teamList = new Vector<>();
	List<Project> listproject = new Vector<>();
	List<ProjectType> projectTypeList = new Vector<>();

	try {
		admin = (Admin) session.getAttribute("admin");
	} catch (Exception e) {
		e.printStackTrace();
	}
		
	try {
		listreviewer = (List<Reviewer>) request.getAttribute("listreviewer");
	} catch (Exception e) {
		e.printStackTrace();
	}

	boolean msg = false;
	try {
		msg = (boolean) request.getAttribute("msg");
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
<link rel="stylesheet" href="./css/multi_step_form.css">
</head>
<script type="text/javascript">
function validateForm(choosegroup) {
	var select = document.getElementById("team_name");
// choosegroup
	if (select == "") {
		alert("<!-- กรุณาเลือกกลุ่ม --> ");
		return false;
	}
}
</script>
<body <%if (msg) {%> onload="return result()" <% } %> style="background-image: url('./image/hero-bg.png')">
	<jsp:include page="common/navbar.jsp"></jsp:include>

	<div class="container" style="margin-top: 35px;">
		<div>
			<h1><i class="fa-solid fa-clipboard-list">&nbsp;</i>สร้างทีม</h1>
			<div id="multi-step-form-container">
				<!-- Form Steps / Progress Bar -->
				<ul
					class="form-stepper form-stepper-horizontal text-center mx-auto pl-0">
					<!-- Step 1 -->
					<li class="form-stepper-active text-center form-stepper-list" step="1">
						<a class="mx-2"> 
							<span class="form-stepper-circle"> 
								<span>1</span> 
							</span>
							<div class="label">อัปโหลดข้อมูลคณะกรรมการ</div>
						</a>
					</li>
					<!-- Step 2 -->
					<li class="form-stepper-unfinished text-center form-stepper-list" step="2">
						<a class="mx-2"> 
							<span class="form-stepper-circle text-muted"> 
								<span>2</span>
							</span>
							<div class="label text-muted">สร้างทีม</div>
						</a>
					</li>
					<!-- Step 3 -->
					<li class="form-stepper-unfinished text-center form-stepper-list" step="3">
						<a class="mx-2"> 
							<span class="form-stepper-circle text-muted"> 
								<span>3</span>
							</span>
							<div class="label text-muted">เลือกคณะกรรมการ</div>
						</a>
					</li>
					<!-- Step 4 -->
					<li class="form-stepper-unfinished text-center form-stepper-list" step="4">
						<a class="mx-2"> 
							<span class="form-stepper-circle text-muted"> 
								<span>4</span>
							</span>
							<div class="label text-muted">เลือกโครงงานวิทยาศาสตร์</div>
						</a>
					</li>
				</ul>
				<!-- Step Wise Form Content -->
				<!--    <form id="userAccountSetupForm" name="userAccountSetupForm" enctype="multipart/form-data" method="POST"> -->
				<!-- Step 1 Content -->
				<section id="step-1" class="form-step">
					<h2 class="font-normal">ขั้นตอนที่ 1 : นำเข้าข้อมูลคณะกรรมการ</h2>
					<!-- Step 1 input fields -->
					<div class="mt-3">
						<h6 style="color: red">ชี้แจ้ง : กรุณาอัปโหลดข้อมูลไฟล์ Excel เป็นนามสกุล .xlsx..</h6>
						<br>
						<form action="ImportReviewer" name="frm" method="post" enctype="multipart/form-data">
							<div class="form-group row">
								<div class="col-sm-4">
									<input class="form-control" type="file" name="fileexcel" id="fileexcel" accept=".csv, application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
								</div>								
								<div class="col-sm-3">
									<button type="submit" name="upload" class="btn btn-success">
										<i class="fa-solid fa-file-excel">&nbsp;</i>Import file
									</button>
								</div>
								<br>
								<label style="color: green; text-align: left; ">${msg}</label>
							</div>
						</form>
					</div>
					<div class="mt-3">
						<% 
						String disabled = null ;
							if (listreviewer.size() == 0 ) {
								disabled = "disabled" ; 
							}
						%>
						<button class="button btn-navigate-form-step" type="button" step_number="2" <%=disabled%>>ต่อไป</button>
						&nbsp;&nbsp;<label style="color: red; text-align: left; ">ปุ่มกด "ต่อไป" จะกดไม่ได้ถ้าไม่มีข้อมูลคณะกรรมการ</label>
					</div>
				</section>
				<!-- Step 2 Content, default hidden on page load. -->
				<form action="isCreateTeam" name="frm" id="choosegroup" method="post" >
				<section id="step-2" class="form-step d-none">
					<h2 class="font-normal">ขั้นตอนที่ 2 สร้างทีม</h2>
					<!-- Step 2 input fields -->
					<div class="mt-3">
						<h6 style="color: red">ชี้แจ้ง : กรุณาเลือกกลุ่ม..</h6>
						<br>
						<div class="form-group row">
							<label class="col-sm-2">กลุ่ม</label>
							<div class="col-sm-6" style="margin-left : -10%">									
								<select class="form-select" name="team_name" id="team_name" required>
										<option selected disabled >--กรุณาเลือกกลุ่ม--</option>
										<option value="มัธยมศึกษาตอนต้นสาขาวิทยาศาสตร์กายภาพ">มัธยมศึกษาตอนต้นสาขาวิทยาศาสตร์กายภาพ</option>
										<option value="มัธยมศึกษาตอนต้นสาขาวิทยาศาสตร์ชีวภาพ">มัธยมศึกษาตอนต้นสาขาวิทยาศาสตร์ชีวภาพ</option>
										<option value="มัธยมศึกษาตอนต้นสาขาวิทยาศาสตร์ประยุกต์">มัธยมศึกษาตอนต้นสาขาวิทยาศาสตร์ประยุกต์</option>
										<option value="มัธยมศึกษาตอนปลายสาขาวิทยาศาสตร์กายภาพ">มัธยมศึกษาตอนปลายสาขาวิทยาศาสตร์กายภาพ</option>
										<option value="มัธยมศึกษาตอนปลายสาขาวิทยาศาสตร์ชีวภาพ">มัธยมศึกษาตอนปลายสาขาวิทยาศาสตร์ชีวภาพ</option>
										<option value="มัธยมศึกษาตอนปลายสาขาวิทยาศาสตร์ประยุกต์">มัธยมศึกษาตอนปลายสาขาวิทยาศาสตร์ประยุกต์</option>
								</select>
							
							</div>												
						</div>
					</div>		
					<br>
					<div class="mt-3">
						<a class="button btn-navigate-form-step" type="button" step_number="1" style="text-decoration: none;">กลับ</a>				
						<a class="button btn-navigate-form-step" type="button" onclick ="return validateForm(choosegroup)" step_number="3" style="text-decoration: none;">ต่อไป</a>
					</div>					
				</section>
				<!-- Step 3 Content, default hidden on page load. -->
				<section id="step-3" class="form-step d-none">
					<h2 class="font-normal">ขั้นตอนที่ 3 : เลือกคณะกรรมการ</h2>
					<!-- Step 3 input fields -->
					<div class="mt-3">
						<h6 style="color: red">ชี้แจ้ง : กรุณาเลือกประธานคณะกรรมการ และคณะกรรมการ..</h6>
					</div>
					<br>
					<div class="container">
						<div class="form-group row">
							<div class="col-auto">
								<h5>ประธานคณะกรรมการ</h5>
							</div>
							<div class="col-auto" style="margin-left: 67% ;">
								<a href="getAddReviewer" class="btn btn-warning"><i
									class="fa-solid fa-user-tie">&nbsp;</i>เพิ่มคณะกรรมการ</a>
							</div>
						</div>
					</div>
					<hr class="colorgraph">				
						<table class="table table-bordered  table-hover" id=myTable>
						<thead class="table-primary" align="center">
							<tr>
								<th width="55"></th>
								<th width="250">รหัสคณะกรรมการ</th>
								<th>ชื่อคณะกรรมการ</th>
								<th width="55"></th>
							</tr>
						</thead>
						<tbody align="center">
							<%
								if (listreviewer.size() != 0) {					
							%>
							<%
								for (int i = 0; i < listreviewer.size(); i++) {
										if (listreviewer.get(i).getTeam().getTeam_id() == 0 && listreviewer.get(i).getPosition().equals("ประธานคณะกรรมการ")) {
							%>
							<tr>
								<td><input type="checkbox" id="chkreviewer" name="chkreviewer" value="<%=listreviewer.get(i).getReviewer_id()%>"></td>
								<td><%=listreviewer.get(i).getReviewer_id()%></td>
								<td><%=listreviewer.get(i).getPrefix() + "  " + listreviewer.get(i).getFirstname() + "  " + listreviewer.get(i).getLastname()%></td>
								<td><a href="ViewReviewerDetail?reviewer_id=<%=listreviewer.get(i).getReviewer_id()%>" class="btn btn-warning"> <i class="fa fa-eye" aria-hidden="true"></i></a></td>
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
						<thead class="table-primary" align="center">
							<tr>
								<th width="55"></th>
								<th width="270">รหัสคณะกรรมการ</th>
								<th>ชื่อคณะกรรมการ</th>
								<th width="55"></th>
							</tr>
						</thead>
						<tbody align="center">
							<%
								if (listreviewer.size() != 0) {
							%>
							<%
								for (int i = 0; i < listreviewer.size(); i++) {
										if (listreviewer.get(i).getTeam().getTeam_id() == 0 && listreviewer.get(i).getPosition().equals("คณะกรรมการ")) {
							%>
							<tr>
								<td><input type="checkbox" id="chkreviewer" name="chkreviewer" value="<%=listreviewer.get(i).getReviewer_id()%>"></td>
								<td><%=listreviewer.get(i).getReviewer_id()%></td>
								<td><%=listreviewer.get(i).getPrefix() + "  " + listreviewer.get(i).getFirstname() + "  " + listreviewer.get(i).getLastname()%></td>
								<td><a href="ViewReviewerDetail?reviewer_id=<%=listreviewer.get(i).getReviewer_id()%>" class="btn btn-warning"> <i class="fa fa-eye" aria-hidden="true"></i> </a></td>
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
					<div class="mt-3">
						<a class="button btn-navigate-form-step" type="button" step_number="2" style="text-decoration: none;">กลับ</a>	
						<a class="button btn-navigate-form-step" type="button" step_number="4" style="text-decoration: none;"> ต่อไป</a>
					</div>
				</section>
				<!-- Step 4 Content, default hidden on page load. -->
				<section id="step-4" class="form-step d-none">
					<h2 class="font-normal">ขั้นตอนที่ 4 : เลือกโครงงานวิทยาศาสตร์</h2>
					<!-- Step 4 input fields -->
					<div class="mt-3">
						<h6 style="color: red">Please, Import Excel file with .xlsx file extension..</h6>
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
											if (listproject.size() != 0) {
										%>
										<%
											for (int i = 0 ; i < listproject.size() ; i++) {	
												
												if (listproject.get(i).getTeam().getTeam_id() == 0 && listproject.get(i).getProjecttype().getProjecttype_name() == null) {
										%>
										<tr>
											<td align="center"><input type="checkbox" id="chkproject" name="chkproject" value="<%=listproject.get(i).getProject_id()%>"></td>
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
					</div>
					<div class="mt-3">
						<a class="button btn-navigate-form-step" type="button" step_number="3" style="text-decoration: none;">กลับ</a>	
						<button class="button submit-btn" type="submit" >บันทึก</button>
					</div>		
				</section>
				</form>
			</div>
		</div>
	</div>

	<jsp:include page="common/footer.jsp"></jsp:include>
	
	<c:if test="${msg != null }">
		<script type="text/javascript">
			var msg = '${msg}';
			alert(msg);
		</script>
	</c:if>
	
	<script>
    if ( window.history.replaceState ) {
        window.history.replaceState( null, null, window.location.href );
    }
	</script>
	
	<script type="text/javascript">
	/**
	 * Define a function to navigate betweens form steps.
	 * It accepts one parameter. That is - step number.
	 */
	const navigateToFormStep = (stepNumber) => {
	    /**
	     * Hide all form steps.
	     */
	    document.querySelectorAll(".form-step").forEach((formStepElement) => {
	        formStepElement.classList.add("d-none");
	    });
	    /**
	     * Mark all form steps as unfinished.
	     */
	    document.querySelectorAll(".form-stepper-list").forEach((formStepHeader) => {
	        formStepHeader.classList.add("form-stepper-unfinished");
	        formStepHeader.classList.remove("form-stepper-active", "form-stepper-completed");
	    });
	    /**
	     * Show the current form step (as passed to the function).
	     */
	    document.querySelector("#step-" + stepNumber).classList.remove("d-none");
	    /**
	     * Select the form step circle (progress bar).
	     */
	    const formStepCircle = document.querySelector('li[step="' + stepNumber + '"]');
	    /**
	     * Mark the current form step as active.
	     */
	    formStepCircle.classList.remove("form-stepper-unfinished", "form-stepper-completed");
	    formStepCircle.classList.add("form-stepper-active");
	    /**
	     * Loop through each form step circles.
	     * This loop will continue up to the current step number.
	     * Example: If the current step is 3,
	     * then the loop will perform operations for step 1 and 2.
	     */
	    for (let index = 0; index < stepNumber; index++) {
	        /**
	         * Select the form step circle (progress bar).
	         */
	        const formStepCircle = document.querySelector('li[step="' + index + '"]');
	        /**
	         * Check if the element exist. If yes, then proceed.
	         */
	        if (formStepCircle) {
	            /**
	             * Mark the form step as completed.
	             */
	            formStepCircle.classList.remove("form-stepper-unfinished", "form-stepper-active");
	            formStepCircle.classList.add("form-stepper-completed");
	        }
	    }
	};
	/**
	 * Select all form navigation buttons, and loop through them.
	 */
	document.querySelectorAll(".btn-navigate-form-step").forEach((formNavigationBtn) => {
	    /**
	     * Add a click event listener to the button.
	     */
	    formNavigationBtn.addEventListener("click", () => {
	        /**
	         * Get the value of the step.
	         */
	        const stepNumber = parseInt(formNavigationBtn.getAttribute("step_number"));
	        /**
	         * Call the function to navigate to the target form step.
	         */
	        navigateToFormStep(stepNumber);
	    });
	});
	</script>

	<script type="text/javascript">
		$(document).ready(
				function() {
					$('#myTable2').after(
							'<div id="nav" class="pagination"></div>');
					var rowsShown = 12;
					var rowsTotal = $('#myTable2 tbody tr').length;
					var numPages = rowsTotal / rowsShown;
					for (i = 0; i < numPages; i++) {
						var pageNum = i + 1;
						$('#nav')
								.append(
										'<a href="#" rel="'+i+'" >' + pageNum
												+ '</a> ');
					}
					$('#myTable2 tbody tr').hide();
					$('#myTable2 tbody tr').slice(0, rowsShown).show();
					$('#nav a:first').addClass('active');
					$('#nav a').bind(
							'click',
							function() {

								$('#nav a').removeClass('active');
								$(this).addClass('active');
								var currPage = $(this).attr('rel');
								var startItem = currPage * rowsShown;
								var endItem = startItem + rowsShown;
								$('#myTable2 tbody tr').css('opacity', '0.0')
										.hide().slice(startItem, endItem).css(
												'display', 'table-row')
										.animate({
											opacity : 1
										}, 300);
							});
				});
	</script>
	
</body>
</html>
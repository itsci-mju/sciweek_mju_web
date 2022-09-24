<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*"%>
<%
	Admin admin = null;
	List<StudentProject> listsproject = new Vector<>();
	List<StudentProject> studentProjectList = new Vector<>();
	String keyword = "";
	StudentProject sproject = null;
	
	try {
		sproject = (StudentProject) request.getAttribute("sproject");
		session.setAttribute("key",sproject.getProject().getProject_id());
	} catch (Exception e) {
		e.printStackTrace();
	}

	try {
		listsproject = (List<StudentProject>) request.getAttribute("listsproject");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try {
		admin = (Admin) session.getAttribute("admin");
	} catch (Exception e) {
		e.printStackTrace();
	}

	try {
		keyword = (String) request.getAttribute("keyword");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	if (keyword == null) {
		keyword = "";
	}
	
	boolean msg = false;
	try {
		msg = (boolean) request.getAttribute("msg");
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
<link rel="stylesheet" href="./css/multi_step_form.css">
</head>
<body <%if (msg) {%> onload="return result()" <% } %>  style="background-image: url('./image/hero-bg.png')">

	<jsp:include page="common/navbar.jsp"></jsp:include>

	<div class="container" style="margin-top: 35px;">
	
		<%-- <form action="searchproject" method="post" class="row g-3" >
			<div class="col-auto">
				<h3><i class="fa-solid fa-folder-open">&nbsp;</i>นำเข้าข้อมูลโครงงานวิทยาศาสตร์</h3>			
			</div>	
			<div class="col-auto text-center" style="margin-left : 529px;">
					<input type="text" class="form-control" name="keyword" value="<%=keyword%>" placeholder="ค้นหาโครงงานวิทยาศาสตร์....." title="Projects">
			</div>
			<div class="col-auto text-left">
				<button type="submit" class="btn btn-success"> <i class="fa fa-search">&nbsp;</i>ค้นหา</button>
			</div>
		</form>	
		
		<hr class="colorgraph">
		
		<form action="ImportExcel" name="frm" method="post" enctype="multipart/form-data">
			<div class="form-group row">
				<div class="col-sm-4">
					<input class="form-control" type="file" name="fileexcel" id="fileexcel" accept=".csv, application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
				</div>		
				<div class="col-sm-3" >
					<button type="submit" name="upload" class="btn btn-success"><i class="fa-solid fa-file-excel">&nbsp;</i>นำเข้าข้อมูลโครงงาน</button>
				</div>
			</div>
		</form>
		
		<%
				if (listsproject.size() != 0) {
		%>
		
		<table class="table table-bordered  table-hover" id=myTable > 
			<thead class="table-info">
				<tr>
					<th style="white-space: nowrap">รหัสโครงงานวิทยาศาสตร์</th>
					<th style="white-space: nowrap">ชื่อโครงงานวิทยาศาสตร์</th>
					<th style="white-space: nowrap">ข้อมูลโครงงานวิทยาศาสตร์</th>
				</tr>
			</thead>
			<tbody>
				
				<%
					for (StudentProject studentProject : listsproject) {
						Project project = studentProject.getProject();
				%>
				<tr>
					<td><%=project.getProject_id()%></td>
					<td ><%=project.getProjectname()%></td>
					<td align="center"><a href="ViewStudentProjectDetail?project_id=<%=project.getProject_id()%>">
							<button name="button" class="btn btn-warning">
								<i class="fa fa-eye"></i>&nbsp;ดูรายละเอียด
							</button></a>
					</td>
				</tr>
				<%
					}
				%>
				<%
					} 
				%>		
			</tbody>
		</table> --%>
		
	<div>
	
    <h1><i class="fa-solid fa-folder-open">&nbsp;</i>นำเข้าข้อมูลโครงงานวิทยาศาสตร์</h1>
    <div id="multi-step-form-container">
        <!-- Form Steps / Progress Bar -->
        <ul class="form-stepper form-stepper-horizontal text-center mx-auto pl-0">
            <!-- Step 1 -->
            <li class="form-stepper-active text-center form-stepper-list" step="1">
                <a class="mx-2">
                    <span class="form-stepper-circle">
                        <span>1</span>
                    </span>            
                    <div class="label">นำเข้าข้อมูลโครงงานวิทยาศาสตร์</div>
                </a>
            </li>
            <!-- Step 2 -->
            <li class="form-stepper-unfinished text-center form-stepper-list" step="2">
                <a class="mx-2">
                    <span class="form-stepper-circle text-muted">
                        <span>2</span>
                    </span>
                    <div class="label text-muted">รายการข้อมูลโครงงานวิทยาศาสตร์</div>
                </a>
            </li>
           <!-- Step 3 -->
          <!--   <li class="form-stepper-unfinished text-center form-stepper-list" step="3">
                <a class="mx-2">
                    <span class="form-stepper-circle text-muted">
                        <span>3</span>
                    </span>
                    <div class="label text-muted">ข้อมูลรายละเอียดโครงงานวิทยาศาสตร์</div>
                </a>
            </li> -->
        </ul>
        <!-- Step Wise Form Content -->
     <!--    <form id="userAccountSetupForm" name="userAccountSetupForm" enctype="multipart/form-data" method="POST"> -->
            <!-- Step 1 Content -->
            <section id="step-1" class="form-step">
                <h2 class="font-normal">ขั้นตอนที่ 1 : นำเข้าข้อมูลโครงงานวิทยาศาสตร์</h2>
                <!-- Step 1 input fields -->
                <div class="mt-3">
                    <h6 style="color : red">ชี้แจ้ง : กรุณาอัปโหลดข้อมูลไฟล์ Excel เป็นนามสกุล .xlsx..</h6>
                    <br>
						<form action="ImportExcel" name="frm" method="post" enctype="multipart/form-data">
							<div class="form-group row">
								<div class="col-sm-4">
									<input class="form-control" type="file" name="fileexcel" id="fileexcel"
										accept=".csv, application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
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
                    <button class="button btn-navigate-form-step" type="button" step_number="2">ต่อไป</button>
                </div>
            </section>
            <!-- Step 2 Content, default hidden on page load. -->
            <section id="step-2" class="form-step d-none">      
                <form action="searchproject" method="post" class="row g-3">
						<div class="col-auto">
							<h2 class="font-normal">ขั้นตอนที่ 2 : รายการโครงงานวิทยาศาสตร์</h2>
						</div>
						<div class="col-auto text-center" style="margin-left: 25%;">
							<input type="text" class="form-control" name="keyword" value="<%=keyword%>" placeholder="ค้นหาโครงงานวิทยาศาสตร์....." title="Projects">
						</div>
						<div class="col-auto text-left">
							<button type="submit" class="btn btn-success"><i class="fa fa-search">&nbsp;</i>ค้นหา</button>
						</div>
					</form>
                <!-- Step 2 input fields -->
                <div class="mt-3">
                    <h6 style="color : red">ชี้แจ้ง : กรุณาอัปโหลดข้อมูลไฟล์ Excel เป็นนามสกุล .xlsx..</h6>
                    <br>
						<%
							if (listsproject.size() != 0) {
						%>

						<table class="table table-bordered  table-hover" id=myTable>
							<thead class="table-primary" align="center">
								<tr>
									<th style="white-space: nowrap">รหัสโครงงานวิทยาศาสตร์</th>
									<th style="white-space: nowrap">ชื่อโครงงานวิทยาศาสตร์</th>
									<th style="white-space: nowrap"></th>
								</tr>
							</thead>
							<tbody>

								<%
									for (StudentProject studentProject : listsproject) {
											Project project = studentProject.getProject();
								%>
								<tr>
									<td><%=project.getProject_id()%></td>
									<td><%=project.getProjectname()%></td>
									<td align="center"><a href="ViewStudentProjectDetail?project_id=<%=project.getProject_id()%>">
											<button type="button"  class="btn btn-warning">
												<i class="fa fa-eye"></i>
											</button>
									</a></td>
								</tr>
								<%
									}
								%>
								<%
									} 
								%>
							</tbody>
						</table>
					</div>
                <div class="mt-3">
                    <button class="button btn-navigate-form-step" type="button" step_number="1">ย้อนกลับ</button>
                </div>
            </section>
            <!-- Step 3 Content, default hidden on page load. -->
           <!--  <section id="step-3" class="form-step d-none">
                <h2 class="font-normal">ขั้นตอนที่ 3 : บันทึกข้อมูลโครงงานวิทยาศาสตร์</h2>
                Step 3 input fields
                <div class="mt-3">
                    
                </div>
                <div class="mt-3">
                    <button class="button btn-navigate-form-step" type="button" step_number="2">กลับ</button>
                    <button class="button submit-btn" type="submit">บันทึก</button>
                </div>
            </section>  -->
       <!--  </form> -->
    </div>
</div>
	</div>

	<jsp:include page="common/footer.jsp"></jsp:include>

	<script type="text/javascript">
		$(document).ready(
				function() {
					$('#myTable').after(
							'<div id="nav" class="pagination" ></div>');
					var rowsShown = 10;
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

	<c:if test="${msg != null }">
		<script type="text/javascript">
			var msg = '${msg}';
			alert(msg);
		</script>
	</c:if>
</body>
</html>
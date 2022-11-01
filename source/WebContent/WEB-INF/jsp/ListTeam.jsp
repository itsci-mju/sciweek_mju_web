<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*"%>
<%
	Admin admin = null;
	List<ProjectType> projectTypeList = new Vector<>();
	List<Reviewer> reviewerList = new Vector<>();
	String keyword = "";

	try {
		admin = (Admin) session.getAttribute("admin");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try {
		reviewerList = (List<Reviewer>) request.getAttribute("reviewerList");
	} catch (Exception e) {	
		e.printStackTrace();
	}
	
	try {
		projectTypeList = (List<ProjectType>) request.getAttribute("projectTypeList");
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
<style type="text/css">
.container1 {
  padding: 50px 10%;
}

.box {
  position: relative;
  background: #FCFAF1;
  width: 100%;
}

.box-header {
  color: #444;
  display: block;
  padding: 10px;
  position: relative;
  border-bottom: 1px solid #f4f4f4;
  margin-bottom: 10px;
}

.box-tools {
  position: absolute;
  right: 10px;
  top: 5px;
}

.dropzone-wrapper {
  border: 2px dashed #91b0b3;
  color: #92b0b3;
  position: relative;
  height: 150px;
}

.dropzone-desc {
  position: absolute;
  margin: 0 auto;
  left: 0;
  right: 0;
  text-align: center;
  width: 40%;
  top: 50px;
  font-size: 16px;
}

.dropzone,
.dropzone:focus {
  position: absolute;
  outline: none !important;
  width: 50%;
  height: 150px;
  cursor: pointer;
  opacity: 0;
  
}

.dropzone-wrapper:hover,
.dropzone-wrapper.dragover {
  background: #ecf0f5;
}

.preview-zone {
  text-align: center;
}

.preview-zone .box {
  box-shadow: none;
  border-radius: 0;
  margin-bottom: 0;
}

</style>
</head>
<script type="text/javascript">

	function validateImportForm(frmexcel) {
		
		if (frmexcel.fileexcel.value == "") {
			alert("<!-- กรุณาอัปโหลดไฟล์ Excel -->");
			return false;
		}

	}
		
</script>
<body style="background-image: url('./image/hero-bg.png') ; background-repeat: no-repeat ; background-attachment: fixed ; background-size: 100% 100%">

	<jsp:include page="common/navbar.jsp"></jsp:include>

	<div class="container" style="margin-top: 35px;">
		<div class="form-group row">
			<div class="col-auto">
				<h3><i class="fa-solid fa-clipboard-list">&nbsp;</i>รายการทีม</h3>		
			</div>	
		</div>						

		<hr class="colorgraph">

		<div class="container">
			<form action="ImportReviewer" id="frmexcel" method="post" class="row g-3" enctype="multipart/form-data">
				<section id="content">
					<div class="container" style="margin-top: -20px">
					
						<div class="row">
							<div class="col-lg-12">
								<div class="container">
									<br>
									<div class="form-group" align="center">
										<div class="col-sm-6">
											<div class="preview-zone hidden">
												<div class="box box-solid">
													<div class="box-header with-border">
														<div class="box-tools pull-right"></div>
													</div>
													<div class="box-body"></div>
												</div>
												<br>
											</div>

											<div class="dropzone-wrapper">
												<div class="dropzone-desc">
													<i class="glyphicon glyphicon-download-alt"></i>
													<p> <i class='fa-solid fa-file-excel' style='font-size: 36px'></i> </p>
													<p>เลือกไฟล์หรือลากมาที่นี่.</p>
												</div>
												<input type="file" name="fileexcel" id="fileexcel"
													class="dropzone"
													accept=".csv, application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
											</div>
										</div>
									</div>
									<br>
									<div class="form-group row">
										<div class="col-sm-12 text-center">
											<button type="submit" class="btn btn-success"
												onclick="return validateImportForm(frmexcel)">นำเข้าข้อมูลคณะกรรมการ</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</section>
			</form>
		</div>
		<br>
		<div class="alert alert-danger" role="alert" style="text-align:center; font-weight:bold;">
  			ชี้แจ้ง : ถ้าไม่มีข้อมูลกลุ่มประเมินโครงงานวิทยาศาสตร์ กรุณานำเข้าข้อมูลคณะกรรมการ..
		</div>
		<table class="table table-bordered  table-hover" id=myTable>
			<thead class="table-info" align="center">
				<tr>
					<th width="100">ลำดับทีม</th>
					<th>ชื่อทีม</th>
					<th width="200">ข้อมูลทีม</th>
				</tr>
			</thead>
			<tbody align="center">
				<%
					if (projectTypeList.size() != 0 && reviewerList.size() != 0) {
				%>
				<%
					for (ProjectType projecttype : projectTypeList) {
				%>
				<tr>
					<td><%=projecttype.getProjecttype_id()%></td>
					<td><%=projecttype.getProjecttype_name()%></td>
					<td><a href="ViewTeamDetail?projecttype_id=<%=projecttype.getProjecttype_id()%>">
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

	<script>
		function readFile(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();

				reader.onload = function(e) {
					var htmlPreview = '<img width="200" src="' + e.target.result + '" />'
							+ '<p>' + input.files[0].name + '</p>';
					var wrapperZone = $(input).parent();
					var previewZone = $(input).parent().parent().find(
							'.preview-zone');
					var boxZone = $(input).parent().parent().find(
							'.preview-zone').find('.box').find('.box-body');

					wrapperZone.removeClass('dragover');
					previewZone.removeClass('hidden');
					boxZone.empty();
					boxZone.append(htmlPreview);
				};

				reader.readAsDataURL(input.files[0]);
			}
		}

		function reset(e) {
			e.wrap('<form>').closest('form').get(0).reset();
			e.unwrap();
		}

		$(".dropzone").change(function() {
			readFile(this);
		});

		$('.dropzone-wrapper').on('dragover', function(e) {
			e.preventDefault();
			e.stopPropagation();
			$(this).addClass('dragover');
		});

		$('.dropzone-wrapper').on('dragleave', function(e) {
			e.preventDefault();
			e.stopPropagation();
			$(this).removeClass('dragover');
		});

		$('.remove-preview').on('click', function() {
			var boxZone = $(this).parents('.preview-zone').find('.box-body');
			var previewZone = $(this).parents('.preview-zone');
			var dropzone = $(this).parents('.form-group').find('.dropzone');
			boxZone.empty();
			previewZone.addClass('hidden');
			reset(dropzone);
		});
	</script>

	<script>
		$(document).ready(function() {
			$('.customer-logos').slick({
				slidesToShow : 6,
				slidesToScroll : 1,
				autoplay : true,
				autoplaySpeed : 1500,
				arrows : false,
				dots : false,
				pauseOnHover : false,
				responsive : [ {
					breakpoint : 768,
					settings : {
						slidesToShow : 4
					}
				}, {
					breakpoint : 520,
					settings : {
						slidesToShow : 3
					}
				} ]
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
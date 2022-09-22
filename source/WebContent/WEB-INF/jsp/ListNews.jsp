<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	Admin admin = null;
	List<Pressrelease> listnews =null;
	String keyword = "";
	
	try {
		admin = (Admin) session.getAttribute("admin");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try {
		listnews = (List<Pressrelease>) request.getAttribute("listnews");
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
<!-- ckeditor-->
<script src="//cdn.ckeditor.com/4.6.2/standard/ckeditor.js"></script>
<link href="./image/logo.png" rel="icon">
<link rel="stylesheet"	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/e18a64822c.js"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Kanit'	rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="./css/web_css.css">
<link rel="stylesheet" href="./css/rte_theme_default.css">
<script	src="./js/all_plugins.js"></script>
<script	src="./js/patch.js"></script>
<script	src="./js/rte.js"></script>
</head>

<body style="background-image: url('./image/hero-bg.png')">

	<jsp:include page="common/navbar.jsp"></jsp:include>
	
	<div class="container" style="margin-top: 35px;">
		<div class="form-group row">
			<div class="col-auto">
				<h3><i class="fa-solid fa-newspaper">&nbsp;</i>ประชาสัมพันธ์</h3>
			</div>	
			<div class="col-auto">
				<button name="button" class="btn btn-warning mb-3" onclick="window.location.href='loadAddNewsPage';" style="margin-left : 959px;">
					<i class="fa fa-bullhorn" aria-hidden="true">&nbsp;</i>ประกาศข่าว
				</button>
			</div>
		</div>
		
		<hr class="colorgraph">

		<form action="searchnews" method="post">
			<div class="form-group row">
				<div class="col-sm-4 text-center">
					<input type="text" class="form-control" name="keyword" value="<%=keyword%>" placeholder="ค้นหาข่าวประชาสัมพันธ์" title="News">
				</div>
				<div class="col-sm-2 text-left">
					<button type="submit" class="btn btn-success">
						<i class="fa fa-search"></i>&nbsp;ค้นหา
					</button>
				</div>
			</div>
		</form>

		<table id="myTable" class="table table-bordered ">
			<thead class="table-info" align="center">
				<tr>
					<th scope="col">รูปภาพ</th>
					<th scope="col">หัวข้อ</th>
					<th scope="col" style="width: 150px;">รายละเอียด</th>
				</tr>
			</thead>
			<tbody>
				<%
					if (listnews.size() != 0) {
				%>
				<%
					for (int i = 0; i < listnews.size(); i++) {
				%>
				<tr>

					<td style="width: 300px;" align="center"><img src="./news_img/<%=listnews.get(i).getNewsid()%>.png" width="275" height="233"
						style="border: 1px solid #ddd; border-radius: 4px; padding: 5px; object-fit: cover; object-position: 100% 0;"></td>
					<td><%=listnews.get(i).getTitle()%></td>
					<td style="width: 160px;" align="center">
						<button class="btn btn-success"
							onclick="return btnshow('<%=listnews.get(i).getNewsid()%>')"><i class="fa fa-book">&nbsp;</i>ดูรายละเอียด
						</button>
						
						<form action="editnews" method="POST" enctype="multipart/form-data" name="addform" class="form-horizontal" id="addform">
							<input type="hidden" name="id" value="<%=listnews.get(i).getNewsid()%>">
							<div id="news<%=listnews.get(i).getNewsid()%>" class="modal">
								<!-- Modal content -->
								<div class="modal-content">

									<div class="form-group row">
										<div class="col-sm-12" align="right">
											<span class="close"
												onclick="return spanclick('<%=listnews.get(i).getNewsid()%>')"
												style="color: red;">&times;</span>
										</div>
									</div>

									<div class="form-group row">
										<div class="col-sm-12" align="center">
											<img src="./news_img/<%=listnews.get(i).getNewsid()%>.png"
												width="700" height="560"
												style="border: 1px solid #ddd; border-radius: 4px; padding: 5px;">
										</div>
									</div>

									<div class="form-group row">
										<label class="col-sm-2 col-form-label text-right">หัวข้อข่าว</label>
										<div class="col-sm-8">
											<input type="text" name="title" id="title" class="form-control data" value="<%=listnews.get(i).getTitle()%>">
										</div>
									</div>
									
									<div class="form-group row">
										
										<label class="col-sm-2 col-form-label text-right">ประเภทข่าว</label>
										<div class="col-sm-4">
											<select class="form-control" name="type" id="type" required>
												<option value="ข่าวกิจกรรม." <%if (listnews.get(i).getType().equals("ข่าวกิจกรรม")) {%> selected
												<%}%>>ข่าวกิจกรรม</option>
												<option value="ข่าวจากแหล่งอื่น" <%if (listnews.get(i).getType().equals("ข่าวจากแหล่งอื่น")) {%> selected
												<%}%>>ข่าวจากแหล่งอื่น</option>
												<option value="ข่าวสารประชาสัมพันธ์" <%if (listnews.get(i).getType().equals("ข่าวสารประชาสัมพันธ์")) {%> selected
												<%}%>>ข่าวสารประชาสัมพันธ์</option>
											</select>
										</div>
									</div>
									
									<div class="form-group row">
										<label class="col-sm-2 col-form-label text-right"></label> <label
											class="col-sm-8 col-form-label ">
											ปรับปรุงข้อมูลล่าสุด : <% String date = ""; %> <%=date = new SimpleDateFormat("dd/MM/yyyy HH:mm", new Locale("th", "TH")) .format(listnews.get(i).getCreatedate())%>
										</label>
									</div>


									<div class="form-group row">
										<div class="col-sm-12" align="left">
											<textarea name="article_detail" id="div_editor<%=i%>"><%=listnews.get(i).getDetail()%></textarea>
											<script type="text/javascript">
												var editor1 = new RichTextEditor("#div_editor<%=i%>");
											</script>
										</div>
									</div>


									<div class="form-group row">
										<div class="col-sm-12 text-center">
											<button type="submit" class="btn btn-success">แก้ไข </button>
											<a href="deletenews?id=<%=listnews.get(i).getNewsid()%>">
												<button type="button" class="btn btn-danger"
													onclick="return confirm('คุณต้องการลบข่าวนี้หรือไม่ ');">
													ลบ</button>
											</a>
										</div>
									</div>


								</div>
							</div>


						</form>

					</td>

				</tr>

				<%
					}
				%>
				<%
					} else {
				%>

				<tr>
					<td colspan="5">ไม่มีข้อมูล</td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>

		<br> <br>
			</div>
			<jsp:include page="common/footer.jsp"></jsp:include>

			<script type="text/javascript">
				$(document).ready(
						function() {
							$('#myTable').after('<div id="nav" class="pagination"></div>');
							var rowsShown = 4;
							var rowsTotal = $('#myTable tbody tr').length;
							var numPages = rowsTotal / rowsShown;
							for (i = 0; i < numPages; i++) {
								var pageNum = i + 1;
								$('#nav').append(
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
										$('#myTable tbody tr').css('opacity',
												'0.0').hide().slice(startItem,
												endItem).css('display',
												'table-row').animate({
											opacity : 1
										}, 300);
									});
						});
			</script>
	<script>
		function btnshow(no) {
			var modal = document.getElementById("news" + no);
			modal.style.display = "block";
			window.onclick = function(event) {
				if (event.target == modal) {
					modal.style.display = "none";
				}
			}
		}

		function spanclick(no) {
			var modal = document.getElementById("news" + no);
			modal.style.display = "none";
			window.onclick = function(event) {
				if (event.target == modal) {
					modal.style.display = "none";
				}
			}
		}
	</script>
	<c:if test="${msg != null }">
		<script type="text/javascript">
			var msg = '${msg}';
			alert(msg);
		</script>
	</c:if>
</body>
</html>
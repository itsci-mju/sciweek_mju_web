<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*,java.sql.Timestamp"%>
<%
	Student student = null;
	Reviewer reviewer = null;
	Admin admin = null;
	String error = null; 
	Integer errors = null;

	try {
		student = (Student) session.getAttribute("student");
	} catch (Exception e) {
		
	}
	
	try {
		reviewer = (Reviewer) session.getAttribute("reviewer");
	} catch (Exception e) {

	}

	try {
		admin = (Admin) session.getAttribute("admin");
	} catch (Exception e) {

	}
	
	try {
		errors = (Integer) request.getAttribute("errors");
	} catch (Exception e) {
		
	}
	
	ListNewsManager listNewsManager= new ListNewsManager();
	List<Pressrelease> listnews = listNewsManager.getlistNewsForshow();
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
<link rel="stylesheet" href="./css/index_css.css">
</head>

<body style="background-image: url('./image/hero-bg.png')">

	<jsp:include page="common/navbar.jsp"></jsp:include>

	<div style="margin-top: 5px;">
		<section id="content">
				<div class="row">
					<div class="col-lg-12">
						<div style="margin-bottom: 5px; border: dashed 1px #eee; height: 35px; line-height: 30px;">
							<marquee onmouseover="this.stop()" onmouseout="this.start()">
								<a href="index">เว็บไซต์ประเมินโครงงานวิทยาศาสตร์ คณะวิทยาศาสตร์ มหาวิทยาลัยแม่โจ้</a>
							</marquee>
						</div>
					</div> 
				</div>
		</section>
	</div>
	
	<%
		if (student != null && errors == 1) {
			
			Date present = new Date();  
		    Timestamp timestamp = new Timestamp(present.getTime());  
		    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss"); 
			String presentdate = new SimpleDateFormat("dd/MM/yyyy").format(present.getTime());
			String presenttime = new SimpleDateFormat("HH:mm").format(present.getTime()); 
			
			error = "กรุณาอัปโหลดเอกสารรายงานและวิดีโอ";
	%>
	<section style="margin-top : -45px">
		<div class="container mt-5">
			<div class="row">
				<div class="col-sm-12">
					<div
						class="alert fade alert-simple alert-danger alert-dismissible text-left font__family-montserrat font__size-16 font__weight-light brk-library-rendered rendered show"
						role="alert" data-brk-library="component__alert">
						<button type="button" class="close font__size-18"
							data-dismiss="alert">
							<span aria-hidden="true"> 
								<i class="fa fa-times danger "></i> 
							</span> 
							<span class="sr-only">Close</span>
						</button>
						<i class="start-icon far fa-times-circle faa-pulse animated"></i>
						<strong class="font__weight-semibold">แจ้งเตือน !!!</strong>&nbsp;วันที่ : <%=presentdate%> เวลา <%=presenttime%> น. &nbsp; <a href="doListProject"><i class="fa-solid fa-hand-point-right">&nbsp;</i><%=error%></a>
					</div>
				</div>
			</div>
		</div>
	</section>
	<% } %>
	
	<% 
		if (student != null && errors == 2) { 
			
			Date present = new Date();  
		    Timestamp timestamp = new Timestamp(present.getTime());  
		    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss"); 
			String presentdate = new SimpleDateFormat("dd/MM/yyyy").format(present.getTime());
			String presenttime = new SimpleDateFormat("HH:mm").format(present.getTime()); 
			
			error = "กรุณาอัปโหลดวิดีโอ" ;	
	%>
	<section style="margin-top : -45px">
		<div class="container mt-5">
			<div class="row">
				<div class="col-sm-12">
					<div
						class="alert fade alert-simple alert-danger alert-dismissible text-left font__family-montserrat font__size-16 font__weight-light brk-library-rendered rendered show"
						role="alert" data-brk-library="component__alert">
						<button type="button" class="close font__size-18"
							data-dismiss="alert">
							<span aria-hidden="true"> 
								<i class="fa fa-times danger "></i> 
							</span> 
							<span class="sr-only">Close</span>
						</button>
						<i class="start-icon far fa-times-circle faa-pulse animated"></i>
						<strong class="font__weight-semibold">แจ้งเตือน !!!</strong>&nbsp;วันที่ : <%=presentdate%> เวลา <%=presenttime%> น. &nbsp; <a href="doListProject"><i class="fa-solid fa-hand-point-right">&nbsp;</i><%=error%></a>
					</div>
				</div>
			</div>
		</div>
	</section>
	<% } %>
	
	<% 
		if (student != null && errors == 3) { 
			
			Date present = new Date();  
		    Timestamp timestamp = new Timestamp(present.getTime());  
		    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss"); 
			String presentdate = new SimpleDateFormat("dd/MM/yyyy").format(present.getTime());
			String presenttime = new SimpleDateFormat("HH:mm").format(present.getTime()); 
			
			error = "กรุณาอัปโหลดเอกสารรายงาน" ;	
	%>
	<section style="margin-top : -45px">
		<div class="container mt-5">
			<div class="row">
				<div class="col-sm-12">
					<div
						class="alert fade alert-simple alert-danger alert-dismissible text-left font__family-montserrat font__size-16 font__weight-light brk-library-rendered rendered show"
						role="alert" data-brk-library="component__alert">
						<button type="button" class="close font__size-18"
							data-dismiss="alert">
							<span aria-hidden="true"> 
								<i class="fa fa-times danger "></i> 
							</span> 
							<span class="sr-only">Close</span>
						</button>
						<i class="start-icon far fa-times-circle faa-pulse animated"></i>
						<strong class="font__weight-semibold">แจ้งเตือน !!!</strong>&nbsp;วันที่ : <%=presentdate%> เวลา <%=presenttime%> น. &nbsp; <a href="doListProject"><i class="fa-solid fa-hand-point-right">&nbsp;</i><%=error%></a>
					</div>
				</div>
			</div>
		</div>
	</section>
	<% } %>
	
	<div style="margin-top: -5px; margin-bottom: 5px">
		<div id="carouselExampleIndicators" class="carousel slide"
			data-ride="carousel">
			<ol class="carousel-indicators"></ol>
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img class="d-block w-100" src="./image/banner.png" alt="First slide" width="100%" height="75%" >
				</div>
			</div>
		</div>
	</div>
	<div style="background-image: url('./image/line_bg.gif')">
		<br>
		<h2 class="text-header text-center">ข่าวประชาสัมพันธ์และกิจกรรม</h2>
		<hr class="colorgraph">
		<section class="section " id="blog" style="margin-top: -60px;">
			<div class="container">
				<%
					String date = "";
				%>
				<%
					for (int i = 0; i < listnews.size(); i++) {
				%>
				<div class="row">
				
					<div class="col-lg-4">
						<div class="blog-grid">
							<div class="blog-img">
								<div class="date">
									<%=date = new SimpleDateFormat("dd MMM yyyy", new Locale("th", "TH")).format(listnews.get(i).getCreatedate())%>
								</div>

								<img src="./news_img/<%=listnews.get(i).getNewsid()%>.png"
									width="350" height="308"
									style="border: 1px solid #ddd; border-radius: 4px; padding: 5px; object-fit: cover; object-position: 100% 0; align: center;"
									title="" alt="">

							</div>
							<div class="blog-info">
								<div style="height: 96px;">
									<b style="word-wrap: break-word;"> <%=listnews.get(i).getTitle()%></b>					
								</div>
								<div class="btn-bar">
									<a href="ViewPressreleaseDetail?id=<%=listnews.get(i).getNewsid()%>" class="px-btn-arrow"> 
										<span>อ่านเพิ่มเติม</span> 
										<i class="arrow"></i>
									</a>
								</div>
							</div>
						</div>
					</div>
					<%
						i++;
							if (i < listnews.size()) {
					%>

					<div class="col-lg-4">
						<div class="blog-grid">
							<div class="blog-img">
								<div class="date">
									<%=date = new SimpleDateFormat("dd MMM yyyy", new Locale("th", "TH")).format(listnews.get(i).getCreatedate())%>
								</div>

								<img src="./news_img/<%=listnews.get(i).getNewsid()%>.png"
									width="350" height="308"
									style="border: 1px solid #ddd; border-radius: 4px; padding: 5px; object-fit: cover; object-position: 100% 0;"
									title="" alt="">

							</div>
							<div class="blog-info">
								<div style="height: 96px;">
									<b style="word-wrap: break-word;"> <%=listnews.get(i).getTitle()%>
									</b>
								</div>
								<div class="btn-bar">
									<a href="ViewPressreleaseDetail?id=<%=listnews.get(i).getNewsid()%>" class="px-btn-arrow"> 
										<span>อ่านเพิ่มเติม</span>
										<i class="arrow"></i>
									</a>
								</div>
							</div>
						</div>
					</div>
					<%
						}
					%>

					<%
						i++;
							if (i < listnews.size()) {
					%>

					<div class="col-lg-4">
						<div class="blog-grid">
							<div class="blog-img">
								<div class="date">
									<%=date = new SimpleDateFormat("dd MMM yyyy", new Locale("th", "TH")).format(listnews.get(i).getCreatedate())%>
								</div>

								<img src="./news_img/<%=listnews.get(i).getNewsid()%>.png"
									width="350" height="308"
									style="border: 1px solid #ddd; border-radius: 4px; padding: 5px; object-fit: cover; object-position: 100% 0;"
									title="" alt="">

							</div>
							<div class="blog-info">
								<div style="height: 96px;">
									<b style="word-wrap: break-word;"> <%=listnews.get(i).getTitle()%>
									</b>
								</div>
								<div class="btn-bar">
									<a href="ViewPressreleaseDetail?id=<%=listnews.get(i).getNewsid()%>" class="px-btn-arrow"> 
										<span>อ่านเพิ่มเติม</span> 
										<i class="arrow"></i>
									</a>
								</div>
							</div>
						</div>
					</div>
					<% } %>
				</div>
				<% } %>
			</div>
		</section>
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
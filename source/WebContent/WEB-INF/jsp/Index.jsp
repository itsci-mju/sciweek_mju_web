<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="java.util.*,manager.*,bean.*,java.text.*"%>
<%
	Student student = null;
	Reviewer reviewer = null;
	Admin admin = null;

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

<style type="text/css">
.zoom {
	padding: 50px;
	background-color: green;
	transition: transform .2s;
	width: 200px;
	height: 200px;
	margin: 0 auto;
}

.zoom:hover {
	-ms-transform: scale(1.5); /* IE 9 */
	-webkit-transform: scale(1.5); /* Safari 3-8 */
	transform: scale(1.5);
}

.section {
	padding: 100px 0;
	position: relative;
}

.gray-bg {
	background-color: #ebf4fa;
}
/* Blog 
---------------------*/
.blog-grid {
	margin-top: 15px;
	margin-bottom: 15px;
}

.blog-grid .blog-img {
	position: relative;
	border-radius: 5px;
	overflow: hidden;
}

.blog-grid .blog-img .date {
	position: absolute;
	background: #3a3973;
	color: #ffffff;
	padding: 8px 15px;
	left: 0;
	top: 10px;
	font-size: 14px;
}

.blog-grid .blog-info {
	box-shadow: 0 0 30px rgba(31, 45, 61, 0.125);
	border-radius: 5px;
	background: #ffffff;
	padding: 20px;
	margin: -30px 20px 0;
	position: relative;
}

.blog-grid .blog-info h5 {
	font-size: 22px;
	font-weight: 500;
	margin: 0 0 10px;
}

.blog-grid .blog-info h5 a {
	color: #3a3973;
}

.blog-grid .blog-info p {
	margin: 0;
}

.blog-grid .blog-info .btn-bar {
	margin-top: 20px;
}

.px-btn-arrow {
	padding: 0 50px 0 0;
	line-height: 20px;
	position: relative;
	display: inline-block;
	color: #fe4f6c;
	-moz-transition: ease all 0.3s;
	-o-transition: ease all 0.3s;
	-webkit-transition: ease all 0.3s;
	transition: ease all 0.3s;
}

.px-btn-arrow .arrow {
	width: 13px;
	height: 2px;
	background: currentColor;
	display: inline-block;
	position: absolute;
	top: 0;
	bottom: 0;
	margin: auto;
	right: 25px;
	-moz-transition: ease right 0.3s;
	-o-transition: ease right 0.3s;
	-webkit-transition: ease right 0.3s;
	transition: ease right 0.3s;
}

.px-btn-arrow .arrow:after {
	width: 8px;
	height: 8px;
	border-right: 2px solid currentColor;
	border-top: 2px solid currentColor;
	content: "";
	position: absolute;
	top: -3px;
	right: 0;
	display: inline-block;
	-moz-transform: rotate(45deg);
	-o-transform: rotate(45deg);
	-ms-transform: rotate(45deg);
	-webkit-transform: rotate(45deg);
	transform: rotate(45deg);
}
</style>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	boolean error_msg = false;
	try {
		error_msg = (boolean) request.getAttribute("error_msg");
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
<link rel="stylesheet"	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/e18a64822c.js"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href='https://fonts.googleapis.com/css?family=Kanit'	rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="./css/web_css.css">
<style>
body {
	font-family: Arial, Helvetica, sans-serif;
}
/* * {
	box-sizing: border-box;
} */

/* style the container */
.container2 {
	position: relative;
	border-radius: 5px;

	padding: 20px 0 30px 0;
}

/* style inputs and link buttons */
input, .btn {
	width: 100%;
	padding: 12px;
	border: none;
	border-radius: 4px;
	margin: 5px 0;
	opacity: 0.85;
	display: inline-block;
	font-size: 17px;
	line-height: 20px;
	text-decoration: none; /* remove underline from anchors */
}

input:hover, .btn:hover {
	opacity: 1;
}

/* add appropriate colors to fb, twitter and google buttons */
.mju {
	margin-top: 9%;
	background-color: #45a049;
	color: white;
}

/* style the submit button */
input[type=submit] {
	background-color: #04AA6D;
	color: white;
	cursor: pointer;
}

input[type=button]:hover {
	background-color: #45a049;
}

/* style the submit button */
input[type=button] {
	background-color: #04AA6D;
	color: white;
	cursor: pointer;
}

input[type=submit]:hover {
	background-color: #45a049;
}

/* Two-column layout */
.col2 {
	float: left;
	width: 50%;
	margin: auto;
	padding: 0 50px;
	margin-top: 6px;
}

/* Clear floats after the columns */
.row2:after {
	content: "";
	display: table;
	clear: both;
}

/* vertical line */
.vl2 {
	position: absolute;
	left: 50%;
	transform: translate(-50%);
	border: 2px solid #ddd;
	height: 175px;
}

/* text inside the vertical line */
.vl-innertext2 {
	position: absolute;
	top: 50%;
	transform: translate(-50%, -50%);
	background-color: #f1f1f1;
	border: 1px solid #ccc;
	border-radius: 50%;
	padding: 8px 10px;
}

/* hide some text on medium and large screens */
.hide-md-lg2 {
	display: none;
}

/* bottom container */
.bottom-container2 {
	text-align: center;
	background-color: #666;
	border-radius: 0px 0px 4px 4px;
}

/* Responsive layout - when the screen is less than 650px wide, make the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 650px) {
	.col2 {
		width: 100%;
		margin-top: 0;
	}
	/* hide the vertical line */
	.vl2 {
		display: none;
	}
	/* show the hidden text on small screens */
	.hide-md-lg2 {
		display: block;
		text-align: center;
	}
}
</style>
</head>
<script type="text/javascript">

	function validateForm(frm) {
		
		var regex_email = /^[_a-zA-Z0-9-]+(.[_a-zA-Z0-9-]+)@[a-zA-Z0-9-]+(.[a-zA-Z0-9-]+)(.([a-zA-Z]){2,4})$/;
		var regex_password = /^[A-Za-z|0-9]{8,16}$/;
		
	// email
		if(frm.floatingInput.value == "") {
			alert('<!-- กรุณากรอกอีเมล -->');
			return false;
		}
		if(regex_email.test(frm.floatingInput.value) == false) {
			alert("<!-- กรุณากรอกอีเมลให้ถูกต้อง -->");
			return false ;
		}
		
	}
</script>
<body <%if (error_msg) {%> onload="return result()" <%}%>>

	<div class="container" style="margin-top: 50px;">	
		<div class="row2">
			<h2 style="text-align: center">เข้าสู่ระบบ</h2>
			<br>
			<form action="verifylogin" name="frm" id="frm" method="post">	
				<div class="form-group row" style="margin-left: 5px;">
				
					<div class="col-sm-5" align="center">
						<iframe width="480" height="275" src="https://www.youtube.com/embed/8LBXQ3VLx08?controls=0&showinfo=1&rel=1&autoplay=1&mute=1&loop=1" ></iframe>
					</div>
					
					<div class="col-sm-2" align="center">
					</div>
				
					<div class="col-sm-4" style="margin-left: -60px;">
						<br>
						<div class="input-group mb-3">
							<span class="input-group-text"><i class="fa-solid fa-at"></i></span> 
							<div class="form-floating">
								<input type="email" class="form-control" placeholder="name@example.com" name="email" id="floatingInput" required>
								<label for="floatingInput">อีเมล</label>
							</div>
						</div>
						<br>
						<div class="input-group mb-3">
							<span class="input-group-text"><i class="fa-solid fa-key"></i></span> 
							<div class="form-floating">
								<input type="password" name="password" id="floatingPassword" class="form-control" placeholder="password" required>
								<label for="floatingPassword">รหัสผ่าน</label>
							</div>
						</div>			 
					<label style="color: red; text-align: center; ">${error_msg}</label>
					<button type="submit" class="btn btn-success" OnClick ="return validateForm(frm)">เข้าสู่ระบบ</button>				
					</div>
																
				</div>
			</form>

		</div>
	</div>


	<c:if test="${msg != null }">
		<script type="text/javascript">
			var msg = '${msg}';
			alert(msg);
		</script>
	</c:if>
	
</body>
</html>
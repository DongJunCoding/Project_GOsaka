<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String idSession = (String)session.getAttribute("loginId");
String nickSession = (String)session.getAttribute("nickname");
String role = (String)session.getAttribute("role");
String femailSession = (String)session.getAttribute("femail");
String semailSession = (String)session.getAttribute("semail");

String email = femailSession + "@" + semailSession;
%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="apple-touch-icon" sizes="76x76" href="../assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="../assets/css/m_img/favicon.png">
  <script type="text/javascript" src="assets/js/jquery-3.7.0.js"></script>
  <title>
    My Page
  </title>
  <!--     Fonts and icons     -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
  <!-- Nucleo Icons -->
  <link href="../assets/css/m_css/nucleo-icons.css" rel="stylesheet" />
  <link href="../assets/css/m_css/nucleo-svg.css" rel="stylesheet" />
  <!-- Font Awesome Icons -->
  <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
  <link href="../assets/css/m_css/nucleo-svg.css" rel="stylesheet" />
  <!-- CSS Files -->
  <link id="pagestyle" href="../assets/css/m_css/argon-dashboard.css?v=2.0.4" rel="stylesheet" />
  
  <!-- ------------------------------------------------------------------------------------------ -->
  
    <link rel="icon" type="image/png" href="favicon.ico">

	<!--Google Font link-->
	<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Kaushan+Script" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Droid+Serif:400,400i,700,700i" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Raleway:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet"> 
	<link rel="stylesheet" href="assets/css/font-awesome.min.css">
	<link rel="stylesheet" href="assets/css/bootstrap.css">
	<link rel="stylesheet" href="assets/css/bootsnav.css">

	<link rel="stylesheet" href="assets/css/style.css">
	
	<script>
	
	// 2 ~ 16자 사이 영어, 숫자, 한글 허용 / 특수문자, 공백 허용 안함.
	const nicknameRegExp = /^(?=.*[a-z0-9가-힣])(?!.*[\s!@#$%^&*()_+|<>?:"{},./;'[\]\\=-]).{2,16}$/;
	
	let nickBox;
	
	window.onload=function() {
		document.getElementById('e-btn').onclick = function() {
					
			// 닉네임
			nickBox = document.getElementById('mpNick'); // idBox에 입력된 id값을 넣어줌.
			
			if(nickBox.value.trim() == '') {
				alert('닉네임을 입력해주세요.');
				return false;
			} else if(!nicknameRegExp.test(nickBox.value)) { // idBox에 있는값이 정규식과 맞지 않으면 alert문구 띄우기
				alert('닉네임을 2 ~ 16자 사이 영어, 숫자, 한글로 입력해주세요.');
				return false;
			}
				
		}
	}
	
	$(document).ready(function() {
		
		// 닉네임 비동기 처리 및 안내문구
	    $('#mpNick').keyup(function() {
	        let signnick = $(this).val();
	    
	        if (signnick != '') {
	            if (!nicknameRegExp.test(signnick)) {
	                $('#mpNick_result').text('2 ~ 16자 사이 영어, 숫자, 한글로 입력해주세요.').css('color', 'orange');
	            } else {
	                $.ajax({
	                    type:'get',
	                    url:'/nickname_check',
	                    async: true,
	                    data: { signnick: signnick },
	                    success: function(result) { 
	                        if (result == 0) {  
	                            $('#mpNick_result').text('사용 가능한 닉네임').css('color', 'green');
	                        } else if (result == 1) {
	                            $('#mpNick_result').text('중복된 닉네임').css('color', 'orange');
	                        }
	                    },
	                    error: function(e) {
	                        alert('[에러] : ' + e.status);
	                    }
	                });
	            }
	        } else {
	            $('#mpNick_result').text('닉네임을 입력해주세요 !').css('color','orange');
	        }
	    });
		
		
	    $('#e-btn').click(function() { 
			if($('#mpNick_result').text() != '사용 가능한 닉네임') {
				alert('닉네임 중복확인을 확인하세요.');
				return false;
			}
		})  
	});
	</script>
</head>

<body class="g-sidenav-show bg-gray-100">
<%
	if(idSession != null) {
%>

		<div class="culmn">
            <!--Home page style-->
            <nav class="navbar navbar-default bootsnav navbar-fixed no-background white">        
                <div class="container"> 
                    
                    <!-- Start Header Navigation -->
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-menu">
                            <i class="fa fa-bars"></i>
                        </button>
                        <a class="navbar-brand" href="/GOsakas.do">
                            <img src="assets/images/Gosaka_gold.png" class="logo" alt="">
                            <!--<img src="assets/images/footer-logo.png" class="logo logo-scrolled" alt="">-->
                        </a>
                    </div>
                    <!-- End Header Navigation -->
                    <!-- navbar menu -->
                    <div class="collapse navbar-collapse" id="navbar-menu">
			           <ul class="nav navbar-nav navbar-right">
			               <li><a href="GOsakas.do">Home</a></li>                    
			               <li class="dropdown dropdown-submenu">
			                   <a href="#" class="dropdown-toggle" data-toggle="dropdown">Guide</a>
			                   <ul class="dropdown-menu">
			                       <li class="dropdown dropdown-submenu">
			                           <a class="dropdown" data-toggle="dropdown">Travel ></a>
			                           <ul class="dropdown-menu" style="left: 100%; right: auto;"> <!-- Adjust position manually -->
			                               <li><a href="osakaList.do" style="text-align:center;">Osaka Guide</a></li>
			                               <li><a href="kyotoList.do" style="text-align:center;"> Kyoto Guide</a></li>
			                               <li><a href="kobeList.do" style="text-align:center;">Kobe Guide</a></li>
			                               <li><a href="naraList.do" style="text-align:center;">Nara Guide</a></li>
			                           </ul>
			                       </li>    
			                       <li class="dropdown dropdown-submenu">
			                           <a class="dropdown" data-toggle="dropdown">Shop And Food ></a>
			                           <ul class="dropdown-menu" style="left: 100%; right: auto;"> <!-- Adjust position manually -->
			                               <li><a href="shoppingList.do" style="text-align:center;">Shopping</a></li>
			                               <li><a href="restaurantList.do" style="text-align:center;">Restaurant</a></li>
			                           </ul>
			                       </li>    
			                       <li class="dropdown dropdown-submenu">
			                           <a class="dropdown" data-toggle="dropdown">Festival ></a>
			                           <ul class="dropdown-menu" style="left: 100%; right: auto;"> <!-- Adjust position manually -->
			                               <li><a href="osakaFestivalList.do" style="text-align:center;">Osaka Festival</a></li>
			                               <li><a href="kyotoFestivalList.do" style="text-align:center;"> Kyoto Festival</a></li>
			                               <li><a href="kobeFestivalList.do" style="text-align:center;">Kobe Festival</a></li>
			                               <li><a href="naraFestivalList.do" style="text-align:center;">Nara Festival</a></li>
			                           </ul>
			                       </li>
			                   </ul>
			               </li>
			               <li class="dropdown">
			                   <a href="#" class="dropdown-toggle" data-toggle="dropdown">Board</a>
			                   <ul class="dropdown-menu">
			                       <li><a href="tipBoardList.do" style="text-align:center;">Tip Board</a></li>
			                       <li><a href="reviewBoardList.do" style="text-align:center;">Review Board</a></li>
			                       <li><a href="qnaBoardList.do" style="text-align:center;">Q&A Board</a></li>
			                   </ul>
			               </li>
			               <li class="dropdown">
			                   <a href="#" class="dropdown-toggle" data-toggle="dropdown">Notice</a>
			                   <ul class="dropdown-menu">
			                       <li><a href="/noticeList.do" style="text-align:center;">Notice</a></li>
			                       <li><a href="/passticketList.do" style="text-align:center;">Pass & Ticket</a></li>
			                   </ul>
			               </li>
			               
			               <% 
			               if(role != null && role.equals("ADMIN")) { 
			               %>				               		               
				           <li><a href="/admin.do">ADMIN</a></li>				           
				           <%
				           } else { 
				           %>				           
				           <li><a href="/myPage.do">MyPage</a></li>				           
				           <% } %>
				           
				           <%
				           	if(idSession == null && nickSession == null) {
				           %>
				           <li><a href="/login.do">Log-in</a></li>
				           <%
				           	} else if((idSession != null && nickSession != null) && (idSession.contains("(카카오)") == false && nickSession.contains("(카카오)") == false)) {
				           %>	
				           <li><a><span>환영합니다 <%=nickSession %>님 !</span></a></li>
				           <li>
				           	<a href="/logout.do">Logout</a>
				           </li>	
				           <%
				           } else if(idSession.contains("(카카오)") == true && nickSession.contains("(카카오)") == true) {
				           %>
				           <li><a><span>환영합니다 <%=nickSession %>님 !</span></a></li>
				           <li>
				           	<a href="kakao/logout">KakaoLogout</a>
				           </li>	
				           <%
				           }
				           %>  	  	
				       </ul>
				   </div>
               </div> 
		   </nav>          
        </div>
  <div class="position-absolute w-100 min-height-300 top-0" style="background-image: url('https://raw.githubusercontent.com/creativetimofficial/public-assets/master/argon-dashboard-pro/assets/img/profile-layout-header.jpg'); background-position-y: 50%;">
    <span class="mask bg-primary opacity-6"></span>
  </div>
  <div class="main-content position-relative max-height-vh-100 h-100">
    
    <div class="card shadow-lg mx-4 card-profile-bottom">
      <div class="card-body p-3">
        <div class="row gx-4">      
          <div class="col-auto my-auto">
            <div class="h-100">
              <h5 class="mb-1">             
                <%=nickSession %>
              </h5>             
            </div>
          </div>         
        </div>
      </div>
    </div>
    <div class="container-fluid py-4">
      <div class="row">
        <div class="col-md-8">
          <div class="card">
            <div class="card-header pb-0">
              <div class="d-flex align-items-center">
                <p class="mb-0">My Profile</p>               
              </div>
            </div>
            <div class="card-body">            
              <div class="row">
                <div class="col-md-6">
                  <div class="form-group">
                    <label for="example-text-input" class="form-control-label">ID</label>
                    <input class="form-control" type="text" value="<%=idSession %>" readonly>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group">
                    <label for="example-text-input" class="form-control-label">Email</label>
                    <input class="form-control" type="email" value="<%=email %>" readonly>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group">
                    <label for="example-text-input" class="form-control-label">Nickname</label>
                    <input class="form-control" type="text" value="<%=nickSession %>" readonly>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group">
                    <label for="example-text-input" class="form-control-label">관리자의 한마디</label>
                    <input class="form-control" type="text" value="저희 사이트를 이용해주셔서 대단히 감사합니다 (_ _) 꾸벅" readonly>
                  </div>
                </div>
              </div>
              <hr>
              <form action="/myPageModifyOK.do" method="post" name="mpfrm">
              <div class="d-flex align-items-center">
              <p class="text-uppercase text-sm">Edit Profile</p>     
              <%
                  if(nickSession.contains("(카카오)") == true) {
                	  
                  } else {
              %>              
              <button class="btn btn-primary btn-sm ms-auto" id="e-btn">Edit</button>
              <%
                  }
              %>
              </div>
              <div class="row">
                <div class="col-md-6">
                  <div class="form-group">
                    <label for="example-text-input" class="form-control-label">ID</label>
                    <input class="form-control" type="text" value="<%=idSession %>" name="mpId" readonly>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group">
                    <label for="example-text-input" class="form-control-label">Email</label>
                    <input class="form-control" type="email" value="<%=email %>" readonly>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group">
                    <label for="example-text-input" class="form-control-label">Nickname</label>
                    <%
                    	if(nickSession.contains("(카카오)") == true) {
                    %>
                    <input class="form-control" type="text" value="<%=nickSession %>" name="mpNick" id="mpNick" readonly>
                    <%
                    	} else {
                    %>
                    <input class="form-control" type="text" value="<%=nickSession %>" name="mpNick" id="mpNick" >
                    <span id="mpNick_result">&nbsp;</span>
                    <%
                    	}
                    %>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group">
                    <label for="example-text-input" class="form-control-label">관리자의 한마디</label>
                    <input class="form-control" type="text" value="비밀번호 변경은 비밀번호 찾기를 이용해주세요 ^^ ! / 닉네임만 변경 가능합니다." readonly>
                  </div>
                </div>
              </div>
              </form>
              <div class="row">            
              </div>
              <hr class="horizontal dark">             
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card card-profile">
            <img src="../assets/css/m_img/한소희.jpg" alt="Image placeholder" class="card-img-top">                      
            <div class="card-body pt-0">
              <h5 style="text-align:center; color:black; font-size:30px; padding-top:70px;">
                 홍보대사 한 소 희
              </h5>           
            </div>
          </div>
        </div>
      </div>
      <!-- footer -->
    </div>
  </div>
  
   <script src="assets/js/jquery.js"></script>
        <script type="text/javascript" src="assets/js/jquery.mixitup.js"></script>
        <script type="text/javascript" src="assets/js/jquery.bxslider.js"></script>
        <script type="text/javascript" src="assets/js/jquery.cslider.js"></script>
        <script type="text/javascript" src="assets/js/jquery.placeholder.js"></script>
        <script type="text/javascript" src="assets/js/app.js"></script>
        
        
        <!-- jQuery -->
		<script src="assets/js/jquery.min.js"></script>
		<!-- Waypoints -->
		<script src="assets/js/jquery.waypoints.min.js"></script>
		<!-- Stellar -->
		<script src="assets/js/jquery.stellar.min.js"></script>
		<!-- Superfish -->
		<script src="assets/js/superfish.js"></script>
		<!-- Date Picker -->
		<script src="assets/js/bootstrap-datepicker.min.js"></script>
	    
        <!-- JS includes -->

        <script src="assets/js/vendor/jquery-1.11.2.min.js"></script>
        <script src="assets/js/vendor/bootstrap.min.js"></script>

        <script src="assets/js/jquery.magnific-popup.js"></script>
        <!--<script src="assets/js/jquery.easypiechart.min.js"></script>-->
        <script src="assets/js/jquery.easing.1.3.js"></script>
        <!--<script src="assets/js/slick.js"></script>-->
        <script src="assets/js/slick.min.js"></script>
        <script src="assets/js/js.isotope.js"></script>
        <script src="assets/js/jquery.collapse.js"></script>
        <script src="assets/js/bootsnav.js"></script>

        <script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>

        <script src="assets/js/plugins.js"></script>
        <script src="assets/js/main.js"></script>
  
  

  <script>
    var win = navigator.platform.indexOf('Win') > -1;
    if (win && document.querySelector('#sidenav-scrollbar')) {
      var options = {
        damping: '0.5'
      }
      Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
    }
  </script>
  <!-- Github buttons -->
  <script async defer src="https://buttons.github.io/buttons.js"></script>
  <!-- Control Center for Soft Dashboard: parallax effects, scripts for the example pages etc -->
  <script src="../assets/css/m_js/argon-dashboard.min.js?v=2.0.4"></script>
  
<%
	} else {
		out.println( " <script type='text/javascript'> " );
		out.println("alert('권한이 없습니다.');");
		out.println("location.href='/login.do'");
		out.println( " </script> " );
	}
%>
</body>

</html>
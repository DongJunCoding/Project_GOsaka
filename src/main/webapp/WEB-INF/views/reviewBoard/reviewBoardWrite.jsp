<%@page import="com.example.model.TipBoardTO"%>
<%@page import="com.example.model.ShoppingTO"%>
<%@page import="com.example.model.PageListTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String idSession = (String)session.getAttribute("loginId");
String nickSession = (String)session.getAttribute("nickname");
String role = (String)session.getAttribute("role");


int cpage = (Integer)request.getAttribute("cpage");
%>
<!doctype html>

<html class="no-js" lang="en">
    <head>
        <meta charset="utf-8">
        <title>GOsaka</title>
        <meta name="description" content="">  
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="icon" type="image/png" href="favicon.ico">

        <!--Google Font link-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Kaushan+Script" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Droid+Serif:400,400i,700,700i" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Raleway:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
 		
 		
        <link rel="stylesheet" href="assets/css/bootstrap2.css">


        <link rel="stylesheet" href="assets/css/animate.css">
        <link rel="stylesheet" href="assets/css/iconfont.css">
        <link rel="stylesheet" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="assets/css/bootstrap.css">
        <link rel="stylesheet" href="assets/css/magnific-popup.css">
        <link rel="stylesheet" href="assets/css/bootsnav.css">
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap-responsive.css" />  

        <!--For Plugins external css-->
        <link rel="stylesheet" href="assets/css/plugins.css" />

        <!--Theme custom css -->

        <link rel="stylesheet" href="assets/css/style.css">
    	<link rel="stylesheet" href="assets/css/board/b_style.css">
    
        <!--Theme Responsive css-->
        <link rel="stylesheet" href="assets/css/responsive.css" />
        
        <!-- board -->
    	<link rel="stylesheet" href="assets/css/board/b_bootstrap.min.css">
    	<link rel="stylesheet" type="text/css" href="assets/css/board/board_write.css">

    	<!-- 제목 -->
    	<title>Table #6</title>
        

        <script src="assets/js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>

<script type="text/javascript">
	window.onload = function() {
		document.getElementById('wbtn').onclick = function() {
			if (document.wfrm.rvsubject.value.trim() == '') {
				alert('제목을 입력하셔야 합니다');
				return false;
			}
			if (document.wfrm.rvcontent.value.trim() == '') {
				alert('내용을 입력하셔야 합니다');
				return false;
			}
			
			document.wfrm.submit();
		};
	};
</script>
</head>

	<body>
	<%
		if(idSession != null) {
	%>
        <!-- Preloader -->
        <div id="loading">
            <div id="loading-center">
                <div id="loading-center-absolute">
                    <div class="object" id="object_one"></div>
                    <div class="object" id="object_two"></div>
                    <div class="object" id="object_three"></div>
                    <div class="object" id="object_four"></div>
                </div>
            </div>
        </div><!--End off Preloader -->


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
				           <li><a>환영합니다 <%=nickSession %>님 !</a></li>
				           <li>
				           	<a href="/logout.do">Logout</a>
				           </li>	
				           <%
				           } else if(idSession.contains("(카카오)") == true && nickSession.contains("(카카오)") == true) {
				           %>
				           <li><a>환영합니다 <%=nickSession %>님 !</a></li>
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
        
        <section id="reviewBoard" class="home bg-black fix">
                <div class="overlay"></div>
                <div class="container">
                    <div class="row">
                        <div class="main_home text-center">
                            <div class="col-md-12">
                                <div class="hello">
                                    <div class="slid_item">
                                        <div class="home_text ">
                                            <h1 class="text-yellow">Review Board </h1>                                                                              
                                            <h1 class="text-yellow">&nbsp;</h1>                                                                                                                                                                                                                                                                               
                                            <h1 class="text-yellow">&nbsp;</h1>                                                                                                                                                                                                                                                                               
                                            <h1 class="text-yellow">&nbsp;</h1>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
                                            <h1 class="text-yellow">&nbsp;</h1>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
                                        </div>
                                    </div><!-- End off slid item -->
                                </div>
                            </div>
                        </div>
                    </div><!--End off row-->
                </div><!--End off container -->           
		</section>
	
        
        
		<!-- 상단 디자인 -->
<div class="contents1"> 
	<form action="/reviewBoardWrite_ok.do" method="post" name="wfrm" enctype="multipart/form-data">
		<div class="contents_sub">
		<!--게시판-->
			<div class="board_write">
				<table>
				<tr>
					<th class="top">글쓴이</th>
					<td class="top" colspan="3"><input type="text" name="rvwriter" value="<%=nickSession %>" class="board_view_input_mail" maxlength="10" style="height:25px;" /></td>
				</tr>
				<tr>
					<th>제목</th>					
					<td colspan="3">
						<select name="preface" style="height: 25px; font-size:15px;">
							<option value="[음식]">음식</option>
							<option value="[쇼핑]">쇼핑</option>
							<option value="[관광]">관광</option>
							<option value="[자유]">자유</option>
						</select>
						<input type="text" name="rvsubject" value="" class="board_view_input" style="height:25px;"/>					
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3">
						<textarea name="rvcontent" class="board_editor_area" style="height:500px;"></textarea>
					</td>
				</tr>
				<tr>
					<th>이미지</th>
					<td style="float:center;">
						<!-- multiple 속성은 input type="file" 요소를 사용하여 여러 파일을 한 번에 선택할 수 있게 하는 속성 -->
						<input type="file" name="upload" value="" multiple="multiple" class="board_view_input" style="height:25px;" />
					</td>
				</tr>
				</table>
				
			</div>

			<div class="btn_area">
				<div class="align_left">			
					<input type="button" value="목록" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='/reviewBoardList.do?cpage=<%=cpage%>'" />
				</div>
				<div class="align_right">			
					<input type="button" value="쓰기" id="wbtn" class="btn_write btn_txt01" style="cursor: pointer;" />					
				</div>	
			</div>	
			<!--//게시판-->
		</div>
	</form>
</div>
<!-- 하단 디자인 -->

			<footer id="contact" class="footer action-lage bg-black p-top-80">
                <!--<div class="action-lage"></div>-->
                <div class="container">
                    <div class="row">
                        <div class="widget_area">
                            <div class="col-md-3">
                                <div class="widget_item widget_about">
                                    <h5 class="text-white">About Us</h5>
                                    <p class="m-top-30">저희는 오사카를 가고싶은 청년들 입니다.
                                    오카사인포 사이트를 바탕으로 만들어진 사이트이며 자세한 정보는 오사카인포 사이트를 이용해주세요.</p>                                                                                                     
                                </div><!-- End off widget item -->
                            </div><!-- End off col-md-3 -->

                            <div class="col-md-3">
                                <div class="widget_item widget_latest sm-m-top-50">
                                    <h5 class="text-white">Location</h5>
                                    <div class="widget_ab_item m-top-30">
                                        <div class="item_icon"><i class="fa fa-location-arrow"></i></div>
                                        <div class="widget_ab_item_text">
                                            <p>서울특별시 강남구 역삼동 819-10 세경빌딩 3층</p>
                                        </div>
                                    </div>
                                </div><!-- End off widget item -->
                            </div><!-- End off col-md-3 -->

                            <div class="col-md-3">
                                <div class="widget_item widget_service sm-m-top-50">
                                    <h5 class="text-white">Phone</h5>
                                    <div class="widget_ab_item m-top-30">
                                        <div class="item_icon"><i class="fa fa-phone"></i></div>
                                        <div class="widget_ab_item_text">
                                            <p>02-000-0000</p>
                                        </div>
                                    </div>

                                </div><!-- End off widget item -->
                            </div><!-- End off col-md-3 -->

                            <div class="col-md-3">
                                <div class="widget_item widget_newsletter sm-m-top-50">
                                    <h5 class="text-white">Email Address</h5>
                                    <div class="widget_ab_item m-top-30">
                                        <div class="item_icon"><i class="fa fa-envelope-o"></i></div>
                                        <div class="widget_ab_item_text">
                                            <p>ehdwns1937@gmail.com</p>
                                            <p>marigoldy061@gmail.com</p>
                                        </div>
                                    </div>
                                </div><!-- End off widget item -->
                            </div><!-- End off col-md-3 -->
                        </div>
                    </div>
                </div>
                <div class="main_footer fix bg-mega text-center p-top-40 p-bottom-30 m-top-80">
                    <div class="col-md-12">
                        <p class="wow fadeInRight" data-wow-duration="1s">
                            Osaka 
                            <i class="fa fa-heart"></i>
                            Travel : made 2023.10.17
                        </p>   
                    </div>
                </div>
            </footer>
        

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
        <%
			} else {
				out.println( " <script type='text/javascript'> " );
				out.println("alert('권한이 없습니다.');");
				out.println("history.back();");
				out.println( " </script> " );
			}
        %>
    </body>
</html>

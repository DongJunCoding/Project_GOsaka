<%@page import="com.example.model.ShoppingTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String idSession = (String)session.getAttribute("loginId");
String nickSession = (String)session.getAttribute("nickname");
String role = (String)session.getAttribute("role");

ShoppingTO shopView = (ShoppingTO)request.getAttribute("to");

StringBuilder sbHtml = new StringBuilder();

String shopId = shopView.getShopId();
String imageUrl = shopView.getImageUrl();
String title = shopView.getStitle();
String content = shopView.getScontent();
String latitude = shopView.getLatitude();
String longitude = shopView.getLongitude();
String location = null;
String information = null;
 

 	int startIdx = content.indexOf("<위");
	int endIdx = content.indexOf("<이용");
	
	  if(startIdx != -1 && endIdx != -1) {
          location = content.substring(startIdx, endIdx);
          information = content.substring(endIdx);
          content = content.substring(0,startIdx);
       }
         else if(startIdx != -1 && endIdx == -1 ) {
          location = content.substring(startIdx, endIdx);
          information = "해당 정보 없음";
          content = content.substring(0,startIdx);
       } else if(startIdx == -1 && endIdx != -1 ) {
          location = "지도";
          information = content.substring(endIdx);
          content = content.substring(0,endIdx);
       } else {
          location = "지도";
          information = "해당 정보 없음";
       }
	  
	  

sbHtml.append("<div role='tabpanel' class='tab-pane fade in active' id='f1'> ");
sbHtml.append("<h4 style='font-size:20px; text-align:center;'>"+title+"<h4>");
sbHtml.append("<img src='"+imageUrl+"' class='img-responsive' alt='...'>"); 
sbHtml.append("</div>");
sbHtml.append("<div role='tabpanel' class='tab-pane fade' id='f2'>");
sbHtml.append("<p class='viewText'>"+content+"</p>");
sbHtml.append("</div>");	               
sbHtml.append("<div role='tabpanel' class='tab-pane fade' id='f4'>"); 
sbHtml.append("<p class='viewText'>"+location+"</p>");
sbHtml.append("<div id='map' style='width: 600px; height: 400px;'></div>");
sbHtml.append("</div>");
sbHtml.append("<div role='tabpanel' class='tab-pane fade' id='f5'>");
sbHtml.append("<p class='viewText'>"+information+"</p>");
sbHtml.append("</div>");

//세션 값 받아와서 jsp에서 로그인 유지에 사용
String sessionNick = (String)session.getAttribute("nickname");
%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Kaushan+Script" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Droid+Serif:400,400i,700,700i" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Raleway:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
 		
<link rel="stylesheet" href="assets/css/bootstrap.css">
<link rel="stylesheet" type="text/css"  href="assets/css/guide/v_bootstrap.css">
<link rel="stylesheet" type="text/css" href="assets/fonts/font-awesome.css">
<link rel="stylesheet" type="text/css"  href="assets/css/style.css">
<link rel="stylesheet" type="text/css"  href="assets/css/guide/v_style.css">
<link rel="stylesheet" href="assets/css/bootsnav.css">
<link rel="stylesheet" type="text/css" href="assets/css/bootstrap-responsive.css" />   
<link rel="stylesheet" href="assets/css/style.css">
<link rel="stylesheet" href="assets/css/responsive.css" />
<script src="assets/js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>



<!-- Google API Key -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCbWzfl1X7jPinFxVzI6lw0sBt8r2SbdfI"></script>

</head>
<body>
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
            <section id="shopping-list" class="home bg-black fix">
                <div class="overlay"></div>
                <div class="container">
                    <div class="row">
                        <div class="main_home text-center">
                            <div class="col-md-12">
                                <div class="hello">
                                    <div class="slid_item">
                                        <div class="home_text ">
                                            <h1 class="text-yellow">Shopping Guide </h1>                                                                              
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
          
	
  		
    </div>


<div id="feature" class="gray-bg"> <!-- fullwidth gray background -->
	<div class="container"> <!-- container -->
    	<div class="row" role="tabpanel"> <!-- row -->
        	<div class="col-md-6"> <!-- right content col 6 -->
            <!-- Tab panes -->
            	<div class="tab-content features-content">
	               <%=sbHtml %>
            	</div>         	       	
    		</div><!-- end right content col 6 -->
    		
    		<div class="col-md-4 col-md-offset-1"> <!-- tab menu col 4 -->
	            <ul class="features nav nav-pills nav-stacked" role="tablist">
	                <li role="presentation" class="active">  <!-- feature tab menu #1 -->
	                    <a href="#f1" aria-controls="f1" role="tab" data-toggle="tab">
	                        <span class="fa fa-desktop"></span>
	                        제목 / 이미지<br><small>Title / Image</small>
	                    </a>
	                </li>
	                <li role="presentation"> <!-- feature tab menu #2 -->
	                    <a href="#f2" aria-controls="f2" role="tab" data-toggle="tab">
	                        <span class="fa fa-pencil"></span>
	                        소개글<br><small>Introduce</small>
	                    </a>
	                </li>
	                
	                <li role="presentation"> <!-- feature tab menu #4 -->
	                    <a href="#f4" aria-controls="f4" role="tab" data-toggle="tab">
	                        <span class="fa fa-automobile"></span>
	                        위치안내 / 지도<br><small>Location / Map</small>
	                    </a>
	                </li>
	                <li role="presentation"> <!-- feature tab menu #5 -->
	                    <a href="#f5" aria-controls="f5" role="tab" data-toggle="tab">
	                        <span class="fa fa-institution"></span>
	                        이용안내<br><small>Information</small>
	                    </a>
	                </li>
	            </ul>
        	</div><!-- end tab menu col 4 -->
		</div> <!-- end row -->
	</div> <!-- end container -->
</div><!-- end fullwidth gray background -->


    <script>
        // 지도가 표시될 HTML element
        let mapElement = document.getElementById('map');
        
        // 지도의 중심 좌표를 일본 중심으로 설정
        let mapOptions = {
            center: { lat:<%=latitude%>, lng:<%=longitude%> }, // 일본 중심 좌표
            zoom: 16 // 지도 확대 수준 설정
        };

        // 지도 생성
        let map = new google.maps.Map(mapElement, mapOptions);

        // 마커 생성
        let marker = new google.maps.Marker({
            position: { lat:<%=latitude%>, lng:<%=longitude%> }, // 일본 중심 좌표
            map: map,
            title: '<%=title%>' // 마커의 타이틀
        });
    </script>


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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript" src="assets/js/bootstrap.js"></script>
 
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
 
 
</body>
</html>
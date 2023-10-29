<%@page import="com.example.model.FestivalTO"%>
<%@page import="com.example.model.RestaurantTO"%>
<%@page import="com.example.model.ShoppingTO"%>
<%@page import="com.example.model.OsakaAreaTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<%
ArrayList<OsakaAreaTO> osakaList = (ArrayList) request.getAttribute("osakaList");
ArrayList<ShoppingTO> shopList = (ArrayList) request.getAttribute("shopList");
ArrayList<RestaurantTO> resList = (ArrayList) request.getAttribute("resList");
ArrayList<FestivalTO> fesList = (ArrayList) request.getAttribute("fesList");

String idSession = (String)session.getAttribute("loginId");
String nickSession = (String)session.getAttribute("nickname");
String role = (String)session.getAttribute("role");

int totalGuideList = osakaList.size();
int totalShopList = shopList.size();
int totalResList = resList.size();
int totalFesList = fesList.size();
%>
<html class="no-js" lang="en">
    <head>
        <meta charset="utf-8">
        <title>GOsaka</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" type="image/png" href="favicon.ico">

        <!--Google Font link-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Kaushan+Script" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Droid+Serif:400,400i,700,700i" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Raleway:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
 		
        <!-- 
        <link rel="stylesheet" href="assets/css/animate.css">
         -->
        <link rel="stylesheet" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="assets/css/bootstrap.css">
        <link rel="stylesheet" href="assets/css/bootsnav.css">	
        <link rel="stylesheet" href="assets/css/style.css">
        
        <style>
        	@media (min-width: 768px) {
			  .container {
			    width: 750px;
			  }
			}
			
			@media (min-width: 992px) {
			  .container {
			    width: 970px;
			  }
			}
			@media (min-width: 1200px) {
			  .container {
			    width: 1170px;
			  }
			}
        </style>
    </head>

	<body data-spy="scroll" data-target=".navbar-collapse" data-offset="100">


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

            <!--Home Sections-->

			<section id="home" class="home bg-black fix">
                <div class="overlay"></div>
                <div class="container">
                    <div class="row">
                        <div class="main_home text-center">
                            <div class="col-md-12">
                                <div class="hello">
                                    <div class="slid_item">
                                        <div class="home_text ">
                                            <h1 class="text-yellow">Welcome to Osaka ! </h1>                                                                                 
                                        </div>
                                    </div><!-- End off slid item -->
                                </div>
                            </div>
                        </div>
                    </div><!--End off row-->
                </div><!--End off container -->      
			<div class="container">
				<div class="row">
					<div class="col-md-12 text-center">
						<!-- 가운데 정렬을 위해 text-center 클래스 추가 -->
						<!-- 첫 번째 카드 -->
						<div class="row justify-content-around">
							<!-- justify-content-around 클래스 추가 -->
							<div class="col-md-6">
								<div class="service_slid">
									<a href="/passticketList.do"><div class="card-body-first"></div></a>
								</div>
							</div>
							<!-- 두 번째 카드 -->
							<div class="col-md-6">
								<div class="service_slid">
									<a href="/noticeList.do"><div class="card-body-second"></div></a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>

		
		<!--Start of counter-->
        <section id="counter">
            <div class="counter_img_overlay">
                <div class="container">
              
                    <!--End of row-->
                    <div class="row">
                        <div class="col-md-3">
                            <div class="counter_item text-center">
                                <div class="sigle_counter_item">
                                    <img src="img/tree.png" alt="">
                                    <div class="counter_text">
                                        <span class="counter"><%=totalGuideList %></span>
                                        <p>관광</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="counter_item text-center">
                                <div class="sigle_counter_item">
                                    <img src="img/hand.png" alt="">
                                    <div class="counter_text">
                                        <span class="counter"><%=totalFesList %></span>
                                        <p>축제</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="counter_item text-center">
                                <div class="sigle_counter_item">
                                    <img src="img/tuhnder.png" alt="">
                                    <div class="counter_text">
                                        <span class="counter"><%=totalShopList %></span>
                                        <p>쇼핑</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="counter_item text-center">
                                <div class="sigle_counter_item">
                                    <img src="img/cloud.png" alt="">
                                    <div class="counter_text">
                                        <span class="counter"><%=totalResList %></span>
                                        <p>음식</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--End of row-->
                </div>
                <!--End of container-->
            </div>
        </section>

        <script src="assets/js/jquery-1.12.3.min.js"></script>

        <!--Counter UP Waypoint-->
        <script src="assets/js/waypoints.min.js"></script>
        <!--Counter UP-->
        <script src="assets/js/jquery.counterup.min.js"></script>

        <script>
            //for counter up
            $('.counter').counterUp({
                delay: 10,
                time: 1000
            });
        </script>

        <!--Isotope-->
        <script src="js/isotope/min/scripts-min.js"></script>
        <script src="js/isotope/cells-by-row.js"></script>
        <script src="js/isotope/isotope.pkgd.min.js"></script>
        <script src="js/isotope/packery-mode.pkgd.min.js"></script>
        <script src="js/isotope/scripts.js"></script>


        <!--Back To Top-->
        <script src="js/backtotop.js"></script>


        <!--JQuery Click to Scroll down with Menu-->
        <script src="js/jquery.localScroll.min.js"></script>
        <script src="js/jquery.scrollTo.min.js"></script>
        <!--WOW With Animation-->
        <script src="js/wow.min.js"></script>
        <!--WOW Activated-->
        <script>
            new WOW().init();
        </script>


        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
        <!-- Custom JavaScript-->
        <script src="js/main.js"></script>


		<!--Featured Section-->
            <section id="features" class="features bg-white">
                <div id="fh5co-destination">
					<div class="tour-fluid">
						<div class="row">
							<div class="col-md-12">
								<ul id="fh5co-destination-list" class="animate-box">
									<li class="one-forth text-center" style="background-image: url(assets/images/main.jpg);">
										<a href="/osakaList.do">
											<div class="case-studies-summary">
												<h2>오사카 관광 가이드</h2>
											</div>
										</a>
									</li>
									<li class="one-forth text-center" style="background-image: url(assets/images/kyoto.jpg); ">
										<a href="/kyotoList.do">
											<div class="case-studies-summary">
												<h2>교토 관광 가이드</h2>
											</div>
										</a>
									</li>
									<li class="one-forth text-center" style="background-image: url(https://a.cdn-hotels.com/gdcs/production170/d1738/170f159c-a498-4869-ac24-aa978cc5f6d2.jpg); ">
										<a href="/kobeList.do">
											<div class="case-studies-summary">
												<h2>고베 관광 가이드</h2>
											</div>
										</a>
									</li>
									<li class="one-forth text-center" style="background-image: url(https://a.cdn-hotels.com/gdcs/production166/d1029/b079adb5-0653-4278-b147-0ff60ddae025.jpg?impolicy=fcrop&w=1600&h=1066&q=medium); ">
										<a href="/naraList.do">
											<div class="case-studies-summary">
												<h2>나라 관광 가이드</h2>
											</div>
										</a>
									</li>
		
									<li class="one-forth text-center" style="background-image: url(assets/images/food.jpg); ">
										<a href="/restaurantList.do">
											<div class="case-studies-summary">
												<h2>음식</h2>
											</div>
										</a>
									</li>
									<li class="one-half text-center" style="background-image: url(https://images.pexels.com/photos/6249089/pexels-photo-6249089.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1https://images.pexels.com/photos/6249089/pexels-photo-6249089.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1); ">					
									</li>
									<li class="one-forth text-center" style="background-image: url(https://a.cdn-hotels.com/gdcs/production91/d1137/ff42d99a-8cd0-4661-aa20-c98c9cc159ac.jpg?impolicy=fcrop&w=1600&h=1066&q=medium); ">
										<a href="/shoppingList.do">
											<div class="case-studies-summary">
												<h2>쇼핑</h2>
											</div>
										</a>
									</li>
									<li class="one-forth text-center" style="background-image: url(https://msp.c.yimg.jp/images/v2/tpvPBYOX1wpNVI1UoNSgEsWn3UQq3CvNvMrBZm8wDGNTbcza9x9EfpkNE8jm3n9oEhCsS9vWEtIvVFOHA1tTmm0k-0jBxI1s1_f8z46H70vGMy4DIHMCljovRxUlS4GoI_ZiFpNx9VWZtIOzdr9WzcWn3UQq3CvNvMrBZm8wDGNTbcza9x9EfpkNE8jm3n9oEhCsS9vWEtIvVFOHA1tTmm0k-0jBxI1s1_f8z46H70vGMy4DIHMCljovRxUlS4Gog2TUWon14TQrPwboFlQOaA==/27_B.jpg?errorImage=false); ">
										<a href="/osakaFestivalList.do">
											<div class="case-studies-summary">
												<h2>오사카 축제</h2>
											</div>
										</a>
									</li>
									<li class="one-forth text-center" style="background-image: url(https://cdn.imweb.me/upload/S201612185855798c0088d/5c97662883cd0.jpeg); ">
										<a href="/kyotoFestivalList.do">
											<div class="case-studies-summary">
												<h2>교토 축제</h2>
											</div>
										</a>
									</li>
									<li class="one-forth text-center" style="background-image: url(https://www.kanpai-japan.com/sites/default/files/uploads/2019/12/kobe-luminarie-10.jpg); ">
										<a href="/kobeFestivalList.do">
											<div class="case-studies-summary">
												<h2>고베 축제</h2>
											</div>
										</a>
									</li>
									<li class="one-forth text-center" style="background-image: url(https://imgcp.aacdn.jp/img-a/1200/auto/global-aaj-front/article/2019/07/5d37baa71c9ea_5d37b9332f207_1615018601.jpg)">
										<a href="/naraFestivalList.do">
											<div class="case-studies-summary">
												<h2>나라 축제</h2>
											</div>
										</a>
									</li>
								</ul>		
							</div>
						</div>
					</div>
				</div>
            </section><!-- End off Featured Section-->


            

            <!--Team And Skill Section-->
            <section id="teams" class="teams roomy-80">
                <div class="container">
                    <div class="row">
                        <div class="main_teams_content fix">
                            <div class="col-md-6">
                                <div class="teams_item">
                                    <div class="head_title">
                                        <h2 class="text-uppercase">GOsaka <strong>개발진</strong></h2>
                                    </div>
                                    <p>오사카 여행을 가고 싶었지만 홈페이지를 만드느라 가지 못하고 상상여행만 해버린 불쌍한 개발진들입니다.</p>
                                    <p>잘생겼다 ~~ 휘 ~ 휘 ~ </p>


                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="teams_item text-center sm-m-top-50">
                                    <div class="row">
                                        <div class="col-sm-4">
                                            <img src="assets/images/dongjun.jpg" alt="" class="img-circle" />
                                            <h4 class="m-top-20">Lee <strong>Dong-jun</strong></h4>
                                            <h5>CEO</h5>
                                            <div class="separator"></div>
                                            <ul class="list-inline">
                                                <li><a href=""><i class="fa fa-facebook"></i></a></li>
                                                <li><a href=""><i class="fa fa-twitter"></i></a></li>
                                                <li><a href=""><i class="fa fa-dribbble"></i></a></li>
                                            </ul>
                                        </div><!-- End off col-md-4 -->
                                        <div class="col-sm-4">
                                            <img src="assets/images/junyoung.jpg" alt="" class="img-circle" />
                                            <h4 class="m-top-20">Lee <strong>Jun-young</strong></h4>
                                            <h5>CEO</h5>
                                            <div class="separator"></div>
                                            <ul class="list-inline">
                                                <li><a href=""><i class="fa fa-facebook"></i></a></li>
                                                <li><a href=""><i class="fa fa-twitter"></i></a></li>
                                                <li><a href=""><i class="fa fa-dribbble"></i></a></li>
                                            </ul>
                                        </div><!-- End off col-md-4 -->
                                    </div>
                                </div>
                            </div><!-- End off col-md-6 -->
                        </div><!-- End off main Team -->

                        
                    </div><!-- End off row -->
                </div><!-- End off container -->
            </section><!-- End off Team & Skill section -->
			


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

        </div>
   
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

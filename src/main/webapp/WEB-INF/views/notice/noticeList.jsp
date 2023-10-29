<%@page import="com.example.model.NoticeTO"%>
<%@page import="com.example.model.PageListTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>

<%
ArrayList<NoticeTO> noticeList = (ArrayList) request.getAttribute("noticeList");
PageListTO pageTO = (PageListTO) request.getAttribute("pageTO");
ArrayList<NoticeTO> noticePageList = pageTO.getNoticePageList();

String idSession = (String)session.getAttribute("loginId");
String nickSession = (String)session.getAttribute("nickname");
String role = (String)session.getAttribute("role");

String searchWord = request.getParameter("searchWord");

int cpage = 1;

if (request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
	cpage = Integer.parseInt(request.getParameter("cpage"));
}

int totalRecord = 0;
int totalPage = 0;
int blockPerPage = 0;
int startBlock = 0;
int endBlock = 0;
int totalsize = 0;

pageTO.setCpage(cpage);

totalRecord = pageTO.getTotalRecord();

totalPage = pageTO.getTotalPage();

blockPerPage = pageTO.getBlockPerPage();

startBlock = pageTO.getStartBlock();

endBlock = pageTO.getEndBlock();

totalsize = noticeList.size();

StringBuilder sbHtml = new StringBuilder();

String subject = null;
String writer = null;
String date = null;
String ip = null;
int hit = 0;
int tgap = 0;
if (noticePageList.size() != 0) {
	for (NoticeTO to : noticePageList) {
		String noticeId = to.getNoticeId();
		subject = to.getNsubject();
		writer = to.getNwriter();
		date = to.getNdate();
		ip = to.getIp();
		hit = to.getNhit();
		tgap = to.getNgap();

		sbHtml.append("<tr scope='row' style='font-size:20px;'>");
		sbHtml.append("<td >" + noticeId + "</td>");
		sbHtml.append("<td><a href='/noticeView.do?noticeId="+noticeId+"&cpage="+cpage+"'>" + subject + "</a>");
		if (tgap == 0) {
			sbHtml.append("<img src='assets/images/icon_new.gif' alt='NEW'>");
		}
		sbHtml.append("</td>");
		sbHtml.append("<td>" + writer + "</td>");
		sbHtml.append("<td>" + date + "</td>");
		sbHtml.append("<td>" + hit + "</td>");
		sbHtml.append("</tr>");

	}
} else if (noticePageList.size() == 0) {
	sbHtml.append("<tr scope='row' style='font-size:20px;'>");
	sbHtml.append("<td ></td>");
	sbHtml.append("<td ></td>");
	sbHtml.append("<td>검색 결과가 없습니다.</td>");
	sbHtml.append("<td ></td>");
	sbHtml.append("<td ></td>");
	sbHtml.append("</tr>");

}
%>

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
 		<link rel="stylesheet" href="assets/css/guide/l_list.css">
 		<link rel="stylesheet" href="assets/css/slick.css"> 
        <link rel="stylesheet" href="assets/css/slick-theme.css">
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
        <link rel="stylesheet" href="assets/css/guide/l_style.css">
        <link rel="stylesheet" href="assets/css/style.css">
    	<link rel="stylesheet" href="assets/css/board/b_style.css">
    
        <!--Theme Responsive css-->
        <link rel="stylesheet" href="assets/css/responsive.css" />
        
        <!-- board -->
    	<link rel="stylesheet" href="assets/css/board/b_bootstrap.min.css">

    	<!-- 제목 -->
    	<title>Table #6</title>
        

        <script src="assets/js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
        
        <script type="text/javascript">
        window.onload = function() {
        	document.getElementById('search-btn').onclick = function() {
      			document.ofrm.submit();
        	}
        }
        
        window.onload = function() {
        	document.getElementById('write-btn').onclick = function() {
      			alert('로그인이 필요합니다.');
      			return false;
        	}
        }
        </script>  
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
        
        <section id="notice" class="home bg-black fix">
                <div class="overlay"></div>
                <div class="container">
                    <div class="row">
                        <div class="main_home text-center">
                            <div class="col-md-12">
                                <div class="hello">
                                    <div class="slid_item">
                                        <div class="home_text ">
                                            <h1 class="text-yellow">Notice</h1>                                                                              
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
	
        
        
		<div class="content">  
    <div class="bcontainer">
 
      <small style="text-align:left"><%=totalsize%>개의 게시글</small>
      <span data-filter="identity" style="float: right; display: flex; align-items: center; padding-bottom:20px;">
	        <form action="/noticeList.do" method="post" name="ofrm" style="display: flex; align-items: center;">		     
			    <input type="text" name="searchWord" class="form-control" placeholder="Search" style="height: 25px; font-size:15px;"> &nbsp;&nbsp;
		        <button id="search-btn" style="background: none; border: none;">
		            <i class="fa fa-search"></i>
		        </button>
		    </form>
		</span>	
      
      <div class="table-responsive">

        <table class="table table-striped custom-table">
          <thead>
            <tr >            
              <th scope="col"></th>
              <th scope="col">제목</th>
              <th scope="col">작성자</th>
              <th scope="col">날짜</th>
              <th scope="col">조회수</th>
            </tr>
          </thead>
          <tbody>
            <%=sbHtml %>
          </tbody>
        </table>
        
		<%
		if(idSession == null && nickSession == null && role == null) {
		%>      

      	<%
		} else if(idSession != null && nickSession != null && role.equals("ADMIN")) {	
      	%>
       	<button type="button"style="float:right;"><a href="/noticeWrite.do?cpage=<%=cpage%>">글쓰기</a></button>     
      	<%
		}
      	%>
           
      </div>
    </div>
  </div>
    <script src="assets/js/jquery-3.3.1.min.js"></script>
    <script src="assets/js/popper.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
		
		

	<!--페이지넘버-->
	<div class="paginate_regular"
		style="text-align: center; font-size: 25px; padding: 30px; background:white;">
		<div>
			<!-- 페이지 누르는곳으로 이동 / << <, > >> 버튼 적용시키기 -->
			<%
			if (searchWord == null) {
				if (startBlock == 1) {
					out.println("<span><a>&lt;&lt;</a></span>");
				} else {
					out.println("<span><a href='/noticeList.do?cpage=" + (startBlock - blockPerPage) + "'>&lt;&lt;</a></span>");
				}

				out.println("&nbsp;");

				if (cpage == 1) {
					out.println("<span><a>&lt;</a></span>");
				} else {
					out.println("<span><a href='/noticeList.do?cpage=" + (cpage - 1) + "'>&lt;</a></span>");
				}
				out.println("&nbsp;&nbsp;");
				for (int i = startBlock; i <= endBlock; i++) {
					if (i == cpage) {
				// 해당 페이지에 [i] 돼있음.
				out.println("<span><a>[" + i + "]</a></span>");
					} else {
				// 페이지 번호들 나열해주고 해당 페이지의 데이터(게시글)들을 보여준다
				out.println("<span><a href='/noticeList.do?cpage=" + i + "'>" + i + "</a></span>");
					}
				}

				out.println("&nbsp;&nbsp;");
				if (cpage == totalPage) {
					out.println("<span><a>&gt;</a></span>");
				} else {
					out.println("<span><a href='/noticeList.do?cpage=" + (cpage + 1) + "'>&gt;</a></span>");
				}

				out.println("&nbsp;");
				if (endBlock == totalPage) {
					out.println("<span><a>&gt;&gt;</a></span>");
				} else {
					out.println("<span><a href='/noticeList.do?cpage=" + (startBlock + blockPerPage) + "'>&gt;&gt;</a></span>");
				}

			} else if (searchWord != null) {

				if (startBlock == 1) {
					out.println("<span><a>&lt;&lt;</a></span>");
				} else {
					out.println("<span><a href='/noticeList.do?cpage=" + (startBlock - blockPerPage) + "&searchWord="+searchWord+"'>&lt;&lt;</a></span>");
				}

				out.println("&nbsp;");

				if (cpage == 1) {
					out.println("<span><a>&lt;</a></span>");
				} else {
					out.println("<span><a href='/noticeList.do?cpage=" + (cpage - 1) + "&searchWord="+searchWord+"'>&lt;</a></span>");
				}
				out.println("&nbsp;&nbsp;");
				for (int i = startBlock; i <= endBlock; i++) {
					if (i == cpage) {
				// 해당 페이지에 [i] 돼있음.
				out.println("<span><a>[" + i + "]</a></span>");
					} else {
				// 페이지 번호들 나열해주고 해당 페이지의 데이터(게시글)들을 보여준다
				out.println("<span><a href='/noticeList.do?cpage=" + i + "&searchWord="+searchWord+"'>" + i + "</a></span>");
					}
				}

				out.println("&nbsp;&nbsp;");
				if (cpage == totalPage) {
					out.println("<span><a>&gt;</a></span>");
				} else {
					out.println("<span><a href='/noticeList.do?cpage=" + (cpage + 1) + "&searchWord="+searchWord+"'>&gt;</a></span>");
				}

				out.println("&nbsp;");
				if (endBlock == totalPage) {
					out.println("<span><a>&gt;&gt;</a></span>");
				} else {
					out.println("<span><a href='/noticeList.do?cpage=" + (startBlock + blockPerPage) + "&searchWord="+searchWord+"'>&gt;&gt;</a></span>");
				}

			}
			%>
		</div>
	</div>
	<!--//페이지넘버-->

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
    </body>
</html>

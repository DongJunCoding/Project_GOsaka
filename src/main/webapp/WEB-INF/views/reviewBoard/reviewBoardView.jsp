<%@page import="com.example.model.ReviewBoardTO"%>
<%@page import="com.example.model.CommentTO"%>
<%@page import="com.example.model.ShoppingTO"%>
<%@page import="com.example.model.PageListTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
ReviewBoardTO reviewBoardTO = (ReviewBoardTO) request.getAttribute("reviewBoardView");
ArrayList<CommentTO> review_commentList = (ArrayList)request.getAttribute("review_commentList");
String idSession = (String)session.getAttribute("loginId");
String nickSession = (String)session.getAttribute("nickname");
String role = (String)session.getAttribute("role");

int cpage = (Integer)request.getAttribute("cpage");
String reviewId = reviewBoardTO.getReviewId();
String cmId = null;

String[] images = reviewBoardTO.getImage().split("▒");

String category = reviewBoardTO.getCategory();
String rvsubject = reviewBoardTO.getRvsubject();
String rvwriter = reviewBoardTO.getRvwriter();
String rvdate = reviewBoardTO.getRvdate();
int rvhit = reviewBoardTO.getRvhit();
String rvcontent = reviewBoardTO.getRvcontent().replaceAll("\n", "<br />");


StringBuffer commentHtml = new StringBuffer();
for (CommentTO commentTO : review_commentList) {
	   cmId = commentTO.getCmId();
	   commentHtml.append("<table>");
	   commentHtml.append("<tr>");
	   commentHtml.append("<td class='coment_re' style='width:1%;'>");
	   commentHtml.append("<strong>" + commentTO.getCwriter() + "</strong> (" + commentTO.getCdate() + ")");
	   
	   if((role != null && role.equals("ADMIN")) ||commentTO.getCwriter().equals(nickSession)) {   
	      commentHtml.append("<div style='display: inline-block;'>");
	      commentHtml.append("<form action='/review_CommentDeleteOk.do' method='post' name='cdfrm' style='display: inline;'>");
	      commentHtml.append("<input type='hidden' name='reviewId' value='" + reviewId+ "'/>");
	      commentHtml.append("<input type='hidden' name='cmId' value='" + cmId + "' />");
	      commentHtml.append("&nbsp;<input type='submit' value='삭제' style='height:18px; width:30px; font-size:12px;'/>");
	      commentHtml.append("</form>");
	      
	      // 수정 버튼 클릭 시 수정 폼을 토글하는 스크립트 추가
	      commentHtml.append("&nbsp;<input type='button' value='수정' style='height:18px; width:30px; font-size:12px;' onclick=\"toggleEditForm('" + cmId + "')\"/>");
	      commentHtml.append("</div>");
	   }

	   commentHtml.append("<div class='coment_re_txt'> "+ commentTO.getCcontent().replaceAll("\n", "<br />") +"</div>");
	   
	   // 수정 폼 추가 (초기에는 display: none으로 숨김)
	   commentHtml.append("<div id='editForm_" + cmId + "' style='display:none;'>");
	   commentHtml.append("<form action='/review_CommentModifyOk.do' method='post' name='editCommentForm'>");
	   commentHtml.append("<input type='hidden' name='reviewId' value='" + reviewId + "'/>");
	   commentHtml.append("<input type='hidden' name='cmId' value='" + cmId + "' />");
	   commentHtml.append("<textarea class='coment_input_text' name='modifyComment'>" + commentTO.getCcontent().replaceAll("\n", "<br />") + "</textarea>");
	   commentHtml.append("<input type='submit' value='저장'/>");
	   commentHtml.append("</form>");
	   commentHtml.append("</div>");
	   
	   commentHtml.append("</td>");
	   commentHtml.append("</tr>");
	   commentHtml.append("</table>");
	}

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
    

    	<!-- 제목 -->
    	<title>Review Board</title>
        
        <script src="assets/js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
        
        <link rel="stylesheet" type="text/css" href="assets/css/board/board_view.css">
		<script type="text/javascript">
		const commentOk = function() {

			if( document.cfrm.ccontent.value.trim() == '' ) {
				alert( '댓글 내용을 입력해주세요' );
				return false;
			}
			document.cfrm.submit();
		}
		
		window.onload = function() {
	         document.getElementById('comment-btn').onclick = function() {
	               var roleValue = '<%= role %>';
	   
	               // Check role value
	               if (roleValue === 'BLACK') {
	                   alert('블랙리스트 회원은 사용하실 수 없습니다.');
	                   return false;
	               } else if(roleValue === 'null') {
	                   alert('로그인이 필요합니다.');
	                   return false;
	               }
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
		<div class="contents_sub">	
		<!--게시판-->
		</div>
			<div class="board_view">		
			 	<table width="100%">
				<tr style="height:70px;">  
					<th width="10%" style="font-size:20px;">제목</th>
					<td width="60%" style="font-size:20px;"><%=category%>&nbsp;&nbsp;<%=rvsubject %></td>
					<th width="10%" style="font-size:20px;">등록일</th>
					<td width="20%" style="font-size:20px;"><%=rvdate %></td>
				</tr>
				<tr style="height:70px;">
					<th style="font-size:20px;">글쓴이</th>
					<td style="font-size:20px;"><%=rvwriter %></td>
					<th style="font-size:20px;">조회</th>
					<td style="font-size:20px;"><%=rvhit %></td>
				</tr>				
				<tr>
					<td colspan="4"  valign="top" style="padding:20px; line-height:160%; height:600px; text-align:center; font-size:20px;">
						<div id="bbs_file_wrap">
							<div >
							<%
							for(String image : images) {
							%>
								<img src="assets/upload/<%=image %>" style="width:1000px; height:500px; padding:5px;"onerror="" name="image"/><br />
							<%
							}
							%>
							</div>
						</div>
					<%=rvcontent %> 
					</td>
				</tr>			
				</table>

				<%-- 코멘트 출력 --%>
				<%=commentHtml %>
							
				<form action="/review_CommentOk.do" method="post" name="cfrm">
				<input type="hidden" name="reviewId" value="<%=reviewId %>" />
				<table width="100%">
				<tr>
					<td width="94%" class="coment_re">
						<%
							if(role != null) {
						%>
						글쓴이 <input type="text" name="cwriter" maxlength="5" class="coment_input" value="<%=nickSession %>" readonly />&nbsp;&nbsp;
						<%
							} else {
						%>
						글쓴이 <input type="text" name="cwriter" maxlength="5" class="coment_input" value="" readonly />&nbsp;&nbsp;
						<%					
							}
						%>
					</td>
					<td width="6%" class="bg01"></td>
				</tr>
				<tr>
					<td class="bg01">
						<textarea name="ccontent" cols="" rows="" class="coment_input_text"></textarea>
					</td>
					<td align="right" class="bg01">
					<%
						if(role == null || role.equals("BLACK")) {
					%>
						<input type="button" class="coment_input_text" value="댓글등록" id="comment-btn"/>
					<%
						} else if(role != null || !role.equals("BLACK")) {
					%>
						<input type="button" class="coment_input_text" id="submit1" value="댓글등록"  onclick="commentOk()"/>
					<%
						}
					%>
					</td>
				</tr>
				</table>
				</form>
			</div>
			<div class="btn_area">
				<div class="align_left">			
					<input type="button" value="목록" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='/reviewBoardList.do?cpage=<%=cpage%>'" />
				</div>
				<div class="align_right">
				<%
					if(role != null && role.equals("ADMIN") || rvwriter.equals(nickSession)) {
				%>
					<input type="button" value="수정" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='/reviewBoardModify.do?reviewId=<%=reviewId %>&cpage=<%=cpage %>'" />
	  			    <input type="button" value="삭제" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='/reviewBoardViewDelete_ok.do?reviewId=<%=reviewId %>'" /> 
				<%
					} 
				%>	
				</div>
			</div>
			<!--//게시판-->
		</div>
	<!-- 하단 디자인 -->
	</div>

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

<script>
function toggleEditForm(commentId) {
   var editForm = document.getElementById('editForm_' + commentId);
   editForm.style.display = (editForm.style.display === 'none') ? 'block' : 'none';
}
</script>        

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

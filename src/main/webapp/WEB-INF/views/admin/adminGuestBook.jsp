<%@page import="java.util.ArrayList"%>
<%@page import="com.example.model.GuestBookTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 내상태에 사용할 이모티콘
String smile = "\uD83D\uDE04";
String cry = "\uD83D\uDE22";
String angry = "\uD83D\uDE21";
String hungry = "\uD83D\uDE32" + "\uD83C\uDF5A";
String sleepy = "\uD83D\uDE34";
String neutral = "\uD83D\uDE10"; 
String confused = "\uD83D\uDE15";
String hurt = "\uD83E\uDD12";


ArrayList<GuestBookTO> guestbookList = (ArrayList)request.getAttribute("list");
String gbId = null;

StringBuilder gbHtml = new StringBuilder();
for(GuestBookTO to : guestbookList) {
	
	gbId = to.getGbId();
	String writer = to.getGbwriter();
	String content = to.getGbcontent();
	String emot = to.getEmot();
	String date = to.getGbdate();
	                             		
	gbHtml.append("<form action='/guestbookDeleteOk.do' method='post'> ");                              	                   
	gbHtml.append("<div class='card-body'>");                              	                   
	gbHtml.append("<div class='form-group'>");
	gbHtml.append("<div class='col-md-12'>");
	gbHtml.append("<span class='ps-0'>" + date + "</span>");
	gbHtml.append("<input type='hidden' name='gbId' value='" + gbId + "' >");
	gbHtml.append("&nbsp;&nbsp;<input type='submit' value='삭제' class='btn btn-warning' style='float:right; font-size:13px; color:black;'>");
	gbHtml.append("<input style='background-color:white; font-size:18px;' type='text' name='gbwriter' id='gbwriter' placeholder='" + writer +" "+ emot + "' class='form-control ps-0 form-control-line' readonly>");                               
	gbHtml.append("</div>");
	gbHtml.append("</div>");                                                              
	gbHtml.append("<div class='form-group'>");
	gbHtml.append("<div class='col-md-12'>");
	gbHtml.append("<textarea style='background-color:white; font-size:18px; height:100px;' rows='5' name='gbcontent' id='gbcontent' class='form-control ps-0 form-control-line' placeholder='" +  content + "' readonly></textarea>");
	gbHtml.append("</div>");
	gbHtml.append("</div>");
	gbHtml.append("</div>");
	gbHtml.append("</form>");
}
%>
<!DOCTYPE html>
<html dir="ltr" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="keywords"
        content="wrappixel, admin dashboard, html css dashboard, web dashboard, bootstrap 5 admin, bootstrap 5, css3 dashboard, bootstrap 5 dashboard, Monsterlite admin bootstrap 5 dashboard, frontend, responsive bootstrap 5 admin template, Monster admin lite design, Monster admin lite dashboard bootstrap 5 dashboard template">
    <meta name="description"
        content="Monster Lite is powerful and clean admin dashboard template, inpired from Bootstrap Framework">
    <meta name="robots" content="noindex,nofollow">
    <title>Monster Lite Template by WrapPixel</title>
    <link rel="canonical" href="https://www.wrappixel.com/templates/monster-admin-lite/" />
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="../assets/images/favicon.png">
    <!-- Custom CSS -->
    <link href="assets/css/acss/css/style.min.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->


</head>

<body>
    <!-- ============================================================== -->
    <!-- Preloader - style you can find in spinners.css -->
    <!-- ============================================================== -->
    <div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
    <!-- ============================================================== -->
    <!-- Main wrapper - style you can find in pages.scss -->
    <!-- ============================================================== -->
    <div id="main-wrapper" data-layout="vertical" data-navbarbg="skin5" data-sidebartype="full"
        data-sidebar-position="absolute" data-header-position="absolute" data-boxed-layout="full">
        <!-- ============================================================== -->
        <!-- Topbar header - style you can find in pages.scss -->
        <!-- ============================================================== -->
        <header class="topbar">
            <nav class="navbar top-navbar navbar-expand-md navbar-dark">
                <div class="navbar-header" data-logobg="skin6">
                    <!-- ============================================================== -->
                    <!-- Logo -->
                    <!-- ============================================================== -->
                    <a class="navbar-brand" href="/GOsakas.do">
                        <!-- Logo icon -->
                        <b class="logo-icon">
                            <img src="assets/images/Gosaka_gold.png" alt="homepage" class="dark-logo" />
                        </b>                        
                    </a>
                    <!-- ============================================================== -->
                    <!-- End Logo -->
                    <!-- ============================================================== -->
                    <!-- ============================================================== -->
                    <!-- toggle and nav items -->
                    <!-- ============================================================== -->
                    <a class="nav-toggler waves-effect waves-light text-dark d-block d-md-none"
                        href="javascript:void(0)"><i class="ti-menu ti-close"></i></a>
                </div>

            </nav>
        </header>
        <!-- ============================================================== -->
        <!-- End Topbar header -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Left Sidebar - style you can find in sidebar.scss  -->
        <!-- ============================================================== -->
        <aside class="left-sidebar" data-sidebarbg="skin6">
            <!-- Sidebar scroll-->
            <div class="scroll-sidebar">
                <!-- Sidebar navigation-->
                <nav class="sidebar-nav">
                    <ul id="sidebarnav">
                        <!-- User Profile-->
                        <li class="sidebar-item"> 
                        	<a class="sidebar-link waves-effect waves-dark sidebar-link" href="/admin.do" aria-expanded="false">
                        		<i class="me-3 far fa-clock fa-fw" aria-hidden="true"></i>
                        		<span class="hide-menu">Dashboard</span>
                        	</a>
                        </li>
                        <li class="sidebar-item"> 
                        	<a class="sidebar-link waves-effect waves-dark sidebar-link" href="/adminGuestBook.do" aria-expanded="false">
                                <i class="me-3 fa fa-user" aria-hidden="true"></i>
                                <span class="hide-menu">Guest Book</span>
                            </a>
                        </li>
                        <li class="sidebar-item"> 
                        	<a class="sidebar-link waves-effect waves-dark sidebar-link" href="/adminMember.do" aria-expanded="false">
                        		<i class="me-3 fa fa-table" aria-hidden="true"></i>
                        		<span class="hide-menu">User Management</span>
                        	</a>
                        </li>                      
                    </ul>
                </nav>
                <!-- End Sidebar navigation -->
            </div>
            <!-- End Sidebar scroll-->
        </aside>
        <!-- ============================================================== -->
        <!-- End Left Sidebar - style you can find in sidebar.scss  -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Page wrapper  -->
        <!-- ============================================================== -->
        <div class="page-wrapper">
            <!-- ============================================================== -->
            <!-- Bread crumb and right sidebar toggle -->
            <!-- ============================================================== -->
            <div class="page-breadcrumb">
                <div class="row align-items-center">
                    <div class="col-md-6 col-8 align-self-center">
                        <h3 class="page-title mb-0 p-0">Guest Book</h3>
                        <div class="d-flex align-items-center">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Guest Book</li>
                                </ol>
                            </nav>
                        </div>
                    </div>                 
                </div>
            </div>
            <!-- ============================================================== -->
            <!-- End Bread crumb and right sidebar toggle -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- Container fluid  -->
            <!-- ============================================================== -->
            <div class="container-fluid">
                <!-- ============================================================== -->
                <!-- Start Page Content -->
                <!-- ============================================================== -->
                <!-- Row -->
                <div class="row">                   
                    <!-- Column -->
                    <!-- Column -->
                    <div>
                        <div class="card">
                            <div class="card-body">
                                <form action="/guestbookWriteOk.do" method="post" name="gfrm" class="form-horizontal form-material mx-2">
                                    <div class="form-group">
                                        <label class="col-md-12 mb-0">Nickname</label>
                                        <div class="col-md-12">
                                            <input type="text" name="gbwriter" id="gbwriter" placeholder="작성자" class="form-control ps-0 form-control-line">
                                        </div>
                                    </div>                                                              
                                    <div class="form-group">
                                        <label class="col-md-12 mb-0">Message</label>
                                        <div class="col-md-12">
                                            <textarea rows="5" name="gbcontent" id="gbcontent" class="form-control ps-0 form-control-line" placeholder="내용을 입력하세요."></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-12">오늘 내상태</label>
                                        <div class="col-sm-12 border-bottom">
                                            <select style="font-size:25px;" name="emot" id="emot" class="form-select shadow-none border-0 ps-0 form-control-line">
                                                <option><%=smile %></option>
                                                <option><%=cry %></option>
                                                <option><%=angry %></option>
                                                <option><%=hungry %></option>
                                                <option><%=sleepy %></option>
                                                <option><%=neutral %></option>
                                                <option><%=confused %></option>
                                                <option><%=hurt %></option>                                             
                                            </select>
                                        </div>
                                    </div>                                   
                                    <div class="form-group">
                                        <div class="col-sm-12 d-flex">
                                            <button class="btn btn-success mx-auto mx-md-0 text-white">작성</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <br>
                            <h4 style="text-align:center;">방명록</h4>                         
                            <hr style="margin:0 auto; width:50%;">                                                         	                    	
                            	<%=gbHtml %>                           
                        </div>
                    </div>
                    <!-- Column -->
                </div>
                <!-- Row -->
                <!-- ============================================================== -->
                <!-- End PAge Content -->
                <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- Right sidebar -->
                <!-- ============================================================== -->
                <!-- .right-sidebar -->
                <!-- ============================================================== -->
                <!-- End Right sidebar -->
                <!-- ============================================================== -->
            </div>
            <!-- ============================================================== -->
            <!-- End Container fluid  -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- footer -->
            <!-- ============================================================== -->
            <footer class="footer text-center">
                © 2021 Monster Admin by <a href="https://www.wrappixel.com/">wrappixel.com</a>
            </footer>
            <!-- ============================================================== -->
            <!-- End footer -->
            <!-- ============================================================== -->
        </div>
        <!-- ============================================================== -->
        <!-- End Page wrapper  -->
        <!-- ============================================================== -->
    </div>
    <!-- ============================================================== -->
    <!-- End Wrapper -->
    <!-- ============================================================== -->
    <!-- ============================================================== -->
    <!-- All Jquery -->
    <!-- ============================================================== -->
    <script src="assets/css/plugins/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="assets/css/plugins/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/css/acss/js/app-style-switcher.js"></script>
    <!--Wave Effects -->
    <script src="assets/css/acss/js/waves.js"></script>
    <!--Menu sidebar -->
    <script src="assets/css/acss/js/sidebarmenu.js"></script>
    <!--Custom JavaScript -->
    <script src="assets/css/acss/js/custom.js"></script>
</body>

</html>
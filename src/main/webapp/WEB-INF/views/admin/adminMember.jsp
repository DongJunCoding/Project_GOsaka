<%@page import="com.example.model.LoginTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
ArrayList<LoginTO> totalUser = (ArrayList)request.getAttribute("totalUser");

StringBuilder mmHtml = new StringBuilder();
for(LoginTO to : totalUser) {
    
    if(to.getRole().equals("NORMAL") || to.getRole().equals("BLACK")) {
        mmHtml.append("<form action='/changeRole.do' method='post' name='cfrm' onsubmit='return confirmAction();'>");
        mmHtml.append("<input type='hidden' value='" + to.getMemberId() + "' name='memberId' />");
        mmHtml.append("<tr>");
        mmHtml.append("<td>" + to.getMemberId() + "</td>");
        mmHtml.append("<td>" + to.getUserId() + "</td>");
        mmHtml.append("<td>" + to.getNickname() + "</td>");
        mmHtml.append("<td>" + to.getMdate() + "</td>");
        mmHtml.append("<td>");
        if(to.getRole().equals("NORMAL")) {
            mmHtml.append("<input class='btn btn-dark' type='submit' value='블랙' name='blackList' id='bbtn' style='font-size:13px;'>&nbsp;");
        } else if(to.getRole().equals("BLACK")) {
            mmHtml.append("<input class='btn btn-success' type='submit' value='해제' name='clear' id='cbtn' style='font-size:13px; color:white;'>&nbsp;");    
        }
        mmHtml.append("<input class='btn btn-danger' type='submit' value='탈퇴' name='delete' id='dbtn' style='font-size:13px; color:white;'>");
        mmHtml.append("</td>");
        mmHtml.append("</tr>"); 
        mmHtml.append("</form>"); 
    }
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

<script>
    function confirmAction() {
        return confirm("정말로 진행하시겠습니까?");
    }
</script>
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
                        <h3 class="page-title mb-0 p-0">User Management</h3>
                        <div class="d-flex align-items-center">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">User Management</li>
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
                <div class="row">
                    <!-- column -->
                    <div class="col-sm-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">회원목록</h4>
                                <h6 class="card-subtitle">블랙리스트 & 삭제</h6>
                                <div class="table-responsive">
                                    <table class="table user-table no-wrap">
                                        <thead>
                                            <tr>
                                                <th class="border-top-0">Number</th>
                                                <th class="border-top-0">ID</th>
                                                <th class="border-top-0">Nickname</th>
                                                <th class="border-top-0">Date</th>
                                                <th class="border-top-0">Manage</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<%=mmHtml %>                                        
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
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
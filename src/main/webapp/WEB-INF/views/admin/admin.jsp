<%@page import="com.example.model.QnaBoardTO"%>
<%@page import="com.example.model.LoginTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int tipSize = (int)request.getAttribute("tipSize");
int revSize = (int)request.getAttribute("revSize");
int qnaSize = (int)request.getAttribute("qnaSize");

int osaka = (int)request.getAttribute("osaka");
int kyoto = (int)request.getAttribute("kyoto");
int kobe = (int)request.getAttribute("kobe");
int nara = (int)request.getAttribute("nara");

ArrayList<LoginTO> todayMember = (ArrayList)request.getAttribute("todayMember");
ArrayList<QnaBoardTO> todayQnaList = (ArrayList)request.getAttribute("todayQnaList");
ArrayList<QnaBoardTO> qnaList = (ArrayList)request.getAttribute("qnaBoardList");

int size = 0;

// 당일 회원가입한 회원 리스트
StringBuilder memberHtml = new StringBuilder();
for(LoginTO to : todayMember) {
	if(to.getGap() == 0) {
		String id = to.getMemberId();
		String userId = to.getUserId();
		String nickname = to.getNickname();
		String date = to.getMdate();
		
		memberHtml.append("<tr>");
		memberHtml.append("<td style='width:50px;'><span class='round'>" + id + "</span></td>");
		memberHtml.append("<td class='align-middle'>");
		memberHtml.append("<h6>" + userId + "</h6>");
		memberHtml.append("</td>");
		memberHtml.append("<td class='align-middle'>" + nickname + "</td>");
		memberHtml.append("<td class='align-middle'>" + date + "</td>");
		memberHtml.append("</tr>");  
	}
}


// qna 당일 게시글 3개 리스트
StringBuilder qnaListHtml = new StringBuilder();
for(QnaBoardTO to : todayQnaList) {
	
	String seq = to.getQnaId();
	String subject = to.getQsubject();
	String writer = to.getQwriter();
	String date = to.getQdate();
	
	if(to.getQgap() == 0) {	
	qnaListHtml.append("<div class='col-lg-4 col-md-6'>");
    qnaListHtml.append("<div class='card'>");                           
    qnaListHtml.append("<div class='card-body'>");
    qnaListHtml.append("<ul class='list-inline d-flex align-items-center'>");
 	qnaListHtml.append("<li class='ps-0'>" + writer + "</li>");
	qnaListHtml.append("<li class='ms-auto'>" + date + "</a></li>");
	qnaListHtml.append("</ul>");
	qnaListHtml.append("<img src='assets/images/icon_new.gif' alt='NEW'>");
	qnaListHtml.append("<h3 class='font-normal' ><a href='/qnaBoardView.do?qnaId="+seq+"'>" + subject + "</a></h3>");
	qnaListHtml.append("</div>");
	qnaListHtml.append("</div>");
	qnaListHtml.append("</div>");
	}	
}


// qna 당일 게시글 총 개수
for(QnaBoardTO to : qnaList) {
	if(to.getQgap() == 0) {
	size++;
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
    <link href="assets/css/plugins/chartist/dist/chartist.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="assets/css/acss/css/style.min.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->


<script src="https://d3js.org/d3.v5.min.js"></script>

<style>
    /* 게시판 및 관광가이드 통계 CSS */
    .legend, .legend1 {
        margin-bottom: 10px;
        display: flex;
        align-items: center; /* 수직 가운데 정렬 */
    }

    .color-box, .color-box1 {
        width: 20px;
        height: 20px;
        display: inline-block;
        margin-right: 5px;
    }

    /* 수정된 부분: 간격 조정 */
    .legend > div, .legend1 > div {
        flex: 1; /* 각 세트의 크기를 동일하게 설정 */
    }

    /* 수정된 부분: 여백 조정 */
    #chart-container {
        display: flex;
        justify-content: space-around; /* 세트를 양 옆에 위치시키기 위한 설정 */
        margin-bottom: 20px; /* 하단 여백을 조절합니다. */
    }
</style>
</head>

<body>
    <div id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
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
                        <h3 class="page-title mb-0 p-0">Dashboard</h3>
                        <div class="d-flex align-items-center">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Dashboard</li>
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
                <!-- Sales chart -->
                <!-- ============================================================== -->
                
                <!-- ============================================================== -->
                <!-- Sales chart -->
                <!-- ============================================================== -->
                <!-- chart -->
                <div id="chart-container">
				    <div>
				        <div id="donut-chart"></div>
				        <div id="legend"></div>
				    </div>
				    <div>
				        <div id="donut-chart1"></div>
				        <div id="legend1"></div>
				    </div>
				</div>
				
				<!-- 게시판 script -->	
			    <script>
				    // 데이터 설정
				    var data = [
				        { label: "TipBoard", value: <%=tipSize%> },
				        { label: "ReviewBoard", value: <%=revSize%> },
				        { label: "QnABoard", value: <%=qnaSize%> }
				    ];
				
				    var width = 400;
				    var height = 400;
				    var radius = Math.min(width, height) / 2;
				
				    var svg = d3.select("#donut-chart")
				        .append("svg")
				        .attr("width", width)
				        .attr("height", height)
				        .append("g")
				        .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");
				
				    var color = d3.scaleOrdinal(d3.schemeCategory10);
				
				    var pie = d3.pie().value(function (d) {
				        return d.value;
				    });
				
				    var path = d3.arc()
				        .outerRadius(radius - 10)
				        .innerRadius(radius - 70);
				
				    var arc = svg.selectAll(".arc")
				        .data(pie(data))
				        .enter()
				        .append("g")
				        .attr("class", "arc");
				
				    arc.append("path")
				        .attr("d", path)
				        .attr("fill", function (d, i) {
				            return color(i);
				        })
				        .transition()
				        .ease(d3.easeLinear)
				        .duration(1000)
				        .attrTween("d", function (d) {
				            var interpolate = d3.interpolate({ startAngle: 0, endAngle: 0 }, d);
				            return function (t) {
				                return path(interpolate(t));
				            };
				        });
				
				    arc.append("text")
				        .attr("transform", function (d) {
				            return "translate(" + path.centroid(d) + ")";
				        })
				        .attr("dy", ".35em")
				        .attr("font-size", 20)
				        .text(function (d) {
				            return d.data.value; // 데이터 개수 표시
				        });
				
				    // 중앙 텍스트
				    svg.append("text")
				        .attr("text-anchor", "middle")
				        .attr("font-size", 30)
				        .attr("dy", ".35em")
				        .text("Board");
				
				    // 설명을 그래프 바로 오른쪽에 추가
				    var legend = d3.select("#legend")
				        .selectAll(".legend")
				        .data(data)
				        .enter().append("div")
				        .attr("class", "legend")
				        .style("color", function (d, i) {
				            return color(i);
				        })
				        .html(function (d) {
				            return '<span class="color-box" style="background-color:' + color(data.indexOf(d)) + '"></span>' +
				                d.label;
				        });
				</script>
				
				<!-- 관광리스트 부분 script -->		
			    <script>
			        // 데이터 설정
			        var data = [
			            { label: "Osaka", value: <%=osaka%> },
			            { label: "Kyoto", value: <%=kyoto%> },
			            { label: "Kobe", value: <%=kobe%> },
			            { label: "Nara", value: <%=nara%> }
			        ];
			
			        var width = 400;
			        var height = 400;
			        var radius = Math.min(width, height) / 2;
			
			        var svg = d3.select("#donut-chart1")
			            .append("svg")
			            .attr("width", width)
			            .attr("height", height)
			            .append("g")
			            .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");
			
			        var color = d3.scaleOrdinal(d3.schemeCategory10);
			
			        var pie = d3.pie().value(function (d) {
			            return d.value;
			        });
			
			        var path = d3.arc()
			            .outerRadius(radius - 10)
			            .innerRadius(radius - 70);
			
			        var arc = svg.selectAll(".arc")
			            .data(pie(data))
			            .enter()
			            .append("g")
			            .attr("class", "arc");
			
			        arc.append("path")
			            .attr("d", path)
			            .attr("fill", function (d, i) {
			                return color(i);
			            })
			            .transition()
			            .ease(d3.easeLinear)
			            .duration(1000)
			            .attrTween("d", function (d) {
			                var interpolate = d3.interpolate({ startAngle: 0, endAngle: 0 }, d);
			                return function (t) {
			                    return path(interpolate(t));
			                };
			            });
			
			        arc.append("text")
			            .attr("transform", function (d) {
			                return "translate(" + path.centroid(d) + ")";
			            })
			            .attr("dy", ".35em")
			            .attr("font-size", 20)
			            .text(function (d) {
			                return d.data.value; // 데이터 개수 표시
			            });
			        
			        // 중앙 텍스트
				    svg.append("text")
				        .attr("text-anchor", "middle")
				        .attr("font-size", 30)
				        .attr("dy", ".35em")
				        .text("Guide");
			
				    // 설명을 그래프 바로 오른쪽에 추가
				    var legend = d3.select("#legend1")
				        .selectAll(".legend1")
				        .data(data)
				        .enter().append("div")
				        .attr("class", "legend1")
				        .style("color", function (d, i) {
				            return color(i);
				        })
				        .html(function (d) {
				            return '<span class="color-box1" style="background-color:' + color(data.indexOf(d)) + '"></span>' +
				                d.label;
				        });
			    </script>
			
			    
    
                <!-- ============================================================== -->
                <!-- Table -->
                <!-- ============================================================== -->
                <div class="row">
                    <div class="col-sm-12">
                        <h3>Today Sign-Up</h3>
                        <div class="card">
                            <div class="card-body">                               
                                <div class="table-responsive">
                                    <table class="table stylish-table no-wrap">
                                        <thead>
                                            <tr>
                                                <th class="border-top-0" colspan="2">ID</th>
                                                <th class="border-top-0">Nickname</th>
                                                <th class="border-top-0">Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%=memberHtml %>                                     
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- ============================================================== -->
                <!-- Table -->
                <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- Recent blogss -->
                <!-- ============================================================== -->
                <h3>Today Q&A &nbsp;<span style="font-size:15px;">(총 <%=size %>건)</span></h3>
                <div class="row justify-content-center">
                    <!-- Column -->
                    <%=qnaListHtml %>                 
                    <!-- Column -->
                </div>
                <!-- ============================================================== -->
                <!-- Recent blogss -->
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
    <!--This page JavaScript -->
    <!--flot chart-->
    <script src="assets/css/plugins/flot/jquery.flot.js"></script>
    <script src="assets/css/plugins/flot.tooltip/js/jquery.flot.tooltip.min.js"></script>
    <script src="assets/css/acss/js/pages/dashboards/dashboard1.js"></script>
</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
	int flag = (Integer) request.getAttribute("flag");
	String reviewId = (String)request.getAttribute("reviewId");

	
	out.println("<script type='text/javascript'>");
	if (flag == 0) {
		out.println("alert('데이터 수정 성공 ~ ');");
		out.println("location.href='/reviewBoardView.do?reviewId="+reviewId+"';");
	} else {
		out.println("alert('실패');");
		out.println("history.back();");
	}
	out.println("</script>");
%>

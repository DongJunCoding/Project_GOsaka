<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int flag = (int)request.getAttribute("flag");

	out.println( "<script type='text/javascript'>" );
	if( flag == 0 ) {
		out.println( "alert('완료되었습니다.');" );
		out.println( "location.href='/adminMember.do'" );
	} else {
		out.println( "alert('실패 !');" );
		out.println( "history.back();" );
	}
	out.println("</script>");
%>

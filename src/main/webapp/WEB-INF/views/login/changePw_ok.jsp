<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int flag = (Integer)request.getAttribute( "flag" );

	out.println( "<script type='text/javascript'>" );
	if( flag == 0 ) {
		out.println( "alert('비밀번호 변경 완료 !');" );
		out.println( "location.href='/login.do'" );
	} else {
		out.println( "alert('비밀번호 변경 실패');" );
		out.println( "history.back();" );
	}
	out.println( "</script>" );
%>

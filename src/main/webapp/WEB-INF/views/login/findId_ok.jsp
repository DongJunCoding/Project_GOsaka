<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String code = (String)request.getAttribute( "code" );

	out.println( "<script type='text/javascript'>" );
	if( code != null ) {
		out.println( "alert('이메일 전송 완료 !');" );
		out.println( "location.href='/login.do'" );
	} else {
		out.println( "alert('이메일 전송 실패 !');" );
		out.println( "history.back();" );
	}
	out.println( "</script>" );
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	out.println( "<script type='text/javascript'>" );
		out.println( "alert('로그아웃');" );
		out.println( "location.href='/login.do'" );

	out.println( "</script>" );
%>

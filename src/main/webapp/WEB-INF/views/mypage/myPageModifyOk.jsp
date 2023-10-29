<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int flag = (Integer)request.getAttribute( "flag" );
	
	out.println( " <script type='text/javascript'> " );
	if( flag == 0 ) {
		out.println( " alert('닉네임 변경 완료 ! / 다시 로그인 해주세요 !'); " );

		out.println( " location.href='/myPage.do'" );
										
	} else {
		out.println( " alert('닉네임 변경 실패 !'); " );
		out.println( " history.back(); " );
	}
	out.println( " </script> " );

%>
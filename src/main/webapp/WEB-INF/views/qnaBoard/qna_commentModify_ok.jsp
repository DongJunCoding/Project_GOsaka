<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String qnaId = request.getParameter("qnaId");

   int flag = (Integer)request.getAttribute( "flag" );
   
   out.println( " <script type='text/javascript'> " );
   if( flag == 0 ) {
      out.println( " alert('댓글 수정 완료!'); " );
      out.println( " location.href='/qnaBoardView.do?qnaId="+ qnaId +"'" );
                              
   } else {
      out.println( " alert('댓글 수정 실패!'); " );
      out.println( " history.back(); " );
   }
   out.println( " </script> " );

%>
<%@page import="model.MemberDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="smtp.SMTPAuth"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>  
<%
request.setCharacterEncoding("UTF-8");

String drv = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MariaConnectURL");

String id = request.getParameter("id");
String name = request.getParameter("name2");
String email = request.getParameter("email2");

MemberDAO dao = new MemberDAO(drv, url);

System.out.println(id);
System.out.println(name);
System.out.println(email);

String result = dao.sendpass(id,name,email);

SMTPAuth smtp = new SMTPAuth();

Map<String,String> emailContent = new HashMap<String,String>();
emailContent.put("from", "krst7336@naver.com");
emailContent.put("to", email);
emailContent.put("subject","찾으시는 비밀번호를 제가 찾아드렸지요");
emailContent.put("content","당신이 찾으시는 비밀번호는 " + result + "입니다");
 
if(result!=null){
	boolean emailResult = smtp.emailSending(emailContent);
	if(emailResult==true){
		out.print(1);
		return;
	}
	else{
	}
}
out.print(0);
%>

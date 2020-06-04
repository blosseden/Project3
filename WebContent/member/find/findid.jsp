<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>    
<%
request.setCharacterEncoding("UTF-8");

String drv = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MariaConnectURL");

String name = request.getParameter("name1");
String email = request.getParameter("email1");


MemberDAO dao = new MemberDAO(drv, url);

System.out.println(name);
System.out.println(email);

String result = dao.findid(name, email);
System.out.println(result);
out.print(result);
%>
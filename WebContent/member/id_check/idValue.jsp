<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String drv = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MariaConnectURL");

String id = request.getParameter("id");

MemberDAO dao = new MemberDAO(drv, url);

System.out.println(id);
int result = dao.overlap(id);
out.println(result);
%>
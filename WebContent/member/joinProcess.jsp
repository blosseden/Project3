<%@page import="java.util.Map"%>
<%@page import="model.MemberDTO"%>
<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String drv = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MariaConnectURL");

String id = request.getParameter("id");
String phonenum = request.getParameter("tel1") + request.getParameter("tel2") + request.getParameter("tel3");
String email = request.getParameter("email1") + "@" + request.getParameter("email2");
String address = request.getParameter("postcode") + request.getParameter("address") + request.getParameter("detailAddress") + request.getParameter("extraAddress");
String pass = request.getParameter("pass");
String name = request.getParameter("name");

System.out.println(id);
System.out.println(phonenum);
System.out.println(email);
System.out.println(address);
System.out.println(pass);
System.out.println(name);

MemberDTO dto = new MemberDTO();

dto.setId(id);
dto.setPhonenum(phonenum);
dto.setEmail(email);
dto.setAddress(address);
dto.setPass(pass);
dto.setName(name);

MemberDAO dao = new MemberDAO(drv, url);

int affected = dao.join(dto);
if(affected==1){
	response.sendRedirect("login.jsp");
}
else{
%>

<script>
	alert("실패!");
	history.go(-1);
</script>

<%
}
%>
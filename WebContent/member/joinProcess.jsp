<%@page import="java.util.Map"%>
<%@page import="model.MemberDTO"%>
<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

String id = request.getParameter("id");
int phonenum = Integer.parseInt(request.getParameter("phonenum"));
String email = request.getParameter("email");
String address = request.getParameter("address");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
int level = Integer.parseInt(request.getParameter("level"));



MemberDTO dto = new MemberDTO();

dto.setId(id);
dto.setPhonenum(phonenum);
dto.setEmail(email);
dto.setAddress(address);
dto.setPass(pass);
dto.setName(name);
dto.setLevel(level);


MemberDAO dao = new MemberDAO();

int affected = dao.signup(dto);
if(affected==1){
	response.sendRedirect("../main/main.jsp");
	
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
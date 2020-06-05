<%@page import="java.util.Map"%>
<%@page import="model.MemberDAO"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("user_id");
String pw = request.getParameter("user_pw");
String id_save = request.getParameter("id_save");

//MariaDB정보로 변경되므로 초기화파라미터를 수정한다.
String drv = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MariaConnectURL");

MemberDAO dao = new MemberDAO(drv, url);


//방법3 : Map 컬렉션에 회원정보 저장 후 반환받기 
Map<String, String> memberInfo = dao.getMemberMap(id, pw); 

if(memberInfo.get("id")!=null){
	 //저장된 값이 있다면....세션영역에 아이디, 패스워드, 이름을 속성으로 저장한다.
	session.setAttribute("user_id", memberInfo.get("id"));
	session.setAttribute("user_pw", memberInfo.get("pass"));
	session.setAttribute("user_name", memberInfo.get("name"));
	if(id_save==null){
		Cookie ck = new Cookie("user_id", "");
		ck.setPath(request.getContextPath());
		ck.setMaxAge(0);
		response.addCookie(ck);
	}
	else{
		Cookie ck = new Cookie("user_id", id);
		System.out.println(request.getContextPath());
		ck.setPath(request.getContextPath());
		ck.setMaxAge(60*60*24*100);
		response.addCookie(ck);
	}
	response.sendRedirect("login.jsp");
}

else{
	//저장된 값이 없다면 리퀘스트 영역에 오류메세지를 저장하고 포워드한다ㅏㅏㅏ
	request.setAttribute("ERROR_MSG", "ㅗ");
	request.getRequestDispatcher("login.jsp").forward(request,response);
}
%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.multipart.FileRenamePolicy"%>
<%@page import="model.BbsDAO"%>
<%@page import="model.BbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//out.print("글쓰기 처리:"+ request.getParameter("title"));
%>
<%@ include file="../member/isLogin.jsp" %>
<%@ include file="../include/isFlag.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

String saveDirectory = application.getRealPath("/Upload");

int maxPostSize = 1024 * 5000;

String encoding = "UTF-8";

FileRenamePolicy policy = new DefaultFileRenamePolicy();

MultipartRequest mr = null;

String title = request.getParameter("title");//제목
String content = request.getParameter("content");//내용 
String file = mr.getFilesystemName("file");//파일

//폼값을 DTO객체에 저장
BbsDTO dto = new BbsDTO();
dto.setTitle(title);
dto.setContent(content);
//세션 영역에 저장된 회원인증정보를 가져와서 저장.
dto.setId(session.getAttribute("user_id").toString());


//게시판 필수파라미터를 DTO에 추가
dto.setBname(bname);

//DAO객체 생성시 application내장 객체를 인자로 전달
BbsDAO dao = new BbsDAO(application);

//사용자의 입력값을 DTO객체에 저장 후 파라미터로 전달
/* 
int affected = 0;
for(int i=1 ; i<=100 ; i++){
	dto.setTitle(title + i +"번째 게시물 ");
	affected = dao.insertWrite(dto);
}
게시물 100개써버리기
*/
int affected = dao.insertWrite(dto);
if(affected==1){
	//글쓰기에 성공했을 때
	response.sendRedirect("BoardList.jsp?bname="+bname);
	}
	else{
	//글쓰기에 실패 했을 때
%>
	<script>
		alert("글쓰기 실패띠");
		history.go(-1);
		</script>
	<%
	}
	%>
	
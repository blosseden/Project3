<%@page import="util.JavascriptUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
//멀티게시판 구현을 위한 파라미터 처리

/*
String bname = "";
if(bname==null || bname.equals("")){
	//만약 bname의 값이 없다면 로그인 화면으로 강제이동시킨다.
	JavascriptUtil.jsAlertLocation("필수파라미터 누락됨", "../member/login.jsp", out);
	return;
}
 */
String bname = request.getParameter("bname");

if(bname==null || bname.equals("")){
bname = "freeboard";	
}

String boardTitle = "";
switch(bname){
case "notice" :
	boardTitle = "../images/space/sub01_title.gif";
	break;
case "program" :
	boardTitle = "../images/space/sub02_title.gif";
	break;
case "freeboard" :
	boardTitle = "../images/space/sub03_title.gif";
	break;
case "picture" :
	boardTitle = "../images/space/sub04_title.gif";
	break;
case "info" :
	boardTitle = "../images/space/sub05_title.gif";
	break;
}

String boardname = "";
switch(bname){
case "notice" :
	boardname = "공지사항";
	break;
case "program" :
	boardname = "프로그램일정";
	break;
case "freeboard" :
	boardname = "자유게시판";
	break;
case "picture" :
	boardname = "사진게시판";
	break;
case "info" :
	boardname = "정보게시판";
	break;
}
%>
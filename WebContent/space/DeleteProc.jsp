<%@page import="util.JavascriptUtil"%>
<%@page import="model.BbsDAO"%>
<%@page import="model.BbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../member/isLogin.jsp" %>
    <%
    request.setCharacterEncoding("UTF-8");
    String num = request.getParameter("num");
    
    BbsDTO dto = new BbsDTO();
    BbsDAO dao = new BbsDAO(application);
    
    //작성자 본인 확인을 위해 기존 게시물의 내용을 가져온다.
    dto = dao.selectView(num);
    
    String session_id = session.getAttribute("user_id").toString();
    
    int affected = 0;
    
    //세션영역과 DB상의 작성자가 동일한지 확인하여 true일 때는 삭제처리
    if(session_id.equals(dto.getId())){
    	dto.setNum(num);
    	affected = dao.delete(dto);
    }
    else{
    	//false일 때는 경고창으로 인ㅇ아ㅣㄴㅇ아ㅣㄴㅇ아ㅣㄴㅇㅈㄱ방
    	JavascriptUtil.jsAlertBack("본인만 삭제가능합니다.", out);
    	return;
    }
    if(affected==1){
    	JavascriptUtil.jsAlertLocation("삭제되었습니다.","BoardList.jsp", out);
    }
    else{
    	out.println(JavascriptUtil.jsAlertBack("실패띠"));
    }
    %>
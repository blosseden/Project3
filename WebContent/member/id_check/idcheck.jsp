<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String result = request.getParameter("result");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="../common/jquery/jquery-3.5.1.js"></script>
<link rel="stylesheet" href="../common/bootstrap4.4.1/css/bootstrap.css" />
<script type="text/javascript">
function idUse() {
	self.close();
}
</script>
</head>
<body>
	<h2>아이디 중복확인 하기</h2>
	<%
	System.out.println(result);
	if(result.equals("1")){
	%>
	<h5>안됩니다 다른거 쓰세요</h5>
	<input type="button" value="아이고 내 팔자야" onclick="idUse();"/>
	<%
	}else{
	%>
	<h5>사용가능합니다. 사용해야겠죠?</h5>
	<input type="button" value="사용하기" onclick="idUse();" />&nbsp;<input type="button" value="어차피 이거 눌러도 사용돼요" onclick="idUse();"/>
	<%
	}
	%>
</body>
</html>
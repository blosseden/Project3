<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

<script>
	$(function(){

		$('#checkId').click(function(){
			
			if($("#name1").val()==""){
				alert("이름을 쓰세요");
				name1.focus();
				return false;
			}
			if($("#email1").val()==""){
				alert("이메일을 쓰세요");
				email1.focus();
				return false;
			}
        	
			$.ajax({
        		url : './find/findid.jsp',
        		type : "post",
        		dataType : "html",
        		contentype : "application/x-www-form-urlencoded;charset=utf-8",
        		data : {
        			name1 : $("#name1").val(),
        			email1 : $("#email1").val()
        		},
        		success : function(value) {
        			console.log(value);
        			if(value==""){
        				alert("없어여");        				
        			}		
        			else{
						alert("찾으신 아이디는 "+ value +" 입니다");					
					} 			
        		}
        	});
        });
		
		$('#checkPass').click(function(){
			if($("#id").val()==""){
				alert("아이디를 쓰세요");
				id.focus();
				return false;
			}
			if($("#name2").val()==""){
				alert("이름을 쓰세요");
				name2.focus();
				return false;
			}
			if($("#email2").val()==""){
				alert("이메일을 쓰세요");
				email2.focus();
				return false;
			}
			
			$.ajax({
        		url : './find/EmailTextSending.jsp',
        		type : "post",
        		dataType : "html",
        		contentype : "application/x-www-form-urlencoded;charset=utf-8",
        		data : {
        			id : $("#id").val(),
        			name2 : $("#name2").val(),
        			email2 : $("#email2").val()
        		},
        		success : function(data){
        			if(data=="1"){
        				alert("성공!");
        				location.href="id_pw.jsp";
        			}
        			else{
        				alert("실패!");
        			}
        		}
        	});
        });
	});	
</script>
 <body>
	<//center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/member/id_pw_title.gif" alt="" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;아이디/비밀번호찾기<p>
				</div>
				<div class="idpw_box">
					<div class="id_box">
					<form method="post" id="findIdFrm" name="findIdFrm" >
						<ul>
							<li><input type="text" name="name1" id="name1" value="" class="login_input01" /></li>
							<li><input type="text" name="email1" id="email1" value="" class="login_input01" /></li>
						</ul>
						<input type="image" src="../images/member/id_btn01.gif" id="checkId" class="id_btn" />
						<a href="join01.jsp"><img src="../images/login_btn03.gif" class="id_btn02" /></a>
						</form>
					</div>
					<div class="pw_box">
					<form action="javascript:void(0);" method="post" id="findIdFrm" name="findIdFrm">
						<ul>
							<li><input type="text" name="id" id="id" value="" class="login_input01" /></li>
							<li><input type="text" name="name2" id="name2" value="" class="login_input01" /></li>
							<li><input type="text" name="email2" id="email2" value="" class="login_input01" /></li>
						</ul>
						<input type="image" src="../images/member/id_btn01.gif" id="checkPass" class="pw_btn" />
					</form>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>

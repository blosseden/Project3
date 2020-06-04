<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = '';
            var extraAddr = '';

            if (data.userSelectedType === 'R') {
                addr = data.roadAddress;
            } else {
                addr = data.jibunAddress;
            }
            
            if(data.userSelectedType === 'R'){
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}
</script>

<%
request.setCharacterEncoding("UTF-8");

String driver = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MariaConnectURL");


MemberDAO dao = new MemberDAO(driver, url);
%>

<script>
    $(function(){
   
        $('#last_email_check2').change(function(){
          
            var text = $('#last_email_check2 option:selected').text();
            
            var value = $('#last_email_check2 option:selected').val();
          
            
            if(value==""){
                $('#email2').attr('readonly' , true);
                $('#email2').val('');
            }
            else if(value=='direct'){
                $('#email2').attr('readonly',false);
                $('#email2').val('');
            }
            else{
                $('#email2').attr('readonly',true);
                $('#email2').val(value);
            }
            
        });

        
        $('#name').keyup(function(event){
	
	     	var namePattern = /^[가-힣]+$/;
        	var compareName = $(this).val();
        	
        	if(namePattern.test(compareName)){
        		
        		$('#namemsg').html('<b style="color:#ff9999">잘썼구만 그래</b>');
        	}
        	else{
        		$('#namemsg').html('<b style="color:#22424a">우리 한국인이잖아...</b>')
        	}
        	
        });
        
        
        $('#id').keyup(function(event){
	
	     	var idPattern = /^[A-Za-z]{1}[A-Za-z0-9]{4,12}$/;
        	var compareId = $(this).val();
        	
        	if(idPattern.test(compareId)){
        		
        		$('#idmsg').html('<b style="color:#ff9999">잘썼구만 그래</b>');
        	}
        	else{
        		$('#idmsg').html('<b style="color:#22424a">하아....</b>')
        	}
        	
        });
        
        
        $('#pass').keyup(function(event){
	
	     	var passPattern = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{4,16}$/;;
        	var comparePass = $(this).val();
        	
        	if(passPattern.test(comparePass)){
        		
        		$('#pwmsg').html('<b style="color:#ff9999">잘썼구만 그래</b>');
        	}
        	else{
        		$('#pwmsg').html('<b style="color:#22424a">하아....</b>')
        	}
        	
        });
        
        
        $('#pass2').keyup(function(){
        
            var compareStr1 = $('#pass').val();
            var compareStr2 = $(this).val();

            if(compareStr1==compareStr2){
             
                $('#pwcheckmsg').html('<b style="color:#ff9999;">일치한다</b>');
            }
            else{
              
                $('#pwcheckmsg').html('<b>똑바로 쓰십시오</b>').css('color','black');
            }
        });
        
        
        $('#checkbtn').click(function(){
        	
        	$.ajax({
        		url : './id_check/idValue.jsp',
        		type : "post",
        		dataType : "html",
        		contentype : "application / x-www-form-urlencoded; charset=utf-8",
        		data : {
        			id : $("#id").val()
        		},
        		success : function(value) {
        			window.open("./id_check/idcheck.jsp?result="+value,"", "width=300,heigth=300");
        		},
        		
        	});
        });
    });
    
  
    function loginValidate(fn){
    	
   
    	if(!fn.name.value){
    		alert("너는 이름이 없구나?");
    		fn.name.focus();
    		return false;
    	}
    	
    	if(!fn.id.value){
    		alert("아이디를 쓰란 말이야");
    		fn.id.focus();
    		return false;
    	}
    	
    	if(!fn.pass.value){
    		alert("해킹당하면 어쩔려고 그래");
    		fn.pass.focus();
    		return false;
    	}
    	
    	if(fn.pass.value != fn.pass2.value){
    		alert("안맞자너");
    		fn.pass2.focus();
    		return false;
    	}

    	if(!fn.tel1.value){
    		alert("아싸라서 전화번호가 없어?");
    		fn.tel1.focus();
    		return false;
    	}
    	
    	if(!fn.email1.value){
    		alert("너는 회원가입이라는 걸 안해봤구나?");
    		fn.email1.focus();
    		return false;
    	}
    	
    	if(!fn.sample6_postcode.value){
    		alert("ㅋㅋ집도 없는 노숙자였네");
    		fn.sample6_postcode.focus();
    		return false;
    	}
    	
    	if(!fn.sample6_detailAddress.value){
    		alert("좀 적자");
    		fn.sample6_detailAddress.focus();
    		return false;
    	}
    	
    	alert("회원가입을 축하한다");
    	
    }
    
    
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
					<img src="../images/join_tit.gif" alt="회원가입" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;회원가입<p>
				</div>

				<p class="join_title"><img src="../images/join_tit03.gif" alt="회원정보입력" /></p>
				<form action="joinProcess.jsp" method="post" id="loginFrm" name="loginFrm" onsubmit="return loginValidate(this);">
				<table cellpadding="0" cellspacing="0" border="0" class="join_box">
					<colgroup>
						<col width="80px;" />
						<col width="*" />
					</colgroup>
					<tr>
						<th><img src="../images/join_tit001.gif" /></th>
						<!-- 이름 -->
						<td><input type="text" name="name" id="name" value="" class="join_input" /><span id="namemsg">한글만쓰세여</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit002.gif" /></th>
						<!-- 아이디 체크 -->
						<td><input type="text" name="id" id="id" value="" class="join_input" maxlength="12"/>&nbsp;<img src="../images/btn_idcheck.gif" id="checkbtn" alt="중복확인"/>&nbsp;&nbsp;<span id="idmsg">* 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit003.gif" /></th>
						<!-- 비밀번호 -->
						<td><input type="password" id="pass" name="pass" value="" class="join_input" maxlength="12"/>&nbsp;&nbsp;<span id="pwmsg">* 4자 이상 12자 이내의 영문/숫자 조합</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit04.gif" /></th>
						<!-- 비밀번호 체크 -->
						<td><input type="password" id="pass2" value="" class="join_input" />&nbsp;&nbsp;<span id="pwcheckmsg"></span></td>
						
					</tr>
					

					<tr>
						<th><img src="../images/join_tit06.gif" /></th>
						<td>
						<!-- 빈값 체크 -->
							<input type="text" name="tel1" value="" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel2" value="" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel3" value="" maxlength="4" class="join_input" style="width:50px;" /><span id="telmsg"></span>
						</td>
					</tr>
					
					<tr>
						<th><img src="../images/join_tit08.gif" /></th>
						<td>
					 	<!-- 이메일 빈값 체크 -->
						<input type="text" id="email1" name="email1" style="width:100px;height:20px;border:solid 1px #dadada;" value="" /> @ 
						<input type="text" id="email2" name="email2" style="width:150px;height:20px;border:solid 1px #dadada;" value="" readonly />
						<select id="last_email_check2" >
							<option selected="" value="">선택해주세요</option>
							<option value="direct" >직접입력</option>
							<option value="naver.com" >naver.com</option>
							<option value="hotmail.com" >hotmail.com</option>
							<option value="nate.com" >nate.com</option>
							<option value="daum.net" >daum.net</option>
							<option value="google.com" >google.com</option>
						</select>
	 					<!-- 사실상 의미 없음 -->
						<input type="checkbox" name="open_email" value="1">
						<span>이메일 수신동의</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit09.gif" /></th>
						<td>
							<input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호">
							<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
							<input type="text" name="address" id="sample6_address" placeholder="주소"><br>
							<input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소">
							<input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목">
						</td>
					</tr>
				</table>
				<p style="text-align:center; margin-bottom:20px"><input type="image" src="../images/btn01.gif" />&nbsp;&nbsp;<a href="http://instagram.com"><img src="../images/btn02.gif" /></a></p>
				</form>
				
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>

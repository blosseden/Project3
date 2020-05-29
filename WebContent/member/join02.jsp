<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            
            var roadAddr = data.roadAddress;
            var extraRoadAddr = ''; 

       
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
          
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
      
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

        
            document.getElementById('sample4_postcode').value = data.zonecode;
            document.getElementById("sample4_roadAddress").value = roadAddr;
            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
            
         
            if(roadAddr !== ''){
                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
            } else {
                document.getElementById("sample4_extraAddress").value = '';
            }

            var guideTextBox = document.getElementById("guide");
            
            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            }
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
       
            //이메일 select선택시 도메인 부분 채워주기
            $('#last_email_check2').change(function(){
                //alert(이메일선택됨)
                //option태그 사이의 텍스트를 읽어온다
                var text = $('#last_email_check2 option:selected').text();
                //value속성에 지정된 값을 읽어온다
                var value = $('#last_email_check2 option:selected').val();
                //alert("선택한 항목의 text:"text"+text", value:"+value);
                
                if(value==""){//선택하세요를 선택
                    $('#email2').attr('readonly' , true);
                    $('#email2').val('');
                }
                else if(value=='direct'){//직접 입력을 선택
                    $('#email2').attr('readonly',false);
                    $('#email2').val('');
                }
                else{//그외 포털 도메인 선택
                    $('#email2').attr('readonly',true);
                    //위에서 읽어온 값을 도메인 부분에 입력한다.
                    $('#email2').val(value);
                }
                
            });

            //조건1
            $('#pass').keyup(function(){
                //input태그의 value속성을 빈값으로 만들어준다.
                $('#pass2').val("");
                //암호를 재입력시에는 msg부분의 텍스트도 지워준다.
                $('#msg').text('');
            });
            //조건2
            $('#pass2').keyup(function(){
                //패스워드 입력란에 입력된 내용을 가져온다.
                var compareStr1 = $('#pass').val();
                var compareStr2 = $(this).val();

                if(compareStr1==compareStr2){
                    //암호가 일치하면 붉은색 텍스트
                    $('#msg').html('<b style="color:#ff9999;">일치합니다</b>');
                }
                else{
                    //일치하지 않으면 검은색 테스트
                    $('#msg').html('<b>똑바로 쓰십시오</b>').css('color','black');
                }
            })
        });
        
    </script>
    
 <body>
	<!-- center -->
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
				<table cellpadding="0" cellspacing="0" border="0" class="join_box">
					<colgroup>
						<col width="80px;" />
						<col width="*" />
					</colgroup>
					<tr>
						<th><img src="../images/join_tit001.gif" /></th>
						<!-- 이름 -->
						<td><input type="text" name="name" value="" class="join_input" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit002.gif" /></th>
						<!-- 아이디 체크 -->
						<td><input type="text" name="id"  value="" class="join_input" />&nbsp;<a onclick="id_check_person();" style="cursor:hand;"><img src="../images/btn_idcheck.gif" alt="중복확인"/></a>&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit003.gif" /></th>
						<!-- 비밀번호 체크 -->
						<td><input type="password" id="pass" value="" class="join_input" />&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit04.gif" /></th>
						<!-- 위에 값이 이 값이랑 똑같지 않으면 에러메세제 뜨게 해야함 -->
						<td><input type="password" id="pass2" value="" class="join_input" />&nbsp;&nbsp;<span id="msg"></span></td>
						
					</tr>
					

					<tr>
						<th><img src="../images/join_tit06.gif" /></th>
						<td>
						<!-- 빈값 체크 -->
							<input type="text" name="tel1" value="" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel2" value="" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel3" value="" maxlength="4" class="join_input" style="width:50px;" />
						</td>
					</tr>
					
					<tr>
						<th><img src="../images/join_tit08.gif" /></th>
						<td>
					 	<!-- 이메일 빈값 체크 -->
						<input type="text" name="email_1" style="width:100px;height:20px;border:solid 1px #dadada;" value="" /> @ 
						<input type="text" name="email_2" style="width:150px;height:20px;border:solid 1px #dadada;" value="" readonly />
						<select name="last_email_check2" onChange="email_input(this);" class="pass" id="last_email_check2" >
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
						<!-- API로 적용 시켜야함 -->
						<input type="text" id="sample4_postcode" placeholder="우편번호">
						<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
						<input type="text" id="sample4_roadAddress" placeholder="도로명주소">
						<input type="text" id="sample4_jibunAddress" placeholder="지번주소">
						<span id="guide" style="color:#999;display:none"></span>
						<input type="text" id="sample4_detailAddress" placeholder="상세주소">
						<input type="text" id="sample4_extraAddress" placeholder="참고항목">
												
						</td>
					</tr>
				</table>

				<p style="text-align:center; margin-bottom:20px"><a href="join02.jsp"><img src="../images/btn01.gif" /></a>&nbsp;&nbsp;<a href="#"><img src="../images/btn02.gif" /></a></p>
				
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>

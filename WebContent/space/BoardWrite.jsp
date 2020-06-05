<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 글작성 페이지 진입전에 로그인 체크를 해야만 쓸 수 있게 한다. -->
<%@ include file="../include/global_head.jsp"%>
<%@ include file="../member/isLogin.jsp"%>
<%@ include file="../include/isFlag.jsp" %>
<%
//공지사항 빼고 다 쓸 수 였습니다
if(!(bname.equals("freeboard") || bname.equals("picture") || bname.equals("program") || bname.equals("info"))){ 
	JavascriptUtil.jsAlertBack("해당 게시판은 글쓰기를 할 수 없습니다.", out);
	return;
}
%>
<script>
	function checkValidate(frm) {
		if (frm.title.value == "") {
			alert("제목써라");
			frm.title.focus();
			return false;
		}
		if (frm.content.value == "") {
			alert("내용물좀 써라");
			frm.content.focus();
			return false;
		}
	}

	//무기명함수

	var checkValidate2 = function(frm) {
		//실행부는 유기명함수와 동일함
	}
</script>

<body>
	<//center>
	<div id="wrap">
		<%@ include file="../include/top.jsp"%>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file="../include/space_leftmenu.jsp"%>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="<%=boardTitle%>" class="con_title" />
					<p class="location">
						<img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;<%=boardname%>
					</p>
				</div>
				<div>
				<% if(bname.equals("info")){ %>
				<form method="post" enctype="multipart/form-data" name="writeFrm" action="WriteProc2.jsp" onsubmit="return checkValidate(this);">
				<%}else{ %>
				<form method="post" name="writeFrm" action="WriteProc.jsp" onsubmit="return checkValidate(this);">
				<%} %>
						<input type="hidden" name="bname" value="<%=bname %>" />
						<table class="table table-bordered">
							<colgroup>
								<col width="20%" />
								<col width="*" />
							</colgroup>
							<tbody>
				<!-- 	<tr>
							<th class="text-center" 
								style="vertical-align:middle;">작성자</th>
							<td>
								<input type="text" class="form-control" 
									style="width:100px;" />
							</td>
						</tr>
						<tr>
							<th class="text-center" 
								style="vertical-align:middle;">이메일</th>
							<td>
								<input type="text" class="form-control" 
									style="width:400px;" />
							</td>
						</tr>
						<tr>
							<th class="text-center" 
								style="vertical-align:middle;">패스워드</th>
							<td>
								<input type="text" class="form-control" 
									style="width:200px;" />
							</td>
						</tr> -->
					<tr>
						<th class="text-center" style="vertical-align: middle;">제목</th>
						<td><input type="text" class="form-control" name="title" />
						</td>
					</tr>
					<tr>
						<th class="text-center" style="vertical-align: middle;">내용</th>
						<td><textarea rows="10" class="form-control"
								name="content"></textarea></td>
					</tr>
					<% if(bname.equals("info")){ %>
					<tr>
						<th class="text-center" 
							style="vertical-align:middle;">첨부파일</th>
						<td>
							<input type="file" class="form-control" />
						</td>
					</tr>
					<%} %>
							</tbody>
						</table>

						<div class="col text-right ml-auto">
							<!-- 각종 버튼 부분 -->

							<button type="submit" class="btn btn-danger">전송하기</button>
							<button type="button" class="btn btn-warning"
								onclick="location.href='BoardList.jsp';">리스트보기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp"%>
	</div>
	<%@ include file="../include/footer.jsp"%>
	</center>
</body>
</html>
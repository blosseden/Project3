<%@page import="model.BbsDTO"%>
<%@page import="model.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp"%>
<%
	String queryStr = "";
	String searchColumn = request.getParameter("searchColumn");
	String searchWord = request.getParameter("searchWord");
	if (searchWord != null) {
		queryStr = "searchColumn=" + searchColumn + "&searchWord=" + searchWord + "&";
	}
	String nowPage = request.getParameter("nowPage");
	queryStr += "&nowPage=" + nowPage;

	String num = request.getParameter("num");
	BbsDAO dao = new BbsDAO(application);

	dao.updateVisitCount(num);

	BbsDTO dto = dao.selectView(num);

	dao.close();
%>
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
					<img src="../images/space/sub01_title.gif" alt="공지사항"
						class="con_title" />
					<p class="location">
						<img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;공지사항


					
					<p>
				</div>
				<div class="row">
					<table class="table table-bordered">
						<colgroup>
							<col width="20%" />
							<col width="30%" />
							<col width="20%" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th class="text-center" style="vertical-align: middle;">작성자</th>
								<td><%=dto.getName()%></td>
								<th class="text-center" style="vertical-align: middle;">작성일</th>
								<td><%=dto.getPostDate()%></td>
							</tr>
							<tr>
								<th class="text-center" style="vertical-align: middle;">이메일</th>
								<td><%=dto.getEmail()%></td>
								<th class="text-center" style="vertical-align: middle;">조회수</th>
								<td><%=dto.getVisitcount()%></td>
							</tr>
							<tr>
								<th class="text-center" style="vertical-align: middle;">제목</th>
								<td colspan="3"><%=dto.getTitle()%></td>
							</tr>
							<tr>
								<th class="text-center" style="vertical-align: middle;">내용</th>
								<td colspan="3" class="align-middle" style="height: 200px;">
									<%=dto.getContent().replace("\r\n", "<br/>")%>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="row">
					<%
							if (session.getAttribute("user_id") != null
									&& session.getAttribute("user_id").toString().equals(dto.getId())) {
						%>
					<!-- 각종 버튼 부분 -->
					<button type="button" class="btn btn-secondary"
						onclick="location.href='BoardEdit.jsp?num=<%=dto.getNum()%>';">수정하기</button>
					<button type="button" class="btn btn-success" onclick="isDelete();">삭제하기</button>
					<%
							}
						%>
					<div class="text-right ml-auto">
						<button type="button" class="btn btn-warning"
							onclick="location.href='BoardList.jsp?<%=queryStr%>';">리스트보기</button>
					</div>
				</div>
				<form name="deleteFrm">
					<input type="hidden" name="num" value="<%=dto.getNum()%>" />
				</form>
				<script>
					function isDelete() {
						var c = confirm("삭제해버릴까 주인?");
						if (c) {
							var f = document.deleteFrm;
							f.method = "post";
							f.action = "DeleteProc.jsp";
							f.submit();
						}
					}
				</script>
			</div>
		</div>
		<%@ include file="../include/quick.jsp"%>
	</div>


	<%@ include file="../include/footer.jsp"%>
	</center>
</body>
</html>
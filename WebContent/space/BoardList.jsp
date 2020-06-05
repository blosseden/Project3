<%@page import="util.PagingUtil"%>
<%@page import="model.BbsDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp"%>
<%@ include file = "../include/isFlag.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

String driver = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MariaConnectURL");

BbsDAO dao = new BbsDAO(driver,url);

Map<String,Object> param = new HashMap<String,Object>();

param.put("bname", bname);

String queryStr = "";

queryStr = "bname="+ bname +"&";

String searchColumn = request.getParameter("searchColumn");
String searchWord= request.getParameter("searchWord");
if(searchWord!=null){

	param.put("Column", searchColumn);
	param.put("Word", searchWord);
	
	queryStr += "searchColumn="+searchColumn+"&searchWord="+searchWord+"&";
}

int totalRecordCount = dao.getTotalRecordCount(param);

int pageSize =
Integer.parseInt(application.getInitParameter("PAGE_SIZE"));
int blockPage =
Integer.parseInt(application.getInitParameter("BLOCK_PAGE"));

int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);

int nowPage = (request.getParameter("nowPage")==null
			|| request.getParameter("nowPage").equals(""))
	? 1 : Integer.parseInt(request.getParameter("nowPage"));

	int start = (nowPage-1)*pageSize;
	int end = pageSize;

	param.put("start", start);
	param.put("end", end);


List<BbsDTO> bbs = dao.selectListPage(param);
 	
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
					
					<img src="<%=boardTitle%>" class="con_title" />
					<p class="location">
						<img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;<%=boardname%>
					</p>
				</div>
				<div class="row text-right"
					style="margin-bottom: 20px; padding-right: 50px;">
					<!-- 검색부분 -->
					<form class="form-inline ml-auto" name="searchFrm" method="get">
					<!-- 검색시 필수파라미터인 bname이 전달 되어야 한다 -->
					<input type="hidden" name="bname" value="<%=bname %>" />
						<div class="form-group">
							<select name="searchColumn" class="form-control">
								<option value="title">제목</option>
								<option value="content">내용</option>
							</select>
						</div>
						<div class="input-group">
							<input type="text" name="searchWord" class="form-control" />
							<div class="input-group-btn">
								<button type="submit" class="btn btn-warning">
									<i class='fa fa-search' style='font-size: 24px;'></i>
								</button>
							</div>
						</div>
					</form>
				</div>
				<div class="row">
					<!-- 게시판리스트부분 -->
					<table class="table table-bordered table-hover table-striped">
						<colgroup>
							<col width="80px" />
							<col width="*" />
							<col width="120px" />
							<col width="120px" />
							<col width="80px" />
							<col width="50px" />
						</colgroup>

						<thead>
							<tr class="text-center">
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회수</th>
								<% if(bname.equals("info")){ %>
								<th>첨부</th>
								<%} %>
							</tr>
						</thead>
						<tbody>
						<%
						//게시물이 없을 때
						if (bbs.isEmpty()) {
						%>
						<tr>
							<td colspan="5" align="center" height="50">
								등록된 게시물이 없습니다.
							</td>
						</tr>
						<%
							} else {
								//게시물의 가상번호로 사용 할 변수
								int vNum = 0;
								int countNum = 0;
								
								for (BbsDTO dto : bbs) {
									
									vNum = totalRecordCount - 
											(((nowPage-1) * pageSize) + countNum++);
						%>
							<!-- 리스트반복 -->
							<tr>
								<td class="text-center"><%=vNum%></td>
								<td class="text-left"><a href="BoardView.jsp?num=<%=dto.getNum()%>&nowPage=<%=nowPage%>&<%=queryStr%>"><%=dto.getTitle()%></a></td>
								<td class="text-center"><%=dto.getId()%></td>
								<td class="text-center"><%=dto.getPostDate()%></td>
								<td class="text-center"><%=dto.getVisitcount()%></td>
								<% if(bname.equals("info")){ %>
								<td class="text-center">첨부</td>
								<%} %>
							</tr>
							<!-- 리스트 반복 끗 -->
							<%
								}
							}
							%>
						</tbody>
					</table>
				</div>
				<div class="row">
					<div class="col text-right">
						<!-- 글쓰기  -->
						<% if(bname.equals("freeboard") || bname.equals("picture") || bname.equals("info") || bname.equals("program")){ %>
						<button type="button" class="btn btn-primary"
							onclick="location.href='BoardWrite.jsp?bname=<%=bname%>';">글쓰기</button>
						<%} %>
						
						<!-- <button type="button" class="btn btn-primary">수정하기</button>
						<button type="button" class="btn btn-success">삭제하기</button>
						<button type="button" class="btn btn-info">답글쓰기</button>
						<button type="button" class="btn btn-warning">리스트보기</button>
						<button type="submit" class="btn btn-danger">전송하기</button> -->
					</div>
				</div>
				<div class="row mt-3">
					<div class="col">
						<!-- 페이지번호 부분 -->
						<ul class="pagination justify-content-center">
					<%=PagingUtil.pagingBS4(totalRecordCount,
						pageSize, blockPage, nowPage, "BoardList.jsp?"+queryStr) %>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp"%>
	</div>
	<%@ include file="../include/footer.jsp"%>
	</center>
</body>
</html>

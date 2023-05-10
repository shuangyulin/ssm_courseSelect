<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/news.css" />
<div id="newsAddDiv">
	<form id="newsAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">新闻标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="news_newsTitle" name="news.newsTitle" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">新闻内容:</span>
			<span class="inputControl">
				<textarea id="news_newsContent" name="news.newsContent" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">发布日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="news_newsDate" name="news.newsDate" />

			</span>

		</div>
		<div>
			<span class="label">新闻图片:</span>
			<span class="inputControl">
				<input id="newsPhotoFile" name="newsPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div class="operation">
			<a id="newsAddButton" class="easyui-linkbutton">添加</a>
			<a id="newsClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/News/js/news_add.js"></script> 

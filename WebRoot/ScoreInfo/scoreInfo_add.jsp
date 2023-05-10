<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/scoreInfo.css" />
<div id="scoreInfoAddDiv">
	<form id="scoreInfoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">学生对象:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="scoreInfo_studentNumber_studentNumber" name="scoreInfo.studentNumber.studentNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">课程对象:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="scoreInfo_courseNumber_courseNumber" name="scoreInfo.courseNumber.courseNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">成绩得分:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="scoreInfo_scoreValue" name="scoreInfo.scoreValue" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">学生评价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="scoreInfo_studentEvaluate" name="scoreInfo.studentEvaluate" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="scoreInfoAddButton" class="easyui-linkbutton">添加</a>
			<a id="scoreInfoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/ScoreInfo/js/scoreInfo_add.js"></script> 

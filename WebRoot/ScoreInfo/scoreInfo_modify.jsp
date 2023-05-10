<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/scoreInfo.css" />
<div id="scoreInfo_editDiv">
	<form id="scoreInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="scoreInfo_scoreId_edit" name="scoreInfo.scoreId" value="<%=request.getParameter("scoreId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">学生对象:</span>
			<span class="inputControl">
				<input class="textbox"  id="scoreInfo_studentNumber_studentNumber_edit" name="scoreInfo.studentNumber.studentNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">课程对象:</span>
			<span class="inputControl">
				<input class="textbox"  id="scoreInfo_courseNumber_courseNumber_edit" name="scoreInfo.courseNumber.courseNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">成绩得分:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="scoreInfo_scoreValue_edit" name="scoreInfo.scoreValue" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">学生评价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="scoreInfo_studentEvaluate_edit" name="scoreInfo.studentEvaluate" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="scoreInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/ScoreInfo/js/scoreInfo_modify.js"></script> 

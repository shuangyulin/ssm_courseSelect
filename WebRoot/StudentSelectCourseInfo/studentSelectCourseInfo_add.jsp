<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/studentSelectCourseInfo.css" />
<div id="studentSelectCourseInfoAddDiv">
	<form id="studentSelectCourseInfoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">学生对象:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="studentSelectCourseInfo_studentNumber_studentNumber" name="studentSelectCourseInfo.studentNumber.studentNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">课程对象:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="studentSelectCourseInfo_courseNumber_courseNumber" name="studentSelectCourseInfo.courseNumber.courseNumber" style="width: auto"/>
			</span>
		</div>
		<div class="operation">
			<a id="studentSelectCourseInfoAddButton" class="easyui-linkbutton">添加</a>
			<a id="studentSelectCourseInfoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/StudentSelectCourseInfo/js/studentSelectCourseInfo_add.js"></script> 

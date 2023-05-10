<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/studentSelectCourseInfo.css" />
<div id="studentSelectCourseInfo_editDiv">
	<form id="studentSelectCourseInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="studentSelectCourseInfo_selectId_edit" name="studentSelectCourseInfo.selectId" value="<%=request.getParameter("selectId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">学生对象:</span>
			<span class="inputControl">
				<input class="textbox"  id="studentSelectCourseInfo_studentNumber_studentNumber_edit" name="studentSelectCourseInfo.studentNumber.studentNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">课程对象:</span>
			<span class="inputControl">
				<input class="textbox"  id="studentSelectCourseInfo_courseNumber_courseNumber_edit" name="studentSelectCourseInfo.courseNumber.courseNumber" style="width: auto"/>
			</span>
		</div>
		<div class="operation">
			<a id="studentSelectCourseInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/StudentSelectCourseInfo/js/studentSelectCourseInfo_modify.js"></script> 

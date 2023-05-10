<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/courseInfo.css" />
<div id="courseInfo_editDiv">
	<form id="courseInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">课程编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="courseInfo_courseNumber_edit" name="courseInfo.courseNumber" value="<%=request.getParameter("courseNumber") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">课程名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="courseInfo_courseName_edit" name="courseInfo.courseName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">上课老师:</span>
			<span class="inputControl">
				<input class="textbox"  id="courseInfo_courseTeacher_teacherNumber_edit" name="courseInfo.courseTeacher.teacherNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">上课时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="courseInfo_courseTime_edit" name="courseInfo.courseTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">上课地点:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="courseInfo_coursePlace_edit" name="courseInfo.coursePlace" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">课程学分:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="courseInfo_courseScore_edit" name="courseInfo.courseScore" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">附加信息:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="courseInfo_courseMemo_edit" name="courseInfo.courseMemo" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="courseInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/CourseInfo/js/courseInfo_modify.js"></script> 

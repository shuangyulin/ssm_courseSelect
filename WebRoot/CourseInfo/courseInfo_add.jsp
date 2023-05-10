<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/courseInfo.css" />
<div id="courseInfoAddDiv">
	<form id="courseInfoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">课程编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="courseInfo_courseNumber" name="courseInfo.courseNumber" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">课程名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="courseInfo_courseName" name="courseInfo.courseName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">上课老师:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="courseInfo_courseTeacher_teacherNumber" name="courseInfo.courseTeacher.teacherNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">上课时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="courseInfo_courseTime" name="courseInfo.courseTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">上课地点:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="courseInfo_coursePlace" name="courseInfo.coursePlace" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">课程学分:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="courseInfo_courseScore" name="courseInfo.courseScore" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">附加信息:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="courseInfo_courseMemo" name="courseInfo.courseMemo" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="courseInfoAddButton" class="easyui-linkbutton">添加</a>
			<a id="courseInfoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/CourseInfo/js/courseInfo_add.js"></script> 

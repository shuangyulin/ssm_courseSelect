<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/courseInfo.css" /> 

<div id="courseInfo_manage"></div>
<div id="courseInfo_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="courseInfo_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="courseInfo_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="courseInfo_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="courseInfo_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="courseInfo_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="courseInfoQueryForm" method="post">
			课程编号：<input type="text" class="textbox" id="courseNumber" name="courseNumber" style="width:110px" />
			课程名称：<input type="text" class="textbox" id="courseName" name="courseName" style="width:110px" />
			上课老师：<input class="textbox" type="text" id="courseTeacher_teacherNumber_query" name="courseTeacher.teacherNumber" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="courseInfo_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="courseInfoEditDiv">
	<form id="courseInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">课程编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="courseInfo_courseNumber_edit" name="courseInfo.courseNumber" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="CourseInfo/js/courseInfo_manage.js"></script> 

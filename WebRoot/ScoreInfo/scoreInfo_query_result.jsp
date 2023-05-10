<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/scoreInfo.css" /> 

<div id="scoreInfo_manage"></div>
<div id="scoreInfo_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="scoreInfo_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="scoreInfo_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="scoreInfo_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="scoreInfo_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="scoreInfo_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="scoreInfoQueryForm" method="post">
			学生对象：<input class="textbox" type="text" id="studentNumber_studentNumber_query" name="studentNumber.studentNumber" style="width: auto"/>
			课程对象：<input class="textbox" type="text" id="courseNumber_courseNumber_query" name="courseNumber.courseNumber" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="scoreInfo_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="scoreInfoEditDiv">
	<form id="scoreInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="scoreInfo_scoreId_edit" name="scoreInfo.scoreId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="ScoreInfo/js/scoreInfo_manage.js"></script> 

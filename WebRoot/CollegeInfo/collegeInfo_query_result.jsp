<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/collegeInfo.css" /> 

<div id="collegeInfo_manage"></div>
<div id="collegeInfo_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="collegeInfo_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="collegeInfo_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="collegeInfo_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="collegeInfo_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="collegeInfo_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="collegeInfoQueryForm" method="post">
		</form>	
	</div>
</div>

<div id="collegeInfoEditDiv">
	<form id="collegeInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">学院编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="collegeInfo_collegeNumber_edit" name="collegeInfo.collegeNumber" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">学院名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="collegeInfo_collegeName_edit" name="collegeInfo.collegeName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">成立日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="collegeInfo_collegeBirthDate_edit" name="collegeInfo.collegeBirthDate" />

			</span>

		</div>
		<div>
			<span class="label">院长姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="collegeInfo_collegeMan_edit" name="collegeInfo.collegeMan" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="collegeInfo_collegeTelephone_edit" name="collegeInfo.collegeTelephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">附加信息:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="collegeInfo_collegeMemo_edit" name="collegeInfo.collegeMemo" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="CollegeInfo/js/collegeInfo_manage.js"></script> 

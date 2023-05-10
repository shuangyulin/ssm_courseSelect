<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/specialFieldInfo.css" /> 

<div id="specialFieldInfo_manage"></div>
<div id="specialFieldInfo_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="specialFieldInfo_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="specialFieldInfo_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="specialFieldInfo_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="specialFieldInfo_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="specialFieldInfo_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="specialFieldInfoQueryForm" method="post">
			专业编号：<input type="text" class="textbox" id="specialFieldNumber" name="specialFieldNumber" style="width:110px" />
			专业名称：<input type="text" class="textbox" id="specialFieldName" name="specialFieldName" style="width:110px" />
			所在学院：<input class="textbox" type="text" id="specialCollegeNumber_collegeNumber_query" name="specialCollegeNumber.collegeNumber" style="width: auto"/>
			成立日期：<input type="text" id="specialBirthDate" name="specialBirthDate" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="specialFieldInfo_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="specialFieldInfoEditDiv">
	<form id="specialFieldInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">专业编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="specialFieldInfo_specialFieldNumber_edit" name="specialFieldInfo.specialFieldNumber" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">专业名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="specialFieldInfo_specialFieldName_edit" name="specialFieldInfo.specialFieldName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所在学院:</span>
			<span class="inputControl">
				<input class="textbox"  id="specialFieldInfo_specialCollegeNumber_collegeNumber_edit" name="specialFieldInfo.specialCollegeNumber.collegeNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">成立日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="specialFieldInfo_specialBirthDate_edit" name="specialFieldInfo.specialBirthDate" />

			</span>

		</div>
		<div>
			<span class="label">联系人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="specialFieldInfo_specialMan_edit" name="specialFieldInfo.specialMan" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="specialFieldInfo_specialTelephone_edit" name="specialFieldInfo.specialTelephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">附加信息:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="specialFieldInfo_specialMemo_edit" name="specialFieldInfo.specialMemo" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="SpecialFieldInfo/js/specialFieldInfo_manage.js"></script> 

<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/teacher.css" /> 

<div id="teacher_manage"></div>
<div id="teacher_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="teacher_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="teacher_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="teacher_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="teacher_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="teacher_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="teacherQueryForm" method="post">
			教师编号：<input type="text" class="textbox" id="teacherNumber" name="teacherNumber" style="width:110px" />
			教师姓名：<input type="text" class="textbox" id="teacherName" name="teacherName" style="width:110px" />
			出生日期：<input type="text" id="teacherBirthday" name="teacherBirthday" class="easyui-datebox" editable="false" style="width:100px">
			入职日期：<input type="text" id="teacherArriveDate" name="teacherArriveDate" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="teacher_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="teacherEditDiv">
	<form id="teacherEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">教师编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherNumber_edit" name="teacher.teacherNumber" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">教师姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherName_edit" name="teacher.teacherName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherPassword_edit" name="teacher.teacherPassword" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherSex_edit" name="teacher.teacherSex" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">出生日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherBirthday_edit" name="teacher.teacherBirthday" />

			</span>

		</div>
		<div>
			<span class="label">入职日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherArriveDate_edit" name="teacher.teacherArriveDate" />

			</span>

		</div>
		<div>
			<span class="label">身份证号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherCardNumber_edit" name="teacher.teacherCardNumber" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherPhone_edit" name="teacher.teacherPhone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">教师照片:</span>
			<span class="inputControl">
				<img id="teacher_teacherPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="teacher_teacherPhoto" name="teacher.teacherPhoto"/>
				<input id="teacherPhotoFile" name="teacherPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">家庭地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherAddress_edit" name="teacher.teacherAddress" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">附加信息:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherMemo_edit" name="teacher.teacherMemo" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Teacher/js/teacher_manage.js"></script> 

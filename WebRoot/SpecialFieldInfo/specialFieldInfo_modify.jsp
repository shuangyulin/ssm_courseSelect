<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/specialFieldInfo.css" />
<div id="specialFieldInfo_editDiv">
	<form id="specialFieldInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">专业编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="specialFieldInfo_specialFieldNumber_edit" name="specialFieldInfo.specialFieldNumber" value="<%=request.getParameter("specialFieldNumber") %>" style="width:200px" />
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
		<div class="operation">
			<a id="specialFieldInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/SpecialFieldInfo/js/specialFieldInfo_modify.js"></script> 

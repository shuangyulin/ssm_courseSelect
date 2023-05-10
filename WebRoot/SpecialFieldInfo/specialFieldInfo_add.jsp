<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/specialFieldInfo.css" />
<div id="specialFieldInfoAddDiv">
	<form id="specialFieldInfoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">专业编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="specialFieldInfo_specialFieldNumber" name="specialFieldInfo.specialFieldNumber" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">专业名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="specialFieldInfo_specialFieldName" name="specialFieldInfo.specialFieldName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所在学院:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="specialFieldInfo_specialCollegeNumber_collegeNumber" name="specialFieldInfo.specialCollegeNumber.collegeNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">成立日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="specialFieldInfo_specialBirthDate" name="specialFieldInfo.specialBirthDate" />

			</span>

		</div>
		<div>
			<span class="label">联系人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="specialFieldInfo_specialMan" name="specialFieldInfo.specialMan" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="specialFieldInfo_specialTelephone" name="specialFieldInfo.specialTelephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">附加信息:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="specialFieldInfo_specialMemo" name="specialFieldInfo.specialMemo" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="specialFieldInfoAddButton" class="easyui-linkbutton">添加</a>
			<a id="specialFieldInfoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/SpecialFieldInfo/js/specialFieldInfo_add.js"></script> 

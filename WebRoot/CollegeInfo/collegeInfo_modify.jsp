<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/collegeInfo.css" />
<div id="collegeInfo_editDiv">
	<form id="collegeInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">学院编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="collegeInfo_collegeNumber_edit" name="collegeInfo.collegeNumber" value="<%=request.getParameter("collegeNumber") %>" style="width:200px" />
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
		<div class="operation">
			<a id="collegeInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/CollegeInfo/js/collegeInfo_modify.js"></script> 

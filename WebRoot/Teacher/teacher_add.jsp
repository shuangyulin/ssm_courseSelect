<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/teacher.css" />
<div id="teacherAddDiv">
	<form id="teacherAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">教师编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherNumber" name="teacher.teacherNumber" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">教师姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherName" name="teacher.teacherName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherPassword" name="teacher.teacherPassword" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherSex" name="teacher.teacherSex" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">出生日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherBirthday" name="teacher.teacherBirthday" />

			</span>

		</div>
		<div>
			<span class="label">入职日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherArriveDate" name="teacher.teacherArriveDate" />

			</span>

		</div>
		<div>
			<span class="label">身份证号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherCardNumber" name="teacher.teacherCardNumber" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherPhone" name="teacher.teacherPhone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">教师照片:</span>
			<span class="inputControl">
				<input id="teacherPhotoFile" name="teacherPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">家庭地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherAddress" name="teacher.teacherAddress" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">附加信息:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="teacher_teacherMemo" name="teacher.teacherMemo" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="teacherAddButton" class="easyui-linkbutton">添加</a>
			<a id="teacherClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Teacher/js/teacher_add.js"></script> 

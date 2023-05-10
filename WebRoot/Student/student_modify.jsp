<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/student.css" />
<div id="student_editDiv">
	<form id="studentEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">学号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_studentNumber_edit" name="student.studentNumber" value="<%=request.getParameter("studentNumber") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_studentName_edit" name="student.studentName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_studentPassword_edit" name="student.studentPassword" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_studentSex_edit" name="student.studentSex" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所在班级:</span>
			<span class="inputControl">
				<input class="textbox"  id="student_studentClassNumber_classNumber_edit" name="student.studentClassNumber.classNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">出生日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_studentBirthday_edit" name="student.studentBirthday" />

			</span>

		</div>
		<div>
			<span class="label">政治面貌:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_studentState_edit" name="student.studentState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">学生照片:</span>
			<span class="inputControl">
				<img id="student_studentPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="student_studentPhoto" name="student.studentPhoto"/>
				<input id="studentPhotoFile" name="studentPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_studentTelephone_edit" name="student.studentTelephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">学生邮箱:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_studentEmail_edit" name="student.studentEmail" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系qq:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_studentQQ_edit" name="student.studentQQ" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">家庭地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_studentAddress_edit" name="student.studentAddress" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">附加信息:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_studentMemo_edit" name="student.studentMemo" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="studentModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Student/js/student_modify.js"></script> 

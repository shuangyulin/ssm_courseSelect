<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/student.css" />
<div id="studentAddDiv">
	<form id="studentAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">学号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_studentNumber" name="student.studentNumber" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_studentName" name="student.studentName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_studentPassword" name="student.studentPassword" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_studentSex" name="student.studentSex" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所在班级:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_studentClassNumber_classNumber" name="student.studentClassNumber.classNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">出生日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_studentBirthday" name="student.studentBirthday" />

			</span>

		</div>
		<div>
			<span class="label">政治面貌:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_studentState" name="student.studentState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">学生照片:</span>
			<span class="inputControl">
				<input id="studentPhotoFile" name="studentPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_studentTelephone" name="student.studentTelephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">学生邮箱:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_studentEmail" name="student.studentEmail" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系qq:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_studentQQ" name="student.studentQQ" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">家庭地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_studentAddress" name="student.studentAddress" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">附加信息:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="student_studentMemo" name="student.studentMemo" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="studentAddButton" class="easyui-linkbutton">添加</a>
			<a id="studentClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Student/js/student_add.js"></script> 

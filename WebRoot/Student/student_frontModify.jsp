<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Student" %>
<%@ page import="com.chengxusheji.po.ClassInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的studentClassNumber信息
    List<ClassInfo> classInfoList = (List<ClassInfo>)request.getAttribute("classInfoList");
    Student student = (Student)request.getAttribute("student");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改学生信息信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">学生信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="studentEditForm" id="studentEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="student_studentNumber_edit" class="col-md-3 text-right">学号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="student_studentNumber_edit" name="student.studentNumber" class="form-control" placeholder="请输入学号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="student_studentName_edit" class="col-md-3 text-right">姓名:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="student_studentName_edit" name="student.studentName" class="form-control" placeholder="请输入姓名">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_studentPassword_edit" class="col-md-3 text-right">登录密码:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="student_studentPassword_edit" name="student.studentPassword" class="form-control" placeholder="请输入登录密码">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_studentSex_edit" class="col-md-3 text-right">性别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="student_studentSex_edit" name="student.studentSex" class="form-control" placeholder="请输入性别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_studentClassNumber_classNumber_edit" class="col-md-3 text-right">所在班级:</label>
		  	 <div class="col-md-9">
			    <select id="student_studentClassNumber_classNumber_edit" name="student.studentClassNumber.classNumber" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_studentBirthday_edit" class="col-md-3 text-right">出生日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date student_studentBirthday_edit col-md-12" data-link-field="student_studentBirthday_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="student_studentBirthday_edit" name="student.studentBirthday" size="16" type="text" value="" placeholder="请选择出生日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_studentState_edit" class="col-md-3 text-right">政治面貌:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="student_studentState_edit" name="student.studentState" class="form-control" placeholder="请输入政治面貌">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_studentPhoto_edit" class="col-md-3 text-right">学生照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="student_studentPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="student_studentPhoto" name="student.studentPhoto"/>
			    <input id="studentPhotoFile" name="studentPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_studentTelephone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="student_studentTelephone_edit" name="student.studentTelephone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_studentEmail_edit" class="col-md-3 text-right">学生邮箱:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="student_studentEmail_edit" name="student.studentEmail" class="form-control" placeholder="请输入学生邮箱">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_studentQQ_edit" class="col-md-3 text-right">联系qq:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="student_studentQQ_edit" name="student.studentQQ" class="form-control" placeholder="请输入联系qq">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_studentAddress_edit" class="col-md-3 text-right">家庭地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="student_studentAddress_edit" name="student.studentAddress" class="form-control" placeholder="请输入家庭地址">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_studentMemo_edit" class="col-md-3 text-right">附加信息:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="student_studentMemo_edit" name="student.studentMemo" class="form-control" placeholder="请输入附加信息">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxStudentModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#studentEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改学生信息界面并初始化数据*/
function studentEdit(studentNumber) {
	$.ajax({
		url :  basePath + "Student/" + studentNumber + "/update",
		type : "get",
		dataType: "json",
		success : function (student, response, status) {
			if (student) {
				$("#student_studentNumber_edit").val(student.studentNumber);
				$("#student_studentName_edit").val(student.studentName);
				$("#student_studentPassword_edit").val(student.studentPassword);
				$("#student_studentSex_edit").val(student.studentSex);
				$.ajax({
					url: basePath + "ClassInfo/listAll",
					type: "get",
					success: function(classInfos,response,status) { 
						$("#student_studentClassNumber_classNumber_edit").empty();
						var html="";
		        		$(classInfos).each(function(i,classInfo){
		        			html += "<option value='" + classInfo.classNumber + "'>" + classInfo.className + "</option>";
		        		});
		        		$("#student_studentClassNumber_classNumber_edit").html(html);
		        		$("#student_studentClassNumber_classNumber_edit").val(student.studentClassNumberPri);
					}
				});
				$("#student_studentBirthday_edit").val(student.studentBirthday);
				$("#student_studentState_edit").val(student.studentState);
				$("#student_studentPhoto").val(student.studentPhoto);
				$("#student_studentPhotoImg").attr("src", basePath +　student.studentPhoto);
				$("#student_studentTelephone_edit").val(student.studentTelephone);
				$("#student_studentEmail_edit").val(student.studentEmail);
				$("#student_studentQQ_edit").val(student.studentQQ);
				$("#student_studentAddress_edit").val(student.studentAddress);
				$("#student_studentMemo_edit").val(student.studentMemo);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交学生信息信息表单给服务器端修改*/
function ajaxStudentModify() {
	$.ajax({
		url :  basePath + "Student/" + $("#student_studentNumber_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#studentEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#studentQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    /*出生日期组件*/
    $('.student_studentBirthday_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    studentEdit("<%=request.getParameter("studentNumber")%>");
 })
 </script> 
</body>
</html>


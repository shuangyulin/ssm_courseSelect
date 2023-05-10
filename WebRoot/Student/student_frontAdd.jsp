<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.ClassInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>学生信息添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Student/frontlist">学生信息管理</a></li>
  			<li class="active">添加学生信息</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="studentAddForm" id="studentAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
					 <label for="student_studentNumber" class="col-md-2 text-right">学号:</label>
					 <div class="col-md-8"> 
					 	<input type="text" id="student_studentNumber" name="student.studentNumber" class="form-control" placeholder="请输入学号">
					 </div>
				  </div> 
				  <div class="form-group">
				  	 <label for="student_studentName" class="col-md-2 text-right">姓名:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="student_studentName" name="student.studentName" class="form-control" placeholder="请输入姓名">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_studentPassword" class="col-md-2 text-right">登录密码:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="student_studentPassword" name="student.studentPassword" class="form-control" placeholder="请输入登录密码">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_studentSex" class="col-md-2 text-right">性别:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="student_studentSex" name="student.studentSex" class="form-control" placeholder="请输入性别">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_studentClassNumber_classNumber" class="col-md-2 text-right">所在班级:</label>
				  	 <div class="col-md-8">
					    <select id="student_studentClassNumber_classNumber" name="student.studentClassNumber.classNumber" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_studentBirthdayDiv" class="col-md-2 text-right">出生日期:</label>
				  	 <div class="col-md-8">
		                <div id="student_studentBirthdayDiv" class="input-group date student_studentBirthday col-md-12" data-link-field="student_studentBirthday" data-link-format="yyyy-mm-dd">
		                    <input class="form-control" id="student_studentBirthday" name="student.studentBirthday" size="16" type="text" value="" placeholder="请选择出生日期" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_studentState" class="col-md-2 text-right">政治面貌:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="student_studentState" name="student.studentState" class="form-control" placeholder="请输入政治面貌">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_studentPhoto" class="col-md-2 text-right">学生照片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="student_studentPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="student_studentPhoto" name="student.studentPhoto"/>
					    <input id="studentPhotoFile" name="studentPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_studentTelephone" class="col-md-2 text-right">联系电话:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="student_studentTelephone" name="student.studentTelephone" class="form-control" placeholder="请输入联系电话">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_studentEmail" class="col-md-2 text-right">学生邮箱:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="student_studentEmail" name="student.studentEmail" class="form-control" placeholder="请输入学生邮箱">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_studentQQ" class="col-md-2 text-right">联系qq:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="student_studentQQ" name="student.studentQQ" class="form-control" placeholder="请输入联系qq">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_studentAddress" class="col-md-2 text-right">家庭地址:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="student_studentAddress" name="student.studentAddress" class="form-control" placeholder="请输入家庭地址">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="student_studentMemo" class="col-md-2 text-right">附加信息:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="student_studentMemo" name="student.studentMemo" class="form-control" placeholder="请输入附加信息">
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxStudentAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#studentAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
	    </div>
	</div>
</div>
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加学生信息信息
	function ajaxStudentAdd() { 
		//提交之前先验证表单
		$("#studentAddForm").data('bootstrapValidator').validate();
		if(!$("#studentAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Student/add",
			dataType : "json" , 
			data: new FormData($("#studentAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#studentAddForm").find("input").val("");
					$("#studentAddForm").find("textarea").val("");
				} else {
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
	//验证学生信息添加表单字段
	$('#studentAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"student.studentNumber": {
				validators: {
					notEmpty: {
						message: "学号不能为空",
					}
				}
			},
			"student.studentName": {
				validators: {
					notEmpty: {
						message: "姓名不能为空",
					}
				}
			},
			"student.studentPassword": {
				validators: {
					notEmpty: {
						message: "登录密码不能为空",
					}
				}
			},
			"student.studentSex": {
				validators: {
					notEmpty: {
						message: "性别不能为空",
					}
				}
			},
			"student.studentBirthday": {
				validators: {
					notEmpty: {
						message: "出生日期不能为空",
					}
				}
			},
		}
	}); 
	//初始化所在班级下拉框值 
	$.ajax({
		url: basePath + "ClassInfo/listAll",
		type: "get",
		success: function(classInfos,response,status) { 
			$("#student_studentClassNumber_classNumber").empty();
			var html="";
    		$(classInfos).each(function(i,classInfo){
    			html += "<option value='" + classInfo.classNumber + "'>" + classInfo.className + "</option>";
    		});
    		$("#student_studentClassNumber_classNumber").html(html);
    	}
	});
	//出生日期组件
	$('#student_studentBirthdayDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#studentAddForm').data('bootstrapValidator').updateStatus('student.studentBirthday', 'NOT_VALIDATED',null).validateField('student.studentBirthday');
	});
})
</script>
</body>
</html>

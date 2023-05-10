<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
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
<title>教师信息添加</title>
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
  			<li><a href="<%=basePath %>Teacher/frontlist">教师信息管理</a></li>
  			<li class="active">添加教师信息</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="teacherAddForm" id="teacherAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
					 <label for="teacher_teacherNumber" class="col-md-2 text-right">教师编号:</label>
					 <div class="col-md-8"> 
					 	<input type="text" id="teacher_teacherNumber" name="teacher.teacherNumber" class="form-control" placeholder="请输入教师编号">
					 </div>
				  </div> 
				  <div class="form-group">
				  	 <label for="teacher_teacherName" class="col-md-2 text-right">教师姓名:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="teacher_teacherName" name="teacher.teacherName" class="form-control" placeholder="请输入教师姓名">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="teacher_teacherPassword" class="col-md-2 text-right">登录密码:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="teacher_teacherPassword" name="teacher.teacherPassword" class="form-control" placeholder="请输入登录密码">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="teacher_teacherSex" class="col-md-2 text-right">性别:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="teacher_teacherSex" name="teacher.teacherSex" class="form-control" placeholder="请输入性别">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="teacher_teacherBirthdayDiv" class="col-md-2 text-right">出生日期:</label>
				  	 <div class="col-md-8">
		                <div id="teacher_teacherBirthdayDiv" class="input-group date teacher_teacherBirthday col-md-12" data-link-field="teacher_teacherBirthday" data-link-format="yyyy-mm-dd">
		                    <input class="form-control" id="teacher_teacherBirthday" name="teacher.teacherBirthday" size="16" type="text" value="" placeholder="请选择出生日期" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="teacher_teacherArriveDateDiv" class="col-md-2 text-right">入职日期:</label>
				  	 <div class="col-md-8">
		                <div id="teacher_teacherArriveDateDiv" class="input-group date teacher_teacherArriveDate col-md-12" data-link-field="teacher_teacherArriveDate" data-link-format="yyyy-mm-dd">
		                    <input class="form-control" id="teacher_teacherArriveDate" name="teacher.teacherArriveDate" size="16" type="text" value="" placeholder="请选择入职日期" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="teacher_teacherCardNumber" class="col-md-2 text-right">身份证号:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="teacher_teacherCardNumber" name="teacher.teacherCardNumber" class="form-control" placeholder="请输入身份证号">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="teacher_teacherPhone" class="col-md-2 text-right">联系电话:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="teacher_teacherPhone" name="teacher.teacherPhone" class="form-control" placeholder="请输入联系电话">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="teacher_teacherPhoto" class="col-md-2 text-right">教师照片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="teacher_teacherPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="teacher_teacherPhoto" name="teacher.teacherPhoto"/>
					    <input id="teacherPhotoFile" name="teacherPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="teacher_teacherAddress" class="col-md-2 text-right">家庭地址:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="teacher_teacherAddress" name="teacher.teacherAddress" class="form-control" placeholder="请输入家庭地址">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="teacher_teacherMemo" class="col-md-2 text-right">附加信息:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="teacher_teacherMemo" name="teacher.teacherMemo" class="form-control" placeholder="请输入附加信息">
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxTeacherAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#teacherAddForm .form-group {margin:5px;}  </style>  
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
	//提交添加教师信息信息
	function ajaxTeacherAdd() { 
		//提交之前先验证表单
		$("#teacherAddForm").data('bootstrapValidator').validate();
		if(!$("#teacherAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Teacher/add",
			dataType : "json" , 
			data: new FormData($("#teacherAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#teacherAddForm").find("input").val("");
					$("#teacherAddForm").find("textarea").val("");
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
	//验证教师信息添加表单字段
	$('#teacherAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"teacher.teacherNumber": {
				validators: {
					notEmpty: {
						message: "教师编号不能为空",
					}
				}
			},
			"teacher.teacherName": {
				validators: {
					notEmpty: {
						message: "教师姓名不能为空",
					}
				}
			},
			"teacher.teacherSex": {
				validators: {
					notEmpty: {
						message: "性别不能为空",
					}
				}
			},
			"teacher.teacherBirthday": {
				validators: {
					notEmpty: {
						message: "出生日期不能为空",
					}
				}
			},
			"teacher.teacherArriveDate": {
				validators: {
					notEmpty: {
						message: "入职日期不能为空",
					}
				}
			},
		}
	}); 
	//出生日期组件
	$('#teacher_teacherBirthdayDiv').datetimepicker({
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
		$('#teacherAddForm').data('bootstrapValidator').updateStatus('teacher.teacherBirthday', 'NOT_VALIDATED',null).validateField('teacher.teacherBirthday');
	});
	//入职日期组件
	$('#teacher_teacherArriveDateDiv').datetimepicker({
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
		$('#teacherAddForm').data('bootstrapValidator').updateStatus('teacher.teacherArriveDate', 'NOT_VALIDATED',null).validateField('teacher.teacherArriveDate');
	});
})
</script>
</body>
</html>

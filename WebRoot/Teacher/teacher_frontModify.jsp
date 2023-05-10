<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Teacher" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Teacher teacher = (Teacher)request.getAttribute("teacher");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改教师信息信息</TITLE>
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
  		<li class="active">教师信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="teacherEditForm" id="teacherEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="teacher_teacherNumber_edit" class="col-md-3 text-right">教师编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="teacher_teacherNumber_edit" name="teacher.teacherNumber" class="form-control" placeholder="请输入教师编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="teacher_teacherName_edit" class="col-md-3 text-right">教师姓名:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="teacher_teacherName_edit" name="teacher.teacherName" class="form-control" placeholder="请输入教师姓名">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="teacher_teacherPassword_edit" class="col-md-3 text-right">登录密码:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="teacher_teacherPassword_edit" name="teacher.teacherPassword" class="form-control" placeholder="请输入登录密码">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="teacher_teacherSex_edit" class="col-md-3 text-right">性别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="teacher_teacherSex_edit" name="teacher.teacherSex" class="form-control" placeholder="请输入性别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="teacher_teacherBirthday_edit" class="col-md-3 text-right">出生日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date teacher_teacherBirthday_edit col-md-12" data-link-field="teacher_teacherBirthday_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="teacher_teacherBirthday_edit" name="teacher.teacherBirthday" size="16" type="text" value="" placeholder="请选择出生日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="teacher_teacherArriveDate_edit" class="col-md-3 text-right">入职日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date teacher_teacherArriveDate_edit col-md-12" data-link-field="teacher_teacherArriveDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="teacher_teacherArriveDate_edit" name="teacher.teacherArriveDate" size="16" type="text" value="" placeholder="请选择入职日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="teacher_teacherCardNumber_edit" class="col-md-3 text-right">身份证号:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="teacher_teacherCardNumber_edit" name="teacher.teacherCardNumber" class="form-control" placeholder="请输入身份证号">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="teacher_teacherPhone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="teacher_teacherPhone_edit" name="teacher.teacherPhone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="teacher_teacherPhoto_edit" class="col-md-3 text-right">教师照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="teacher_teacherPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="teacher_teacherPhoto" name="teacher.teacherPhoto"/>
			    <input id="teacherPhotoFile" name="teacherPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="teacher_teacherAddress_edit" class="col-md-3 text-right">家庭地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="teacher_teacherAddress_edit" name="teacher.teacherAddress" class="form-control" placeholder="请输入家庭地址">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="teacher_teacherMemo_edit" class="col-md-3 text-right">附加信息:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="teacher_teacherMemo_edit" name="teacher.teacherMemo" class="form-control" placeholder="请输入附加信息">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxTeacherModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#teacherEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改教师信息界面并初始化数据*/
function teacherEdit(teacherNumber) {
	$.ajax({
		url :  basePath + "Teacher/" + teacherNumber + "/update",
		type : "get",
		dataType: "json",
		success : function (teacher, response, status) {
			if (teacher) {
				$("#teacher_teacherNumber_edit").val(teacher.teacherNumber);
				$("#teacher_teacherName_edit").val(teacher.teacherName);
				$("#teacher_teacherPassword_edit").val(teacher.teacherPassword);
				$("#teacher_teacherSex_edit").val(teacher.teacherSex);
				$("#teacher_teacherBirthday_edit").val(teacher.teacherBirthday);
				$("#teacher_teacherArriveDate_edit").val(teacher.teacherArriveDate);
				$("#teacher_teacherCardNumber_edit").val(teacher.teacherCardNumber);
				$("#teacher_teacherPhone_edit").val(teacher.teacherPhone);
				$("#teacher_teacherPhoto").val(teacher.teacherPhoto);
				$("#teacher_teacherPhotoImg").attr("src", basePath +　teacher.teacherPhoto);
				$("#teacher_teacherAddress_edit").val(teacher.teacherAddress);
				$("#teacher_teacherMemo_edit").val(teacher.teacherMemo);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交教师信息信息表单给服务器端修改*/
function ajaxTeacherModify() {
	$.ajax({
		url :  basePath + "Teacher/" + $("#teacher_teacherNumber_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#teacherEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#teacherQueryForm").submit();
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
    $('.teacher_teacherBirthday_edit').datetimepicker({
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
    /*入职日期组件*/
    $('.teacher_teacherArriveDate_edit').datetimepicker({
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
    teacherEdit("<%=request.getParameter("teacherNumber")%>");
 })
 </script> 
</body>
</html>


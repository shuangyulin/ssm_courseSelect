<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.CourseInfo" %>
<%@ page import="com.chengxusheji.po.Student" %>
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
<title>选课信息添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>StudentSelectCourseInfo/frontlist">选课信息列表</a></li>
			    	<li role="presentation" class="active"><a href="#studentSelectCourseInfoAdd" aria-controls="studentSelectCourseInfoAdd" role="tab" data-toggle="tab">添加选课信息</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="studentSelectCourseInfoList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="studentSelectCourseInfoAdd"> 
				      	<form class="form-horizontal" name="studentSelectCourseInfoAddForm" id="studentSelectCourseInfoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="studentSelectCourseInfo_studentNumber_studentNumber" class="col-md-2 text-right">学生对象:</label>
						  	 <div class="col-md-8">
							    <select id="studentSelectCourseInfo_studentNumber_studentNumber" name="studentSelectCourseInfo.studentNumber.studentNumber" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="studentSelectCourseInfo_courseNumber_courseNumber" class="col-md-2 text-right">课程对象:</label>
						  	 <div class="col-md-8">
							    <select id="studentSelectCourseInfo_courseNumber_courseNumber" name="studentSelectCourseInfo.courseNumber.courseNumber" class="form-control">
							    </select>
						  	 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxStudentSelectCourseInfoAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#studentSelectCourseInfoAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
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
	//提交添加选课信息信息
	function ajaxStudentSelectCourseInfoAdd() { 
		//提交之前先验证表单
		$("#studentSelectCourseInfoAddForm").data('bootstrapValidator').validate();
		if(!$("#studentSelectCourseInfoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "StudentSelectCourseInfo/add",
			dataType : "json" , 
			data: new FormData($("#studentSelectCourseInfoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#studentSelectCourseInfoAddForm").find("input").val("");
					$("#studentSelectCourseInfoAddForm").find("textarea").val("");
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
	//验证选课信息添加表单字段
	$('#studentSelectCourseInfoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
		}
	}); 
	//初始化学生对象下拉框值 
	$.ajax({
		url: basePath + "Student/listAll",
		type: "get",
		success: function(students,response,status) { 
			$("#studentSelectCourseInfo_studentNumber_studentNumber").empty();
			var html="";
    		$(students).each(function(i,student){
    			html += "<option value='" + student.studentNumber + "'>" + student.studentName + "</option>";
    		});
    		$("#studentSelectCourseInfo_studentNumber_studentNumber").html(html);
    	}
	});
	//初始化课程对象下拉框值 
	$.ajax({
		url: basePath + "CourseInfo/listAll",
		type: "get",
		success: function(courseInfos,response,status) { 
			$("#studentSelectCourseInfo_courseNumber_courseNumber").empty();
			var html="";
    		$(courseInfos).each(function(i,courseInfo){
    			html += "<option value='" + courseInfo.courseNumber + "'>" + courseInfo.courseName + "</option>";
    		});
    		$("#studentSelectCourseInfo_courseNumber_courseNumber").html(html);
    	}
	});
})
</script>
</body>
</html>

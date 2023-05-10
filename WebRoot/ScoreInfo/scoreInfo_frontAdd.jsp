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
<title>成绩信息添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>ScoreInfo/frontlist">成绩信息列表</a></li>
			    	<li role="presentation" class="active"><a href="#scoreInfoAdd" aria-controls="scoreInfoAdd" role="tab" data-toggle="tab">添加成绩信息</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="scoreInfoList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="scoreInfoAdd"> 
				      	<form class="form-horizontal" name="scoreInfoAddForm" id="scoreInfoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="scoreInfo_studentNumber_studentNumber" class="col-md-2 text-right">学生对象:</label>
						  	 <div class="col-md-8">
							    <select id="scoreInfo_studentNumber_studentNumber" name="scoreInfo.studentNumber.studentNumber" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="scoreInfo_courseNumber_courseNumber" class="col-md-2 text-right">课程对象:</label>
						  	 <div class="col-md-8">
							    <select id="scoreInfo_courseNumber_courseNumber" name="scoreInfo.courseNumber.courseNumber" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="scoreInfo_scoreValue" class="col-md-2 text-right">成绩得分:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="scoreInfo_scoreValue" name="scoreInfo.scoreValue" class="form-control" placeholder="请输入成绩得分">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="scoreInfo_studentEvaluate" class="col-md-2 text-right">学生评价:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="scoreInfo_studentEvaluate" name="scoreInfo.studentEvaluate" class="form-control" placeholder="请输入学生评价">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxScoreInfoAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#scoreInfoAddForm .form-group {margin:10px;}  </style>
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
	//提交添加成绩信息信息
	function ajaxScoreInfoAdd() { 
		//提交之前先验证表单
		$("#scoreInfoAddForm").data('bootstrapValidator').validate();
		if(!$("#scoreInfoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "ScoreInfo/add",
			dataType : "json" , 
			data: new FormData($("#scoreInfoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#scoreInfoAddForm").find("input").val("");
					$("#scoreInfoAddForm").find("textarea").val("");
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
	//验证成绩信息添加表单字段
	$('#scoreInfoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"scoreInfo.scoreValue": {
				validators: {
					notEmpty: {
						message: "成绩得分不能为空",
					},
					numeric: {
						message: "成绩得分不正确"
					}
				}
			},
		}
	}); 
	//初始化学生对象下拉框值 
	$.ajax({
		url: basePath + "Student/listAll",
		type: "get",
		success: function(students,response,status) { 
			$("#scoreInfo_studentNumber_studentNumber").empty();
			var html="";
    		$(students).each(function(i,student){
    			html += "<option value='" + student.studentNumber + "'>" + student.studentName + "</option>";
    		});
    		$("#scoreInfo_studentNumber_studentNumber").html(html);
    	}
	});
	//初始化课程对象下拉框值 
	$.ajax({
		url: basePath + "CourseInfo/listAll",
		type: "get",
		success: function(courseInfos,response,status) { 
			$("#scoreInfo_courseNumber_courseNumber").empty();
			var html="";
    		$(courseInfos).each(function(i,courseInfo){
    			html += "<option value='" + courseInfo.courseNumber + "'>" + courseInfo.courseName + "</option>";
    		});
    		$("#scoreInfo_courseNumber_courseNumber").html(html);
    	}
	});
})
</script>
</body>
</html>

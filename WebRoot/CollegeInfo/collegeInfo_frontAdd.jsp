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
<title>学院信息添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>CollegeInfo/frontlist">学院信息列表</a></li>
			    	<li role="presentation" class="active"><a href="#collegeInfoAdd" aria-controls="collegeInfoAdd" role="tab" data-toggle="tab">添加学院信息</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="collegeInfoList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="collegeInfoAdd"> 
				      	<form class="form-horizontal" name="collegeInfoAddForm" id="collegeInfoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
							 <label for="collegeInfo_collegeNumber" class="col-md-2 text-right">学院编号:</label>
							 <div class="col-md-8"> 
							 	<input type="text" id="collegeInfo_collegeNumber" name="collegeInfo.collegeNumber" class="form-control" placeholder="请输入学院编号">
							 </div>
						  </div> 
						  <div class="form-group">
						  	 <label for="collegeInfo_collegeName" class="col-md-2 text-right">学院名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="collegeInfo_collegeName" name="collegeInfo.collegeName" class="form-control" placeholder="请输入学院名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="collegeInfo_collegeBirthDateDiv" class="col-md-2 text-right">成立日期:</label>
						  	 <div class="col-md-8">
				                <div id="collegeInfo_collegeBirthDateDiv" class="input-group date collegeInfo_collegeBirthDate col-md-12" data-link-field="collegeInfo_collegeBirthDate" data-link-format="yyyy-mm-dd">
				                    <input class="form-control" id="collegeInfo_collegeBirthDate" name="collegeInfo.collegeBirthDate" size="16" type="text" value="" placeholder="请选择成立日期" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="collegeInfo_collegeMan" class="col-md-2 text-right">院长姓名:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="collegeInfo_collegeMan" name="collegeInfo.collegeMan" class="form-control" placeholder="请输入院长姓名">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="collegeInfo_collegeTelephone" class="col-md-2 text-right">联系电话:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="collegeInfo_collegeTelephone" name="collegeInfo.collegeTelephone" class="form-control" placeholder="请输入联系电话">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="collegeInfo_collegeMemo" class="col-md-2 text-right">附加信息:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="collegeInfo_collegeMemo" name="collegeInfo.collegeMemo" class="form-control" placeholder="请输入附加信息">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxCollegeInfoAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#collegeInfoAddForm .form-group {margin:10px;}  </style>
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
	//提交添加学院信息信息
	function ajaxCollegeInfoAdd() { 
		//提交之前先验证表单
		$("#collegeInfoAddForm").data('bootstrapValidator').validate();
		if(!$("#collegeInfoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "CollegeInfo/add",
			dataType : "json" , 
			data: new FormData($("#collegeInfoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#collegeInfoAddForm").find("input").val("");
					$("#collegeInfoAddForm").find("textarea").val("");
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
	//验证学院信息添加表单字段
	$('#collegeInfoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"collegeInfo.collegeNumber": {
				validators: {
					notEmpty: {
						message: "学院编号不能为空",
					}
				}
			},
			"collegeInfo.collegeName": {
				validators: {
					notEmpty: {
						message: "学院名称不能为空",
					}
				}
			},
			"collegeInfo.collegeBirthDate": {
				validators: {
					notEmpty: {
						message: "成立日期不能为空",
					}
				}
			},
		}
	}); 
	//成立日期组件
	$('#collegeInfo_collegeBirthDateDiv').datetimepicker({
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
		$('#collegeInfoAddForm').data('bootstrapValidator').updateStatus('collegeInfo.collegeBirthDate', 'NOT_VALIDATED',null).validateField('collegeInfo.collegeBirthDate');
	});
})
</script>
</body>
</html>

<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.CollegeInfo" %>
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
<title>专业信息添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>SpecialFieldInfo/frontlist">专业信息列表</a></li>
			    	<li role="presentation" class="active"><a href="#specialFieldInfoAdd" aria-controls="specialFieldInfoAdd" role="tab" data-toggle="tab">添加专业信息</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="specialFieldInfoList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="specialFieldInfoAdd"> 
				      	<form class="form-horizontal" name="specialFieldInfoAddForm" id="specialFieldInfoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
							 <label for="specialFieldInfo_specialFieldNumber" class="col-md-2 text-right">专业编号:</label>
							 <div class="col-md-8"> 
							 	<input type="text" id="specialFieldInfo_specialFieldNumber" name="specialFieldInfo.specialFieldNumber" class="form-control" placeholder="请输入专业编号">
							 </div>
						  </div> 
						  <div class="form-group">
						  	 <label for="specialFieldInfo_specialFieldName" class="col-md-2 text-right">专业名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="specialFieldInfo_specialFieldName" name="specialFieldInfo.specialFieldName" class="form-control" placeholder="请输入专业名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="specialFieldInfo_specialCollegeNumber_collegeNumber" class="col-md-2 text-right">所在学院:</label>
						  	 <div class="col-md-8">
							    <select id="specialFieldInfo_specialCollegeNumber_collegeNumber" name="specialFieldInfo.specialCollegeNumber.collegeNumber" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="specialFieldInfo_specialBirthDateDiv" class="col-md-2 text-right">成立日期:</label>
						  	 <div class="col-md-8">
				                <div id="specialFieldInfo_specialBirthDateDiv" class="input-group date specialFieldInfo_specialBirthDate col-md-12" data-link-field="specialFieldInfo_specialBirthDate" data-link-format="yyyy-mm-dd">
				                    <input class="form-control" id="specialFieldInfo_specialBirthDate" name="specialFieldInfo.specialBirthDate" size="16" type="text" value="" placeholder="请选择成立日期" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="specialFieldInfo_specialMan" class="col-md-2 text-right">联系人:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="specialFieldInfo_specialMan" name="specialFieldInfo.specialMan" class="form-control" placeholder="请输入联系人">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="specialFieldInfo_specialTelephone" class="col-md-2 text-right">联系电话:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="specialFieldInfo_specialTelephone" name="specialFieldInfo.specialTelephone" class="form-control" placeholder="请输入联系电话">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="specialFieldInfo_specialMemo" class="col-md-2 text-right">附加信息:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="specialFieldInfo_specialMemo" name="specialFieldInfo.specialMemo" class="form-control" placeholder="请输入附加信息">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxSpecialFieldInfoAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#specialFieldInfoAddForm .form-group {margin:10px;}  </style>
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
	//提交添加专业信息信息
	function ajaxSpecialFieldInfoAdd() { 
		//提交之前先验证表单
		$("#specialFieldInfoAddForm").data('bootstrapValidator').validate();
		if(!$("#specialFieldInfoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "SpecialFieldInfo/add",
			dataType : "json" , 
			data: new FormData($("#specialFieldInfoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#specialFieldInfoAddForm").find("input").val("");
					$("#specialFieldInfoAddForm").find("textarea").val("");
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
	//验证专业信息添加表单字段
	$('#specialFieldInfoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"specialFieldInfo.specialFieldNumber": {
				validators: {
					notEmpty: {
						message: "专业编号不能为空",
					}
				}
			},
			"specialFieldInfo.specialFieldName": {
				validators: {
					notEmpty: {
						message: "专业名称不能为空",
					}
				}
			},
			"specialFieldInfo.specialBirthDate": {
				validators: {
					notEmpty: {
						message: "成立日期不能为空",
					}
				}
			},
		}
	}); 
	//初始化所在学院下拉框值 
	$.ajax({
		url: basePath + "CollegeInfo/listAll",
		type: "get",
		success: function(collegeInfos,response,status) { 
			$("#specialFieldInfo_specialCollegeNumber_collegeNumber").empty();
			var html="";
    		$(collegeInfos).each(function(i,collegeInfo){
    			html += "<option value='" + collegeInfo.collegeNumber + "'>" + collegeInfo.collegeName + "</option>";
    		});
    		$("#specialFieldInfo_specialCollegeNumber_collegeNumber").html(html);
    	}
	});
	//成立日期组件
	$('#specialFieldInfo_specialBirthDateDiv').datetimepicker({
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
		$('#specialFieldInfoAddForm').data('bootstrapValidator').updateStatus('specialFieldInfo.specialBirthDate', 'NOT_VALIDATED',null).validateField('specialFieldInfo.specialBirthDate');
	});
})
</script>
</body>
</html>

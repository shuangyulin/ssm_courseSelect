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
<title>新闻信息添加</title>
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
  			<li><a href="<%=basePath %>News/frontlist">新闻信息管理</a></li>
  			<li class="active">添加新闻信息</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="newsAddForm" id="newsAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
				  	 <label for="news_newsTitle" class="col-md-2 text-right">新闻标题:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="news_newsTitle" name="news.newsTitle" class="form-control" placeholder="请输入新闻标题">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="news_newsContent" class="col-md-2 text-right">新闻内容:</label>
				  	 <div class="col-md-8">
					    <textarea id="news_newsContent" name="news.newsContent" rows="8" class="form-control" placeholder="请输入新闻内容"></textarea>
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="news_newsDateDiv" class="col-md-2 text-right">发布日期:</label>
				  	 <div class="col-md-8">
		                <div id="news_newsDateDiv" class="input-group date news_newsDate col-md-12" data-link-field="news_newsDate" data-link-format="yyyy-mm-dd">
		                    <input class="form-control" id="news_newsDate" name="news.newsDate" size="16" type="text" value="" placeholder="请选择发布日期" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="news_newsPhoto" class="col-md-2 text-right">新闻图片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="news_newsPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="news_newsPhoto" name="news.newsPhoto"/>
					    <input id="newsPhotoFile" name="newsPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxNewsAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#newsAddForm .form-group {margin:5px;}  </style>  
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
	//提交添加新闻信息信息
	function ajaxNewsAdd() { 
		//提交之前先验证表单
		$("#newsAddForm").data('bootstrapValidator').validate();
		if(!$("#newsAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "News/add",
			dataType : "json" , 
			data: new FormData($("#newsAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#newsAddForm").find("input").val("");
					$("#newsAddForm").find("textarea").val("");
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
	//验证新闻信息添加表单字段
	$('#newsAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"news.newsTitle": {
				validators: {
					notEmpty: {
						message: "新闻标题不能为空",
					}
				}
			},
			"news.newsContent": {
				validators: {
					notEmpty: {
						message: "新闻内容不能为空",
					}
				}
			},
			"news.newsDate": {
				validators: {
					notEmpty: {
						message: "发布日期不能为空",
					}
				}
			},
		}
	}); 
	//发布日期组件
	$('#news_newsDateDiv').datetimepicker({
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
		$('#newsAddForm').data('bootstrapValidator').updateStatus('news.newsDate', 'NOT_VALIDATED',null).validateField('news.newsDate');
	});
})
</script>
</body>
</html>

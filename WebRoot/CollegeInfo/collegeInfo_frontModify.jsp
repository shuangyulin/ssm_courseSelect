<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.CollegeInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    CollegeInfo collegeInfo = (CollegeInfo)request.getAttribute("collegeInfo");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改学院信息信息</TITLE>
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
  		<li class="active">学院信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="collegeInfoEditForm" id="collegeInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="collegeInfo_collegeNumber_edit" class="col-md-3 text-right">学院编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="collegeInfo_collegeNumber_edit" name="collegeInfo.collegeNumber" class="form-control" placeholder="请输入学院编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="collegeInfo_collegeName_edit" class="col-md-3 text-right">学院名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="collegeInfo_collegeName_edit" name="collegeInfo.collegeName" class="form-control" placeholder="请输入学院名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="collegeInfo_collegeBirthDate_edit" class="col-md-3 text-right">成立日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date collegeInfo_collegeBirthDate_edit col-md-12" data-link-field="collegeInfo_collegeBirthDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="collegeInfo_collegeBirthDate_edit" name="collegeInfo.collegeBirthDate" size="16" type="text" value="" placeholder="请选择成立日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="collegeInfo_collegeMan_edit" class="col-md-3 text-right">院长姓名:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="collegeInfo_collegeMan_edit" name="collegeInfo.collegeMan" class="form-control" placeholder="请输入院长姓名">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="collegeInfo_collegeTelephone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="collegeInfo_collegeTelephone_edit" name="collegeInfo.collegeTelephone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="collegeInfo_collegeMemo_edit" class="col-md-3 text-right">附加信息:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="collegeInfo_collegeMemo_edit" name="collegeInfo.collegeMemo" class="form-control" placeholder="请输入附加信息">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxCollegeInfoModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#collegeInfoEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改学院信息界面并初始化数据*/
function collegeInfoEdit(collegeNumber) {
	$.ajax({
		url :  basePath + "CollegeInfo/" + collegeNumber + "/update",
		type : "get",
		dataType: "json",
		success : function (collegeInfo, response, status) {
			if (collegeInfo) {
				$("#collegeInfo_collegeNumber_edit").val(collegeInfo.collegeNumber);
				$("#collegeInfo_collegeName_edit").val(collegeInfo.collegeName);
				$("#collegeInfo_collegeBirthDate_edit").val(collegeInfo.collegeBirthDate);
				$("#collegeInfo_collegeMan_edit").val(collegeInfo.collegeMan);
				$("#collegeInfo_collegeTelephone_edit").val(collegeInfo.collegeTelephone);
				$("#collegeInfo_collegeMemo_edit").val(collegeInfo.collegeMemo);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交学院信息信息表单给服务器端修改*/
function ajaxCollegeInfoModify() {
	$.ajax({
		url :  basePath + "CollegeInfo/" + $("#collegeInfo_collegeNumber_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#collegeInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                location.href= basePath + "CollegeInfo/frontlist";
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
    /*成立日期组件*/
    $('.collegeInfo_collegeBirthDate_edit').datetimepicker({
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
    collegeInfoEdit("<%=request.getParameter("collegeNumber")%>");
 })
 </script> 
</body>
</html>


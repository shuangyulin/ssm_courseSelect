<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.SpecialFieldInfo" %>
<%@ page import="com.chengxusheji.po.CollegeInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的specialCollegeNumber信息
    List<CollegeInfo> collegeInfoList = (List<CollegeInfo>)request.getAttribute("collegeInfoList");
    SpecialFieldInfo specialFieldInfo = (SpecialFieldInfo)request.getAttribute("specialFieldInfo");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改专业信息信息</TITLE>
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
  		<li class="active">专业信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="specialFieldInfoEditForm" id="specialFieldInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="specialFieldInfo_specialFieldNumber_edit" class="col-md-3 text-right">专业编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="specialFieldInfo_specialFieldNumber_edit" name="specialFieldInfo.specialFieldNumber" class="form-control" placeholder="请输入专业编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="specialFieldInfo_specialFieldName_edit" class="col-md-3 text-right">专业名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="specialFieldInfo_specialFieldName_edit" name="specialFieldInfo.specialFieldName" class="form-control" placeholder="请输入专业名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="specialFieldInfo_specialCollegeNumber_collegeNumber_edit" class="col-md-3 text-right">所在学院:</label>
		  	 <div class="col-md-9">
			    <select id="specialFieldInfo_specialCollegeNumber_collegeNumber_edit" name="specialFieldInfo.specialCollegeNumber.collegeNumber" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="specialFieldInfo_specialBirthDate_edit" class="col-md-3 text-right">成立日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date specialFieldInfo_specialBirthDate_edit col-md-12" data-link-field="specialFieldInfo_specialBirthDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="specialFieldInfo_specialBirthDate_edit" name="specialFieldInfo.specialBirthDate" size="16" type="text" value="" placeholder="请选择成立日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="specialFieldInfo_specialMan_edit" class="col-md-3 text-right">联系人:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="specialFieldInfo_specialMan_edit" name="specialFieldInfo.specialMan" class="form-control" placeholder="请输入联系人">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="specialFieldInfo_specialTelephone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="specialFieldInfo_specialTelephone_edit" name="specialFieldInfo.specialTelephone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="specialFieldInfo_specialMemo_edit" class="col-md-3 text-right">附加信息:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="specialFieldInfo_specialMemo_edit" name="specialFieldInfo.specialMemo" class="form-control" placeholder="请输入附加信息">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxSpecialFieldInfoModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#specialFieldInfoEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改专业信息界面并初始化数据*/
function specialFieldInfoEdit(specialFieldNumber) {
	$.ajax({
		url :  basePath + "SpecialFieldInfo/" + specialFieldNumber + "/update",
		type : "get",
		dataType: "json",
		success : function (specialFieldInfo, response, status) {
			if (specialFieldInfo) {
				$("#specialFieldInfo_specialFieldNumber_edit").val(specialFieldInfo.specialFieldNumber);
				$("#specialFieldInfo_specialFieldName_edit").val(specialFieldInfo.specialFieldName);
				$.ajax({
					url: basePath + "CollegeInfo/listAll",
					type: "get",
					success: function(collegeInfos,response,status) { 
						$("#specialFieldInfo_specialCollegeNumber_collegeNumber_edit").empty();
						var html="";
		        		$(collegeInfos).each(function(i,collegeInfo){
		        			html += "<option value='" + collegeInfo.collegeNumber + "'>" + collegeInfo.collegeName + "</option>";
		        		});
		        		$("#specialFieldInfo_specialCollegeNumber_collegeNumber_edit").html(html);
		        		$("#specialFieldInfo_specialCollegeNumber_collegeNumber_edit").val(specialFieldInfo.specialCollegeNumberPri);
					}
				});
				$("#specialFieldInfo_specialBirthDate_edit").val(specialFieldInfo.specialBirthDate);
				$("#specialFieldInfo_specialMan_edit").val(specialFieldInfo.specialMan);
				$("#specialFieldInfo_specialTelephone_edit").val(specialFieldInfo.specialTelephone);
				$("#specialFieldInfo_specialMemo_edit").val(specialFieldInfo.specialMemo);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交专业信息信息表单给服务器端修改*/
function ajaxSpecialFieldInfoModify() {
	$.ajax({
		url :  basePath + "SpecialFieldInfo/" + $("#specialFieldInfo_specialFieldNumber_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#specialFieldInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#specialFieldInfoQueryForm").submit();
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
    $('.specialFieldInfo_specialBirthDate_edit').datetimepicker({
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
    specialFieldInfoEdit("<%=request.getParameter("specialFieldNumber")%>");
 })
 </script> 
</body>
</html>


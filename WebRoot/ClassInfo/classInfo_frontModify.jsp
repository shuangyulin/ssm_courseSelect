<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.ClassInfo" %>
<%@ page import="com.chengxusheji.po.SpecialFieldInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的classSpecialFieldNumber信息
    List<SpecialFieldInfo> specialFieldInfoList = (List<SpecialFieldInfo>)request.getAttribute("specialFieldInfoList");
    ClassInfo classInfo = (ClassInfo)request.getAttribute("classInfo");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改班级信息信息</TITLE>
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
  		<li class="active">班级信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="classInfoEditForm" id="classInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="classInfo_classNumber_edit" class="col-md-3 text-right">班级编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="classInfo_classNumber_edit" name="classInfo.classNumber" class="form-control" placeholder="请输入班级编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="classInfo_className_edit" class="col-md-3 text-right">班级名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="classInfo_className_edit" name="classInfo.className" class="form-control" placeholder="请输入班级名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="classInfo_classSpecialFieldNumber_specialFieldNumber_edit" class="col-md-3 text-right">所属专业:</label>
		  	 <div class="col-md-9">
			    <select id="classInfo_classSpecialFieldNumber_specialFieldNumber_edit" name="classInfo.classSpecialFieldNumber.specialFieldNumber" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="classInfo_classBirthDate_edit" class="col-md-3 text-right">成立日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date classInfo_classBirthDate_edit col-md-12" data-link-field="classInfo_classBirthDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="classInfo_classBirthDate_edit" name="classInfo.classBirthDate" size="16" type="text" value="" placeholder="请选择成立日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="classInfo_classTeacherCharge_edit" class="col-md-3 text-right">班主任:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="classInfo_classTeacherCharge_edit" name="classInfo.classTeacherCharge" class="form-control" placeholder="请输入班主任">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="classInfo_classTelephone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="classInfo_classTelephone_edit" name="classInfo.classTelephone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="classInfo_classMemo_edit" class="col-md-3 text-right">附加信息:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="classInfo_classMemo_edit" name="classInfo.classMemo" class="form-control" placeholder="请输入附加信息">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxClassInfoModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#classInfoEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改班级信息界面并初始化数据*/
function classInfoEdit(classNumber) {
	$.ajax({
		url :  basePath + "ClassInfo/" + classNumber + "/update",
		type : "get",
		dataType: "json",
		success : function (classInfo, response, status) {
			if (classInfo) {
				$("#classInfo_classNumber_edit").val(classInfo.classNumber);
				$("#classInfo_className_edit").val(classInfo.className);
				$.ajax({
					url: basePath + "SpecialFieldInfo/listAll",
					type: "get",
					success: function(specialFieldInfos,response,status) { 
						$("#classInfo_classSpecialFieldNumber_specialFieldNumber_edit").empty();
						var html="";
		        		$(specialFieldInfos).each(function(i,specialFieldInfo){
		        			html += "<option value='" + specialFieldInfo.specialFieldNumber + "'>" + specialFieldInfo.specialFieldName + "</option>";
		        		});
		        		$("#classInfo_classSpecialFieldNumber_specialFieldNumber_edit").html(html);
		        		$("#classInfo_classSpecialFieldNumber_specialFieldNumber_edit").val(classInfo.classSpecialFieldNumberPri);
					}
				});
				$("#classInfo_classBirthDate_edit").val(classInfo.classBirthDate);
				$("#classInfo_classTeacherCharge_edit").val(classInfo.classTeacherCharge);
				$("#classInfo_classTelephone_edit").val(classInfo.classTelephone);
				$("#classInfo_classMemo_edit").val(classInfo.classMemo);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交班级信息信息表单给服务器端修改*/
function ajaxClassInfoModify() {
	$.ajax({
		url :  basePath + "ClassInfo/" + $("#classInfo_classNumber_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#classInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#classInfoQueryForm").submit();
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
    $('.classInfo_classBirthDate_edit').datetimepicker({
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
    classInfoEdit("<%=request.getParameter("classNumber")%>");
 })
 </script> 
</body>
</html>


<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.StudentSelectCourseInfo" %>
<%@ page import="com.chengxusheji.po.CourseInfo" %>
<%@ page import="com.chengxusheji.po.Student" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的courseNumber信息
    List<CourseInfo> courseInfoList = (List<CourseInfo>)request.getAttribute("courseInfoList");
    //获取所有的studentNumber信息
    List<Student> studentList = (List<Student>)request.getAttribute("studentList");
    StudentSelectCourseInfo studentSelectCourseInfo = (StudentSelectCourseInfo)request.getAttribute("studentSelectCourseInfo");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改选课信息信息</TITLE>
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
  		<li class="active">选课信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="studentSelectCourseInfoEditForm" id="studentSelectCourseInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="studentSelectCourseInfo_selectId_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="studentSelectCourseInfo_selectId_edit" name="studentSelectCourseInfo.selectId" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="studentSelectCourseInfo_studentNumber_studentNumber_edit" class="col-md-3 text-right">学生对象:</label>
		  	 <div class="col-md-9">
			    <select id="studentSelectCourseInfo_studentNumber_studentNumber_edit" name="studentSelectCourseInfo.studentNumber.studentNumber" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="studentSelectCourseInfo_courseNumber_courseNumber_edit" class="col-md-3 text-right">课程对象:</label>
		  	 <div class="col-md-9">
			    <select id="studentSelectCourseInfo_courseNumber_courseNumber_edit" name="studentSelectCourseInfo.courseNumber.courseNumber" class="form-control">
			    </select>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxStudentSelectCourseInfoModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#studentSelectCourseInfoEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改选课信息界面并初始化数据*/
function studentSelectCourseInfoEdit(selectId) {
	$.ajax({
		url :  basePath + "StudentSelectCourseInfo/" + selectId + "/update",
		type : "get",
		dataType: "json",
		success : function (studentSelectCourseInfo, response, status) {
			if (studentSelectCourseInfo) {
				$("#studentSelectCourseInfo_selectId_edit").val(studentSelectCourseInfo.selectId);
				$.ajax({
					url: basePath + "Student/listAll",
					type: "get",
					success: function(students,response,status) { 
						$("#studentSelectCourseInfo_studentNumber_studentNumber_edit").empty();
						var html="";
		        		$(students).each(function(i,student){
		        			html += "<option value='" + student.studentNumber + "'>" + student.studentName + "</option>";
		        		});
		        		$("#studentSelectCourseInfo_studentNumber_studentNumber_edit").html(html);
		        		$("#studentSelectCourseInfo_studentNumber_studentNumber_edit").val(studentSelectCourseInfo.studentNumberPri);
					}
				});
				$.ajax({
					url: basePath + "CourseInfo/listAll",
					type: "get",
					success: function(courseInfos,response,status) { 
						$("#studentSelectCourseInfo_courseNumber_courseNumber_edit").empty();
						var html="";
		        		$(courseInfos).each(function(i,courseInfo){
		        			html += "<option value='" + courseInfo.courseNumber + "'>" + courseInfo.courseName + "</option>";
		        		});
		        		$("#studentSelectCourseInfo_courseNumber_courseNumber_edit").html(html);
		        		$("#studentSelectCourseInfo_courseNumber_courseNumber_edit").val(studentSelectCourseInfo.courseNumberPri);
					}
				});
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交选课信息信息表单给服务器端修改*/
function ajaxStudentSelectCourseInfoModify() {
	$.ajax({
		url :  basePath + "StudentSelectCourseInfo/" + $("#studentSelectCourseInfo_selectId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#studentSelectCourseInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#studentSelectCourseInfoQueryForm").submit();
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
    studentSelectCourseInfoEdit("<%=request.getParameter("selectId")%>");
 })
 </script> 
</body>
</html>


<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.CourseInfo" %>
<%@ page import="com.chengxusheji.po.Teacher" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的courseTeacher信息
    List<Teacher> teacherList = (List<Teacher>)request.getAttribute("teacherList");
    CourseInfo courseInfo = (CourseInfo)request.getAttribute("courseInfo");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改课程信息信息</TITLE>
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
  		<li class="active">课程信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="courseInfoEditForm" id="courseInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="courseInfo_courseNumber_edit" class="col-md-3 text-right">课程编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="courseInfo_courseNumber_edit" name="courseInfo.courseNumber" class="form-control" placeholder="请输入课程编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="courseInfo_courseName_edit" class="col-md-3 text-right">课程名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="courseInfo_courseName_edit" name="courseInfo.courseName" class="form-control" placeholder="请输入课程名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="courseInfo_courseTeacher_teacherNumber_edit" class="col-md-3 text-right">上课老师:</label>
		  	 <div class="col-md-9">
			    <select id="courseInfo_courseTeacher_teacherNumber_edit" name="courseInfo.courseTeacher.teacherNumber" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="courseInfo_courseTime_edit" class="col-md-3 text-right">上课时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="courseInfo_courseTime_edit" name="courseInfo.courseTime" class="form-control" placeholder="请输入上课时间">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="courseInfo_coursePlace_edit" class="col-md-3 text-right">上课地点:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="courseInfo_coursePlace_edit" name="courseInfo.coursePlace" class="form-control" placeholder="请输入上课地点">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="courseInfo_courseScore_edit" class="col-md-3 text-right">课程学分:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="courseInfo_courseScore_edit" name="courseInfo.courseScore" class="form-control" placeholder="请输入课程学分">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="courseInfo_courseMemo_edit" class="col-md-3 text-right">附加信息:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="courseInfo_courseMemo_edit" name="courseInfo.courseMemo" class="form-control" placeholder="请输入附加信息">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxCourseInfoModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#courseInfoEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改课程信息界面并初始化数据*/
function courseInfoEdit(courseNumber) {
	$.ajax({
		url :  basePath + "CourseInfo/" + courseNumber + "/update",
		type : "get",
		dataType: "json",
		success : function (courseInfo, response, status) {
			if (courseInfo) {
				$("#courseInfo_courseNumber_edit").val(courseInfo.courseNumber);
				$("#courseInfo_courseName_edit").val(courseInfo.courseName);
				$.ajax({
					url: basePath + "Teacher/listAll",
					type: "get",
					success: function(teachers,response,status) { 
						$("#courseInfo_courseTeacher_teacherNumber_edit").empty();
						var html="";
		        		$(teachers).each(function(i,teacher){
		        			html += "<option value='" + teacher.teacherNumber + "'>" + teacher.teacherName + "</option>";
		        		});
		        		$("#courseInfo_courseTeacher_teacherNumber_edit").html(html);
		        		$("#courseInfo_courseTeacher_teacherNumber_edit").val(courseInfo.courseTeacherPri);
					}
				});
				$("#courseInfo_courseTime_edit").val(courseInfo.courseTime);
				$("#courseInfo_coursePlace_edit").val(courseInfo.coursePlace);
				$("#courseInfo_courseScore_edit").val(courseInfo.courseScore);
				$("#courseInfo_courseMemo_edit").val(courseInfo.courseMemo);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交课程信息信息表单给服务器端修改*/
function ajaxCourseInfoModify() {
	$.ajax({
		url :  basePath + "CourseInfo/" + $("#courseInfo_courseNumber_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#courseInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#courseInfoQueryForm").submit();
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
    courseInfoEdit("<%=request.getParameter("courseNumber")%>");
 })
 </script> 
</body>
</html>


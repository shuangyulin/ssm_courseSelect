<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.CourseInfo" %>
<%@ page import="com.chengxusheji.po.Teacher" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<CourseInfo> courseInfoList = (List<CourseInfo>)request.getAttribute("courseInfoList");
    //获取所有的courseTeacher信息
    List<Teacher> teacherList = (List<Teacher>)request.getAttribute("teacherList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String courseNumber = (String)request.getAttribute("courseNumber"); //课程编号查询关键字
    String courseName = (String)request.getAttribute("courseName"); //课程名称查询关键字
    Teacher courseTeacher = (Teacher)request.getAttribute("courseTeacher");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>课程信息查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#courseInfoListPanel" aria-controls="courseInfoListPanel" role="tab" data-toggle="tab">课程信息列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>CourseInfo/courseInfo_frontAdd.jsp" style="display:none;">添加课程信息</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="courseInfoListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>课程编号</td><td>课程名称</td><td>上课老师</td><td>上课时间</td><td>上课地点</td><td>课程学分</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<courseInfoList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		CourseInfo courseInfo = courseInfoList.get(i); //获取到课程信息对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=courseInfo.getCourseNumber() %></td>
 											<td><%=courseInfo.getCourseName() %></td>
 											<td><%=courseInfo.getCourseTeacher().getTeacherName() %></td>
 											<td><%=courseInfo.getCourseTime() %></td>
 											<td><%=courseInfo.getCoursePlace() %></td>
 											<td><%=courseInfo.getCourseScore() %></td>
 											<td>
 												<a href="<%=basePath  %>CourseInfo/<%=courseInfo.getCourseNumber() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="courseInfoEdit('<%=courseInfo.getCourseNumber() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="courseInfoDelete('<%=courseInfo.getCourseNumber() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>课程信息查询</h1>
		</div>
		<form name="courseInfoQueryForm" id="courseInfoQueryForm" action="<%=basePath %>CourseInfo/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="courseNumber">课程编号:</label>
				<input type="text" id="courseNumber" name="courseNumber" value="<%=courseNumber %>" class="form-control" placeholder="请输入课程编号">
			</div>






			<div class="form-group">
				<label for="courseName">课程名称:</label>
				<input type="text" id="courseName" name="courseName" value="<%=courseName %>" class="form-control" placeholder="请输入课程名称">
			</div>






            <div class="form-group">
            	<label for="courseTeacher_teacherNumber">上课老师：</label>
                <select id="courseTeacher_teacherNumber" name="courseTeacher.teacherNumber" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Teacher teacherTemp:teacherList) {
	 					String selected = "";
 					if(courseTeacher!=null && courseTeacher.getTeacherNumber()!=null && courseTeacher.getTeacherNumber().equals(teacherTemp.getTeacherNumber()))
 						selected = "selected";
	 				%>
 				 <option value="<%=teacherTemp.getTeacherNumber() %>" <%=selected %>><%=teacherTemp.getTeacherName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="courseInfoEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;课程信息信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#courseInfoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxCourseInfoModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.courseInfoQueryForm.currentPage.value = currentPage;
    document.courseInfoQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.courseInfoQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.courseInfoQueryForm.currentPage.value = pageValue;
    documentcourseInfoQueryForm.submit();
}

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
				$('#courseInfoEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除课程信息信息*/
function courseInfoDelete(courseNumber) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "CourseInfo/deletes",
			data : {
				courseNumbers : courseNumber,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#courseInfoQueryForm").submit();
					//location.href= basePath + "CourseInfo/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>


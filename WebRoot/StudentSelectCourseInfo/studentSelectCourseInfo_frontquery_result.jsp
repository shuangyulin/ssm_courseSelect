<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.StudentSelectCourseInfo" %>
<%@ page import="com.chengxusheji.po.CourseInfo" %>
<%@ page import="com.chengxusheji.po.Student" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<StudentSelectCourseInfo> studentSelectCourseInfoList = (List<StudentSelectCourseInfo>)request.getAttribute("studentSelectCourseInfoList");
    //获取所有的courseNumber信息
    List<CourseInfo> courseInfoList = (List<CourseInfo>)request.getAttribute("courseInfoList");
    //获取所有的studentNumber信息
    List<Student> studentList = (List<Student>)request.getAttribute("studentList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Student studentNumber = (Student)request.getAttribute("studentNumber");
    CourseInfo courseNumber = (CourseInfo)request.getAttribute("courseNumber");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>选课信息查询</title>
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
			    	<li role="presentation" class="active"><a href="#studentSelectCourseInfoListPanel" aria-controls="studentSelectCourseInfoListPanel" role="tab" data-toggle="tab">选课信息列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>StudentSelectCourseInfo/studentSelectCourseInfo_frontAdd.jsp" style="display:none;">添加选课信息</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="studentSelectCourseInfoListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>记录编号</td><td>学生对象</td><td>课程对象</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<studentSelectCourseInfoList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		StudentSelectCourseInfo studentSelectCourseInfo = studentSelectCourseInfoList.get(i); //获取到选课信息对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=studentSelectCourseInfo.getSelectId() %></td>
 											<td><%=studentSelectCourseInfo.getStudentNumber().getStudentName() %></td>
 											<td><%=studentSelectCourseInfo.getCourseNumber().getCourseName() %></td>
 											<td>
 												<a href="<%=basePath  %>StudentSelectCourseInfo/<%=studentSelectCourseInfo.getSelectId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="studentSelectCourseInfoEdit('<%=studentSelectCourseInfo.getSelectId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="studentSelectCourseInfoDelete('<%=studentSelectCourseInfo.getSelectId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>选课信息查询</h1>
		</div>
		<form name="studentSelectCourseInfoQueryForm" id="studentSelectCourseInfoQueryForm" action="<%=basePath %>StudentSelectCourseInfo/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="studentNumber_studentNumber">学生对象：</label>
                <select id="studentNumber_studentNumber" name="studentNumber.studentNumber" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Student studentTemp:studentList) {
	 					String selected = "";
 					if(studentNumber!=null && studentNumber.getStudentNumber()!=null && studentNumber.getStudentNumber().equals(studentTemp.getStudentNumber()))
 						selected = "selected";
	 				%>
 				 <option value="<%=studentTemp.getStudentNumber() %>" <%=selected %>><%=studentTemp.getStudentName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="courseNumber_courseNumber">课程对象：</label>
                <select id="courseNumber_courseNumber" name="courseNumber.courseNumber" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(CourseInfo courseInfoTemp:courseInfoList) {
	 					String selected = "";
 					if(courseNumber!=null && courseNumber.getCourseNumber()!=null && courseNumber.getCourseNumber().equals(courseInfoTemp.getCourseNumber()))
 						selected = "selected";
	 				%>
 				 <option value="<%=courseInfoTemp.getCourseNumber() %>" <%=selected %>><%=courseInfoTemp.getCourseName() %></option>
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
<div id="studentSelectCourseInfoEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;选课信息信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#studentSelectCourseInfoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxStudentSelectCourseInfoModify();">提交</button>
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
    document.studentSelectCourseInfoQueryForm.currentPage.value = currentPage;
    document.studentSelectCourseInfoQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.studentSelectCourseInfoQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.studentSelectCourseInfoQueryForm.currentPage.value = pageValue;
    documentstudentSelectCourseInfoQueryForm.submit();
}

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
				$('#studentSelectCourseInfoEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除选课信息信息*/
function studentSelectCourseInfoDelete(selectId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "StudentSelectCourseInfo/deletes",
			data : {
				selectIds : selectId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#studentSelectCourseInfoQueryForm").submit();
					//location.href= basePath + "StudentSelectCourseInfo/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>


<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.ScoreInfo" %>
<%@ page import="com.chengxusheji.po.CourseInfo" %>
<%@ page import="com.chengxusheji.po.Student" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<ScoreInfo> scoreInfoList = (List<ScoreInfo>)request.getAttribute("scoreInfoList");
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
<title>成绩信息查询</title>
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
			    	<li role="presentation" class="active"><a href="#scoreInfoListPanel" aria-controls="scoreInfoListPanel" role="tab" data-toggle="tab">成绩信息列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>ScoreInfo/scoreInfo_frontAdd.jsp" style="display:none;">添加成绩信息</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="scoreInfoListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>记录编号</td><td>学生对象</td><td>课程对象</td><td>成绩得分</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<scoreInfoList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		ScoreInfo scoreInfo = scoreInfoList.get(i); //获取到成绩信息对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=scoreInfo.getScoreId() %></td>
 											<td><%=scoreInfo.getStudentNumber().getStudentName() %></td>
 											<td><%=scoreInfo.getCourseNumber().getCourseName() %></td>
 											<td><%=scoreInfo.getScoreValue() %></td>
 											<td>
 												<a href="<%=basePath  %>ScoreInfo/<%=scoreInfo.getScoreId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="scoreInfoEdit('<%=scoreInfo.getScoreId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="scoreInfoDelete('<%=scoreInfo.getScoreId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>成绩信息查询</h1>
		</div>
		<form name="scoreInfoQueryForm" id="scoreInfoQueryForm" action="<%=basePath %>ScoreInfo/frontlist" class="mar_t15" method="post">
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
<div id="scoreInfoEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;成绩信息信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="scoreInfoEditForm" id="scoreInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="scoreInfo_scoreId_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="scoreInfo_scoreId_edit" name="scoreInfo.scoreId" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="scoreInfo_studentNumber_studentNumber_edit" class="col-md-3 text-right">学生对象:</label>
		  	 <div class="col-md-9">
			    <select id="scoreInfo_studentNumber_studentNumber_edit" name="scoreInfo.studentNumber.studentNumber" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="scoreInfo_courseNumber_courseNumber_edit" class="col-md-3 text-right">课程对象:</label>
		  	 <div class="col-md-9">
			    <select id="scoreInfo_courseNumber_courseNumber_edit" name="scoreInfo.courseNumber.courseNumber" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="scoreInfo_scoreValue_edit" class="col-md-3 text-right">成绩得分:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="scoreInfo_scoreValue_edit" name="scoreInfo.scoreValue" class="form-control" placeholder="请输入成绩得分">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="scoreInfo_studentEvaluate_edit" class="col-md-3 text-right">学生评价:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="scoreInfo_studentEvaluate_edit" name="scoreInfo.studentEvaluate" class="form-control" placeholder="请输入学生评价">
			 </div>
		  </div>
		</form> 
	    <style>#scoreInfoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxScoreInfoModify();">提交</button>
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
    document.scoreInfoQueryForm.currentPage.value = currentPage;
    document.scoreInfoQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.scoreInfoQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.scoreInfoQueryForm.currentPage.value = pageValue;
    documentscoreInfoQueryForm.submit();
}

/*弹出修改成绩信息界面并初始化数据*/
function scoreInfoEdit(scoreId) {
	$.ajax({
		url :  basePath + "ScoreInfo/" + scoreId + "/update",
		type : "get",
		dataType: "json",
		success : function (scoreInfo, response, status) {
			if (scoreInfo) {
				$("#scoreInfo_scoreId_edit").val(scoreInfo.scoreId);
				$.ajax({
					url: basePath + "Student/listAll",
					type: "get",
					success: function(students,response,status) { 
						$("#scoreInfo_studentNumber_studentNumber_edit").empty();
						var html="";
		        		$(students).each(function(i,student){
		        			html += "<option value='" + student.studentNumber + "'>" + student.studentName + "</option>";
		        		});
		        		$("#scoreInfo_studentNumber_studentNumber_edit").html(html);
		        		$("#scoreInfo_studentNumber_studentNumber_edit").val(scoreInfo.studentNumberPri);
					}
				});
				$.ajax({
					url: basePath + "CourseInfo/listAll",
					type: "get",
					success: function(courseInfos,response,status) { 
						$("#scoreInfo_courseNumber_courseNumber_edit").empty();
						var html="";
		        		$(courseInfos).each(function(i,courseInfo){
		        			html += "<option value='" + courseInfo.courseNumber + "'>" + courseInfo.courseName + "</option>";
		        		});
		        		$("#scoreInfo_courseNumber_courseNumber_edit").html(html);
		        		$("#scoreInfo_courseNumber_courseNumber_edit").val(scoreInfo.courseNumberPri);
					}
				});
				$("#scoreInfo_scoreValue_edit").val(scoreInfo.scoreValue);
				$("#scoreInfo_studentEvaluate_edit").val(scoreInfo.studentEvaluate);
				$('#scoreInfoEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除成绩信息信息*/
function scoreInfoDelete(scoreId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "ScoreInfo/deletes",
			data : {
				scoreIds : scoreId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#scoreInfoQueryForm").submit();
					//location.href= basePath + "ScoreInfo/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交成绩信息信息表单给服务器端修改*/
function ajaxScoreInfoModify() {
	$.ajax({
		url :  basePath + "ScoreInfo/" + $("#scoreInfo_scoreId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#scoreInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#scoreInfoQueryForm").submit();
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


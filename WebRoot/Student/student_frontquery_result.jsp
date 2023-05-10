<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Student" %>
<%@ page import="com.chengxusheji.po.ClassInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Student> studentList = (List<Student>)request.getAttribute("studentList");
    //获取所有的studentClassNumber信息
    List<ClassInfo> classInfoList = (List<ClassInfo>)request.getAttribute("classInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String studentNumber = (String)request.getAttribute("studentNumber"); //学号查询关键字
    String studentName = (String)request.getAttribute("studentName"); //姓名查询关键字
    ClassInfo studentClassNumber = (ClassInfo)request.getAttribute("studentClassNumber");
    String studentBirthday = (String)request.getAttribute("studentBirthday"); //出生日期查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>学生信息查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Student/frontlist">学生信息信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Student/student_frontAdd.jsp" style="display:none;">添加学生信息</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<studentList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Student student = studentList.get(i); //获取到学生信息对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Student/<%=student.getStudentNumber() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=student.getStudentPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		学号:<%=student.getStudentNumber() %>
			     	</div>
			     	<div class="field">
	            		姓名:<%=student.getStudentName() %>
			     	</div>
			     	<div class="field">
	            		性别:<%=student.getStudentSex() %>
			     	</div>
			     	<div class="field">
	            		所在班级:<%=student.getStudentClassNumber().getClassName() %>
			     	</div>
			     	<div class="field">
	            		出生日期:<%=student.getStudentBirthday() %>
			     	</div>
			     	<div class="field">
	            		政治面貌:<%=student.getStudentState() %>
			     	</div>
			     	<div class="field">
	            		联系电话:<%=student.getStudentTelephone() %>
			     	</div>
			     	<div class="field">
	            		学生邮箱:<%=student.getStudentEmail() %>
			     	</div>
			     	<div class="field">
	            		联系qq:<%=student.getStudentQQ() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Student/<%=student.getStudentNumber() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="studentEdit('<%=student.getStudentNumber() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="studentDelete('<%=student.getStudentNumber() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

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

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>学生信息查询</h1>
		</div>
		<form name="studentQueryForm" id="studentQueryForm" action="<%=basePath %>Student/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="studentNumber">学号:</label>
				<input type="text" id="studentNumber" name="studentNumber" value="<%=studentNumber %>" class="form-control" placeholder="请输入学号">
			</div>
			<div class="form-group">
				<label for="studentName">姓名:</label>
				<input type="text" id="studentName" name="studentName" value="<%=studentName %>" class="form-control" placeholder="请输入姓名">
			</div>
            <div class="form-group">
            	<label for="studentClassNumber_classNumber">所在班级：</label>
                <select id="studentClassNumber_classNumber" name="studentClassNumber.classNumber" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(ClassInfo classInfoTemp:classInfoList) {
	 					String selected = "";
 					if(studentClassNumber!=null && studentClassNumber.getClassNumber()!=null && studentClassNumber.getClassNumber().equals(classInfoTemp.getClassNumber()))
 						selected = "selected";
	 				%>
 				 <option value="<%=classInfoTemp.getClassNumber() %>" <%=selected %>><%=classInfoTemp.getClassName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="studentBirthday">出生日期:</label>
				<input type="text" id="studentBirthday" name="studentBirthday" class="form-control"  placeholder="请选择出生日期" value="<%=studentBirthday %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="studentEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;学生信息信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="studentEditForm" id="studentEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="student_studentNumber_edit" class="col-md-3 text-right">学号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="student_studentNumber_edit" name="student.studentNumber" class="form-control" placeholder="请输入学号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="student_studentName_edit" class="col-md-3 text-right">姓名:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="student_studentName_edit" name="student.studentName" class="form-control" placeholder="请输入姓名">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_studentPassword_edit" class="col-md-3 text-right">登录密码:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="student_studentPassword_edit" name="student.studentPassword" class="form-control" placeholder="请输入登录密码">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_studentSex_edit" class="col-md-3 text-right">性别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="student_studentSex_edit" name="student.studentSex" class="form-control" placeholder="请输入性别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_studentClassNumber_classNumber_edit" class="col-md-3 text-right">所在班级:</label>
		  	 <div class="col-md-9">
			    <select id="student_studentClassNumber_classNumber_edit" name="student.studentClassNumber.classNumber" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_studentBirthday_edit" class="col-md-3 text-right">出生日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date student_studentBirthday_edit col-md-12" data-link-field="student_studentBirthday_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="student_studentBirthday_edit" name="student.studentBirthday" size="16" type="text" value="" placeholder="请选择出生日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_studentState_edit" class="col-md-3 text-right">政治面貌:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="student_studentState_edit" name="student.studentState" class="form-control" placeholder="请输入政治面貌">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_studentPhoto_edit" class="col-md-3 text-right">学生照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="student_studentPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="student_studentPhoto" name="student.studentPhoto"/>
			    <input id="studentPhotoFile" name="studentPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_studentTelephone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="student_studentTelephone_edit" name="student.studentTelephone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_studentEmail_edit" class="col-md-3 text-right">学生邮箱:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="student_studentEmail_edit" name="student.studentEmail" class="form-control" placeholder="请输入学生邮箱">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_studentQQ_edit" class="col-md-3 text-right">联系qq:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="student_studentQQ_edit" name="student.studentQQ" class="form-control" placeholder="请输入联系qq">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_studentAddress_edit" class="col-md-3 text-right">家庭地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="student_studentAddress_edit" name="student.studentAddress" class="form-control" placeholder="请输入家庭地址">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="student_studentMemo_edit" class="col-md-3 text-right">附加信息:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="student_studentMemo_edit" name="student.studentMemo" class="form-control" placeholder="请输入附加信息">
			 </div>
		  </div>
		</form> 
	    <style>#studentEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxStudentModify();">提交</button>
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
    document.studentQueryForm.currentPage.value = currentPage;
    document.studentQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.studentQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.studentQueryForm.currentPage.value = pageValue;
    documentstudentQueryForm.submit();
}

/*弹出修改学生信息界面并初始化数据*/
function studentEdit(studentNumber) {
	$.ajax({
		url :  basePath + "Student/" + studentNumber + "/update",
		type : "get",
		dataType: "json",
		success : function (student, response, status) {
			if (student) {
				$("#student_studentNumber_edit").val(student.studentNumber);
				$("#student_studentName_edit").val(student.studentName);
				$("#student_studentPassword_edit").val(student.studentPassword);
				$("#student_studentSex_edit").val(student.studentSex);
				$.ajax({
					url: basePath + "ClassInfo/listAll",
					type: "get",
					success: function(classInfos,response,status) { 
						$("#student_studentClassNumber_classNumber_edit").empty();
						var html="";
		        		$(classInfos).each(function(i,classInfo){
		        			html += "<option value='" + classInfo.classNumber + "'>" + classInfo.className + "</option>";
		        		});
		        		$("#student_studentClassNumber_classNumber_edit").html(html);
		        		$("#student_studentClassNumber_classNumber_edit").val(student.studentClassNumberPri);
					}
				});
				$("#student_studentBirthday_edit").val(student.studentBirthday);
				$("#student_studentState_edit").val(student.studentState);
				$("#student_studentPhoto").val(student.studentPhoto);
				$("#student_studentPhotoImg").attr("src", basePath +　student.studentPhoto);
				$("#student_studentTelephone_edit").val(student.studentTelephone);
				$("#student_studentEmail_edit").val(student.studentEmail);
				$("#student_studentQQ_edit").val(student.studentQQ);
				$("#student_studentAddress_edit").val(student.studentAddress);
				$("#student_studentMemo_edit").val(student.studentMemo);
				$('#studentEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除学生信息信息*/
function studentDelete(studentNumber) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Student/deletes",
			data : {
				studentNumbers : studentNumber,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#studentQueryForm").submit();
					//location.href= basePath + "Student/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交学生信息信息表单给服务器端修改*/
function ajaxStudentModify() {
	$.ajax({
		url :  basePath + "Student/" + $("#student_studentNumber_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#studentEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#studentQueryForm").submit();
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

    /*出生日期组件*/
    $('.student_studentBirthday_edit').datetimepicker({
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
})
</script>
</body>
</html>


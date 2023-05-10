<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.CollegeInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<CollegeInfo> collegeInfoList = (List<CollegeInfo>)request.getAttribute("collegeInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>学院信息查询</title>
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
		<div class="col-md-12 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#collegeInfoListPanel" aria-controls="collegeInfoListPanel" role="tab" data-toggle="tab">学院信息列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>CollegeInfo/collegeInfo_frontAdd.jsp" style="display:none;">添加学院信息</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="collegeInfoListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>学院编号</td><td>学院名称</td><td>成立日期</td><td>院长姓名</td><td>联系电话</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<collegeInfoList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		CollegeInfo collegeInfo = collegeInfoList.get(i); //获取到学院信息对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=collegeInfo.getCollegeNumber() %></td>
 											<td><%=collegeInfo.getCollegeName() %></td>
 											<td><%=collegeInfo.getCollegeBirthDate() %></td>
 											<td><%=collegeInfo.getCollegeMan() %></td>
 											<td><%=collegeInfo.getCollegeTelephone() %></td>
 											<td>
 												<a href="<%=basePath  %>CollegeInfo/<%=collegeInfo.getCollegeNumber() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="collegeInfoEdit('<%=collegeInfo.getCollegeNumber() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="collegeInfoDelete('<%=collegeInfo.getCollegeNumber() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
	<div style="display:none;">
		<div class="page-header">
    		<h1>学院信息查询</h1>
		</div>
		<form name="collegeInfoQueryForm" id="collegeInfoQueryForm" action="<%=basePath %>CollegeInfo/frontlist" class="mar_t15" method="post">
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="collegeInfoEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;学院信息信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
                <div class="input-group date collegeInfo_collegeBirthDate_edit col-md-12" data-link-field="collegeInfo_collegeBirthDate_edit"  data-link-format="yyyy-mm-dd">
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
		</form> 
	    <style>#collegeInfoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxCollegeInfoModify();">提交</button>
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
    document.collegeInfoQueryForm.currentPage.value = currentPage;
    document.collegeInfoQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.collegeInfoQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.collegeInfoQueryForm.currentPage.value = pageValue;
    documentcollegeInfoQueryForm.submit();
}

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
				$('#collegeInfoEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除学院信息信息*/
function collegeInfoDelete(collegeNumber) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "CollegeInfo/deletes",
			data : {
				collegeNumbers : collegeNumber,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#collegeInfoQueryForm").submit();
					//location.href= basePath + "CollegeInfo/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>


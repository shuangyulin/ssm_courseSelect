<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.SpecialFieldInfo" %>
<%@ page import="com.chengxusheji.po.CollegeInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<SpecialFieldInfo> specialFieldInfoList = (List<SpecialFieldInfo>)request.getAttribute("specialFieldInfoList");
    //获取所有的specialCollegeNumber信息
    List<CollegeInfo> collegeInfoList = (List<CollegeInfo>)request.getAttribute("collegeInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String specialFieldNumber = (String)request.getAttribute("specialFieldNumber"); //专业编号查询关键字
    String specialFieldName = (String)request.getAttribute("specialFieldName"); //专业名称查询关键字
    CollegeInfo specialCollegeNumber = (CollegeInfo)request.getAttribute("specialCollegeNumber");
    String specialBirthDate = (String)request.getAttribute("specialBirthDate"); //成立日期查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>专业信息查询</title>
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
			    	<li role="presentation" class="active"><a href="#specialFieldInfoListPanel" aria-controls="specialFieldInfoListPanel" role="tab" data-toggle="tab">专业信息列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>SpecialFieldInfo/specialFieldInfo_frontAdd.jsp" style="display:none;">添加专业信息</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="specialFieldInfoListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>专业编号</td><td>专业名称</td><td>所在学院</td><td>成立日期</td><td>联系人</td><td>联系电话</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<specialFieldInfoList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		SpecialFieldInfo specialFieldInfo = specialFieldInfoList.get(i); //获取到专业信息对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=specialFieldInfo.getSpecialFieldNumber() %></td>
 											<td><%=specialFieldInfo.getSpecialFieldName() %></td>
 											<td><%=specialFieldInfo.getSpecialCollegeNumber().getCollegeName() %></td>
 											<td><%=specialFieldInfo.getSpecialBirthDate() %></td>
 											<td><%=specialFieldInfo.getSpecialMan() %></td>
 											<td><%=specialFieldInfo.getSpecialTelephone() %></td>
 											<td>
 												<a href="<%=basePath  %>SpecialFieldInfo/<%=specialFieldInfo.getSpecialFieldNumber() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="specialFieldInfoEdit('<%=specialFieldInfo.getSpecialFieldNumber() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="specialFieldInfoDelete('<%=specialFieldInfo.getSpecialFieldNumber() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>专业信息查询</h1>
		</div>
		<form name="specialFieldInfoQueryForm" id="specialFieldInfoQueryForm" action="<%=basePath %>SpecialFieldInfo/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="specialFieldNumber">专业编号:</label>
				<input type="text" id="specialFieldNumber" name="specialFieldNumber" value="<%=specialFieldNumber %>" class="form-control" placeholder="请输入专业编号">
			</div>






			<div class="form-group">
				<label for="specialFieldName">专业名称:</label>
				<input type="text" id="specialFieldName" name="specialFieldName" value="<%=specialFieldName %>" class="form-control" placeholder="请输入专业名称">
			</div>






            <div class="form-group">
            	<label for="specialCollegeNumber_collegeNumber">所在学院：</label>
                <select id="specialCollegeNumber_collegeNumber" name="specialCollegeNumber.collegeNumber" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(CollegeInfo collegeInfoTemp:collegeInfoList) {
	 					String selected = "";
 					if(specialCollegeNumber!=null && specialCollegeNumber.getCollegeNumber()!=null && specialCollegeNumber.getCollegeNumber().equals(collegeInfoTemp.getCollegeNumber()))
 						selected = "selected";
	 				%>
 				 <option value="<%=collegeInfoTemp.getCollegeNumber() %>" <%=selected %>><%=collegeInfoTemp.getCollegeName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="specialBirthDate">成立日期:</label>
				<input type="text" id="specialBirthDate" name="specialBirthDate" class="form-control"  placeholder="请选择成立日期" value="<%=specialBirthDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="specialFieldInfoEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;专业信息信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
                <div class="input-group date specialFieldInfo_specialBirthDate_edit col-md-12" data-link-field="specialFieldInfo_specialBirthDate_edit"  data-link-format="yyyy-mm-dd">
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
		</form> 
	    <style>#specialFieldInfoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxSpecialFieldInfoModify();">提交</button>
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
    document.specialFieldInfoQueryForm.currentPage.value = currentPage;
    document.specialFieldInfoQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.specialFieldInfoQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.specialFieldInfoQueryForm.currentPage.value = pageValue;
    documentspecialFieldInfoQueryForm.submit();
}

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
				$('#specialFieldInfoEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除专业信息信息*/
function specialFieldInfoDelete(specialFieldNumber) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "SpecialFieldInfo/deletes",
			data : {
				specialFieldNumbers : specialFieldNumber,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#specialFieldInfoQueryForm").submit();
					//location.href= basePath + "SpecialFieldInfo/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>


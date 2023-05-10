var courseInfo_manage_tool = null; 
$(function () { 
	initCourseInfoManageTool(); //建立CourseInfo管理对象
	courseInfo_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#courseInfo_manage").datagrid({
		url : 'CourseInfo/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "courseNumber",
		sortOrder : "desc",
		toolbar : "#courseInfo_manage_tool",
		columns : [[
			{
				field : "courseNumber",
				title : "课程编号",
				width : 140,
			},
			{
				field : "courseName",
				title : "课程名称",
				width : 140,
			},
			{
				field : "courseTeacher",
				title : "上课老师",
				width : 140,
			},
			{
				field : "courseTime",
				title : "上课时间",
				width : 140,
			},
			{
				field : "coursePlace",
				title : "上课地点",
				width : 140,
			},
			{
				field : "courseScore",
				title : "课程学分",
				width : 70,
			},
		]],
	});

	$("#courseInfoEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#courseInfoEditForm").form("validate")) {
					//验证表单 
					if(!$("#courseInfoEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#courseInfoEditForm").form({
						    url:"CourseInfo/" + $("#courseInfo_courseNumber_edit").val() + "/update",
						    onSubmit: function(){
								if($("#courseInfoEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#courseInfoEditDiv").dialog("close");
			                        courseInfo_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#courseInfoEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#courseInfoEditDiv").dialog("close");
				$("#courseInfoEditForm").form("reset"); 
			},
		}],
	});
});

function initCourseInfoManageTool() {
	courseInfo_manage_tool = {
		init: function() {
			$.ajax({
				url : "Teacher/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#courseTeacher_teacherNumber_query").combobox({ 
					    valueField:"teacherNumber",
					    textField:"teacherName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{teacherNumber:"",teacherName:"不限制"});
					$("#courseTeacher_teacherNumber_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#courseInfo_manage").datagrid("reload");
		},
		redo : function () {
			$("#courseInfo_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#courseInfo_manage").datagrid("options").queryParams;
			queryParams["courseNumber"] = $("#courseNumber").val();
			queryParams["courseName"] = $("#courseName").val();
			queryParams["courseTeacher.teacherNumber"] = $("#courseTeacher_teacherNumber_query").combobox("getValue");
			$("#courseInfo_manage").datagrid("options").queryParams=queryParams; 
			$("#courseInfo_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#courseInfoQueryForm").form({
			    url:"CourseInfo/OutToExcel",
			});
			//提交表单
			$("#courseInfoQueryForm").submit();
		},
		remove : function () {
			var rows = $("#courseInfo_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var courseNumbers = [];
						for (var i = 0; i < rows.length; i ++) {
							courseNumbers.push(rows[i].courseNumber);
						}
						$.ajax({
							type : "POST",
							url : "CourseInfo/deletes",
							data : {
								courseNumbers : courseNumbers.join(","),
							},
							beforeSend : function () {
								$("#courseInfo_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#courseInfo_manage").datagrid("loaded");
									$("#courseInfo_manage").datagrid("load");
									$("#courseInfo_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#courseInfo_manage").datagrid("loaded");
									$("#courseInfo_manage").datagrid("load");
									$("#courseInfo_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#courseInfo_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "CourseInfo/" + rows[0].courseNumber +  "/update",
					type : "get",
					data : {
						//courseNumber : rows[0].courseNumber,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (courseInfo, response, status) {
						$.messager.progress("close");
						if (courseInfo) { 
							$("#courseInfoEditDiv").dialog("open");
							$("#courseInfo_courseNumber_edit").val(courseInfo.courseNumber);
							$("#courseInfo_courseNumber_edit").validatebox({
								required : true,
								missingMessage : "请输入课程编号",
								editable: false
							});
							$("#courseInfo_courseName_edit").val(courseInfo.courseName);
							$("#courseInfo_courseName_edit").validatebox({
								required : true,
								missingMessage : "请输入课程名称",
							});
							$("#courseInfo_courseTeacher_teacherNumber_edit").combobox({
								url:"Teacher/listAll",
							    valueField:"teacherNumber",
							    textField:"teacherName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#courseInfo_courseTeacher_teacherNumber_edit").combobox("select", courseInfo.courseTeacherPri);
									//var data = $("#courseInfo_courseTeacher_teacherNumber_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#courseInfo_courseTeacher_teacherNumber_edit").combobox("select", data[0].teacherNumber);
						            //}
								}
							});
							$("#courseInfo_courseTime_edit").val(courseInfo.courseTime);
							$("#courseInfo_coursePlace_edit").val(courseInfo.coursePlace);
							$("#courseInfo_courseScore_edit").val(courseInfo.courseScore);
							$("#courseInfo_courseScore_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入课程学分",
								invalidMessage : "课程学分输入不对",
							});
							$("#courseInfo_courseMemo_edit").val(courseInfo.courseMemo);
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}

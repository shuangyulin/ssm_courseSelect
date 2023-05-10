var studentSelectCourseInfo_manage_tool = null; 
$(function () { 
	initStudentSelectCourseInfoManageTool(); //建立StudentSelectCourseInfo管理对象
	studentSelectCourseInfo_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#studentSelectCourseInfo_manage").datagrid({
		url : 'StudentSelectCourseInfo/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "selectId",
		sortOrder : "desc",
		toolbar : "#studentSelectCourseInfo_manage_tool",
		columns : [[
			{
				field : "selectId",
				title : "记录编号",
				width : 70,
			},
			{
				field : "studentNumber",
				title : "学生对象",
				width : 140,
			},
			{
				field : "courseNumber",
				title : "课程对象",
				width : 140,
			},
		]],
	});

	$("#studentSelectCourseInfoEditDiv").dialog({
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
				if ($("#studentSelectCourseInfoEditForm").form("validate")) {
					//验证表单 
					if(!$("#studentSelectCourseInfoEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#studentSelectCourseInfoEditForm").form({
						    url:"StudentSelectCourseInfo/" + $("#studentSelectCourseInfo_selectId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#studentSelectCourseInfoEditForm").form("validate"))  {
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
			                        $("#studentSelectCourseInfoEditDiv").dialog("close");
			                        studentSelectCourseInfo_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#studentSelectCourseInfoEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#studentSelectCourseInfoEditDiv").dialog("close");
				$("#studentSelectCourseInfoEditForm").form("reset"); 
			},
		}],
	});
});

function initStudentSelectCourseInfoManageTool() {
	studentSelectCourseInfo_manage_tool = {
		init: function() {
			$.ajax({
				url : "Student/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#studentNumber_studentNumber_query").combobox({ 
					    valueField:"studentNumber",
					    textField:"studentName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{studentNumber:"",studentName:"不限制"});
					$("#studentNumber_studentNumber_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "CourseInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#courseNumber_courseNumber_query").combobox({ 
					    valueField:"courseNumber",
					    textField:"courseName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{courseNumber:"",courseName:"不限制"});
					$("#courseNumber_courseNumber_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#studentSelectCourseInfo_manage").datagrid("reload");
		},
		redo : function () {
			$("#studentSelectCourseInfo_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#studentSelectCourseInfo_manage").datagrid("options").queryParams;
			queryParams["studentNumber.studentNumber"] = $("#studentNumber_studentNumber_query").combobox("getValue");
			queryParams["courseNumber.courseNumber"] = $("#courseNumber_courseNumber_query").combobox("getValue");
			$("#studentSelectCourseInfo_manage").datagrid("options").queryParams=queryParams; 
			$("#studentSelectCourseInfo_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#studentSelectCourseInfoQueryForm").form({
			    url:"StudentSelectCourseInfo/OutToExcel",
			});
			//提交表单
			$("#studentSelectCourseInfoQueryForm").submit();
		},
		remove : function () {
			var rows = $("#studentSelectCourseInfo_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var selectIds = [];
						for (var i = 0; i < rows.length; i ++) {
							selectIds.push(rows[i].selectId);
						}
						$.ajax({
							type : "POST",
							url : "StudentSelectCourseInfo/deletes",
							data : {
								selectIds : selectIds.join(","),
							},
							beforeSend : function () {
								$("#studentSelectCourseInfo_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#studentSelectCourseInfo_manage").datagrid("loaded");
									$("#studentSelectCourseInfo_manage").datagrid("load");
									$("#studentSelectCourseInfo_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#studentSelectCourseInfo_manage").datagrid("loaded");
									$("#studentSelectCourseInfo_manage").datagrid("load");
									$("#studentSelectCourseInfo_manage").datagrid("unselectAll");
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
			var rows = $("#studentSelectCourseInfo_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "StudentSelectCourseInfo/" + rows[0].selectId +  "/update",
					type : "get",
					data : {
						//selectId : rows[0].selectId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (studentSelectCourseInfo, response, status) {
						$.messager.progress("close");
						if (studentSelectCourseInfo) { 
							$("#studentSelectCourseInfoEditDiv").dialog("open");
							$("#studentSelectCourseInfo_selectId_edit").val(studentSelectCourseInfo.selectId);
							$("#studentSelectCourseInfo_selectId_edit").validatebox({
								required : true,
								missingMessage : "请输入记录编号",
								editable: false
							});
							$("#studentSelectCourseInfo_studentNumber_studentNumber_edit").combobox({
								url:"Student/listAll",
							    valueField:"studentNumber",
							    textField:"studentName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#studentSelectCourseInfo_studentNumber_studentNumber_edit").combobox("select", studentSelectCourseInfo.studentNumberPri);
									//var data = $("#studentSelectCourseInfo_studentNumber_studentNumber_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#studentSelectCourseInfo_studentNumber_studentNumber_edit").combobox("select", data[0].studentNumber);
						            //}
								}
							});
							$("#studentSelectCourseInfo_courseNumber_courseNumber_edit").combobox({
								url:"CourseInfo/listAll",
							    valueField:"courseNumber",
							    textField:"courseName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#studentSelectCourseInfo_courseNumber_courseNumber_edit").combobox("select", studentSelectCourseInfo.courseNumberPri);
									//var data = $("#studentSelectCourseInfo_courseNumber_courseNumber_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#studentSelectCourseInfo_courseNumber_courseNumber_edit").combobox("select", data[0].courseNumber);
						            //}
								}
							});
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

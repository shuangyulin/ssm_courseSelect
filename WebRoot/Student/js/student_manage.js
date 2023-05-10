var student_manage_tool = null; 
$(function () { 
	initStudentManageTool(); //建立Student管理对象
	student_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#student_manage").datagrid({
		url : 'Student/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "studentNumber",
		sortOrder : "desc",
		toolbar : "#student_manage_tool",
		columns : [[
			{
				field : "studentNumber",
				title : "学号",
				width : 140,
			},
			{
				field : "studentName",
				title : "姓名",
				width : 140,
			},
			{
				field : "studentSex",
				title : "性别",
				width : 140,
			},
			{
				field : "studentClassNumber",
				title : "所在班级",
				width : 140,
			},
			{
				field : "studentBirthday",
				title : "出生日期",
				width : 140,
			},
			{
				field : "studentState",
				title : "政治面貌",
				width : 140,
			},
			{
				field : "studentPhoto",
				title : "学生照片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "studentTelephone",
				title : "联系电话",
				width : 140,
			},
			{
				field : "studentEmail",
				title : "学生邮箱",
				width : 140,
			},
			{
				field : "studentQQ",
				title : "联系qq",
				width : 140,
			},
		]],
	});

	$("#studentEditDiv").dialog({
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
				if ($("#studentEditForm").form("validate")) {
					//验证表单 
					if(!$("#studentEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#studentEditForm").form({
						    url:"Student/" + $("#student_studentNumber_edit").val() + "/update",
						    onSubmit: function(){
								if($("#studentEditForm").form("validate"))  {
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
			                        $("#studentEditDiv").dialog("close");
			                        student_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#studentEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#studentEditDiv").dialog("close");
				$("#studentEditForm").form("reset"); 
			},
		}],
	});
});

function initStudentManageTool() {
	student_manage_tool = {
		init: function() {
			$.ajax({
				url : "ClassInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#studentClassNumber_classNumber_query").combobox({ 
					    valueField:"classNumber",
					    textField:"className",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{classNumber:"",className:"不限制"});
					$("#studentClassNumber_classNumber_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#student_manage").datagrid("reload");
		},
		redo : function () {
			$("#student_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#student_manage").datagrid("options").queryParams;
			queryParams["studentNumber"] = $("#studentNumber").val();
			queryParams["studentName"] = $("#studentName").val();
			queryParams["studentClassNumber.classNumber"] = $("#studentClassNumber_classNumber_query").combobox("getValue");
			queryParams["studentBirthday"] = $("#studentBirthday").datebox("getValue"); 
			$("#student_manage").datagrid("options").queryParams=queryParams; 
			$("#student_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#studentQueryForm").form({
			    url:"Student/OutToExcel",
			});
			//提交表单
			$("#studentQueryForm").submit();
		},
		remove : function () {
			var rows = $("#student_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var studentNumbers = [];
						for (var i = 0; i < rows.length; i ++) {
							studentNumbers.push(rows[i].studentNumber);
						}
						$.ajax({
							type : "POST",
							url : "Student/deletes",
							data : {
								studentNumbers : studentNumbers.join(","),
							},
							beforeSend : function () {
								$("#student_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#student_manage").datagrid("loaded");
									$("#student_manage").datagrid("load");
									$("#student_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#student_manage").datagrid("loaded");
									$("#student_manage").datagrid("load");
									$("#student_manage").datagrid("unselectAll");
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
			var rows = $("#student_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Student/" + rows[0].studentNumber +  "/update",
					type : "get",
					data : {
						//studentNumber : rows[0].studentNumber,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (student, response, status) {
						$.messager.progress("close");
						if (student) { 
							$("#studentEditDiv").dialog("open");
							$("#student_studentNumber_edit").val(student.studentNumber);
							$("#student_studentNumber_edit").validatebox({
								required : true,
								missingMessage : "请输入学号",
								editable: false
							});
							$("#student_studentName_edit").val(student.studentName);
							$("#student_studentName_edit").validatebox({
								required : true,
								missingMessage : "请输入姓名",
							});
							$("#student_studentPassword_edit").val(student.studentPassword);
							$("#student_studentPassword_edit").validatebox({
								required : true,
								missingMessage : "请输入登录密码",
							});
							$("#student_studentSex_edit").val(student.studentSex);
							$("#student_studentSex_edit").validatebox({
								required : true,
								missingMessage : "请输入性别",
							});
							$("#student_studentClassNumber_classNumber_edit").combobox({
								url:"ClassInfo/listAll",
							    valueField:"classNumber",
							    textField:"className",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#student_studentClassNumber_classNumber_edit").combobox("select", student.studentClassNumberPri);
									//var data = $("#student_studentClassNumber_classNumber_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#student_studentClassNumber_classNumber_edit").combobox("select", data[0].classNumber);
						            //}
								}
							});
							$("#student_studentBirthday_edit").datebox({
								value: student.studentBirthday,
							    required: true,
							    showSeconds: true,
							});
							$("#student_studentState_edit").val(student.studentState);
							$("#student_studentPhoto").val(student.studentPhoto);
							$("#student_studentPhotoImg").attr("src", student.studentPhoto);
							$("#student_studentTelephone_edit").val(student.studentTelephone);
							$("#student_studentEmail_edit").val(student.studentEmail);
							$("#student_studentQQ_edit").val(student.studentQQ);
							$("#student_studentAddress_edit").val(student.studentAddress);
							$("#student_studentMemo_edit").val(student.studentMemo);
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

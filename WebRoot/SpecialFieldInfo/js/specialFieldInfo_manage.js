var specialFieldInfo_manage_tool = null; 
$(function () { 
	initSpecialFieldInfoManageTool(); //建立SpecialFieldInfo管理对象
	specialFieldInfo_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#specialFieldInfo_manage").datagrid({
		url : 'SpecialFieldInfo/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "specialFieldNumber",
		sortOrder : "desc",
		toolbar : "#specialFieldInfo_manage_tool",
		columns : [[
			{
				field : "specialFieldNumber",
				title : "专业编号",
				width : 140,
			},
			{
				field : "specialFieldName",
				title : "专业名称",
				width : 140,
			},
			{
				field : "specialCollegeNumber",
				title : "所在学院",
				width : 140,
			},
			{
				field : "specialBirthDate",
				title : "成立日期",
				width : 140,
			},
			{
				field : "specialMan",
				title : "联系人",
				width : 140,
			},
			{
				field : "specialTelephone",
				title : "联系电话",
				width : 140,
			},
		]],
	});

	$("#specialFieldInfoEditDiv").dialog({
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
				if ($("#specialFieldInfoEditForm").form("validate")) {
					//验证表单 
					if(!$("#specialFieldInfoEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#specialFieldInfoEditForm").form({
						    url:"SpecialFieldInfo/" + $("#specialFieldInfo_specialFieldNumber_edit").val() + "/update",
						    onSubmit: function(){
								if($("#specialFieldInfoEditForm").form("validate"))  {
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
			                        $("#specialFieldInfoEditDiv").dialog("close");
			                        specialFieldInfo_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#specialFieldInfoEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#specialFieldInfoEditDiv").dialog("close");
				$("#specialFieldInfoEditForm").form("reset"); 
			},
		}],
	});
});

function initSpecialFieldInfoManageTool() {
	specialFieldInfo_manage_tool = {
		init: function() {
			$.ajax({
				url : "CollegeInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#specialCollegeNumber_collegeNumber_query").combobox({ 
					    valueField:"collegeNumber",
					    textField:"collegeName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{collegeNumber:"",collegeName:"不限制"});
					$("#specialCollegeNumber_collegeNumber_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#specialFieldInfo_manage").datagrid("reload");
		},
		redo : function () {
			$("#specialFieldInfo_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#specialFieldInfo_manage").datagrid("options").queryParams;
			queryParams["specialFieldNumber"] = $("#specialFieldNumber").val();
			queryParams["specialFieldName"] = $("#specialFieldName").val();
			queryParams["specialCollegeNumber.collegeNumber"] = $("#specialCollegeNumber_collegeNumber_query").combobox("getValue");
			queryParams["specialBirthDate"] = $("#specialBirthDate").datebox("getValue"); 
			$("#specialFieldInfo_manage").datagrid("options").queryParams=queryParams; 
			$("#specialFieldInfo_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#specialFieldInfoQueryForm").form({
			    url:"SpecialFieldInfo/OutToExcel",
			});
			//提交表单
			$("#specialFieldInfoQueryForm").submit();
		},
		remove : function () {
			var rows = $("#specialFieldInfo_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var specialFieldNumbers = [];
						for (var i = 0; i < rows.length; i ++) {
							specialFieldNumbers.push(rows[i].specialFieldNumber);
						}
						$.ajax({
							type : "POST",
							url : "SpecialFieldInfo/deletes",
							data : {
								specialFieldNumbers : specialFieldNumbers.join(","),
							},
							beforeSend : function () {
								$("#specialFieldInfo_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#specialFieldInfo_manage").datagrid("loaded");
									$("#specialFieldInfo_manage").datagrid("load");
									$("#specialFieldInfo_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#specialFieldInfo_manage").datagrid("loaded");
									$("#specialFieldInfo_manage").datagrid("load");
									$("#specialFieldInfo_manage").datagrid("unselectAll");
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
			var rows = $("#specialFieldInfo_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "SpecialFieldInfo/" + rows[0].specialFieldNumber +  "/update",
					type : "get",
					data : {
						//specialFieldNumber : rows[0].specialFieldNumber,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (specialFieldInfo, response, status) {
						$.messager.progress("close");
						if (specialFieldInfo) { 
							$("#specialFieldInfoEditDiv").dialog("open");
							$("#specialFieldInfo_specialFieldNumber_edit").val(specialFieldInfo.specialFieldNumber);
							$("#specialFieldInfo_specialFieldNumber_edit").validatebox({
								required : true,
								missingMessage : "请输入专业编号",
								editable: false
							});
							$("#specialFieldInfo_specialFieldName_edit").val(specialFieldInfo.specialFieldName);
							$("#specialFieldInfo_specialFieldName_edit").validatebox({
								required : true,
								missingMessage : "请输入专业名称",
							});
							$("#specialFieldInfo_specialCollegeNumber_collegeNumber_edit").combobox({
								url:"CollegeInfo/listAll",
							    valueField:"collegeNumber",
							    textField:"collegeName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#specialFieldInfo_specialCollegeNumber_collegeNumber_edit").combobox("select", specialFieldInfo.specialCollegeNumberPri);
									//var data = $("#specialFieldInfo_specialCollegeNumber_collegeNumber_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#specialFieldInfo_specialCollegeNumber_collegeNumber_edit").combobox("select", data[0].collegeNumber);
						            //}
								}
							});
							$("#specialFieldInfo_specialBirthDate_edit").datebox({
								value: specialFieldInfo.specialBirthDate,
							    required: true,
							    showSeconds: true,
							});
							$("#specialFieldInfo_specialMan_edit").val(specialFieldInfo.specialMan);
							$("#specialFieldInfo_specialTelephone_edit").val(specialFieldInfo.specialTelephone);
							$("#specialFieldInfo_specialMemo_edit").val(specialFieldInfo.specialMemo);
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

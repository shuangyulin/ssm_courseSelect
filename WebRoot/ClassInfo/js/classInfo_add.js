$(function () {
	$("#classInfo_classNumber").validatebox({
		required : true, 
		missingMessage : '请输入班级编号',
	});

	$("#classInfo_className").validatebox({
		required : true, 
		missingMessage : '请输入班级名称',
	});

	$("#classInfo_classSpecialFieldNumber_specialFieldNumber").combobox({
	    url:'SpecialFieldInfo/listAll',
	    valueField: "specialFieldNumber",
	    textField: "specialFieldName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#classInfo_classSpecialFieldNumber_specialFieldNumber").combobox("getData"); 
            if (data.length > 0) {
                $("#classInfo_classSpecialFieldNumber_specialFieldNumber").combobox("select", data[0].specialFieldNumber);
            }
        }
	});
	$("#classInfo_classBirthDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#classInfoAddButton").click(function () {
		//验证表单 
		if(!$("#classInfoAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#classInfoAddForm").form({
			    url:"ClassInfo/add",
			    onSubmit: function(){
					if($("#classInfoAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#classInfoAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#classInfoAddForm").submit();
		}
	});

	//单击清空按钮
	$("#classInfoClearButton").click(function () { 
		$("#classInfoAddForm").form("clear"); 
	});
});

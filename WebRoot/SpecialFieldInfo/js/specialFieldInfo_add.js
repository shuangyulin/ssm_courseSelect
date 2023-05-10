$(function () {
	$("#specialFieldInfo_specialFieldNumber").validatebox({
		required : true, 
		missingMessage : '请输入专业编号',
	});

	$("#specialFieldInfo_specialFieldName").validatebox({
		required : true, 
		missingMessage : '请输入专业名称',
	});

	$("#specialFieldInfo_specialCollegeNumber_collegeNumber").combobox({
	    url:'CollegeInfo/listAll',
	    valueField: "collegeNumber",
	    textField: "collegeName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#specialFieldInfo_specialCollegeNumber_collegeNumber").combobox("getData"); 
            if (data.length > 0) {
                $("#specialFieldInfo_specialCollegeNumber_collegeNumber").combobox("select", data[0].collegeNumber);
            }
        }
	});
	$("#specialFieldInfo_specialBirthDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#specialFieldInfoAddButton").click(function () {
		//验证表单 
		if(!$("#specialFieldInfoAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#specialFieldInfoAddForm").form({
			    url:"SpecialFieldInfo/add",
			    onSubmit: function(){
					if($("#specialFieldInfoAddForm").form("validate"))  { 
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
                        $("#specialFieldInfoAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#specialFieldInfoAddForm").submit();
		}
	});

	//单击清空按钮
	$("#specialFieldInfoClearButton").click(function () { 
		$("#specialFieldInfoAddForm").form("clear"); 
	});
});

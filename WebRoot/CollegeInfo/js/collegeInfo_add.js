$(function () {
	$("#collegeInfo_collegeNumber").validatebox({
		required : true, 
		missingMessage : '请输入学院编号',
	});

	$("#collegeInfo_collegeName").validatebox({
		required : true, 
		missingMessage : '请输入学院名称',
	});

	$("#collegeInfo_collegeBirthDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#collegeInfoAddButton").click(function () {
		//验证表单 
		if(!$("#collegeInfoAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#collegeInfoAddForm").form({
			    url:"CollegeInfo/add",
			    onSubmit: function(){
					if($("#collegeInfoAddForm").form("validate"))  { 
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
                        $("#collegeInfoAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#collegeInfoAddForm").submit();
		}
	});

	//单击清空按钮
	$("#collegeInfoClearButton").click(function () { 
		$("#collegeInfoAddForm").form("clear"); 
	});
});

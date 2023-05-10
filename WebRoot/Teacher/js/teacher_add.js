$(function () {
	$("#teacher_teacherNumber").validatebox({
		required : true, 
		missingMessage : '请输入教师编号',
	});

	$("#teacher_teacherName").validatebox({
		required : true, 
		missingMessage : '请输入教师姓名',
	});

	$("#teacher_teacherSex").validatebox({
		required : true, 
		missingMessage : '请输入性别',
	});

	$("#teacher_teacherBirthday").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#teacher_teacherArriveDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#teacherAddButton").click(function () {
		//验证表单 
		if(!$("#teacherAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#teacherAddForm").form({
			    url:"Teacher/add",
			    onSubmit: function(){
					if($("#teacherAddForm").form("validate"))  { 
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
                        $("#teacherAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#teacherAddForm").submit();
		}
	});

	//单击清空按钮
	$("#teacherClearButton").click(function () { 
		$("#teacherAddForm").form("clear"); 
	});
});

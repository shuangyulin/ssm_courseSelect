$(function () {
	$.ajax({
		url : "CollegeInfo/" + $("#collegeInfo_collegeNumber_edit").val() + "/update",
		type : "get",
		data : {
			//collegeNumber : $("#collegeInfo_collegeNumber_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (collegeInfo, response, status) {
			$.messager.progress("close");
			if (collegeInfo) { 
				$("#collegeInfo_collegeNumber_edit").val(collegeInfo.collegeNumber);
				$("#collegeInfo_collegeNumber_edit").validatebox({
					required : true,
					missingMessage : "请输入学院编号",
					editable: false
				});
				$("#collegeInfo_collegeName_edit").val(collegeInfo.collegeName);
				$("#collegeInfo_collegeName_edit").validatebox({
					required : true,
					missingMessage : "请输入学院名称",
				});
				$("#collegeInfo_collegeBirthDate_edit").datebox({
					value: collegeInfo.collegeBirthDate,
					required: true,
					showSeconds: true,
				});
				$("#collegeInfo_collegeMan_edit").val(collegeInfo.collegeMan);
				$("#collegeInfo_collegeTelephone_edit").val(collegeInfo.collegeTelephone);
				$("#collegeInfo_collegeMemo_edit").val(collegeInfo.collegeMemo);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#collegeInfoModifyButton").click(function(){ 
		if ($("#collegeInfoEditForm").form("validate")) {
			$("#collegeInfoEditForm").form({
			    url:"CollegeInfo/" +  $("#collegeInfo_collegeNumber_edit").val() + "/update",
			    onSubmit: function(){
					if($("#collegeInfoEditForm").form("validate"))  {
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#collegeInfoEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});

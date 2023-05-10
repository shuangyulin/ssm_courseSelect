$(function () {
	$.ajax({
		url : "Teacher/" + $("#teacher_teacherNumber_edit").val() + "/update",
		type : "get",
		data : {
			//teacherNumber : $("#teacher_teacherNumber_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (teacher, response, status) {
			$.messager.progress("close");
			if (teacher) { 
				$("#teacher_teacherNumber_edit").val(teacher.teacherNumber);
				$("#teacher_teacherNumber_edit").validatebox({
					required : true,
					missingMessage : "请输入教师编号",
					editable: false
				});
				$("#teacher_teacherName_edit").val(teacher.teacherName);
				$("#teacher_teacherName_edit").validatebox({
					required : true,
					missingMessage : "请输入教师姓名",
				});
				$("#teacher_teacherPassword_edit").val(teacher.teacherPassword);
				$("#teacher_teacherSex_edit").val(teacher.teacherSex);
				$("#teacher_teacherSex_edit").validatebox({
					required : true,
					missingMessage : "请输入性别",
				});
				$("#teacher_teacherBirthday_edit").datebox({
					value: teacher.teacherBirthday,
					required: true,
					showSeconds: true,
				});
				$("#teacher_teacherArriveDate_edit").datebox({
					value: teacher.teacherArriveDate,
					required: true,
					showSeconds: true,
				});
				$("#teacher_teacherCardNumber_edit").val(teacher.teacherCardNumber);
				$("#teacher_teacherPhone_edit").val(teacher.teacherPhone);
				$("#teacher_teacherPhoto").val(teacher.teacherPhoto);
				$("#teacher_teacherPhotoImg").attr("src", teacher.teacherPhoto);
				$("#teacher_teacherAddress_edit").val(teacher.teacherAddress);
				$("#teacher_teacherMemo_edit").val(teacher.teacherMemo);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#teacherModifyButton").click(function(){ 
		if ($("#teacherEditForm").form("validate")) {
			$("#teacherEditForm").form({
			    url:"Teacher/" +  $("#teacher_teacherNumber_edit").val() + "/update",
			    onSubmit: function(){
					if($("#teacherEditForm").form("validate"))  {
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
			$("#teacherEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});

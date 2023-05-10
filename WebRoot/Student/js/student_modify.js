$(function () {
	$.ajax({
		url : "Student/" + $("#student_studentNumber_edit").val() + "/update",
		type : "get",
		data : {
			//studentNumber : $("#student_studentNumber_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (student, response, status) {
			$.messager.progress("close");
			if (student) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#studentModifyButton").click(function(){ 
		if ($("#studentEditForm").form("validate")) {
			$("#studentEditForm").form({
			    url:"Student/" +  $("#student_studentNumber_edit").val() + "/update",
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
			$("#studentEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});

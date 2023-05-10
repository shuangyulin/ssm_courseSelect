$(function () {
	$.ajax({
		url : "StudentSelectCourseInfo/" + $("#studentSelectCourseInfo_selectId_edit").val() + "/update",
		type : "get",
		data : {
			//selectId : $("#studentSelectCourseInfo_selectId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (studentSelectCourseInfo, response, status) {
			$.messager.progress("close");
			if (studentSelectCourseInfo) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#studentSelectCourseInfoModifyButton").click(function(){ 
		if ($("#studentSelectCourseInfoEditForm").form("validate")) {
			$("#studentSelectCourseInfoEditForm").form({
			    url:"StudentSelectCourseInfo/" +  $("#studentSelectCourseInfo_selectId_edit").val() + "/update",
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
			$("#studentSelectCourseInfoEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});

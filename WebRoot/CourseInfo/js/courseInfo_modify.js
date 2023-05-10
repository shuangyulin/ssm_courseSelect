$(function () {
	$.ajax({
		url : "CourseInfo/" + $("#courseInfo_courseNumber_edit").val() + "/update",
		type : "get",
		data : {
			//courseNumber : $("#courseInfo_courseNumber_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (courseInfo, response, status) {
			$.messager.progress("close");
			if (courseInfo) { 
				$("#courseInfo_courseNumber_edit").val(courseInfo.courseNumber);
				$("#courseInfo_courseNumber_edit").validatebox({
					required : true,
					missingMessage : "请输入课程编号",
					editable: false
				});
				$("#courseInfo_courseName_edit").val(courseInfo.courseName);
				$("#courseInfo_courseName_edit").validatebox({
					required : true,
					missingMessage : "请输入课程名称",
				});
				$("#courseInfo_courseTeacher_teacherNumber_edit").combobox({
					url:"Teacher/listAll",
					valueField:"teacherNumber",
					textField:"teacherName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#courseInfo_courseTeacher_teacherNumber_edit").combobox("select", courseInfo.courseTeacherPri);
						//var data = $("#courseInfo_courseTeacher_teacherNumber_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#courseInfo_courseTeacher_teacherNumber_edit").combobox("select", data[0].teacherNumber);
						//}
					}
				});
				$("#courseInfo_courseTime_edit").val(courseInfo.courseTime);
				$("#courseInfo_coursePlace_edit").val(courseInfo.coursePlace);
				$("#courseInfo_courseScore_edit").val(courseInfo.courseScore);
				$("#courseInfo_courseScore_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入课程学分",
					invalidMessage : "课程学分输入不对",
				});
				$("#courseInfo_courseMemo_edit").val(courseInfo.courseMemo);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#courseInfoModifyButton").click(function(){ 
		if ($("#courseInfoEditForm").form("validate")) {
			$("#courseInfoEditForm").form({
			    url:"CourseInfo/" +  $("#courseInfo_courseNumber_edit").val() + "/update",
			    onSubmit: function(){
					if($("#courseInfoEditForm").form("validate"))  {
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
			$("#courseInfoEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});

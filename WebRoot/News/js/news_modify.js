$(function () {
	$.ajax({
		url : "News/" + $("#news_newsId_edit").val() + "/update",
		type : "get",
		data : {
			//newsId : $("#news_newsId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (news, response, status) {
			$.messager.progress("close");
			if (news) { 
				$("#news_newsId_edit").val(news.newsId);
				$("#news_newsId_edit").validatebox({
					required : true,
					missingMessage : "请输入记录编号",
					editable: false
				});
				$("#news_newsTitle_edit").val(news.newsTitle);
				$("#news_newsTitle_edit").validatebox({
					required : true,
					missingMessage : "请输入新闻标题",
				});
				$("#news_newsContent_edit").val(news.newsContent);
				$("#news_newsContent_edit").validatebox({
					required : true,
					missingMessage : "请输入新闻内容",
				});
				$("#news_newsDate_edit").datebox({
					value: news.newsDate,
					required: true,
					showSeconds: true,
				});
				$("#news_newsPhoto").val(news.newsPhoto);
				$("#news_newsPhotoImg").attr("src", news.newsPhoto);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#newsModifyButton").click(function(){ 
		if ($("#newsEditForm").form("validate")) {
			$("#newsEditForm").form({
			    url:"News/" +  $("#news_newsId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#newsEditForm").form("validate"))  {
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
			$("#newsEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});

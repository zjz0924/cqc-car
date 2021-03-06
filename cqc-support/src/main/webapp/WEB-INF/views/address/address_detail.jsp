<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<input type="hidden" id="id" name="id" value="${facadeBean.id}"/>
	
	<div style="margin-top:15px;margin-left:20px;">
		<div class="data-row">
			<span class="title-span"><span class="req-span">*</span>地址：</span> 
			<input id="name" name="name" value="${facadeBean.name}" class="easyui-textbox">
			<span id="name_error" class="error-message"></span>
		</div>
		
		 <div style="text-align:center;margin-top:5px;" class="data-row">
			<a href="javascript:void(0);"  onclick="save()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
			<span id="exception_error" class="error-message"></span>
		</div>
	</div>
	
	<script type="text/javascript">
		function save(){
			var name = $("#name").textbox("getValue");
			
			if(isNull(name)){
				err("name_error", "地址必值");
				return false;
			}else{
				err("name_error", "");
			}
			
			$.ajax({
				url: "${ctx}/address/save",
				data: {
					name: name,
					id: $("#id").val()
				},
				success:function(data){
					if(data.success){
						closeDialog(data.msg);
					}else{
						if(data.data == "name"){
							err("name_error", data.msg);
						}else{
							err("exception_error", data.msg);
						}
					}
				}
			});
		}
		
		function err(id, message){
            $("#" + id).html(message);
        }
	</script>
	
	<style type="text/css">
		.data-row{
			height: 35px;
		}
	
		.title-span{
			font-weight: bold;
			display: inline-block;
			width: 80px;
		}
		
        .error-message{
            margin: 4px 0 0 5px;
            padding: 0;
            color: red;
        }
        
        .req-span{
        	font-weight: bold;
        	color: red;
        }
	</style>
	
</body>

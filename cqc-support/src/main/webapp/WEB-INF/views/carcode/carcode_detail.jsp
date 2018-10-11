<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<input type="hidden" id="id" name="id" value="${facadeBean.id}"/>
	
	<div style="margin-top:15px;margin-left:20px;">
		<div class="data-row">
			<span class="title-span"><span class="req-span">*</span>代码：</span> 
			<input id="code" name="code" value="${facadeBean.code}" class="easyui-textbox">
			<span id="code_error" class="error-message"></span>
		</div>
		
		<div class="data-row">
			<span class="title-span">备注：</span> 
			<input id="remark" name="remark" value="${facadeBean.remark}" class="easyui-textbox">
			<span id="code_error" class="error-message"></span>
		</div>
		
		 <div style="text-align:center;margin-top:5px;" class="data-row">
			<a href="javascript:void(0);"  onclick="save()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
			<span id="exception_error" class="error-message"></span>
		</div>
	</div>
	
	<script type="text/javascript">
		function save(){
			var code = $("#code").textbox("getValue");
			
			if(isNull(name)){
				err("code_error", "代码必值");
				return false;
			}else{
				err("code_error", "");
			}
			
			$.ajax({
				url: "${ctx}/carCode/save",
				data: {
					code: code,
					id: $("#id").val(),
					remark: $("#remark").val()
				},
				success:function(data){
					if(data.success){
						closeDialog(data.msg);
					}else{
						if(data.data == "code"){
							err("code_error", data.msg);
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

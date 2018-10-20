<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<input type="hidden" id="id" name="id" value="${facadeBean.id}"/>
	
	<div style="margin-top:15px;margin-left:20px;">
		<div class="data-row">
			<span class="title-span"><span class="req-span">*</span>名称：</span> 
			<input id="name" name="name" value="${facadeBean.name}" class="easyui-textbox">
			<span id="name_error" class="error-message"></span>
		</div>
		
		<div class="data-row">
			<span class="title-span"><span class="req-span">*</span>类型：</span> 
			<select id="type" name="type" class="easyui-combobox" data-options="panelHeight: 'auto'" style="width: 158px;">
				<option value="">请选择</option>
				<option value="1" <c:if test="${facadeBean.type == 1}">selected="selected"</c:if>>样件来源</option>
				<option value="2" <c:if test="${facadeBean.type == 2}">selected="selected"</c:if>>抽样原因</option>
				<option value="3" <c:if test="${facadeBean.type == 3}">selected="selected"</c:if>>费用出处</option>
			</select>
			<span id="type_error" class="error-message"></span>
		</div>
		
		<div class="data-row">
			<span class="title-span">备注：</span> 
			<input id="remark" name="remark" value="${facadeBean.remark}" class="easyui-textbox">
			<span id="remark_error" class="error-message"></span>
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
				err("name_error", "代码必值");
				return false;
			}else{
				err("name_error", "");
			}
			
			var type = $("#type").combobox('getValue')
			if(isNull(type)){
				err("type_error", "类型必选");
				return false;
			}else{
				err("type_error", "");
			}
			
			$.ajax({
				url: "${ctx}/reasonOption/save",
				data: {
					name: name,
					id: $("#id").val(),
					type: type,
					remark: $("#remark").val()
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

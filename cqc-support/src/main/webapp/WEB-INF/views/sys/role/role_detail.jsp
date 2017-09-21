<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<div style="margin-top:15px;margin-left:20px;">
		<c:if test="${type == 1}">
			<div class="info-div">
				<span class="title-span"><span class="req-span">*</span>${title}编码：</span> 
				<input id="e_code" name="e_code" value="${facade.code}" <c:if test="${not empty facade.id}">disabled</c:if> class="easyui-validatebox tb">
				<span id="code_error" class="error-message"></span>
			</div>
		</c:if>
		
		<div class="info-div">
			<span class="title-span"><span class="req-span">*</span>${title}名称： </span>
			<input id="e_name" name="e_name" value="${facade.name}" class="easyui-validatebox tb">
			<span id="name_error" class="error-message"></span>
		</div>
		
		<div class="info-div">
			<span class="title-span">上级角色组： </span>
			${parentGroup.name } 
		</div>
		
		<div class="info-div">
			<span class="title-span">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注： </span>
			<input type="text" id="e_desc" name="e_desc" value="${facade.desc}">
		</div>
		
		<div style="text-align:center;margin-top:5px;" class="info-div">
			<a href="javascript:void(0)"  onclick="save()" class="easyui-linkbutton" >保存</a>
			<span id="exception_error" class="error-message"></span>
		</div>
	</div>
	
	<script type="text/javascript">
		function save(){
			var name = $("#e_name").val();
			var code = $("#e_code").val();
			var type = "${type}";
			
			if(type == 1 && isNull(code)){
				err("code_error", "编码必填");
				return;
			}else{
				err("code_error", "");	
			}
			
			if(isNull(name)){
				err("name_error", "名称必填");
				return;
			}else{
				err("name_error", "");
			}
			
			$.ajax({
				url: "${ctx}/role/save?time=" + new Date(),
				data: {
					"name": name,
					"code": code,
					"desc": $("#e_desc").val(),
					"id": "${facade.id}",
					"parentid": "${parentGroup.id}",
					"type": type
				},
				success:function(data){
					if(data.success){
						window.parent.closeDialog(data.data, data.msg);
					}else{
						if(data.data == "name"){
							err("name_error", data.msg);
						}else if(data.data == "code"){
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
		.info-div{
			line-height: 35px;
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

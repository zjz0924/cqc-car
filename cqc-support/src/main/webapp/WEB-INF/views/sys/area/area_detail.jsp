<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<div style="margin-top:15px;margin-left:20px;">
		<div class="info-div">
			<span class="title-span">区域编码：</span> 
			<input id="e_code" name="e_code" value="${area.code}" <c:if test="${not empty id}">disabled</c:if> class="easyui-validatebox tb">
			<span id="code_error" class="error-message"></span>
		</div>
		
		<div class="info-div">
			<span class="title-span">区域名称： </span>
			<input id="e_name" name="e_name" value="${area.name}" class="easyui-validatebox tb">
			<span id="name_error" class="error-message"></span>
		</div>
		
		<div class="info-div">
			<span class="title-span">上级区域： </span>
			${parentArea.name } 
		</div>
		
		<div class="info-div">
			<span class="title-span">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注： </span>
			<input type="text" id="e_desc" name="e_desc" value="${area.desc}">
		</div>
		
		<div style="text-align:center;margin-top:5px;" class="info-div">
			<a href="javascript:void()"  onclick="save()" class="easyui-linkbutton" >保存</a>
			<span id="exception_error" class="error-message"></span>
		</div>
	</div>
	
	<script type="text/javascript">
		function save(){
			var name = $("#e_name").val();
			var code = $("#e_code").val();
			
			if(isNull(code)){
				err("code_error", "区域编码必填");
				return;
			}else{
				err("code_error", "");	
			}
			
			if(isNull(name)){
				err("name_error", "区域名称必填");
				return;
			}else{
				err("name_error", "");
			}
			
			$.ajax({
				url: "${ctx}/area/save?time=" + new Date(),
				data: {
					"text": name,
					"code": code,
					"desc": $("#e_desc").val(),
					"id": "${id}",
					"parentid": "${parentArea.id}"
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
	</style>

</body>

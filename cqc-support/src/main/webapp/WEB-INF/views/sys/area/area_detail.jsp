<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>
<%@include file="/page/NavPageBar.jsp"%>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@include file="../../common/source.jsp"%>
	
	<script type="text/javascript">
		function save(){
			var name = $("#name").val();
			var code = $("#code").val();
			
			if(isNull(code)){
				errorMsg("区域编码必填");	
				return;
			}
			
			if(isNull(name)){
				errorMsg("区域名称必填");	
				return;
			}
			
			$.ajax({
				url: "${ctx}/area/save?time=" + new Date(),
				data: {
					"text": name,
					"code": code,
					"desc": $("#desc").val(),
					"id": "${id}",
					"parentid": "${parentid}"
				},
				success:function(data){
					if(data.success){
						artDialog.data("currentNodeId", data.data);
						artDialog.data("result", data.msg);
						art.dialog.close();
					}else{
						errorMsg(data.msg);
					}
				}
			});
		}
	</script>
</head>

<body>
	<div style="margin-top:30px;margin-left:20px;">
		<p>区域编码： <input type="text" id="code" name="code" value="${area.code}" <c:if test="${not empty id}">disabled</c:if>></p>
		<p>区域名称： <input type="text" id="name" name="name" value="${area.name}"></p>
		<p>上级区域： ${parent.name } </p>
		<p>备注： <input type="text" id="desc" name="desc" value="${area.desc}"></p>
		
		<button onclick="save()">保存</button>
	</div>
	

</body>
</html>
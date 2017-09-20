<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>
	

<body>
	<div style="margin-top:15px;margin-left:20px;">
		<div class="info-div">
			<span class="title-span"><span class="req-span">*</span>机构编码：</span> 
			<input id="o_code" name="o_code" value="${org.code}" <c:if test="${not empty id}">disabled</c:if> class="easyui-validatebox tb">
			<span id="ocode_error" class="error-message"></span>
		</div>
		
		<div class="info-div">
			<span class="title-span"><span class="req-span">*</span>机构名称： </span>
			<input id="o_name" name="o_name" value="${org.name}" class="easyui-validatebox tb">
			<span id="oname_error" class="error-message"></span>
		</div>
		
		<div class="info-div">
			<span class="title-span">上级机构： </span>
			${parentOrg.name } 
		</div>
		
		<div>
			<span class="title-span"><span class="req-span">*</span>区&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;域： </span>
			<input id="oarea_id" >
			<span id="oarea_error" class="error-message"></span>
		</div>
		
		<div class="info-div">
			<span class="title-span">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注： </span>
			<input type="text" id="o_desc" name="o_desc" value="${area.desc}">
		</div>
		
		<div style="text-align:center;margin-top:5px;" class="info-div">
			<a href="javascript:void(0);"  onclick="save()" class="easyui-linkbutton" >保存</a>
			<span id="exception_error" class="error-message"></span>
		</div>
	</div>
	
	<script type="text/javascript">
		$(function(){
			$('#oarea_id').combotree({
			    url: '${ctx}/area/tree'
			});
			
			var areaid = "${areaid}";
			if(!isNull(areaid)){
				$('#oarea_id').combotree('setValue', {
					id: "${areaid}",
					text: "${areaname}"
				});
			}
		});
	
		function save(){
			var name = $("#o_name").val();
			var code = $("#o_code").val();
			var areaid = "";
			
			var tree = $('#oarea_id').combotree('tree');	
			var selecteNode = tree.tree('getSelected');
			if(!isNull(selecteNode)){
				areaid = selecteNode.id;
			}
			
			if(isNull(code)){
				err("ocode_error", "机构编码必填");
				return;
			}else{
				err("ocode_error", "");
			}
			
			if(isNull(name)){
				err("oname_error", "区域名称必填");	
				return;
			}else{
				err("oname_error", "");
			}
			
			if(isNull(areaid)){
				err("oarea_error", "区域必选");	
				return;
			}else{
				err("oarea_error", "");
			}
			
			$.ajax({
				url: "${ctx}/org/save?time=" + new Date(),
				data: {
					"text": name,
					"code": code,
					"desc": $("#o_desc").val(),
					"id": "${id}",
					"parentid": "${parentOrg.id}",
					"areaid": areaid
				},
				success:function(data){
					if(data.success){
						window.parent.closeDialog(data.data, data.msg);
					}else{
						if(data.data == "name"){
							err("oname_error", data.msg);
						}else if(data.data == "code"){
							err("ocode_error", data.msg);
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

<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>SGMW</title>
		<%@include file="../../common/source.jsp"%>
		<script src="${ctx}/resources/js/jquery.form.js"></script>
		
		<script type="text/javascript">
			//操作类型, 0: 新建修改  1：删除
			var orgOperation = "";
			var getOrgDataUrl = "${ctx}/org/tree";
			var svalue = "";
			var stype = ""; 
			
			$(function(){
				$('#orgTree').tree({
					method:'get',
					animate:true,
					dnd:true,
					lines: true,
				    url: getOrgDataUrl,
				    onBeforeDrop: function(target,source,point){
						var targetNode = $("#orgTree").tree('getNode', target);
						if(!isNull(targetNode.children)){
							// 已有相同名称的不能移动
							for(var i = 0; i < targetNode.children.length; i++){
								var node = targetNode.children[i];
								if(node.text == source.text){
									return false;
								}
							}
						}
						return true;
					},
					onDrop : function(target, source, point) { 
						var targetId = $("#orgTree").tree('getNode', target).id;
						
						$.ajax({
							url : "${ctx}/org/move",
							data : {
								id : source.id,
								parentid : targetId
							},
							success : function(data) {
								if (!data.success) {
									errorMsg(data.msg);
								} 
								orgOperation = source.id;
								$("#orgTree").tree("reload");
							}
						});
					},
					onSelect : function(node) {
						$.ajax({
							url : "${ctx}/org/info",
							data : {
								id : node.id
							},
							success : function(data) {
								$("#name_info").html(data.name);
								$("#desc_info").html(data.desc);
								$("#code_info").html(data.code);
								$("#addr_info").html(data.addr);
								
								var type = data.type;
								var typeName = "";
								if(type == 1){
									typeName = "通用五菱";
								}else if(type == 2){
									typeName = "供应商";
								}else if(type == 3){
									typeName = "实验室";
								}else if(type == 4){
									typeName = "其它";
								}
								$("#type_info").html(typeName);
								
								if (!isNull(data.area)) {
									$("#areaName_info").html(data.area.name);
								}else{
									$("#areaName_info").html("");
								}
								if (!isNull(data.parent)) {
									$("#parentName_info").html(data.parent.name);
								} else {
									$("#parentName_info").html("");
								}
							}
						});
					},
					onContextMenu : function(e, node) {
						e.preventDefault();
						$('#orgTree').tree('select', node.target);
	
						$('#orgTreeMenu').menu('show', {
							left : e.pageX,
							top : e.pageY
						})
					},
					onLoadSuccess : function(node, data) {
						if (orgOperation == 0 || isNull(orgOperation)) {
							// 删除后自动选中根节点
							$("#orgTree").tree("select", $("#orgTree").tree("getRoot").target);
						} else if (orgOperation > 0) {
							// 创建/编辑成功后自动选中该节点
							var node = $('#orgTree').tree('find', orgOperation);
							$("#orgTree").tree("select", node.target);
						}
					},
					onBeforeLoad: function(node, param){
						param.svalue = svalue;
						param.stype = stype;
					}
				});
				
				
				/* $('#orgSearchbox').searchbox({
				    searcher:function(value,name){
				    	svalue = value;
						stype = name;
						
						// 搜索时不选中任何
						if(isNull(value)){
							orgOperation = 0;
						}else{
							orgOperation = -1;
							$("#name_info").html("");
							$("#desc_info").html("");
							$("#code_info").html("");
							$("#parentName_info").html("");
							$("#areaName_info").html("");
						}
						
						$("#orgTree").tree("reload");
				    },
				    menu:'#searchMenu',
				    prompt:''
				}); */
			});
			
			function createUpdate(type){
				var id = "";
				var parentid = "";
				var selecteNode = $("#orgTree").tree("getSelected");
				if (type == 1) {
					parentid = selecteNode.id;
				} else {
					id = selecteNode.id;
					
					var parentNode = $("#orgTree").tree("getParent", selecteNode.target);
					if(isNull(parentNode)){
						errorMsg("不能编辑根节点");
						return false;
					}
				}
	
				$('#orgdialog').dialog({
					title : '机构信息',
					width : 400,
					height : 350,
					closed : false,
					cache : false,
					href : '${ctx}/org/detail?id=' + id + '&parentid=' + parentid,
					modal : true
				});
				$('#orgdialog').window('center');
			}
			
			// 关掉对话时回调
			function closeOrgDialog(id, result) {
				$('#orgdialog').dialog('close');
	
				// 创建/编辑成功
				if (!isNull(id)) {
					tipMsg(result);
					orgOperation = id;
				}
				$("#orgTree").tree("reload");
			}
			
			function remove() {
				$.messager.confirm('确认', '确定要删除此机构？删除后不可恢复?', function(r) {
					if (r) {
						var node = $("#orgTree").tree("getSelected");
						var parentNode = $("#orgTree").tree("getParent", node.target);
	
						if (parentNode == null) {
							errorMsg("不能删除根节点");
							return;
						}
	
						var children = $("#orgTree").tree("getChildren", node.target);
						if (!isNull(children)) {
							errorMsg("请先删除下级机构");
							return;
						}
	
						$.ajax({
							url : "${ctx}/org/delete",
							data : {
								id : node.id
							},
							success : function(data) {
								if (data.success) {
									orgOperation = 0;
									$("#orgTree").tree("reload");
									tipMsg(data.msg);
								} else {
									errorMsg(data.msg);
								}
							}
						});
					}
				});
			}
			
			function openImport(){
				$('#excelDialog').dialog('open');
				$('#excelDialog').window('center');
			}
			
			function importExcel() {
				$("#result").html("");
				
				var fileDir = $("#upfile").filebox("getValue");
				var suffix = fileDir.substr(fileDir.lastIndexOf("."));
				if ("" == fileDir) {
					$("#fileInfo").html("请选择要导入的Excel文件");
					return false;
				}
				if (".xls" != suffix && ".xlsx" != suffix) {
					$("#fileInfo").html("请选择Excel格式的文件导入！");
					return false;
				}
				
				$("#fileInfo").html("");
		
				$('#uploadForm').ajaxSubmit({
					url : '${ctx}/org/import',
					dataType : 'text',
					success : function(msg) {
						var data = eval('(' + msg + ')');
						$("#upfile").filebox("clear");
						$("#result").html(data.msg);
						window.location.reload();
					}
				});
			}
		</script>
		
		<style type="text/css">
			.table {
				table-layout: fixed;
				display: table;
			}
			
			.column {
				display: table-cell;
				vertical-align: top;
				margin: 0;
				padding: 0;
			}
			
			.info{
				line-height: 30px;
			}
			
			.info_title{
				display: inline-block;
				width: 80px;
				font-weight:bold;
				padding-right: 20px;
			}
		</style>
		
	</head>

	<body style="overflow-y: hidden;">
	    <div style="height: 20px;margin-left:20px;margin-top:5px;">
	    	<a href="${ctx}/org/export" class="easyui-linkbutton" data-options="iconCls:'icon-export'" style="width:80px">导出</a>&nbsp;&nbsp;
		   <%--  <a href="javascript:void(0)" onclick="openImport();" class="easyui-linkbutton" data-options="iconCls:'icon-import'" style="width:80px">导入</a>&nbsp;&nbsp;
		    <a href="${ctx}/resources/template/机构导入模板.xlsx" class="easyui-linkbutton" data-options="iconCls:'icon-large-smartart'" style="width:80px">模板</a> --%>
	    </div>
	    
		<div class="table" style="margin-top:10px;">
			<div class="column" style="line-height: 300px;height: 500px;width: 300px;border-right:1px dashed #e6e6e6;overflow-x:auto;overflow-y:auto;padding-top:10px;padding-left:10px;">
				<!-- <input id="orgSearchbox" style="width: 280px;"></input>
				<div id="searchMenu">
			        <div data-options="name:'name'">名称</div>
			        <div data-options="name:'code'">编码</div>
			    </div> -->
				<div style="margin-top:10px;margin-right: 10px;">
					<ul id="orgTree" name="orgTree"></ul>
				</div>
			</div>
			
			<div class="column" style="padding:10px 20px;font-size: 14px;width:80%;">
				<p style="font-size: 16px;margin-bottom: 10px;">机构信息</p>
				<div style="border: 1px dashed #e6e6e6;width: 100%;margin-bottom:5px;"></div>
				
				<div class="info">
					<span class="info_title">机构编码：</span>
					<span id="code_info"></span>
				</div>
				
				<div class="info">
					<span class="info_title">机构名称：</span>
					<span id="name_info"></span>
				</div>
				
				<div class="info">
					<span class="info_title">机构类型：</span>
					<span id="type_info"></span>
				</div>
				
				<div class="info">
					<span class="info_title">上级机构：</span>
					<span id="parentName_info"></span>
				</div>
				
				<div class="info">
					<span class="info_title">区&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;域：</span>
					<span id="areaName_info"></span>
				</div>
				
				<div class="info">
					<span class="info_title">地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址：</span>
					<span id="addr_info"></span>
				</div>
				
				<div class="info">
					<span class="info_title">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</span>
					<span id="desc_info"></span>
				</div>
			</div>
		</div>
		
		<div id="orgTreeMenu" class="easyui-menu" style="width:120px;">
			<div onclick="createUpdate(1)">添加</div>
			<div onclick="createUpdate(2)">编辑</div>
			<div onclick="remove()">删除</div>
		</div>
		
		<div id="orgdialog"></div>
		
		<!-- Excel 导入 -->
		<div id="excelDialog" class="easyui-dialog" title="机构导入" style="width: 300px; height: 200px; padding: 10px;" data-options="modal: true" closed="true">
			<form method="POST" enctype="multipart/form-data" id="uploadForm">
				<div>
					请选择要导入的文件（<span style="color: red;">只支持 Excel</span>）：
				</div>
				
				<div style="margin-top: 10px;">
					<input class="easyui-filebox" id="upfile" name="upfile" style="width: 90%" data-options="buttonText: '选择文件'">
					<p id="fileInfo" style="color:red;margin-top:5px;"></p>
				</div>
				
				<div style="margin-top: 15px;">
					<a href="javascript:void(0);" class="easyui-linkbutton" style="width: 90%" onclick="importExcel()">上传</a>
				</div>
				
				<div id="result" style="margin-top:5px;"></div>
			</form>
		</div>
		
	</body>
</html>
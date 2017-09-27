<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>SGMW</title>
		<%@include file="../../common/source.jsp"%>
		
		<script type="text/javascript">
			//操作类型, 0: 新建修改  1：删除
			var roleOpeartion = "";
			var getRoleDataUrl = "${ctx}/role/tree";
			var svalue = "";
			var stype = ""; 
			
			$(function(){
				$('#roleTree').tree({
					method:'get',
					animate:true,
					dnd:true,
					lines: true,
				    url: getRoleDataUrl + "?time=" + new Date(),
				    onBeforeDrop: function(target,source,point){
						var targetNode = $("#roleTree").tree('getNode', target);
						if(!isNull(targetNode.children)){
							for(var i = 0; i < targetNode.children.length; i++){
								var node = targetNode.children[i];
								if(node.text == source.text){
									return false;
								}
							}
						}
						
						// 不能移动角色组到角色下
						if(getRoleType(source.id) == 2 && getRoleType(targetNode.id) == 1){
							return false;
						}
						
						// 不能移动角色到角色下
						if(getRoleType(source.id) == 1 && getRoleType(targetNode.id) == 1){
							return false;
						}
						
						return true;
					},
					onDrop : function(target, source, point) { 
						var targetId = $("#roleTree").tree('getNode', target).id;
						
						$.ajax({
							url : "${ctx}/role/move?time=" + new Date(),
							data : {
								id : source.id,
								parentid : targetId
							},
							success : function(data) {
								if (!data.success) {
									errorMsg(data.msg);
								} 
								roleOpeartion = source.id;
								$("#roleTree").tree("reload");
							}
						});
					},
					onSelect : function(node) {
						var url;
						var type = getRoleType(node.id);
						
						if(type == 1){
							url = "${ctx}/role/roleInfo?time=" + new Date();
							$("#r_title").html("角色信息");
							$("#r_pname").html("角&nbsp;&nbsp;色&nbsp;&nbsp;组：");
							$("#code_div").show();
							
							// 显示操作权限
							$("#operationPermission").show();
						}else{
							url = "${ctx}/role/roleGroupInfo?time=" + new Date();
							$("#r_title").html("角色组信息");
							$("#code_div").hide();
							$("#r_pname").html("上&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;级：");
							
							// 显示操作权限
							$("#operationPermission").hide();
						}
						
						$.ajax({
							url : url,
							data : {
								id : node.id
							},
							success : function(data) {
								$("#name").html(data.name);
								$("#desc").html(data.desc);
								
								if(type == 1){
									$("#code").html(data.code);
									
									if (!isNull(data.group)) {
										$("#parentName").html(data.group.name);
									} else {
										$("#parentName").html("");
									}
								}else{
									if (!isNull(data.parent)) {
										$("#parentName").html(data.parent.name);
									} else {
										$("#parentName").html("");
									}
								}
								
								if(data.code == "super admin"){
									var roots = $('#operationPermission').tree('getRoots');//返回tree的所有根节点数组  
							        for ( var i = 0; i < roots.length; i++) {  
							            var node = $('#operationPermission').tree('find', roots[i].id);//查找节点  
							            $('#operationPermission').tree('check', node.target);//将得到的节点选中  
							        }  
								}
								
								
							}
						});
					},
					onContextMenu : function(e, node) {
						e.preventDefault();
						$('#roleTree').tree('select', node.target);
	
						$('#roleTreeMenu').menu('show', {
							left : e.pageX,
							top : e.pageY
						})
					},
					onLoadSuccess : function(node, data) {
						if (roleOpeartion == 0 || isNull(roleOpeartion)) {
							// 删除后自动选中根节点
							$("#roleTree").tree("select", $("#roleTree").tree("getRoot").target);
						} else if (isNaN(roleOpeartion)) {
							// 创建/编辑成功后自动选中该节点
							var node = $('#roleTree').tree('find', roleOpeartion);
							$("#roleTree").tree("select", node.target);
						}
					},
					onBeforeLoad: function(node, param){
						param.svalue = svalue;
						param.stype = stype;
					}
				});
	
				/* $('#searchbox').searchbox({
					searcher : function(value, name) {
						svalue = value;
						stype = name;
						
						// 搜索时不选中任何
						if(isNull(value)){
							roleOpeartion = 0;
						}else{
							roleOpeartion = -1;
							$("#name").html("");
							$("#desc").html("");
							$("#code").html("");
							$("#parentName").html("");
						}
						
						$("#roleTree").tree("reload");
					},
					menu : '#roleSearchMenu',
					prompt : ''
				}); */
				
				$('#operationTree').tree({
					method : 'get',
					lines : true,
					checkbox: true,
					url : "${ctx}/menu/getTreeData?time=" + new Date(),
					checkbox : function(node) {
						if (node.id == 0) {
							return false;
						}
						return true;
					}
				});

			});

			/*
			 * type: 1-添加     2-编辑 
			 * rtype: 1- 角色    2-角色组
			 */
			function createUpdateRole(type, rtype) {
				var id = "";
				var parentid = "";
				var selecteNode = $("#roleTree").tree("getSelected");
				var title;

				if (type == 1) {
					parentid = selecteNode.id;

					if (getRoleType(selecteNode.id) == 1) {
						errorMsg("角色下不能再添加角色或角色组");
						return false;
					}

					title = type == 1 ? "角色" : "角色组";
				} else {
					id = selecteNode.id;

					var parentNode = $("#roleTree").tree("getParent", selecteNode.target);
					if (isNull(parentNode)) {
						errorMsg("不能编辑根节点");
						return false;
					}

					if (getRoleType(selecteNode.id) == 1) {
						rtype = 1;
						title = "角色"
					} else {
						rtype = 2;
						title = "角色组";
					}
				}

				$('#roleDialog').dialog({
					title : title + '信息',
					width : 380,
					height : 250,
					closed : false,
					cache : false,
					href : '${ctx}/role/detail?id=' + id + '&parentid='
							+ parentid + "&type=" + rtype,
					modal : true
				});
				$('#roleDialog').window('center');
			}

			// 关掉对话时回调
			function closeRoleDialog(id, result) {
				$('#roleDialog').dialog('close');

				// 创建/编辑成功
				if (!isNull(id)) {
					tipMsg(result);
					roleOpeartion = id;
				}
				$("#roleTree").tree("reload");
			}

			function removeRole() {
				$.messager.confirm('确认', '确定要删除此角色或角色组？删除后不可恢复?', function(r) {
					if (r) {
						var node = $("#roleTree").tree("getSelected");
						var parentNode = $("#roleTree").tree("getParent", node.target);

						if (parentNode == null) {
							errorMsg("不能删除根节点");
							return;
						}

						var children = $("#roleTree").tree("getChildren", node.target);
						if (!isNull(children)) {
							errorMsg("请先删除下级区域");
							return;
						}

						$.ajax({
							url : "${ctx}/role/delete?time=" + new Date(),
							data : {
								id : node.id
							},
							success : function(data) {
								if (data.success) {
									roleOpeartion = 0;
									$("#roleTree").tree("reload");
									tipMsg(data.msg);
								} else {
									errorMsg(data.msg);
								}
							}
						});
					}
				});
			}

			function getRoleType(id) {
				if (id.indexOf("r") != -1) {
					return 1;
				} else {
					return 2;
				}
			}
			
			function saveOperationPermission(){
				var menuIds = "";
				var roleId = "";
				
				var roleNode = $("#roleTree").tree("getSelected");
				if(!isNull(roleNode)){
					roleId = roleNode.id.split("_")[1];
				}
				
				var menuNodes = $("#operationTree").tree("getChecked");
				if(!isNull(menuNodes)){
					for(var i = 0; i < menuNodes.length; i++){
						var obj = menuNodes[i];
						var children =$("#operationTree").tree("getChildren", obj.target);
						
						if(children == null || children.length < 1){
							menuIds += obj.id + ",";
						}
					}
				}
				
				$.ajax({
					url: "${ctx}/role/saveOperationPermission?time=" + new Date(),
					data: {
						roleId: roleId,
						menuIds: menuIds
					},
					success: function(data){
						if (data.success) {
							tipMsg(data.msg);
						} else {
							errorMsg(data.msg);
						}
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
			}
		</style>
	</head>
	
	<body>
	 	<div class="table">
	 		<div class="column" style="height: 600px;width: 25%;border-right:1px dashed #e6e6e6;overflow-x:auto;overflow-y:auto;padding-top:10px;padding-left:10px;">
				<!-- <input id="searchbox" name="searchbox" style="width: 280px;"></input>
				<div id="roleSearchMenu">
			        <div data-options="name:'name'">名称</div>
			        <div data-options="name:'code'">编码</div>
			    </div> -->
				
				<div style="margin-top:10px;margin-right: 10px;">
					<ul id="roleTree"></ul>
				</div>
			</div>
			
			<div class="column" style="padding:10px 20px;font-size: 14px;width:450px;border-right:1px dashed #e6e6e6;">
				<p style="font-size: 16px;margin-bottom: 10px;"><span id="r_title"></span></p>
				<div style="border: 1px dashed #e6e6e6;width: 100%;margin-bottom:5px;"></div>
			
				<div class="info" id="code_div">
					<span class="info_title">编&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：</span>
					<span id="code"></span>
				</div>
				
				<div class="info">
					<span class="info_title">名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：</span>
					<span id="name"></span>
				</div>
				
				<div class="info">
					<span class="info_title"><span id="r_pname"></span></span>
					<span id="parentName"></span>
				</div>
				
				<div class="info">
					<span class="info_title">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</span>
					<span id="desc"></span>
				</div>
			</div>
			
			
			<div class="column" style="padding:10px 20px;font-size: 14px;width:25%;border-right:1px dashed #e6e6e6;">
				<p style="font-size: 16px;margin-bottom: 10px;">操作权限</p>
				<div style="border: 1px dashed #e6e6e6;width: 100%;margin-bottom:5px;"></div>
				
				<div id="operationPermission">
					<ul id="operationTree"></ul>	
					
					<div style="margin-top:15px;">
						<a href="javascript:void(0)" onclick="saveOperationPermission()" class="easyui-linkbutton" data-options="iconCls:'icon-save'" style="width: 70px;">保存</a>
					</div>
				</div>
			</div>
			
			<div class="column" style="padding:10px 20px;font-size: 14px;width:25%;">
				<p style="font-size: 16px;margin-bottom: 10px;">数据权限</p>
				<div style="border: 1px dashed #e6e6e6;width: 100%;margin-bottom:5px;"></div>
				
			</div>
	 	</div>
	 	
	 	<div id="roleTreeMenu" class="easyui-menu" style="width:120px;">
			<div onclick="createUpdateRole(1, 1)">添加角色</div>
			<div onclick="createUpdateRole(1, 2)">添加角色组</div>
			<div onclick="createUpdateRole(2)">编辑</div>
			<div onclick="removeRole()">删除</div>
		</div>
		
		<div id="roleDialog"></div>
	</body>
</html>

<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<div class="table">
		<div class="column" style="height: 600px;width: 300px;border-right:1px dashed #e6e6e6;overflow-x:auto;overflow-y:auto;padding-top:20px;padding-left:10px;">
			<input id="searchbox" name="searchbox" style="width: 280px;"></input>
			<div id="searchMenu">
		        <div data-options="name:'name'">名称</div>
		        <div data-options="name:'code'">编码</div>
		    </div>
			
			<div style="margin-top:10px;margin-right: 10px;">
				<ul id="areaTree" name="areaTree"></ul>
			</div>
		</div>
		
		<div class="column" style="padding:10px 20px;">
			<p>区域信息</p>
		
			<div class="info">
				<span class="info_title">区域编码：</span>
				<span id="code"></span>
			</div>
			
			<div class="info">
				<span class="info_title">区域名称：</span>
				<span id="name"></span>
			</div>
			
			<div class="info">
				<span class="info_title">上级区域：</span>
				<span id="parentName"></span>
			</div>
			
			<div class="info">
				<span class="info_title">备注：</span>
				<span id="desc"></span>
			</div>
		</div>
	</div>
	
	<div id="treeMenu" class="easyui-menu" style="width:120px;">
		<div onclick="createUpdate(1)">添加</div>
		<div onclick="createUpdate(2)">编辑</div>
		<div onclick="remove()">删除</div>
	</div>
	
	<div id="dd"></div>
	
	<script type="text/javascript">
		//操作类型, 0: 新建修改  1：删除
		var operation = "";
		var getDataUrl = "${ctx}/area/tree";
		
		$(function () {
			$('#areaTree').tree({
				dnd: true,
				animate:true,
			    url: getDataUrl + "?time=" + new Date(),
			    onDrop: function(target,source,point){
			    	var targetId = $(target).tree('getNode', targetNode).id;
			    	$.ajax({
		        		url: "${ctx}/area/move?time=" + new Date(),
		        		data:{
		        			id: point.id,
		        			parentid: targetId
		        		},
		        		success:function(data){
	    					if(!data.success){
	    						errorMsg(data.msg);
	    					}else{
	    						operation = point.id;
	    						$("#areaTree").tree("reload");
	    					}
	    				}
		        	});
			    },
			    onSelect: function(node){
					 $.ajax({
						 url: "${ctx}/area/info?time="+ new Date(),
						 data: {
							 id: node.id
						 },
						 success: function(data){
							 $("#name").html(data.name);
							 $("#desc").html(data.desc);
							 $("#code").html(data.code);
							 
							 if(!isNull(data.area)){
								 $("#areaName").html(data.area.name);
							 }
							 if(!isNull(data.parent)){
								 $("#parentName").html(data.parent.name);
							 }else{
								 $("#parentName").html("");
							 }
						 }
					});
			    },
			    onContextMenu: function(e, node){
			    	e.preventDefault();
			    	$('#areaTree').tree('select', node.target);
			    	
					$('#treeMenu').menu('show', {
						left: e.pageX,
						top: e.pageY
					})
			    },
			    onLoadSuccess: function(node, data){
			    	if(operation == 0 || isNull(operation)){
	            		// 删除后自动选中根节点
	            		$("#areaTree").tree("select", $("#areaTree").tree("getRoot").target);
	            	}else if(operation > 0){
	            		// 创建/编辑成功后自动选中该节点
	            		 var node = $('#areaTree').tree('find', operation); 
	            		$("#areaTree").tree("select", node.target);
	            	}
			    }
			});
			
			$('#searchbox').searchbox({
			    searcher:function(value,name){
			    	$.ajax({
			    		url: getDataUrl + "?time=" + new Date(),
			    	    type: "post",
			    	    data: {
			    	    	"stype": name,
			    	    	"svalue": value
			    	    },
			    	    success: function(data){
			    	    	$('#areaTree').jstree(true).settings.core.data = data;
			    	    	refreshTree(-1);
					    	// 展开所有节点 
			                $('#areaTree').jstree('open_all');
					    	
					    	$("#name").html("");
							$("#desc").html("");
							$("#code").html("");
							$("#parentName").html("");
			    	    }
			    	});
			    },
			    menu:'#searchMenu',
			    prompt:''
			});
		});
		
		function createUpdate(type){
			var id = "";
			var parentid = "";
			if(type == 1){
				parentid = $("#areaTree").tree("getSelected").id;
			}else{
				id = $("#areaTree").tree("getSelected").id;
			}
			
			$('#dd').dialog({
			    title: '区域信息',
			    width: 800,
			    height: 500,
			    closed: false,
			    cache: false,
			    href: '${ctx}/area/detail?id=' + id + '&parentid='+ parentid,
			    modal: true
			});
			$('#dd').window('center');
		}
		
		// 关掉对话时回调
		function closeDialog(id, result){
			$('#dd').dialog('close');
			
			// 创建/编辑成功
			if(!isNull(id)){ 
				tipMsg(result);
				operation = id;
			}
			$("#areaTree").tree("reload");
		}
		
		function remove(){
			$.messager.confirm('确认','确定要删除此机构？删除后不可恢复?',function(r){
			    if (r){
			    	 var node = $("#areaTree").tree("getSelected");
			    	 var parentNode = $("#areaTree").tree("getParent", node.target);
			    	
			    	 if(parentNode == null){
                    	 errorMsg("不能删除根节点");
                    	 return;
                     } 
                     
			    	 var children = $("#areaTree").tree("getChildren", node.target);
                     if(!isNull(children)){
                    	 errorMsg("请先删除下级机构");
                    	 return;
                     }
                  
                     $.ajax({
                    	url: "${ctx}/area/delete?time=" + new Date(),
                    	data:{
                    		id: node.id
                    	},
        				success:function(data){
        					if(data.success){
        						operation = 0;
        						$("#areaTree").tree("reload");
        						tipMsg(data.msg);
        					}else{
        						errorMsg(data.msg);
        					}
        				}
                     });
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
	
</body>

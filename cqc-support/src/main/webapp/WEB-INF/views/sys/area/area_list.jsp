<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>
<%@include file="/page/NavPageBar.jsp"%>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@include file="../../common/source.jsp"%>
	
	<link rel="stylesheet" href="${ctx}/resources/js/jstree/themes/default/style.min.css" />
	<script src="${ctx}/resources/js/jstree/jstree.min.js"></script>
	
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
	
	<script type="text/javascript">
		//操作类型, 0: 新建修改  1：删除
		var operation = "";
		
		$(function () {
			$('#areaTree').jstree({
				core : {
			        'data' : {
			            'url' : "${ctx}/area/tree?time=" + new Date()
			        },
			        "check_callback" : true
			    },
			    "plugins" : [
	             	"contextmenu",
	             	"dnd",
	             	"unique",
	             	"changed"
	             ],
	             "contextmenu":{  
	                 "items":{  
	                     "create":{  
	                         "label":"新建",  
	                         "action":function(data){  
	                             var obj = jQuery.jstree.reference(data.reference).get_node(data.reference);  
	                             createUpdate("", obj.id);
	                         }  
	                     },  
	                     "edit":{  
	                         "label":"编辑",  
	                         "action":function(data){  
	                             var obj = jQuery.jstree.reference(data.reference).get_node(data.reference);  
	                             createUpdate(obj.id, obj.parent);
	                         }  
	                     },
	                     "delete":{  
	                         "label":"删除",  
	                         "action":function(data){  
	                             var obj = jQuery.jstree.reference(data.reference).get_node(data.reference);   
								 
	                             art.dialog.confirm("确定要删除此区域？删除后不可恢复.", function(){ 
	                                 if(obj.parent == "#"){
	                                	 errorMsg("不能删除根节点");
	                                	 return;
	                                 } 
	                                 
	                                 if(!isNull(obj.children)){
	                                	 errorMsg("请先删除下级区域");
	                                	 return;
		                             }
	                              
	                                 $.ajax({
	                                	url: "${ctx}/area/delete?time=" + new Date(),
	                                	data:{
	                                		id: obj.id
	                                	},
	                    				success:function(data){
	                    					if(data.success){
	                    						refreshTree(0); 
	                    						tipMsg(data.msg);
	                    					}else{
	                    						errorMsg(data.msg);
	                    					}
	                    				}
	                                 });
	                             });  
	                         }  
	                     } 
	                 }
	             }
			}).on('select_node.jstree',function(e,data){  //选择事件 
				 //当前选中节点的文本值
	             var id = data.instance.get_node(data.selected[0]).id;
				 
				 $.ajax({
					 url: "${ctx}/area/info?time="+ new Date(),
					 data: {
						 id: id
					 },
					 success: function(data){
						 $("#name").html(data.name);
						 $("#desc").html(data.desc);
						 $("#code").html(data.code);
						 if(!isNull(data.parent)){
							 $("#parentName").html(data.parent.name);
						 }else{
							 $("#parentName").html("");
						 }
					 }
				 });
	        }).on('move_node.jstree', function(e,data){  //移动后调用 
	        	$.ajax({
	        		url: "${ctx}/area/move?time=" + new Date(),
	        		data:{
	        			id: data.node.id,
	        			parentid: data.parent
	        		},
	        		success:function(data){
    					if(!data.success){
    						errorMsg(data.msg);
    					}
    				}
	        	});
	        }).on("loaded.jstree", function (event, data) {  //加载完调用 
                // 展开所有节点 
                $('#areaTree').jstree('open_all');
                // 默认选中根节点
                selectRootNode();
            }).on("refresh.jstree", function (event, data) {  //refresh完成后调用
            	if(operation != 0){
            		// 添加后自动展开父节点
            		$('#areaTree').jstree('open_all');
            		$('#areaTree').jstree('deselect_all');
            		$('#areaTree').jstree("select_node", operation);
            	}else{
            		// 删除后自动选中根节点
            		selectRootNode();
            	}
            	
            	adjustHeight();
            });
			
			adjustHeight();
		});
		
		function createUpdate(id, parentid){
			art.dialog.open('${ctx}/area/detail?id=' + id + '&parentid='+ parentid,{
				id: "detailDialog",
		    	padding: 0,
				width: 500,
				height: 300,
				resize: false,
				lock: true,
				close: function(){
					var id = art.dialog.data('currentNodeId');
					var result = art.dialog.data('result');
					
					if(!isNull(id)){ 
						refreshTree(id);
						tipMsg(result);
					}
				}
			});
		}
		
		// 刷新树
		function refreshTree(type) {
			operation = type;
			$('#areaTree').jstree().refresh();
		}
		
		// 选中根节点
		function selectRootNode(){
			$('#areaTree').jstree("select_node", "1");
		}
	</script>
</head>

<body>

	<div class="row">
		<div class="col-lg-12">
			<ol class="breadcrumb">
				<li>系统管理</li>
				<li><a href="${ctx}/area/list">区域管理</a></li>
			</ol>
		</div>
	</div>

	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2><span class="break"></span><strong>区域管理</strong></h2>
				</div>

				<div class="panel-body">
					<div class="table">
						<div id="areaTree" class="column" style="height: 500px;width: 300px;border-right:1px dashed #000;overflow-x:auto;overflow-y:auto;"></div>
						<div class="column" style="padding:10px 20px;">
							<p>区域信息</p>
							<a href="javscript:void(0)" onclick="selectRootNode()">refresh</a>
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
				</div>
			</div>
		</div>
		<!--/col-->
	</div>
	<!--/row-->
</body>
</html>
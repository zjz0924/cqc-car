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
		
	</style>
	
	<script type="text/javascript">
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
	             	"unique"
	             ],
	             "contextmenu":{  
	                 "items":{  
	                     "create":{  
	                         "label":"新建",  
	                         "action":function(data){  
	                             var obj = jQuery.jstree.reference(data.reference).get_node(data.reference);  
	                             createUpdate(null, obj.id);
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
	                             if(confirm("确定要删除此区域？删除后不可恢复。")){  
	                                 if(obj.parent == "#"){
	                                	 errorMsg("不能删除根节点");
	                                	 return;
	                                 } 
	                                 
	                                 $.ajax({
	                                	url: "${ctx}/area/delete?time=" + new Date(),
	                                	data:{
	                                		id: obj.id
	                                	},
	                    				success:function(data){
	                    					if(data.success){
	                    						tipMsg(data.msg, function(){
	                    							$("#areaTree").jstree("refresh");
	                    						});
	                    					}else{
	                    						errorMsg(data.msg);
	                    					}
	                    				}
	                                 });
	                             }  
	                         }  
	                     } 
	                 }
	             }
			}).on('changed.jstree',function(e,data){
					//当前选中节点的文本值
	             var name = data.instance.get_node(data.selected[0]).text;
				 var parentid = data.instance.get_node(data.selected[0]).parent;
				 var parentName = "";
				 
				 if(parentid != "#"){
					 var parentNode = $('#areaTree').jstree("get_node", data.instance.get_node(data.selected[0]).parent);
					 parentName = parentNode.text;
				 }
				 
				 $.ajax({
					 url: "${ctx}/area/info?time="+ new Date(),
					 data: {
						 id: parentid
					 },
					 success: function(data){
						 console.info(data);
					 }
				 });
				 
				 $("#name").html(name);
				 $("#parentName").html(parentName);
				 $("#desc").html(parentName);
	        }).on('move_node.jstree', function(e,data){
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
	        	})
	        });
			
			// 展开节点
            $("#areaTree").on("loaded.jstree", function (event, data) {
                // 展开所有节点
                $('#areaTree').jstree('open_all');
            });
			
			
			function createUpdate(parentid, id){
				art.dialog.open('${ctx}/area/detail?id=' + id + '&parentid='+ parentid,{
					id: "detailDialog",
			    	padding: 0,
					width: 500,
					height: 300,
					resize: true,
					lock: true
				});
			}
			
            window.parent.adapter(document.body.scrollHeight + 10);
		});
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
					
					<span style="float:right;padding-top:5px;">
						<button type="button" class="btn btn-primary btn-xs" onclick="goTo('detail')">添加</button>
					</span>
				</div>

				<div class="panel-body">
					<div class="table">
						<div id="areaTree" class="column" style="height: 500px;width: 300px;border-right:1px dashed #000;"></div>
						<div class="column" style="padding:10px 20px;">
							<p>区域信息</p>
							
							<div class="info">
								<span>名称</span>
								<span id="name"></span>
							</div>
							
							<div class="info">
								<span>父区域</span>
								<span id="parentName"></span>
							</div>
							
							<div class="info">
								<span>备注</span>
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
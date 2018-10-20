<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>SGMW</title>
		<%@include file="../common/source.jsp"%>
		
		<script type="text/javascript">
			var url = "${ctx}/reasonOption/getList";
			var detailUrl = "${ctx}/reasonOption/detail";
			var datagrid = "reasonOptionTable";
			
			var toolbar = [{
	            text:'新增',
	            iconCls:'icon-add',
	            handler: function(){
	            	info(detailUrl);	
	            }
	        }, '-',  {
	            text:'编辑',
	            iconCls:'icon-edit',
	            handler: function(){
	            	var row = $("#" + datagrid).datagrid('getSelected');
	            	if(isNull(row)){
	            		errorMsg("请选择一条记录进行操作!");
	            		return;
	            	}
	            	
	            	info(detailUrl + "?id=" + row.id);	
	            }
	        }, '-',  {
				text : '删除',
				iconCls : 'icon-cancel',
				handler : function() {
					var row = $("#" + datagrid).datagrid('getSelected');
	            	if(isNull(row)){
	            		errorMsg("请选择一条记录进行操作!");
	            		return;
	            	}
	            	
	            	 $.messager.confirm('系统提示', "此操作将删除该选项，您确定要继续吗？", function(r){
	                     if (r){
	                         $.ajax({
	                         	url: "${ctx}/reasonOption/delete",
	                         	data: {
	                         		id: row.id,
	                         	},
	                         	success: function(data){
	                         		if(data.success){
	                         			tipMsg(data.msg, function(){
	                						$('#' + datagrid).datagrid('reload');
	                					});
	                 				}else{
	                 					errorMsg(data.msg);
	                 				}
	                         	}
	                         });
	                     }
	                 });
				}
			}];
			
			
			$(function(){
				 $("#" + datagrid).datagrid({
			        url : url,
			        singleSelect : true, /*是否选中一行*/
			        height: '570px',
			        width:'auto', 
			        pagination : true,  /*是否显示下面的分页菜单*/
			        border:false,
			        rownumbers: true,
			        toolbar : toolbar,
			        title: "选项信息",
			        idField: 'id',
			        columns : [ [{
			            field : 'id', 
			            hidden: 'true'
			        }, {
			            field : 'name',
			            title : '名称',
			       		width : '50%',
			            align : 'center',
			            formatter: formatCellTooltip
			        }, {
			            field : 'type',
			            title : '类型',
			       		width : '20%',
			            align : 'center',
			            formatter: function(val){
			            	var type = "";
			            	if(val == 1){
			            		type = "样件来源";
			            	}else if(val == 2){
			            		type = "抽样原因";
			            	}else {
			            		type = "费用出处";
			            	}
			            	return "<span title='" + type + "'>" + type + "</span>";
			            }
			        }, {
			            field : 'remark',
			            title : '备注',
			       		width : '30%',
			            align : 'center',
			            formatter: formatCellTooltip
			        }
			        ] ],
					onDblClickRow : function(rowIndex, rowData) {
						info(detailUrl + "?id=" + rowData.id);
					}
				});
	
				// 分页信息
				$('#' + datagrid).datagrid('getPager').pagination({
					pageSize : "${defaultPageSize}",
					pageNumber : 1,
					displayMsg : '当前显示 {from} - {to} 条记录    共  {total} 条记录',
					onSelectPage : function(pageNumber, pageSize) {//分页触发  
						var data = {
							'name' : $("#q_name").textbox("getValue"), 
							'type': $("#q_type").combobox('getValue'),
							'pageNum' : pageNumber,
							'pageSize' : pageSize
						}
						getData(datagrid, url, data);
					}
				});
			});
	
			function doSearch() {
				var data = {
					'name' : $("#q_name").textbox("getValue"), 
					'type': $("#q_type").combobox('getValue')
				}
				getData(datagrid, url, data);
			}
	
			function doClear() {
				$("#q_name").textbox('clear');
				$("#q_type").combobox('select', "");
				getData(datagrid, url, {});
			}
	
			function info(url) {
				$('#reasonOptionDialog').dialog({
					title : '选项信息',
					width : 400,
					height : 250,
					closed : false,
					cache : false,
					href : url,
					modal : true
				});
				$('#reasonOptionDialog').window('center');
			}
			
			// 关掉对话时回调
			function closeDialog(msg) {
				$('#reasonOptionDialog').dialog('close');
				tipMsg(msg, function(){
					$('#' + datagrid).datagrid('reload');
				});
			}
		</script>
	</head>
	

	<body>
		<div style="margin-top: 15px; padding-left: 20px; margin-bottom: 10px;font-size:12px;">
			名称：<input id="q_name" name="q_name" class="easyui-textbox" style="width: 150px;">&nbsp;&nbsp;&nbsp;&nbsp;
	
			类型：<select id="q_type" name="q_type" style="width:168px;" class="easyui-combobox" data-options="panelHeight: '200px'">
				<option value="">请选择</option>
				<option value="1">样件来源</option>
				<option value="2">抽样原因</option>
				<option value="3">费用出处</option>
			</select>&nbsp;&nbsp;&nbsp;&nbsp;
			
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px;" onclick="doSearch()">查询</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" style="width:80px;" onclick="doClear()">清空</a>&nbsp;&nbsp;&nbsp;&nbsp;
		
		</div>
				
		<div style="margin-top:10px;">
			<table id="reasonOptionTable" style="height:auto;width:auto"></table>
		</div>
		
		<div id="reasonOptionDialog"></div>
	</body>
</html>
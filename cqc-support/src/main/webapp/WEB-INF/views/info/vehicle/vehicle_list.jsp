<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>SGMW</title>
		<%@include file="../../common/source.jsp"%>
		
		<script type="text/javascript">
			var getDataUrl = "${ctx}/vehicle/getList?time=" + new Date();
			var detailUrl = "${ctx}/vehicle/detail";
			var datagrid = "vehicleTable";
			
			var toolbar = [{
		           text:'添加',
		           iconCls:'icon-add',
		           handler: function(){
		           		vehicleInfo(detailUrl);	
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
			           	
			           	vehicleInfo(detailUrl + "?id=" + row.id);	
		           }
			  }, '-',  {
				text : '删除',
				iconCls : 'icon-remove',
				handler : function() {
					var row = $("#" + datagrid).datagrid('getSelected');
		           	if(isNull(row)){
		           		errorMsg("请选择一条记录进行操作!");
		           		return;
		           	}
		           	
		           	 $.messager.confirm('系统提示', "此操作将删除该整车信息，您确定要继续吗？", function(r){
	                    if (r){
	                        $.ajax({
	                        	url: "${ctx}/vehicle/delete",
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
			        url : getDataUrl,
			      //  checkOnSelect: true,
			        singleSelect : true, /*是否选中一行*/
			        width:'auto', 
			        pagination : true,  /*是否显示下面的分页菜单*/
			        border:false,
			        rownumbers: true,
			        toolbar : toolbar,
			        title: "整车信息",
			        idField: 'id',
			        columns : [ [  /* {
			        	field: 'ck',
			        	checkbox: true
			        }, */{
			            field : 'id', 
			            hidden: 'true'
			        }, {
			            field : 'code',
			            title : '编码',
			            width : '150',
			            align : 'center',
			            formatter: formatCellTooltip
			        }, {
			            field : 'type',
			            title : '车型',
			            width : '150',
			            align : 'center',
			            formatter: formatCellTooltip
			        }, {
			            field : 'proTime',
			            title : '生产时间',
			            width : '150',
			            align : 'center',
			            formatter: DateFormatter
			        }, {
						field : 'proAddr',
						title : '生产地址',
						width : '350',
						align : 'center',
						formatter : formatCellTooltip
					}, {
						field : 'remark',
						title : '备注',
						width : '350',
						align : 'center',
						formatter : formatCellTooltip
					} ] ],
					onDblClickRow : function(rowIndex, rowData) {
						vehicleInfo(detailUrl + "?id=" + rowData.id);
					}
				});
		
				// 分页信息
				$('#' + datagrid).datagrid('getPager').pagination({
					pageSize : "${defaultPageSize}",
					pageNumber : 1,
					displayMsg : '当前显示 {from} - {to} 条记录    共  {total} 条记录',
					onSelectPage : function(pageNumber, pageSize) {//分页触发  
						var data = {
							'code' : $("#q_code").textbox("getValue"), 
							'type' : $("#q_type").textbox("getValue"),
							'startProTime' : $("#q_startProTime").val(),
							'endProTime' : $("#q_endProTime").val(),
							'pageNum' : pageNumber,
							'pageSize' : pageSize
						}
						getData(datagrid, getDataUrl, data);
					}
				});
			});
		
			function doSearch() {
				var data = {
					'code' : $("#q_code").textbox("getValue"), 
					'type' : $("#q_type").textbox("getValue"),
					'startProTime' : $("#q_startProTime").val(),
					'endProTime' : $("#q_endProTime").val()
				}
				getData(datagrid, getDataUrl, data);
			}
		
			function doClear() {
				$("#q_code").textbox('clear');
				$("#q_type").textbox('clear');
				$("#q_startProTime").val('');
				$("#q_endProTime").val('');
				
				getData(datagrid, getDataUrl, {});
			}
		
			function vehicleInfo(url) {
				$('#vehicleDialog').dialog({
					title : '整车信息',
					width : 450,
					height : 400,
					closed : false,
					cache : false,
					href : url,
					modal : true
				});
				$('#vehicleDialog').window('center');
			}
			
			
			// 关掉对话时回调
			function closeDialog(msg) {
				$('#vehicleDialog').dialog('close');
				tipMsg(msg, function(){
					$('#' + datagrid).datagrid('reload');
				});
			}
			
		</script>
		
		
		<style style="text/css">
			.datagrid-btable tr {
				height: 30px;
			}
			
			.datagrid-header {
				background: linear-gradient(to bottom, #BFDEFF 0, #F2F2F2 100%)
			}
			
			.datagrid-header-row {
				font-weight: bold;
				height: 50px
			}
			
			.datagrid-row-over, .datagrid-header td.datagrid-header-over {
			    background: #e6e6e6;
			    color: #00438a;
			    cursor: default;
			}
			
			.lock-unlock {
				display: inline-block;
			    width: 16px;
			    height: 16px;
			    margin-right: 3px;
			}
		</style>
		
	</head>

	<body>
		<div style="margin-top: 15px; padding-left: 20px; margin-bottom: 10px;font-size:12px;">
			<div>
				编码：<input id="q_code" name="q_code" class="easyui-textbox" style="width: 150px;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				车型：<input id="q_type" name="q_type" class="easyui-textbox" style="width: 150px;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
		      	生产时间：<input type="text" id="q_startProTime" name="q_startProTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'q_endProTime\')}'})" class="textbox" style="line-height: 23px;width:150px;display:inline-block"/> - 
				   	   <input type="text" id="q_endProTime" name="q_endProTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'q_startProTime\')}'})" class="textbox"  style="line-height: 23px;width:150px;display:inline-block;margin-right:60px;"/>
			
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px;" onclick="doSearch()">查询</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" style="width:80px;" onclick="doClear()">清空</a>
			</div>
		</div>
				
		<div style="margin-top:10px;">
			<table id="vehicleTable" style="height:auto;width:auto"></table>
		</div>
		
		<div id="vehicleDialog"></div>
		
	
	</body>
</html>
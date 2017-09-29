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
			var getDataUrl = "${ctx}/material/getList?time=" + new Date();
			var detailUrl = "${ctx}/material/detail";
			var datagrid = "materialTable";
			
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
		           	
		           	 $.messager.confirm('系统提示', "此操作将删除该零部件材料信息，您确定要继续吗？", function(r){
	                    if (r){
	                        $.ajax({
	                        	url: "${ctx}/material/delete",
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
			        height: "720px",
			        pagination : true,  /*是否显示下面的分页菜单*/
			        border:false,
			        rownumbers: true,
			        toolbar : toolbar,
			        title: "零部件材料信息",
			        idField: 'id',
			        columns : [ [  /* {
			        	field: 'ck',
			        	checkbox: true
			        }, */{
			            field : 'id', 
			            hidden: 'true'
			        }, {
			            field : 'pic',
			            title : '材料成分表',
			            width : '120',
			            align : 'center',
			            formatter: function(val){
			            	if(val){
			            		return "<a target='_blank' href='${resUrl}/" + val+ "'><img src='${resUrl}/" + val+ "' style='width: 100px; height: 50px'></img></a>";
			            	}
			            }
			        }, {
						field : 'matName',
						title : '材料名称',
						width : '120',
						align : 'center',
						formatter : formatCellTooltip
					}, {
			            field : 'type',
			            title : '类型',
			            width : '70',
			            align : 'center',
			            formatter: function(val){
			            	if(val){
			            		var name = "基准";
			            		if(val == 2){
			            			name = "抽样"
			            		}
			            		return "<span title='" + name + "'>" + name + "</span>";
			            	}
			            }
			        }, {
						field : 'proNo',
						title : '生产批次',
						width : '120',
						align : 'center',
						formatter : formatCellTooltip
					}, {
						field : 'matNo',
						title : '材料牌号',
						width : '120',
						align : 'center',
						formatter : formatCellTooltip
					}, {
						field : 'matColor',
						title : '材料颜色',
						width : '120',
						align : 'center',
						formatter : formatCellTooltip
					}, {
						field : 'matProducer',
						title : '材料生产商',
						width : '150',
						align : 'center',
						formatter : formatCellTooltip
					}, {
						field : 'producerAdd',
						title : '材料生产商地址',
						width : '200',
						align : 'center',
						formatter : formatCellTooltip
					}, {
						field : 'remark',
						title : '备注',
						width : '200',
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
							'type' : $("#q_type").textbox("getValue"),
							'proNo' : $("#q_proNo").textbox("getValue"), 
							'matName' : $("#q_matName").textbox("getValue"), 
							'matNo' : $("#q_matNo").textbox("getValue"), 
							'matProducer' : $("#q_matProducer").textbox("getValue"),
							'pageNum' : pageNumber,
							'pageSize' : pageSize
						}
						getData(datagrid, getDataUrl, data);
					}
				});
			});
		
			function doSearch() {
				var data = {
					'type' : $("#q_type").textbox("getValue"),
					'proNo' : $("#q_proNo").textbox("getValue"), 
					'matName' : $("#q_matName").textbox("getValue"), 
					'matNo' : $("#q_matNo").textbox("getValue"), 
					'matProducer' : $("#q_matProducer").textbox("getValue")
				}
				getData(datagrid, getDataUrl, data);
			}
		
			function doClear() {
				$("#q_proNo").textbox('clear');
				$("#q_matName").textbox('clear');
				$("#q_matNo").textbox('clear');
				$("#q_matProducer").textbox('clear');
				$('#q_type').combobox('setValue', '');
				getData(datagrid, getDataUrl, {});
			}
		
			function vehicleInfo(url) {
				$('#materialDialog').dialog({
					title : '零部件材料信息',
					width : 800,
					height : 430,
					closed : false,
					cache : false,
					href : url,
					modal : true
				});
				$('#materialDialog').window('center');
			}
			
			
			// 关掉对话时回调
			function closeDialog(msg) {
				$('#materialDialog').dialog('close');
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
			
			.qlabel{
				display: inline-block;
				width: 72px;
			}
		</style>
		
	</head>

	<body>
		<div style="margin-top: 15px; padding-left: 20px; margin-bottom: 10px;font-size:12px;">
			<div>
				<div>
					<span class="qlabel">材料名称：</span><input id="q_matName" name="q_matName" class="easyui-textbox" style="width: 140px;"> &nbsp;&nbsp;&nbsp;&nbsp;
					<span class="qlabel">类型：</span>
						<select id="q_type" class="easyui-combobox" name="q_type" data-options="panelHeight:'auto'" style="width:140px;">
					    <option value="">全部</option>
						<option value="1">基准</option>
					    <option value="2">抽样</option>
					   </select>&nbsp;&nbsp;&nbsp;&nbsp;
					<span class="qlabel">生产批次：</span><input id="q_proNo" name="q_proNo" class="easyui-textbox" style="width: 140px;"> &nbsp;&nbsp;&nbsp;&nbsp;
					<span class="qlabel">材料牌号：</span><input id="q_matNo" name="q_matNo" class="easyui-textbox" style="width: 140px;"> &nbsp;&nbsp;&nbsp;&nbsp;
					<span class="qlabel">材料生产商：</span><input id="q_matProducer" name="q_matProducer" class="easyui-textbox" style="width: 140px;">
				</div>
				
				<div align="right" style="margin-top:10px;margin-right: 40px;">
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px;" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" style="width:80px;" onclick="doClear()">清空</a>
				</div>
			</div>
		</div>
				
		<div style="margin-top:10px;">
			<table id="materialTable" style="height:auto;width:auto"></table>
		</div>
		
		<div id="materialDialog"></div>
		
	
	</body>
</html>

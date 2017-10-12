<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

			
	<body>
		<div style="margin-top: 15px; padding-left: 20px; margin-bottom: 10px;font-size:12px;">
			<div>
				<div>
					<span class="qlabel">材料名称：</span><input id="q_matName" name="q_matName" class="easyui-textbox" style="width: 140px;"> &nbsp;&nbsp;&nbsp;&nbsp;
					<span class="qlabel">生产批次：</span><input id="q_proNo" name="q_proNo" class="easyui-textbox" style="width: 140px;"> &nbsp;&nbsp;&nbsp;&nbsp;
					<span class="qlabel">材料牌号：</span><input id="q_matNo" name="q_matNo" class="easyui-textbox" style="width: 140px;"> &nbsp;&nbsp;&nbsp;&nbsp;
					<span class="qlabel">材料生产商：</span><input id="q_matProducer" name="q_matProducer" class="easyui-textbox" style="width: 140px;">&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
				
				<div style="margin-top:10px;margin-right: 40px;">
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px;" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" style="width:80px;" onclick="doClear()">清空</a>
				</div>
			</div>
		</div>
				
		<div style="margin-top:10px;">
			<table id="materialTable" style="height:auto;width:auto"></table>
		</div>
		
		<script type="text/javascript">
			var getDataUrl = "${ctx}/material/getList?time=" + new Date();
			var detailUrl = "${ctx}/material/detail";
			var datagrid = "materialTable";
			
			$(function(){
				 $("#" + datagrid).datagrid({
			        url : getDataUrl,
			        singleSelect : true, /*是否选中一行*/
			        width:'auto', 	
			        height: "390px",
			        pagination : true,  /*是否显示下面的分页菜单*/
			        border:false,
			        rownumbers: true,
			        idField: 'id',
			        columns : [ [ {
			            field : 'id', 
			            hidden: 'true'
			        }, {
						field : 'matName',
						title : '材料名称',
						width : '100',
						align : 'center',
						formatter : formatCellTooltip
					}, {
						field : 'proNo',
						title : '生产批次',
						width : '100',
						align : 'center',
						formatter : formatCellTooltip
					}, {
						field : 'matNo',
						title : '材料牌号',
						width : '100',
						align : 'center',
						formatter : formatCellTooltip
					}, {
						field : 'matColor',
						title : '材料颜色',
						width : '100',
						align : 'center',
						formatter : formatCellTooltip
					}, {
						field : 'matProducer',
						title : '材料生产商',
						width : '120',
						align : 'center',
						formatter : formatCellTooltip
					}, {
						field : 'producerAdd',
						title : '材料生产商地址',
						width : '170',
						align : 'center',
						formatter : formatCellTooltip
					}, {
						field : 'remark',
						title : '备注',
						width : '170',
						align : 'center',
						formatter : formatCellTooltip
					}, {
						field : '_operation',
						title : '操作',
						width : '80',
						align : 'center',
						formatter : function(value,row,index){
							return '<a href="javascript:void(0)" onclick="closeDialog('+ index +')">选择</a>';  	
						}
					}  ] ]
				});
		
				// 分页信息
				$('#' + datagrid).datagrid('getPager').pagination({
					pageSize : "${defaultPageSize}",
					pageNumber : 1,
					displayMsg : '当前显示 {from} - {to} 条记录    共  {total} 条记录',
					onSelectPage : function(pageNumber, pageSize) {//分页触发  
						var data = {
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
				getData(datagrid, getDataUrl, {});
			}
			
			// 关掉对话时回调
			function closeDialog(index) {
				var rows = $('#' + datagrid).datagrid('getRows');
				var row = rows[index];

				if (!isNull(row)) {
					$("#m_matName").textbox("setValue", row.matName);
					$("#m_proNo").textbox("setValue", row.proNo);
					$("#m_matProducer").textbox("setValue", row.matProducer);
					$("#m_producerAdd").textbox("setValue", row.producerAdd);
					$("#m_matNo").textbox("setValue", row.matNo);
					$("#m_matColor").textbox("setValue", row.matColor);
					$("#m_remark").textbox("setValue", row.remark);
				}
				
				$('#materialDialog').dialog('close');
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
	
	</body>

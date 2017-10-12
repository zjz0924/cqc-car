<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>


<body>
	<div style="margin-top: 15px; padding-left: 20px; margin-bottom: 10px;font-size:12px;">
		<div>
			<div>
				<span class="qlabel">代码：</span><input id="p_q_code" name="p_q_code" class="easyui-textbox" style="width: 140px;"> &nbsp;&nbsp;&nbsp;&nbsp;
				<span class="qlabel">名称：</span><input id="p_q_name" name="p_q_name" class="easyui-textbox" style="width: 140px;"> &nbsp;&nbsp;&nbsp;&nbsp;
				<span class="qlabel">生产时间：</span>
				<input type="text" id="p_q_startProTime" name="p_q_startProTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'p_q_endProTime\')}'})" class="textbox" style="line-height: 23px;width:140px;display:inline-block"/> - 
			   	<input type="text" id="p_q_endProTime" name="p_q_endProTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'p_q_startProTime\')}'})" class="textbox"  style="line-height: 23px;width:140px;display:inline-block;margin-right:60px;"/>
			</div>
			
			<div style="margin-top:10px;">
				<span class="qlabel">生产商：</span><input id="p_q_producer" name="p_q_producer" class="easyui-textbox" style="width: 140px;"> &nbsp;&nbsp;&nbsp;&nbsp;
				<span class="qlabel">生产批次：</span><input id="p_q_proNo" name="p_q_proNo" class="easyui-textbox" style="width: 140px;"> &nbsp;&nbsp;&nbsp;&nbsp;
				<span class="qlabel">材料名称：</span><input id="p_q_matName" name="p_q_matName" class="easyui-textbox" style="width: 140px;"> &nbsp;&nbsp;&nbsp;&nbsp;
				<span class="qlabel">材料牌号：</span><input id="p_q_matNo" name="p_q_matNo" class="easyui-textbox" style="width: 140px;"> &nbsp;&nbsp;&nbsp;&nbsp;
			</div>
			
			<div style="margin-top:10px;margin-right: 40px;">
				<span class="qlabel">材料生产商：</span><input id="p_q_matProducer" name="p_q_matProducer" class="easyui-textbox" style="width: 140px;"> &nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px;" onclick="p_doSearch()">查询</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" style="width:80px;" onclick="doClear()">清空</a>
			</div>
		</div>
	</div>
			
	<div style="margin-top:10px;">
		<table id="partsTable" style="width:auto"></table>
	</div>
	
	<script type="text/javascript">
		var getDataUrl = "${ctx}/parts/getList?time=" + new Date();
		var detailUrl = "${ctx}/parts/detail";
		var datagrid = "partsTable";
		
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
		        columns : [ [{
		            field : 'id', 
		            hidden: 'true'
		        }, {
		            field : 'code',
		            title : '代码',
		            width : '120',
		            align : 'center',
		            formatter: formatCellTooltip
		        }, {
		            field : 'name',
		            title : '名称',
		            width : '120',
		            align : 'center',
		            formatter: formatCellTooltip
		        }, {
		            field : 'producer',
		            title : '生产商',
		            width : '150',
		            align : 'center',
		            formatter: formatCellTooltip
		        }, {
		            field : 'proTime',
		            title : '生产时间',
		            width : '100',
		            align : 'center',
		            formatter: DateFormatter
		        }, {
					field : 'place',
					title : '生产场地',
					width : '150',
					align : 'center',
					formatter : formatCellTooltip
				}, {
					field : 'proNo',
					title : '生产批次',
					width : '120',
					align : 'center',
					formatter : formatCellTooltip
				}, {
					field : 'technology',
					title : '生产工艺',
					width : '120',
					align : 'center',
					formatter : formatCellTooltip
				}, {
					field : 'matName',
					title : '材料名称',
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
					field : 'remark',
					title : '备注',
					width : '200',
					align : 'center',
					formatter : formatCellTooltip
				} ] ],
				frozenColumns:[[{
					field : '_operation',
					title : '操作',
					width : '80',
					align : 'center',
					formatter : function(value,row,index){
						return '<a href="javascript:void(0)" onclick="closeDialog('+ index +')">选择</a>';  	
					}
				  }
				]]
			});
	
			// 分页信息
			$('#' + datagrid).datagrid('getPager').pagination({
				pageSize : "${defaultPageSize}",
				pageNumber : 1,
				displayMsg : '当前显示 {from} - {to} 条记录    共  {total} 条记录',
				onSelectPage : function(pageNumber, pageSize) {//分页触发  
					var data = {
						'code' : $("#p_q_code").textbox("getValue"), 
						'name' : $("#p_q_name").textbox("getValue"), 
						'startProTime' : $("#p_q_startProTime").val(),
						'endProTime' : $("#p_q_endProTime").val(),
						'producer' : $("#p_q_producer").textbox("getValue"), 
						'proNo' : $("#p_q_proNo").textbox("getValue"), 
						'matName' : $("#p_q_matName").textbox("getValue"), 
						'matNo' : $("#p_q_matNo").textbox("getValue"), 
						'matProducer' : $("#p_q_matProducer").textbox("getValue"),
						'pageNum' : pageNumber,
						'pageSize' : pageSize
					}
					getData(datagrid, getDataUrl, data);
				}
			});
		});
	
		function p_doSearch() {
			var data = {
				'code' : $("#p_q_code").textbox("getValue"), 
				'name' : $("#p_q_name").textbox("getValue"), 
				'startProTime' : $("#p_q_startProTime").val(),
				'endProTime' : $("#p_q_endProTime").val(),
				'producer' : $("#p_q_producer").textbox("getValue"), 
				'proNo' : $("#p_q_proNo").textbox("getValue"), 
				'matName' : $("#p_q_matName").textbox("getValue"), 
				'matNo' : $("#p_q_matNo").textbox("getValue"), 
				'matProducer' : $("#p_q_matProducer").textbox("getValue")
			}
			getData(datagrid, getDataUrl, data);
		}
	
		function doClear() {
			$("#p_q_code").textbox('clear');
			$("#p_q_startProTime").val('');
			$("#p_q_endProTime").val('');
			$("#p_q_name").textbox('clear');
			$("#p_q_producer").textbox('clear');
			$("#p_q_proNo").textbox('clear');
			$("#p_q_matName").textbox('clear');
			$("#p_q_matNo").textbox('clear');
			$("#p_q_matProducer").textbox('clear');
			getData(datagrid, getDataUrl, {});
		}
	
		// 关掉对话时回调
		function closeDialog(index) {
			var rows = $('#' + datagrid).datagrid('getRows');
			var row = rows[index];

			if (!isNull(row)) {
				$("#p_code").textbox("setValue", row.code);
				$("#p_name").textbox("setValue", row.name);
				$("#p_proTime").datebox("setValue", formatDate(row.proTime));
				$("#p_producer").textbox("setValue", row.producer);
				$("#p_place").textbox("setValue", row.place);
				$("#p_proNo").textbox("setValue", row.proNo);
				$("#p_technology").textbox("setValue", row.technology);
				$("#p_matName").textbox("setValue", row.matName);
				$("#p_matNo").textbox("setValue", row.matNo);
				$("#p_matColor").textbox("setValue", row.matColor);
				$("#p_matProducer").textbox("setValue", row.matProducer);
				$("#p_remark").textbox("setValue", row.remark);			
			}
			
			$('#partsDialog').dialog('close');
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


	

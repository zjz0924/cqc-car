<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>


<body>
	<div style="margin-top: 15px; padding-left: 20px; margin-bottom: 10px;font-size:12px;">
		<div>
			<div>
				<span class="qlabel">零件名称：</span>
				<input id="p_q_name" name="p_q_name" class="easyui-textbox" style="width: 140px;"> &nbsp;&nbsp;&nbsp;&nbsp;
				
				<span class="qlabel">零件图号：</span>
				<input id="p_q_code" name="p_q_code" class="easyui-textbox" style="width: 140px;"> &nbsp;&nbsp;&nbsp;&nbsp;
				
				<span class="qlabel">生产时间：</span>
				<input type="text" id="p_q_startProTime" name="p_q_startProTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'p_q_endProTime\')}'})" class="textbox" style="line-height: 23px;width:140px;display:inline-block"/> - 
			   	<input type="text" id="p_q_endProTime" name="p_q_endProTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'p_q_startProTime\')}'})" class="textbox"  style="line-height: 23px;width:140px;display:inline-block;margin-right:60px;"/>
			</div>
			
			<div style="margin-top:10px;">
				<span class="qlabel">供应商：</span>
				<input id="p_q_producer" name="p_q_producer" type="text"  class="inputAutocomple" style="width:140px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<span class="qlabel">供应商代码：</span>
				<input id="p_q_producerCode" name="p_q_producerCode" class="easyui-textbox" style="width: 140px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<span class="qlabel">样件批号：</span>
				<input id="p_q_proNo" name="p_q_proNo" class="easyui-textbox" style="width: 140px;"> &nbsp;&nbsp;
				
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px;" onclick="p_doSearch()">查询</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" style="width:80px;" onclick="doClear()">清空</a>
			</div>
		</div>
	</div>
			
	<div style="margin-top:10px;">
		<table id="partsTable" style="width:auto"></table>
	</div>
	
	<script type="text/javascript">
		var getDataUrl = "${ctx}/parts/getList";
		var detailUrl = "${ctx}/parts/detail";
		var datagrid = "partsTable";
		
		$(function(){
			$("#p_q_producer").autocomplete("${ctx}/ots/getProducerList?type=1", {
				formatItem: function(row,i,max) {
					var obj =eval("(" + row + ")");//转换成js对象
					return obj.text;
				},
				formatResult: function(row) {
					var obj =eval("(" + row + ")");
					return obj.text;
				}
			});
			
			//选择后处理方法
			$("#p_q_producer").result(function(event, data, formatted){ 
				var obj = eval("(" + data + ")"); //转换成js对象 
				$("#p_q_producer").val(obj.text);
			});
			
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
					field : '_operation',
					title : '操作',
					width : '50',
					align : 'center',
					formatter : function(value,row,index){
						return '<a href="javascript:void(0)" onclick="closeDialog('+ index +')">选择</a>';  	
					}
				  },{
		            field : 'id', 
		            hidden: 'true'
		        }, {
		            field : 'name',
		            title : '零件名称',
		            width : '100',
		            align : 'center',
		            formatter: formatCellTooltip
		        }, {
		            field : 'code',
		            title : '零件图号',
		            width : '80',
		            align : 'center',
		            formatter: formatCellTooltip
		        }, {
		            field : 'producer',
		            title : '供应商',
		            width : '100',
		            align : 'center',
		            formatter: formatCellTooltip
		        },  {
		            field : 'producerCode',
		            title : '供应商代码',
		            width : '100',
		            align : 'center',
		            formatter: formatCellTooltip
		        },  {
		            field : 'num',
		            title : '样件数量',
		            width : '60',
		            align : 'center',
		            formatter: formatCellTooltip
		        }, {
					field : 'proNo',
					title : '样件批号',
					width : '80',
					align : 'center',
					formatter : formatCellTooltip
				}, {
		            field : 'proTime',
		            title : '生产时间',
		            width : '90',
		            align : 'center',
		            formatter: DateFormatter
		        }, {
					field : 'place',
					title : '生产场地',
					width : '170',
					align : 'center',
					formatter : formatCellTooltip
				},{
					field : 'remark',
					title : '备注',
					width : '100',
					align : 'center',
					formatter : formatCellTooltip
				} ] ]
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
						'proNo' : $("#p_q_proNo").textbox("getValue"), 
						'producer' : $("#p_q_producer").val(), 
						'producerCode' : $("#p_q_producerCode").textbox("getValue"), 
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
				'proNo' : $("#p_q_proNo").textbox("getValue"), 
				'producer' : $("#p_q_producer").val(), 
				'producerCode' : $("#p_q_producerCode").textbox("getValue")
			}
			getData(datagrid, getDataUrl, data);
		}
	
		function doClear() {
			$("#p_q_code").textbox('clear');
			$("#p_q_startProTime").val('');
			$("#p_q_endProTime").val('');
			$("#p_q_name").textbox('clear');
			$("#p_q_proNo").textbox('clear');
			$("#p_q_producer").val(""), 
			$("#p_q_producerCode").textbox("clear"), 
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
				$("#p_place").textbox("setValue", row.place);
				$("#p_proNo").textbox("setValue", row.proNo);
				$("#p_remark").textbox("setValue", row.remark); 
				$("#p_producer").val(row.producer);
				$("#p_producerCode").textbox("setValue", row.producerCode);	
				$("#p_num").textbox("setValue", row.num);
				$("#p_id").val(row.id);
			
				if($('#qCode').length > 0){
					$('#qCode').textbox("setValue", "");
				}
			}
			
			$('#partsDialog').dialog('close');
		}
		
	</script>
	
	
	<style style="text/css">
		
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
		
		.inputAutocomple{
			border: 1px solid #D3D3D3;
		    outline-style: none;
		    resize: none;
			position: relative;
		    background-color: #fff;
		    vertical-align: middle;
		    display: inline-block;
		    overflow: hidden;
		    white-space: nowrap;
		    margin: 0;
		    padding: 4px;
		    border-radius: 5px 5px 5px 5px;
			height: 22px;
		    line-height: 22px;
		    font-size: 12px;
		}
	</style>

</body>


	

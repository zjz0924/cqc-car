<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<html>
	<head>
		<meta charset="utf-8">
		<title>SGMW</title>
		<%@include file="../common/source.jsp"%>
		<script src="${ctx}/resources/js/jquery.form.js"></script>
		
		<script type="text/javascript">
			var getDataUrl = "${ctx}/result/sendListData";
			var getRecordUrl = "${ctx}/ots/taskRecordListData";
			var datagrid = "sendTable";
			var recordDatagrid = "taskRecordTable";
			// 当前选中的任务的任务号
			var currentTaskCode = "";
			
			$(function(){
				 // 任务列表
				 $("#" + datagrid).datagrid({
			        url : getDataUrl,
			        singleSelect : true, /*是否选中一行*/
			        width:'auto', 	
			        height: "375px",
					title: '任务列表',
			        pagination : true,  /*是否显示下面的分页菜单*/
			        border:false,
			        rownumbers: true,
			        idField: 'id',
			        columns : [ [ {
						field : '_operation',
						title : '操作',
						width : '60',
						align : 'center',
						formatter : function(value,row,index){
							return '<a href="javascript:void(0)" onclick="sendDetail('+ row.id +')">发送结果</a>';  	
						}
					}, {
			            field : 'id', 
			            hidden: 'true'
			        }, {
						field : 'code',
						title : '任务号',
						width : '150',
						align : 'center',
						formatter : formatCellTooltip
					}, {
						field : 'type',
						title : '任务类型',
						width : '100',
						align : 'center',
						formatter : function(val){
							var str = "材料研究所任务"
							if(val == 1){
								str = "OTS阶段任务";
							}else if(val == 2){
								str = "PPAP阶段任务";
							}else if(val == 3){
								str = "SOP阶段任务";
							}
							return "<span title='" + str + "'>" + str + "</span>";
						}
					}, {
						field : 'info.parts.code',
						title : '零件号',
						width : '100',
						align : 'center',
						formatter : function(value, row, index){
							var parts = row.info.parts;
							if(!isNull(parts)){
								return "<span title='"+ parts.code +"'>"+ parts.code +"</span>";
							}							
						}
					}, {
						field : 'info.parts.name',
						title : '零件名称',
						width : '110',
						align : 'center',
						formatter : function(value, row, index){
							var parts = row.info.parts;
							if(!isNull(parts)){
								return "<span title='"+ parts.name +"'>"+ parts.name +"</span>";
							}							
						}
					}, {
						field : 'info.parts.producer',
						title : '生产商',
						width : '110',
						align : 'center',
						formatter : function(value, row, index){
							var parts = row.info.parts;
							if(!isNull(parts)){
								return "<span title='"+ parts.producer +"'>"+ parts.producer +"</span>";
							}						
						}
					}, {
						field : 'info.material.name',
						title : '材料名称',
						width : '110',
						align : 'center',
						formatter : function(value, row, index){
							var material = row.info.material;
							if(!isNull(material)){
								return "<span title='"+ material.matName +"'>"+ material.matName +"</span>";
							}							
						}
					}, {
						field : 'info.material.producer',
						title : '生产商',
						width : '110',
						align : 'center',
						formatter : function(value, row, index){
							var material = row.info.material;
							if(!isNull(material)){
								return "<span title='"+ material.producer +"'>"+ material.producer +"</span>";
							}						
						}
					}, {
						field : 'account',
						title : '录入用户',
						width : '100',
						align : 'center',
						formatter : function(val){
							if(val){
								return "<span title='" + val.nickName + "'>" + val.nickName + "</span>";
							}
						}
					},{
						field : 'createTime',
						title : '录入时间',
						width : '130',
						align : 'center',
						formatter : DateTimeFormatter
					}  ] ],
					onDblClickRow : function(rowIndex, rowData) {
						sendDetail(rowData.id);
					},
					onClickRow: function(rowIndex, rowData) {
						currentTaskCode = rowData.code;
						getRecordList(rowData.code);
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
							'nickName' : $("#q_nickName").textbox("getValue"), 
							'startCreateTime' : $("#q_startCreateTime").val(),
							'endCreateTime' : $("#q_endCreateTime").val(),
							'parts_code': $("#parts_code").textbox("getValue"),
							'parts_name': $("#parts_name").textbox("getValue"),
							'matName': $("#matName").textbox("getValue"),
							'parts_producer': $("#parts_producer").val(),
							'mat_producer': $("#mat_producer").val(),
							'pageNum' : pageNumber,
							'pageSize' : pageSize
						}
						getData(datagrid, getDataUrl, data);
					}
				});
				
				
				// 任务记录列表
				$("#" + recordDatagrid).datagrid({
			        url : getRecordUrl,
			        singleSelect : true, /*是否选中一行*/
			        width:'auto', 	
			        height: "380px",
			        pagination : true,  /*是否显示下面的分页菜单*/
			        border:false,
			        rownumbers: true,
			        idField: 'id',
					title: '操作记录',
			        columns : [ [ {
			            field : 'id', 
			            hidden: 'true'
			        }, {
						field : 'code',
						title : '任务号',
						width : '210',
						align : 'center',
						formatter : formatCellTooltip
					}, {
						field : 'account',
						title : '操作用户',
						width : '150',
						align : 'center',
						formatter : function(val){
							if(val){
								return "<span title='" + val.nickName + "'>" + val.nickName + "</span>";
							}
						}
					}, {
						field : 'state',
						title : '状态',
						width : '180',
						align : 'center',
						formatter : function(value,row,index){
							var str = getTaskRecordState(row.taskType, row.state);
							return "<span title='" + str + "'>" + str + "</span>";
						}
					}, {
						field : 'remark',
						title : '备注',
						width : '350',
						align : 'center',
						formatter : formatCellTooltip
					},{
						field : 'createTime',
						title : '录入时间',
						width : '180',
						align : 'center',
						formatter : DateTimeFormatter
					}  ] ]
				});
				 
				 
				$("#" + recordDatagrid).datagrid('getPager').pagination({
					pageSize : "${recordPageSize}",
					pageNumber : 1,
					displayMsg : '当前显示 {from} - {to} 条记录    共  {total} 条记录',
					onSelectPage : function(pageNumber, pageSize) {//分页触发  
						var data = {
							'code' : currentTaskCode, 
							'pageNum' : pageNumber,
							'pageSize' : pageSize
						}
						getData(recordDatagrid, getRecordUrl, data);
					}
				});
				
				// 零部件生产商
				$("#parts_producer").autocomplete("${ctx}/ots/getProducerList?type=1", {
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
				$("#parts_producer").result(function(event, data, formatted){ 
					var obj = eval("(" + data + ")"); //转换成js对象 
					$("#parts_producer").val(obj.text);
				});
				
				// 原材料生产商
				$("#mat_producer").autocomplete("${ctx}/ots/getProducerList?type=2", {
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
				$("#mat_producer").result(function(event, data, formatted){ 
					var obj = eval("(" + data + ")"); //转换成js对象 
					$("#mat_producer").val(obj.text);
				});
			});
		
			function doSearch() {
				var data = {
					'code' : $("#q_code").textbox("getValue"), 
					'nickName' : $("#q_nickName").textbox("getValue"), 
					'startCreateTime' : $("#q_startCreateTime").val(),
					'endCreateTime' : $("#q_endCreateTime").val(),
					'parts_code': $("#parts_code").textbox("getValue"),
					'parts_name': $("#parts_name").textbox("getValue"),
					'matName': $("#matName").textbox("getValue"),
					'parts_producer': $("#parts_producer").val(),
					'mat_producer': $("#mat_producer").val()
				}
				getData(datagrid, getDataUrl, data);
			}
			
			function getRecordList(code){
				var data = {
					'code': code
				}
				getData(recordDatagrid, getRecordUrl, data);
			}
		
			function doClear() {
				$("#q_code").textbox('clear');
				$("#q_nickName").textbox('clear');
				$("#q_startCreateTime").val('');
				$("#q_endCreateTime").val('');
				$("#parts_code").textbox("clear");
				$("#parts_name").textbox("clear");
				$("#matName").textbox("clear");
				$("#parts_producer").val("");
				$("#mat_producer").val("");
				getData(datagrid, getDataUrl, {});
			}
			
			// 关掉对话时回调
			function closeDialog(msg) {
				$('#sendDetailDialog').dialog('close');
				tipMsg(msg, function(){
					$('#' + datagrid).datagrid('reload');
					$('#' + recordDatagrid).datagrid('reload');
				});
			}
			
			function sendDetail(id) {
				$('#sendDetailDialog').dialog({
					title : '结果信息',
					width : 1200,
					height : 660,
					top: "300px",
					closed : false,
					cache : false,
					href : "${ctx}/result/sendDetail?id=" + id,
					modal : true
				});
				//$('#sendDetailDialog').window('center');
			}
			
		</script>
	</head>
	
	<body>
		<%@include file="../common/header.jsp"%>
		
		<!--banner-->
		<div class="inbanner XSLR">
			<span style="font-size: 30px;font-weight: bold; margin-top: 70px; display: inline-block; margin-left: 80px;color: #4169E1">${menuName}</span>
		</div>
	
		<div style="margin-top: 25px; padding-left: 20px; margin-bottom: 10px;font-size:12px;margin-left: 5%;margin-right: 5%;">
			<div>
				<div>
					<span class="qlabel">任务号：</span>
					<input id="q_code" name="q_code" class="easyui-textbox" style="width: 168px;"> &nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">录入用户：</span>
					<input id="q_nickName" name="q_nickName" class="easyui-textbox" style="width: 168px;"> &nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">材料生产商：</span>
					<input id="mat_producer" name="mat_producer" type="text"  class="inputAutocomple" style="width:168px;">&nbsp;&nbsp;&nbsp;&nbsp;
				
					<span class="qlabel">材料名称：</span>
					<input id="matName" name="matName" class="easyui-textbox" style="width: 168px;">
				</div>
				
				<div style="margin-top: 5px;">
					<span class="qlabel">零件号：</span>
					<input id="parts_code" name="parts_code" class="easyui-textbox" style="width: 168px;"> &nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">零件名：</span>
					<input id="parts_name" name="parts_name" class="easyui-textbox" style="width: 168px;"> &nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">零件生产商：</span>
					<input id="parts_producer" name="parts_producer" type="text"  class="inputAutocomple" style="width:168px;">&nbsp;&nbsp;&nbsp;&nbsp;
				
					<span class="qlabel">录入时间：</span>
					<input type="text" id="q_startCreateTime" name="q_startCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'q_endCreateTime\')}'})" class="textbox" style="line-height: 23px;width:80px;display:inline-block"/> - 
					<input type="text" id="q_endCreateTime" name="q_endCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'q_startCreateTime\')}'})" class="textbox"  style="line-height: 23px;width:80px;display:inline-block;margin-right: 40px;"/>
				</div>
				
				<div style="margin-top: 5px;">
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px;" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" style="width:80px;" onclick="doClear()">清空</a>
				</div>
			</div>
			
			<div style="margin-top:10px;">
				<table id="sendTable" style="height:auto;width:auto"></table>
			</div>
			
			<div style="margin-top:10px;">
				<table id="taskRecordTable" style="height:auto;width:auto"></table>
			</div>
			
			<div id="sendDetailDialog"></div>
		
		</div>

		<!-- footer -->
		<%@include file="../common/footer.jsp"%>
		
		<style type="text/css">
			.qlabel{
				display: inline-block;
				width: 75px;
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
</html>
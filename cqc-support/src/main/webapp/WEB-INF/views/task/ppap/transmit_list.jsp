<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<html>
	<head>
		<meta charset="utf-8">
		<title>SGMW</title>
		<%@include file="../../common/source.jsp"%>
		
		<style type="text/css">
			.qlabel{
				display: inline-block;
				width: 63px;
			}
		</style>
		
		<script type="text/javascript">
			var getDataUrl = "${ctx}/ppap/transmitListData?taskType=${taskType}";
			var datagrid = "transmitTable";
		
			var toolbar = [{
		           text:'新增',
		           iconCls:'icon-add',
		           handler: function(){
		        	   detail(null);
		           }
		    }];
			
			$(function(){
				$("#" + datagrid).datagrid({
			        url : getDataUrl,
			        singleSelect : true, /*是否选中一行*/
			        width:'auto', 	
			        height: "420px",
					title: '申请列表',
			        pagination : true,  /*是否显示下面的分页菜单*/
			        border:false,
			        rownumbers: true,
			        toolbar : toolbar,
			        idField: 'id',
			        columns : [ [ {
			            field : 'id', 
			            hidden: 'true'
			        }, {
						field : 'code',
						title : '任务号',
						width : '250',
						align : 'center',
						formatter : formatCellTooltip
					},{
						field : 'createTime',
						title : '申请时间',
						width : '250',
						align : 'center',
						formatter : DateTimeFormatter
					},{
						field : 'state',
						title : '状态',
						width : '250',
						align : 'center',
						formatter : function(val){
							if(val == 1){
								return "<span title='等待审批'>等待审批</span>";
							}else if(val == 2){
								return "<span style='color:red;' title='审批不通过'>审批不通过</span>";
							}
						}
					}, {
						field : '_operation',
						title : '操作',
						width : '120',
						align : 'center',
						formatter : function(value,row,index){
							return '<a href="javascript:void(0)" onclick="detail('+ row.id +')">编辑</a>';  	
						}
					}  ] ],
					onDblClickRow : function(rowIndex, rowData) {
						detail(rowData.id);
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
							'startCreateTime' : $("#q_startCreateTime").val(),
							'endCreateTime' : $("#q_endCreateTime").val(),
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
					'startCreateTime' : $("#q_startCreateTime").val(),
					'endCreateTime' : $("#q_endCreateTime").val()
				}
				getData(datagrid, getDataUrl, data);
			}
			
			function doClear() {
				$("#q_code").textbox('clear');
				$("#q_startCreateTime").val('');
				$("#q_endCreateTime").val('');
				getData(datagrid, getDataUrl, {});
			}
			
			function detail(id) {
				var url = "${ctx}/ppap/transmitDetail?taskType=${taskType}";
				if(!isNull(id)){
					url += "&id=" + id;
				}
				
				$('#transmitDialog').dialog({
					title : '详情',
					width : 1100,
					height : 660,
					closed : false,
					cache : false,
					href : url,
					modal : true,
					onClose: function(){
						window.location.reload();
					}
				});
				$('#transmitDialog').window('center');
			}
		</script>
	</head>
	
	<body>
		<div style="margin-top: 25px; padding-left: 20px; margin-bottom: 10px;font-size:12px;">
			<div>
				<div>
					<span class="qlabel">任务号：</span>
					<input id="q_code" name="q_code" class="easyui-textbox" style="width: 138px;"> &nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">申请时间：</span>
					<input type="text" id="q_startCreateTime" name="q_startCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'q_endCreateTime\')}'})" class="textbox" style="line-height: 23px;display:inline-block"/> - 
					<input type="text" id="q_endCreateTime" name="q_endCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'q_startCreateTime\')}'})" class="textbox"  style="line-height: 23px;display:inline-block;"/>&nbsp;&nbsp;&nbsp;&nbsp;
				
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px;" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" style="width:80px;" onclick="doClear()">清空</a>
				</div>
			</div>
		</div>
		
		
		<div style="margin-top:10px;">
			<table id="transmitTable" style="height:auto;width:auto"></table>
		</div>
		
		<div id="transmitDialog"></div>
	</body>
</html>
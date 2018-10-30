<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<html>
	<head>
		<meta charset="utf-8">
		<title>SGMW</title>
		<%@include file="../common/source.jsp"%>
		<script src="${ctx}/resources/js/jquery.form.js"></script>
		
		<script type="text/javascript">
			var getDataUrl = "${ctx}/query/getListData";
			var datagrid = "taskTable";
			
			var toolbar = [{
				text : '导出',
				iconCls : 'icon-export',
				handler : function() {
					window.location.href = "${ctx}/query/exportTask";
				}
			}];
			
			$(function(){
				 // 任务列表
				 $("#" + datagrid).datagrid({
			        url : getDataUrl,
			        singleSelect : true, /*是否选中一行*/
			        width:'auto', 	
			        height: "390px",
					title: '待办任务列表',
			        pagination : true,  /*是否显示下面的分页菜单*/
			        border:false,
			        rownumbers: true, 
			        toolbar : toolbar,
			        idField: 'id',
			        frozenColumns:[[{
						field : '_operation',
						title : '操作',
						width : '60',
						align : 'center',
						formatter : function(value,row,index){
							return '<a href="javascript:void(0)" onclick="detail('+ row.id +')">详情</a>';  	
						}
					}, {
			            field : 'id', 
			            hidden: 'true'
			        }, {
						field : 'code',
						title : '任务号',
						width : '120',
						align : 'center',
						sortable: true,
						formatter : formatCellTooltip
					}, {
						field : 'type',
						title : '任务类型',
						width : '150',
						align : 'center',
						sortable: true,
						formatter : function(val){
							var str = "第三方委托"
							if(val == 1){
								str = "基准图谱建立";
							}else if(val == 2){
								str = "图谱试验抽查-开发阶段";
							}else if(val == 3){
								str = "图谱试验抽查-量产阶段";
							}
							return "<span title='" + str + "'>" + str + "</span>";
						}
					}, {
						field : 'state',
						title : '状态',
						width : '120',
						align : 'center',
						sortable: true,
						formatter : function(value,row,index){
							var str = "";
							if(row.type == 1 || row.type == 4){
								if(row.state == 1){
									str = "审核中";
								}else if(row.state == 2){
									str = "审核不通过";
								}else if(row.state == 3){
									str = "试验中";
								}else if(row.state == 4){
									str = "完成";
								}else if(row.state == 5){
									str = "申请修改";
								}else {
									str = "申请不通过";
								}
							}else if(row.type == 2 || row.type == 3){
								if(row.state == 1){
									str = "审批中";
								}else if(row.state == 2){
									str = "审批不通过";
								}else if(row.state == 3){
									str = "结果上传中";
								}else if(row.state == 4){
									str = "结果比对中";
								}else if(row.state == 5){
									str = "结果发送中";
								}else if(row.state == 6){
									str = "结果接收中";
								}else if(row.state == 7){
									str = "完成";
								}else if(row.state == 8){
									str = "申请修改";
								}else if(row.state == 9){
									str = "申请不通过";
								}else if(row.state == 10){
									str = "等待是否二次抽样";
								}else {
									str = "中止任务";
								}
							}
							return "<span title='" + str + "'>" + str + "</span>";
						}
					}, {
						field : 'isReceive',
						title : '是否接收',
						width : '80',
						align : 'center',
						sortable: true,
						formatter : function(val){
							var str = "";
							var color = "red";
							if(val == 1){
								str = "接收";
								color = "green";
							}else if(val == 2){
								str = "不接收";
							}
							return "<span title='" + str + "' style='color:"+ color +"'>" + str + "</span>";
						}
					}, {
						field : 'result',
						title : '结果',
						width : '80',
						align : 'center',
						sortable: true,
						formatter : function(val){
							var str = "";
							var color = "red";
							if(val == 1){
								str = "合格";
								color = "green";
							}else if(val == 2){
								str = "不合格";
							}
							return "<span title='" + str + "' style='color:"+ color +"'>" + str + "</span>";
						}
					}]],
			        columns : [ [ {
						field : 'receiveLabOrg',
						title : '接收实验室',
						width : '130',
						align : 'center',
						rowspan: 2,
						formatter : formatCellTooltip
					}, {
						field : 'createTime',
						title : '录入时间',
						width : '130',
						align : 'center',
						sortable: true,
						rowspan: 2,
						formatter : DateTimeFormatter
					}, {
						field : 'confirmTime',
						title : '完成时间',
						width : '130',
						align : 'center',
						sortable: true,
						rowspan: 2,
						formatter : DateTimeFormatter
					},{
						title:'车型信息', 
						colspan:2
					},{
						title:'零件信息', 
						colspan: 4
					},{
						title:'材料信息', 
						colspan: 3
					},{
						title:'申请人信息', 
						colspan: 3
					}],
					[{
						field : 'info.vehicle.code',
						title : '车型代码',
						width : '120',
						align : 'center',
						rowspan: 1,
						formatter :  function(value, row, index){
							var vehicle = row.info.vehicle;
							if(!isNull(vehicle)){
								return "<span title='"+ vehicle.code +"'>"+ vehicle.code +"</span>";
							}							
						}
					}, {
						field : 'info.vehicle.proAddr',
						title : '生产基地',
						width : '120',
						align : 'center',
						rowspan: 1,
						formatter :  function(value, row, index){
							var vehicle = row.info.vehicle;
							if(!isNull(vehicle)){
								return "<span title='"+ vehicle.proAddr +"'>"+ vehicle.proAddr +"</span>";
							}							
						}
					}, {
						field : 'info.parts.name',
						title : '零件名称',
						width : '100',
						align : 'center',
						formatter : function(value, row, index){
							var parts = row.info.parts;
							if(!isNull(parts)){
								return "<span title='"+ parts.name +"'>"+ parts.name +"</span>";
							}							
						}
					}, {
						field : 'info.parts.producer',
						title : '供应商',
						width : '100',
						align : 'center',
						formatter : function(value, row, index){
							var parts = row.info.parts;
							if(!isNull(parts)){
								return "<span title='"+ parts.producer +"'>"+ parts.producer +"</span>";
							}
						}
					}, {
						field : 'info.parts.producerCode',
						title : '供应商代码',
						width : '80',
						align : 'center',
						formatter : function(value, row, index){
							var parts = row.info.parts;
							if(!isNull(parts)){
								return "<span title='"+ parts.producerCode +"'>"+ parts.producerCode +"</span>";
							}							
						}
					}, {
						field : 'info.parts.proTime',
						title : '样件生产日期',
						width : '100',
						align : 'center',
						formatter : function(value, row, index){
							var parts = row.info.parts;
							if(!isNull(parts)){
								var date = formatDate(parts.proTime);
								return "<span title='"+ date +"'>"+ date +"</span>";
							}							
						}
					}, {
						field : 'info.material.name',
						title : '材料名称',
						width : '100',
						align : 'center',
						formatter : function(value, row, index){
							var material = row.info.material;
							if(!isNull(material)){
								return "<span title='"+ material.matName +"'>"+ material.matName +"</span>";
							}							
						}
					}, {
						field : 'info.material.matNo',
						title : '材料牌号',
						width : '100',
						align : 'center',
						formatter : function(value, row, index){
							var material = row.info.material;
							if(!isNull(material)){
								return "<span title='"+ material.matNo +"'>"+ material.matNo +"</span>";
							}							
						}
					}, {
						field : 'info.material.producer',
						title : '供应商',
						width : '120',
						align : 'center',
						formatter : function(value, row, index){
							var material = row.info.material;
							if(!isNull(material)){
								return "<span title='"+ material.producer +"'>"+ material.producer +"</span>";
							}							
						}
					}, {
						field : 'applicat.name',
						title : '申请人',
						width : '100',
						align : 'center',
						formatter : function(value, row, index){
							var applicat = row.applicat;
							if(!isNull(applicat)){
								return "<span title='"+ applicat.nickName +"'>"+ applicat.nickName +"</span>";
							}							
						}
					}, {
						field : 'applicat.depart',
						title : '科室',
						width : '120',
						align : 'center',
						formatter : function(value, row, index){
							var applicat = row.applicat;
							if(!isNull(applicat)){
								return "<span title='"+ applicat.department +"'>"+ applicat.department +"</span>";
							}							
						}
					}, {
						field : 'applicat.org',
						title : '单位/机构',
						width : '180',
						align : 'center',
						formatter : function(value, row, index){
							var org = row.applicat.org;
							if(!isNull(org)){
								return "<span title='"+ org.name +"'>"+ org.name +"</span>";
							}							
						}
					}] ],
					onDblClickRow : function(rowIndex, rowData) {
						detail(rowData.id);
						window.location.href = "${ctx}/ppap/index?taskType=2&choose=1";
					}
				});
		
				// 分页信息
				$('#' + datagrid).datagrid('getPager').pagination({
					pageSize : "${defaultPageSize}",
					pageNumber : 1,
					displayMsg : '当前显示 {from} - {to} 条记录    共  {total} 条记录',
					onSelectPage : function(pageNumber, pageSize) {//分页触发  
						var data = {
							'pageNum' : pageNumber,
							'pageSize' : pageSize
						}
						getData(datagrid, getDataUrl, data);
					}
				});
			});
			
			function getRecordList(code){
				var data = {
					'code': code
				}
				getData(recordDatagrid, getRecordUrl, data);
			}
		
			function doClear() {
				getData(datagrid, getDataUrl, {});
			}
			
			// 关掉对话时回调
			function closeDialog(msg) {
				$('#detailDialog').dialog('close');
				tipMsg(msg, function(){
					$('#' + datagrid).datagrid('reload');
				});
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
			
			<div style="margin-top:10px;">
				<table id="taskTable" style="height:auto;width:auto"></table>
			</div>
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
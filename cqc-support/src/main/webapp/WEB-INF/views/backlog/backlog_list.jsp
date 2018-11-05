<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<html>
	<head>
		<meta charset="utf-8">
		<title>SGMW</title>
		<%@include file="../common/source.jsp"%>
		<script src="${ctx}/resources/js/jquery.form.js"></script>
		
		<script type="text/javascript">
			var getDataUrl = "${ctx}/backlog/getListData";
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
			        height: "420px",
					title: '待办任务列表',
			        pagination : true,  /*是否显示下面的分页菜单*/
			        border:false,
			        rownumbers: true, 
			        //toolbar : toolbar,
			        idField: 'id',
			        frozenColumns:[[{
			            field : 'id', 
			            hidden: 'true'
			        }, {
						field : 'code',
						title : '任务号',
						width : '150',
						align : 'center',
						sortable: true,
						formatter : formatCellTooltip
					}, {
						field : 'type',
						title : '任务类型',
						width : '160',
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
						width : '140',
						align : 'center',
						sortable: true,
						formatter : function(value,row,index){
							var str = "";
							var type = row.taskType;
							
							if(type == 1){
								str = "任务申请"
							}else if(type == 2){
								str = "信息审核"
							}else if(type == 3){
								str = "任务下达";
							}else if(type == 4){
								str = "任务审批";
							}else if(type == 5){
								str = "任务下达"
							}else if(type == 6){
								str = "任务审批";
							}else if(type == 7){
								str = "任务下达"
							}else if(type == 8){
								str = "任务审批";
							}else if(type == 9){
								str = "任务申请"
							}else if(type == 10){
								str = "信息审核"
							}else if(type == 11){
								str = "任务下达";
							}else if(type == 12){
								str = "任务审批";
							}else if(type == 13){
								str = "型式结果上传";
							}else if(type == 14){
								str = "图谱结果上传";
							}else if(type == 15){
								str = "结果对比";
							}else if(type == 16){
								str = "结果发送";
							}else if(type == 17){
								str = "待上传结果确认";
							}else if(type == 18){
								str = "已上传结果确认";
							}
							return "<span title='" + str + "'>" + str + "</span>";
						}
					}]],
			        columns : [ [ {
						field : 'createTime',
						title : '录入时间',
						width : '140',
						align : 'center',
						sortable: true,
						rowspan: 2,
						formatter : DateTimeFormatter
					}, {
						title:'申请人信息', 
						colspan: 3
					}],
					[{
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
							if(!isNull(row.applicat) && !isNull(row.applicat.org)){
								return "<span title='"+ row.applicat.org.name +"'>"+ row.applicat.org.name +"</span>";
							}							
						}
					}] ],
					onDblClickRow : function(rowIndex, rowData) {
						window.location.href = "${ctx}/" + rowData.url;
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
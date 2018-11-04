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
			        height: "400px",
					title: '待办任务列表',
			        pagination : true,  /*是否显示下面的分页菜单*/
			        border:false,
			        rownumbers: true, 
			        //toolbar : toolbar,
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
						width : '140',
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
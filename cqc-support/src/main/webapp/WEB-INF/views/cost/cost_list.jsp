<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<html>
	<head>
		<meta charset="utf-8">
		<title>SGMW</title>
		<%@include file="../common/source.jsp"%>
		<script src="${ctx}/resources/js/jquery.form.js"></script>
		
		<script type="text/javascript">
			var getDataUrl = "${ctx}/cost/getListData?type=${type}";
			var datagrid = "costTable";
			
			var toolbar = [{
				text : '导出',
				iconCls : 'icon-export',
				handler : function() {
					window.location.href = "${ctx}/cost/exportList?type=${type}";
				}
			}];
			
			$(function(){
				 // 任务列表
				 $("#" + datagrid).datagrid({
			        url : getDataUrl,
			        singleSelect : true, /*是否选中一行*/
			        width:'auto', 	
			        height: "450px",
					title: '费用清单',
			        pagination : true,  /*是否显示下面的分页菜单*/
			        border:false,
			        rownumbers: true,
			        toolbar : toolbar,
			        idField: 'id',
			        frozenColumns: [[{
							field : '_operation',
							title : '操作',
							width : '45',
							align : 'center',
							formatter : function(value,row,index){
								var str = "发送"
								if("${type}" == 2){
									str = "查看";
								}
								return '<a href="javascript:void(0)" onclick="costDetail('+ row.id +')">'+ str +'</a>';  	
							}
						}, {
				            field : 'id', 
				            hidden: 'true'
				        }, {
							field : 'task',
							title : '任务号',
							width : '115',
							align : 'center',
							formatter : function(val){
								if(val){
									return "<span title='" + val.code + "'>" + val.code + "</span>";
								}
							}
						}, {
							field : 'taskType',
							title : '任务类型',
							width : '150',
							align : 'center',
							formatter:function(value,row,index){
								var str = "";
								
								if(!isNull(row.task)){
									var val = row.task.type;
									
									if(val == 1){
										str = "基准图谱建立";
									}else if(val == 2){
										str = "图谱试验抽查-开发阶段";
									}else if(val == 3){
										str = "图谱试验抽查-量产阶段";
									}else{
										str = "第三方委托";
									}
								}
								return "<span title='" + str+ "'>" + str + "</span>"; 
							}
						}, {
							field : 'createTime',
							title : '创建时间',
							width : '125',
							align : 'center',
							formatter : DateTimeFormatter
						} 
			        ]],
			        columns : [ [{
						title:'实验信息', 
						colspan:5
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
						field : 'labType',
						title : '实验类型',
						width : '90',
						align : 'center',
						formatter : function(val){
							var str = "原材料型式"
							if(val == 1){
								str = "零部件图谱";
							}else if(val == 2){
								str = "零部件型式";
							}else if(val == 3){
								str = "原材料图谱";
							}
							return "<span title='" + str + "'>" + str + "</span>";
						}
					},{
						field : 'labCode',
						title : '试验编号',
						width : '140',
						align : 'center',
						formatter : function(value,row,index){
							var str = "";
							var task = row.task;
							
							if(!isNull(task)){
								var taskType = task.type;
								
								if(taskType == 1){
									str = task.partsAtlCode;
								}else if(taskType == 2){
									str = task.matAtlCode;
								}else if(taskType == 3){
									str = task.partsPatCode;
								}else{
									str = task.matPatCode;
								}
							}
							
							if(!isNull(str)){
								return "<span title='"+ str +"'>"+ str +"</span>";
							}
						}
					},{
						field : 'labOrg',
						title : '实验室',
						width : '150',
						align : 'center',
						formatter : function(value,row,index){
							var str = "";
							var task = row.task;
							
							if(!isNull(task)){
								var taskType = task.type;
								
								if(taskType == 1){
									if(!isNull(task.partsAtl)){
										str = task.partsAtl.name;
									}
								}else if(taskType == 2){
									if(!isNull(task.matAtl)){
										str = task.matAtl.name;
									}
								}else if(taskType == 3){
									if(!isNull(task.partsPat)){
										str = task.partsPat.name;
									}
								}else{
									if(!isNull(task.matPat)){
										str = task.matPat.name;
									}
								}
							}
							
							if(!isNull(str)){
								return "<span title='"+ str +"'>"+ str +"</span>";
							}
						}
					}, {
						field : 'labResult',
						title : '实验结果',
						width : '70',
						align : 'center',
						formatter : function(val){
							if(val == 1){
								return "<span style='color:green' title='合格'>合格</span>";
							}else{
								return "<span style='color:red' title='不合格'>不合格</span>";
							}
						}
					},{
						field : 'reason.source',
						title : '费用出处',
						width : '130',
						align : 'center',
						formatter :  function(value, row, index){
							var reason = row.task.reason;
							if(!isNull(reason)){
								return "<span title='"+ reason.source +"'>"+ reason.source +"</span>";
							}							
						}
					},{
						field : 'total',
						title : '总费用',
						width : '80',
						align : 'center',
						formatter :  function(val){
							if(!isNull(val)){
								return "<span title='"+ val +"'>"+val+"</span>";
							}
						}
					},{
						field : 'task.info.vehicle.code',
						title : '车型代码',
						width : '120',
						align : 'center',
						rowspan: 1,
						formatter :  function(value, row, index){
							var vehicle = row.task.info.vehicle;
							if(!isNull(vehicle)){
								return "<span title='"+ vehicle.code +"'>"+ vehicle.code +"</span>";
							}							
						}
					}, {
						field : 'task.info.vehicle.proAddr',
						title : '生产基地',
						width : '120',
						align : 'center',
						rowspan: 1,
						formatter :  function(value, row, index){
							var vehicle = row.task.info.vehicle;
							if(!isNull(vehicle)){
								return "<span title='"+ vehicle.proAddr +"'>"+ vehicle.proAddr +"</span>";
							}							
						}
					}, {
						field : 'task.info.parts.name',
						title : '零件名称',
						width : '100',
						align : 'center',
						formatter : function(value, row, index){
							var parts = row.task.info.parts;
							if(!isNull(parts)){
								return "<span title='"+ parts.name +"'>"+ parts.name +"</span>";
							}							
						}
					}, {
						field : 'task.info.parts.producer',
						title : '供应商',
						width : '100',
						align : 'center',
						formatter : function(value, row, index){
							var parts = row.task.info.parts;
							if(!isNull(parts)){
								return "<span title='"+ parts.producer +"'>"+ parts.producer +"</span>";
							}
						}
					}, {
						field : 'task.info.parts.producerCode',
						title : '供应商代码',
						width : '80',
						align : 'center',
						formatter : function(value, row, index){
							var parts = row.task.info.parts;
							if(!isNull(parts)){
								return "<span title='"+ parts.producerCode +"'>"+ parts.producerCode +"</span>";
							}							
						}
					}, {
						field : 'task.info.parts.proTime',
						title : '样件生产日期',
						width : '100',
						align : 'center',
						formatter : function(value, row, index){
							var parts = row.task.info.parts;
							if(!isNull(parts)){
								var date = formatDate(parts.proTime);
								return "<span title='"+ date +"'>"+ date +"</span>";
							}							
						}
					}, {
						field : 'task.info.material.name',
						title : '材料名称',
						width : '100',
						align : 'center',
						formatter : function(value, row, index){
							var material = row.task.info.material;
							if(!isNull(material)){
								return "<span title='"+ material.matName +"'>"+ material.matName +"</span>";
							}							
						}
					}, {
						field : 'task.info.material.matNo',
						title : '材料牌号',
						width : '100',
						align : 'center',
						formatter : function(value, row, index){
							var material = row.task.info.material;
							if(!isNull(material)){
								return "<span title='"+ material.matNo +"'>"+ material.matNo +"</span>";
							}							
						}
					}, {
						field : 'task.info.material.producer',
						title : '供应商',
						width : '120',
						align : 'center',
						formatter : function(value, row, index){
							var material = row.task.info.material;
							if(!isNull(material)){
								return "<span title='"+ material.producer +"'>"+ material.producer +"</span>";
							}							
						}
					}, {
						field : 'task.applicat.nickName',
						title : '申请人',
						width : '100',
						align : 'center',
						formatter : function(value, row, index){
							var applicat = row.task.applicat;
							if(!isNull(applicat)){
								return "<span title='"+ applicat.nickName +"'>"+ applicat.nickName +"</span>";
							}							
						}
					}, {
						field : 'task.applicat.depart',
						title : '科室',
						width : '120',
						align : 'center',
						formatter : function(value, row, index){
							var applicat = row.task.applicat;
							if(!isNull(applicat)){
								return "<span title='"+ applicat.department +"'>"+ applicat.department +"</span>";
							}							
						}
					}, {
						field : 'task.applicat.org',
						title : '单位/机构',
						width : '180',
						align : 'center',
						formatter : function(value, row, index){
							var org = row.task.applicat.org;
							if(!isNull(org)){
								return "<span title='"+ org.name +"'>"+ org.name +"</span>";
							}							
						}
					} ] ],
					onDblClickRow : function(rowIndex, rowData) {
						costDetail(rowData.id);
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
							'taskType': $("#taskType").combobox("getValue"),
							'labType': $("#labType").combobox("getValue"),
							'labResult': $("#labResult").combobox("getValue"),
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
					'endCreateTime' : $("#q_endCreateTime").val(),
					'taskType': $("#taskType").combobox("getValue"),
					'labType': $("#labType").combobox("getValue"),
					'labResult': $("#labResult").combobox("getValue")
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
				$("#q_startCreateTime").val('');
				$("#q_endCreateTime").val('');
				$("#taskType").combobox("select", "");
				$("#labType").combobox("select", "");
				$("#labResult").combobox("select", "");
				getData(datagrid, getDataUrl, {});
			}
			
			// 关掉对话时回调
			function closeDialog(msg) {
				$('#costDetailDialog').dialog('close');
				tipMsg(msg, function(){
					$('#' + datagrid).datagrid('reload');
					$('#' + recordDatagrid).datagrid('reload');
				});
			}
			
			function costDetail(id) {
				$('#costDetailDialog').dialog({
					title : '结果信息',
					width : 1200,
					height : 500,
					top: 300,
					closed : false,
					cache : false,
					href : "${ctx}/cost/detail?id=" + id + "&type=${type}",
					modal : true
				});
				
				top.parent.scrollTo(0, 250);
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
					<input id="q_code" name="q_code" class="easyui-textbox" style="width: 163px;"> &nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">任务类型：</span>
					<select id="taskType" name="taskType" style="width:163px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
						<option value="">全部</option>	
						<option value="1">基准图谱建立</option>
						<option value="2">图谱试验抽查-开发阶段</option>
						<option value="3">图谱试验抽查-量产阶段</option>
						<option value="4">第三方委托</option>
					</select>&nbsp;&nbsp;&nbsp;&nbsp;

					
					<span class="qlabel">实验类型：</span>
					<select id="labType" name="labType" style="width:163px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
						<option value="">全部</option>	
						<option value="1">零部件图谱</option>
						<option value="2">零部件型式</option>
						<option value="3">原材料图谱</option>
						<option value="4">原材料型式</option>
					</select> &nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">创建时间：</span>
					<input type="text" id="q_startCreateTime" name="q_startCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'q_endCreateTime\')}'})" class="textbox" style="line-height: 23px;width:120px;display:inline-block"/> - 
					<input type="text" id="q_endCreateTime" name="q_endCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'q_startCreateTime\')}'})" class="textbox"  style="line-height: 23px;width:120px;display:inline-block;"/>&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
				
				<div style="margin-top: 10px;">
					<span class="qlabel">实验结果：</span>
					<select id="labResult" name="labResult" style="width:163px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
						<option value="">全部</option>	
						<option value="1">合格</option>
						<option value="2">不合格</option>
					</select> &nbsp;&nbsp;&nbsp;&nbsp;
					
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px;" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" style="width:80px;" onclick="doClear()">清空</a>
				</div>
				
			</div>
			
			<div style="margin-top:10px;">
				<table id="costTable" style="height:auto;width:auto"></table>
			</div>
			
			<div id="costDetailDialog"></div>
		
		</div>

		<!-- footer -->
		<%@include file="../common/footer.jsp"%>
		
		<style type="text/css">
			.qlabel{
				display: inline-block;
				width: 63px;
			}
		</style>
	</body>	
</html>
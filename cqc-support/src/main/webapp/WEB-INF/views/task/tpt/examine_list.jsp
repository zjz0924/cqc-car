<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<html>
	<head>
		<meta charset="utf-8">
		<title>SGMW</title>
		<%@include file="../../common/source.jsp"%>
		<script src="${ctx}/resources/js/jquery.form.js"></script>
		
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
		
		<script type="text/javascript">
			var getDataUrl = "${ctx}/tpt/examineListData";
			var datagrid = "examineTable";
			
			var recordDatagrid = "taskRecordTable";
			var getRecordUrl = "${ctx}/tpt/taskRecordListData";
			// 当前选中的任务的任务号
			var currentTaskCode = "";
			// 是否提交中
			var saving = false;
			
			var toolbar = [{
				text : '通过',
				iconCls : 'icon-ok',
				handler : function() {
					var result = getSelectedIds();
					if(!result){
						return false;
					}
					batchExamine(result, 1, "");
				}
			},{
				text : '不通过',
				iconCls : 'icon-cancel',
				handler : function() {
					var result = getSelectedIds();
					if(!result){
						return false;
					}
					$("#batchRemark").textbox("setValue", "");
					$("#seasonDialog").dialog("open");
					
					// 移去滚动条
					window.parent.scrollY(300);
				}
			}];
			
			$(function(){
				 $("#" + datagrid).datagrid({
			        url : getDataUrl,
			        singleSelect : false, /*是否选中一行*/
			        checkOnSelect: false, // 只有点击checkbox才会选中
			        width:'auto', 	
			        height: "375px",
					title: '任务列表',
			        pagination : true,  /*是否显示下面的分页菜单*/
			        border:false,
			        rownumbers: true,
			        toolbar : toolbar,
			        idField: 'id',
			        frozenColumns: [[
			        	{
				        	field:'ck',
				        	checkbox:true 
				        },  {
							field : '_operation',
							title : '操作',
							width : '40',
							align : 'center',
							formatter : function(value,row,index){
								return '<a href="javascript:void(0)" onclick="examineDetail('+ row.id +')">审核</a>';  	
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
							field : 'createTime',
							title : '录入时间',
							width : '130',
							align : 'center',
							formatter : DateTimeFormatter
						}
			        ]],
			        columns : [ [{
						title:'抽样原因', 
						colspan: 3
					}, {
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
						field : 'reason.origin',
						title : '样件来源',
						width : '120',
						align : 'center',
						rowspan: 1,
						formatter :  function(value, row, index){
							var reason = row.reason;
							if(!isNull(reason)){
								return "<span title='"+ reason.origin +"'>"+ reason.origin +"</span>";
							}							
						}
					},{
						field : 'reason.reason',
						title : '抽样原因',
						width : '120',
						align : 'center',
						rowspan: 1,
						formatter :  function(value, row, index){
							var reason = row.reason;
							if(!isNull(reason)){
								return "<span title='"+ reason.reason +"'>"+ reason.reason +"</span>";
							}							
						}
					},{
						field : 'reason.source',
						title : '费用出处',
						width : '120',
						align : 'center',
						rowspan: 1,
						formatter :  function(value, row, index){
							var reason = row.reason;
							if(!isNull(reason)){
								return "<span title='"+ reason.source +"'>"+ reason.source +"</span>";
							}							
						}
					}, {
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
						field : 'applicat.nickName',
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
						field : 'applicat.department',
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
					} ] ],
					onDblClickRow : function(rowIndex, rowData) {
						examineDetail(rowData.id);
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
							'task_code': $("#task_code").textbox("getValue"),
							'parts_name': $("#parts_name").textbox("getValue"),
							'parts_producer': $("#parts_producer").val(),
							'parts_producerCode': $("#parts_producerCode").textbox("getValue"),
							'startProTime' : $("#q_startProTime").val(),
							'endProTime' : $("#q_endProTime").val(),
							'matName': $("#matName").textbox("getValue"),
							'matNo': $("#matNo").textbox("getValue"),
							'mat_producer': $("#mat_producer").val(),
							'v_code': $("#q_v_code").combobox('getValue'),
							'v_proAddr': $("#q_v_proAddr").combobox('getValue'),
							'applicat_name': $("#applicat_name").textbox("getValue"),
							'applicat_depart': $("#applicat_depart").textbox("getValue"),
							'applicat_org': $('#applicat_org').combotree('getValue'),
							'startCreateTime' : $("#q_startCreateTime").val(),
							'endCreateTime' : $("#q_endCreateTime").val(),
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
			        height: "370px",
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
						width : '220',
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
						width : '300',
						align : 'center',
						formatter : formatCellTooltip
					},{
						field : 'createTime',
						title : '录入时间',
						width : '200',
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
				
				// 零件供应商
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
				
				// 材料供应商
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
				
				// 机构单位
				$('#applicat_org').combotree({
					url: '${ctx}/org/getTreeByType?type=2',
					multiple: false,
					animate: true,
					onBeforeSelect: function(node){
					   if(isNull(node.children)){
							return true;
					   }else{
						   return false;
					   }
					}
				});
				
				
				if("${taskType}" == 1){
                    var dg = $("#" + datagrid);
                    // 隐藏零件信息
                    dg.datagrid('hideColumn', 'reason.origin');
                    dg.datagrid('hideColumn', 'reason.reason');
                    dg.datagrid('hideColumn', 'reason.source');
                    dg.datagrid();
                    
                    $('#datagrid-td-group1-0-0').hide();
                 }
			});
		
			function doSearch() {
				var data = {
					'task_code': $("#task_code").textbox("getValue"),
					'parts_name': $("#parts_name").textbox("getValue"),
					'parts_producer': $("#parts_producer").val(),
					'parts_producerCode': $("#parts_producerCode").textbox("getValue"),
					'startProTime' : $("#q_startProTime").val(),
					'endProTime' : $("#q_endProTime").val(),
					'matName': $("#matName").textbox("getValue"),
					'matNo': $("#matNo").textbox("getValue"),
					'mat_producer': $("#mat_producer").val(),
					'v_code': $("#q_v_code").combobox('getValue'),
					'v_proAddr': $("#q_v_proAddr").combobox('getValue'),
					'applicat_name': $("#applicat_name").textbox("getValue"),
					'applicat_depart': $("#applicat_depart").textbox("getValue"),
					'applicat_org': $('#applicat_org').combotree('getValue'),
					'startCreateTime' : $("#q_startCreateTime").val(),
					'endCreateTime' : $("#q_endCreateTime").val()
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
				$("#task_code").textbox("setValue","");
				$("#parts_name").textbox("setValue","");
				$("#parts_producer").val("");
				$("#parts_producerCode").textbox("setValue","");
				$("#q_startProTime").val("");
				$("#q_endProTime").val("");
				$("#matName").textbox("setValue","");
				$("#matNo").textbox("setValue","");
				$("#mat_producer").val("");
				$("#q_v_code").textbox("setValue","");
				$("#q_v_proAddr").textbox("setValue","");
				$("#applicat_name").textbox("setValue","");
				$("#applicat_depart").textbox("setValue","");
				$('#applicat_org').combotree('setValue', "");
				$("#q_startCreateTime").val('');
				$("#q_endCreateTime").val('');
				getData(datagrid, getDataUrl, {});
			}
			
			// 关掉对话时回调
			function closeDialog(msg) {
				tipMsg(msg, function(){
					$('#examineDetailDialog').dialog('close');
					$('#' + datagrid).datagrid('reload');
					$('#' + recordDatagrid).datagrid('reload');
				});
			}
			
			function examineDetail(id) {
				$('#examineDetailDialog').dialog({
					title : '审核信息',
					width : 1100,
					height : 690,
					closed : false,
					cache : false,
					href : "${ctx}/tpt/examineDetail?id=" + id,
					modal : true
				});
				$('#examineDetailDialog').window('center');
				
				// 移去滚动条
				window.parent.scrollY(480);
			}
			
			function getSelectedIds(){
				var rows =  $("#" + datagrid).datagrid('getChecked');
				if(!isNull(rows)){
					var ids = [];
					for(var i = 0; i < rows.length; i++){
						ids.push(rows[i].id);
					}
					return ids;
				}else{
					errorMsg("请选择要审核的任务");
					return false;
				}
			}
			
			function batchExamine(ids, type, remark){
				if(saving){
					return false;
				}
				saving = true;
				
				$.ajax({
					url: "${ctx}/tpt/batchExamine",
					data:{
						"ids": ids,
						"type": type,
						"remark": remark
					},
					success: function(data){
						if(data.success){
							tipMsg(data.msg, function(){
								$('#' + datagrid).datagrid('reload');
								$('#' + recordDatagrid).datagrid('reload');
							});
						}else{
							errorMsg(data.msg);
						}
						saving = false;
					}
				});
			}
			
			function doBatchSubmit(){
				var remark = $("#batchRemark").textbox("getValue");
				if(isNull(remark)){
					errorMsg("请输入原因");
					$("#batchRemark").next('span').find('input').focus();
					return false;
				}
				
				batchExamine(getSelectedIds(), 2, remark);
				$("#seasonDialog").dialog("close");
			}
			
		</script>
	</head>
	
	<body>
		<div style="margin-top: 15px; padding-left: 20px; margin-bottom: 10px;font-size:12px;">
			<p> <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px;" onclick="$('#queryDiv').toggle();">查询条件</a></p>
			
			<div id="queryDiv" style="display:none;">
				<div style="margin-top: 5px;">
					<span class="qlabel">零件名称：</span>
					<input id="parts_name" name="parts_name" class="easyui-textbox" style="width: 168px;"> &nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">零件供应商：</span>
					<input id="parts_producer" name="parts_producer" type="text"  class="inputAutocomple" style="width:168px;">&nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">供应商代码：</span>
					<input id="parts_producerCode" name="parts_producerCode" class="easyui-textbox" style="width:168px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">生产日期：</span>
					<input type="text" id="q_startProTime" name="q_startProTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'q_endProTime\')}'})" class="textbox" style="line-height: 23px;display:inline-block;width: 80px;"/> - 
					<input type="text" id="q_endProTime" name="q_endProTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'q_startProTime\')}'})" class="textbox"  style="line-height: 23px;display:inline-block;width: 80px;"/>
				</div>
				
				<div style="margin-top: 5px;">
					<span class="qlabel">材料名称：</span>
					<input id="matName" name="matName" class="easyui-textbox" style="width: 168px;"> &nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">材料牌号：</span>
					<input id="matNo" name="matNo" class="easyui-textbox" style="width: 168px;"> &nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">材料供应商：</span>
					<input id="mat_producer" name="mat_producer" type="text"  class="inputAutocomple" style="width:168px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">车型代码：</span>
					<select id="q_v_code" name="q_v_code" style="width:168px;" class="easyui-combobox" data-options="panelHeight: '200px'">
						<option value="">请选择</option>
						<c:forEach items="${carCodeList}" var="vo">
							<option value="${vo.code}" <c:if test="${facadeBean.info.vehicle.code == vo.code }">selected="selected"</c:if>>${vo.code}</option>
						</c:forEach>
					</select>
				</div>
				
				<div style="margin-top: 5px;">
					<span class="qlabel">生产基地：</span>
					<select id="q_v_proAddr" name="q_v_proAddr" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
						<option value="">请选择</option>
						<c:forEach items="${addressList}" var="vo">
							<option value="${vo.name}" <c:if test="${facadeBean.info.vehicle.proAddr == vo.name }">selected="selected"</c:if>>${vo.name}</option>
						</c:forEach>
					</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
					<span class="qlabel">申请人：</span>
					<input id="applicat_name" name="applicat_name" class="easyui-textbox" style="width: 168px;">&nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">科室：</span>
					<input id="applicat_depart" name="applicat_depart" class="easyui-textbox" style="width: 168px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">机构/单位：</span>
					<input id="applicat_org" name="applicat_org" style="width: 168px;"/>
				</div>
				
				<div style="margin-top: 5px;">
					<span class="qlabel">任务号：</span>
					<input id="task_code" name="task_code" class="easyui-textbox" style="width: 168px;"> &nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">录入时间：</span>
					<input type="text" id="q_startCreateTime" name="q_startCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'q_endCreateTime\')}'})" class="textbox" style="line-height: 23px;width:80px;display:inline-block"/> - 
					<input type="text" id="q_endCreateTime" name="q_endCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'q_startCreateTime\')}'})" class="textbox"  style="line-height: 23px;width:80px;display:inline-block;"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px;" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" style="width:80px;" onclick="doClear()">清空</a>
				</div>
			</div>
		</div>
	
		<div style="margin-top:10px;">
			<table id="examineTable" style="height:auto;width:auto"></table>
		</div>
		
		<div style="margin-top:10px;">
			<table id="taskRecordTable" style="height:auto;width:auto"></table>
		</div>
		
		<div id="examineDetailDialog"></div>
		
		<div id="seasonDialog" class="easyui-dialog" title="审核不通过" style="width: 400px; height: 200px; padding: 10px;top:100px;" closed="true" data-options="modal:true">
			<input id="batchRemark" class="easyui-textbox" label="不通过原因：" labelPosition="top" multiline="true" style="width: 350px;height: 100px;"/>
			
			<div align=center style="margin-top: 15px;">
				<a href="javascript:void(0);"  onclick="doBatchSubmit()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">提交</a>&nbsp;&nbsp;
				<a href="javascript:void(0);"  onclick="$('#seasonDialog').dialog('close')" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
			</div>
		</div>
		
	</body>	
</html>
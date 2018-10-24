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
			        frozenColumns: [[
			        	{
							field : '_operation',
							title : '操作',
							width : '50',
							align : 'center',
							formatter : function(value,row,index){
								return '<a href="javascript:void(0)" onclick="detail('+ row.id +')">编辑</a>';  	
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
							field : 'matAtl.name',
							title : '材料图谱实验室',
							width : '150',
							align : 'center',
							formatter : function(value, row, index){
								var org = row.matAtl;
								if(org != null){
									return "<span title='"+ org.name +"'>"+ org.name +"</span>";
								}
							}
						}, {
							field : 'partsAtl.name',
							title : '零件图谱实验室',
							width : '150',
							align : 'center',
							formatter : function(value, row, index){
								var org = row.partsAtl;
								if(org != null){
									return "<span title='"+ org.name +"'>"+ org.name +"</span>";
								}
							}
						}, {
							field : 'createTime',
							title : '录入时间',
							width : '140',
							align : 'center',
							formatter : DateTimeFormatter
						},{
							field : 'state',
							title : '状态',
							width : '90',
							align : 'center',
							formatter : function(val){
								if(val == 1){
									return "<span title='等待审批'>等待审批</span>";
								}else if(val == 2){
									return "<span style='color:red;' title='审批不通过'>审批不通过</span>";
								}
							}
						} 
			        ]],
			        columns : [ [{
						title:'抽样原因', 
						colspan: 3
					},{
						title:'车型信息', 
						colspan: 2
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
					}
				});
		
				// 分页信息
				$('#' + datagrid).datagrid('getPager').pagination({
					pageSize : "${defaultPageSize}",
					pageNumber : 1,
					displayMsg : '当前显示 {from} - {to} 条记录    共  {total} 条记录',
					onSelectPage : function(pageNumber, pageSize) {//分页触发  
						var data = {
							'partsAtlId': $('#q_partsAtl_org').combotree('getValue'),
							'matAtlId': $('#q_matAtl_org').combotree('getValue'),
							'origin': $("#q_origin").combobox('getValue'),
							'reason': $("#q_reason").combobox('getValue'),
							'source': $("#q_source").combobox('getValue'),
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
				
				// 委托实验室
				$('#q_partsAtl_org').combotree({
					url: '${ctx}/org/getTreeByType?type=3',
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
			});
	
			function doSearch() {
				var data = {
					'partsAtlId': $('#q_partsAtl_org').combotree('getValue'),
					'matAtlId': $('#q_matAtl_org').combotree('getValue'),
					'origin': $("#q_origin").combobox('getValue'),
					'reason': $("#q_reason").combobox('getValue'),
					'source': $("#q_source").combobox('getValue'),
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
			
			function doClear() {
				$('#q_partsAtl_org').combotree("setValue","");
				$('#q_matAtl_org').combotree("setValue","");
				$("#q_origin").combobox('select', "");
				$("#q_reason").combobox('select', "");
				$("#q_source").combobox('select', "");
				$("#task_code").textbox("clear");
				$("#parts_name").textbox("clear");
				$("#parts_producer").val(""),
				$("#parts_producerCode").textbox("clear");
				$("#q_startProTime").val(""),
				$("#q_endProTime").val(""),
				$("#matName").textbox("clear");
				$("#matNo").textbox("clear");
				$("#mat_producer").val(""),
				$("#q_v_code").combobox('select', "");
				$("#q_v_proAddr").combobox('select', "");
				$("#applicat_name").textbox("clear");
				$("#applicat_depart").textbox("clear");
				$('#applicat_org').combotree("setValue","");
				$("#q_startCreateTime").val("");
				$("#q_endCreateTime").val("");
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
					top: 100,
					onClose: function(){
						window.location.reload();
					}
				});
				$('#transmitDialog').window('center');
				
				// 移去滚动条
				window.parent.scrollY(495);
			}
		</script>
	</head>
	
	<body>
		<div style="margin-top: 15px; padding-left: 20px; margin-bottom: 10px;font-size:12px;">
			<p> <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px;" onclick="$('#queryDiv').toggle();">查询条件</a></p>
			
			<div id="queryDiv" style="display:none;">
				<div>
					<span class="qlabel">任务号：</span>
					<input id="task_code" name="task_code" class="easyui-textbox" style="width: 168px;"> &nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">样件来源：</span>
					<select id="q_origin" name="q_origin" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
						<option value="">请选择</option>
						<c:forEach items="${optionList}" var="vo">
							<c:if test="${vo.type == 1}">
								<option value="${vo.name}">${vo.name}</option>
							</c:if>
						</c:forEach>
					</select>&nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">抽样原因：</span>
					<select id="q_reason" name="q_reason" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
						<option value="">请选择</option>
						<c:forEach items="${optionList}" var="vo">
							<c:if test="${vo.type == 2}">
								<option value="${vo.name}">${vo.name}</option>
							</c:if>
						</c:forEach>
					</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">费用出处：</span>
					<select id="q_source" name="q_source" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
						<option value="">请选择</option>
						<c:forEach items="${optionList}" var="vo">
							<c:if test="${vo.type == 3}">
								<option value="${vo.name}">${vo.name}</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
				
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
					<span class="qlabel">零件图谱实验室：</span>
					<input id="q_partsAtl_org" name="q_partsAtl_org" style="width: 168px;"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">材料图谱实验室：</span>
					<input id="q_matAtl_org" name="q_matAtl_org" style="width: 168px;"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">录入时间：</span>
					<input type="text" id="q_startCreateTime" name="q_startCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'q_endCreateTime\')}'})" class="textbox" style="line-height: 23px;width:80px;display:inline-block"/> - 
					<input type="text" id="q_endCreateTime" name="q_endCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'q_startCreateTime\')}'})" class="textbox"  style="line-height: 23px;width:80px;display:inline-block;"/>&nbsp;&nbsp;
				
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
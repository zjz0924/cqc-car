<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

	<body>
		<div style="margin-top: 25px;margin-bottom: 10px;font-size:12px;margin-left: 10px;">
			<div>
				<div style="margin-top: 5px;">
					<span class="qlabel">零件名称：</span>
					<input id="tq_parts_name" name="tq_parts_name" class="easyui-textbox" style="width: 168px;"> &nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">零件供应商：</span>
					<input id="tq_parts_producer" name="tq_parts_producer" type="text"  class="inputAutocomple" style="width:168px;">&nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">供应商代码：</span>
					<input id="tq_parts_producerCode" name="tq_parts_producerCode" class="easyui-textbox" style="width:168px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">生产日期：</span>
					<input type="text" id="tq_startProTime" name="tq_startProTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'tq_endProTime\')}'})" class="textbox" style="line-height: 23px;display:inline-block;width: 80px;"/> - 
					<input type="text" id="tq_endProTime" name="tq_endProTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'tq_startProTime\')}'})" class="textbox"  style="line-height: 23px;display:inline-block;width: 80px;"/>
				</div>
				
				<div style="margin-top: 5px;">
					<span class="qlabel">材料名称：</span>
					<input id="tq_matName" name="tq_matName" class="easyui-textbox" style="width: 168px;"> &nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">材料牌号：</span>
					<input id="tq_matNo" name="tq_matNo" class="easyui-textbox" style="width: 168px;"> &nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">材料供应商：</span>
					<input id="tq_mat_producer" name="tq_mat_producer" type="text"  class="inputAutocomple" style="width:168px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">车型代码：</span>
					<select id="tq_v_code" name="tq_v_code" style="width:168px;" class="easyui-combobox" data-options="panelHeight: '200px'">
						<option value="">全部</option>
						<c:forEach items="${carCodeList}" var="vo">
							<option value="${vo.code}" <c:if test="${facadeBean.info.vehicle.code == vo.code }">selected="selected"</c:if>>${vo.code}</option>
						</c:forEach>
					</select>
				</div>
				
				<div style="margin-top: 5px;">
					<span class="qlabel">生产基地：</span>
					<select id="tq_v_proAddr" name="tq_v_proAddr" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
						<option value="">请选择</option>
						<c:forEach items="${addressList}" var="vo">
							<option value="${vo.name}" <c:if test="${facadeBean.info.vehicle.proAddr == vo.name }">selected="selected"</c:if>>${vo.name}</option>
						</c:forEach>
					</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
					<span class="qlabel">申请人：</span>
					<input id="tq_applicat_name" name="tq_applicat_name" class="easyui-textbox" style="width: 168px;">&nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">科室：</span>
					<input id="tq_applicat_depart" name="tq_applicat_depart" class="easyui-textbox" style="width: 168px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">机构/单位：</span>
					<input id="tq_applicat_org" name="tq_applicat_org" style="width: 168px;"/>
				</div>
				
				<div style="margin-top: 5px;">
					<span class="qlabel">任务号：</span>
					<input id="tq_task_code" name="tq_task_code" class="easyui-textbox" style="width: 168px;"> &nbsp;&nbsp;&nbsp;&nbsp;
				
					<span class="qlabel">抽检原因：</span>
					<select id="tq_reason" name="tq_reason" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
						<option value="">全部</option>
						<c:forEach items="${optionList}" var="vo">
							<c:if test="${vo.type == 2}">
								<option value="${vo.name}" <c:if test="${facadeBean.reason.reason == vo.name }">selected="selected"</c:if>>${vo.name}</option>
							</c:if>
						</c:forEach>
					</select> &nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">费用出处：</span>
					<select id="tq_source" name="tq_source" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
						<option value="">全部</option>
						<c:forEach items="${optionList}" var="vo">
							<c:if test="${vo.type == 3}">
								<option value="${vo.name}" <c:if test="${facadeBean.reason.source == vo.name }">selected="selected"</c:if>>${vo.name}</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
				
				<div style="margin-top: 5px;">
					<span class="qlabel">完成时间：</span>
					<input type="text" id="tq_startConfirmTime" name="q_startConfirmTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'tq_endConfirmTime\')}'})" class="textbox" style="line-height: 23px;width:80px;display:inline-block"/> - 
					<input type="text" id="tq_endConfirmTime" name="tq_endConfirmTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'tq_startConfirmTime\')}'})" class="textbox"  style="line-height: 23px;width:80px;display:inline-block;"/> &nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">录入时间：</span>
					<input type="text" id="tq_startCreateTime" name="tq_startCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'tq_endCreateTime\')}'})" class="textbox" style="line-height: 23px;width:80px;display:inline-block"/> - 
					<input type="text" id="tq_endCreateTime" name="tq_endCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'tq_startCreateTime\')}'})" class="textbox"  style="line-height: 23px;width:80px;display:inline-block;"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px;" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" style="width:80px;" onclick="doClear()">清空</a>
				</div>
			</div>
			
			<div style="margin-top:10px;">
				<table id="taskTable" style="height:auto;width:auto"></table>
			</div>
			
			<div id="detailDialog"></div>
		</div>
		
		<script src="${ctx}/resources/js/jquery.form.js"></script>
		<script type="text/javascript">
			var getDataUrl = "${ctx}/ppap/getListData";
			var datagrid = "taskTable";
			
			$(function(){
				 // 任务列表
				 $("#" + datagrid).datagrid({
			        url : getDataUrl,
			        singleSelect : true, /*是否选中一行*/
			        width:'auto', 	
			        height: "390px",
					title: '任务列表',
			        pagination : true,  /*是否显示下面的分页菜单*/
			        border:false,
			        rownumbers: true, 
			        idField: 'id',
			        frozenColumns:[[{
						field : '_operation',
						title : '操作',
						width : '70',
						align : 'center',
						formatter : function(value,row,index){
							return '<a href="javascript:void(0)" onclick="closeDialog('+ index +')">选择</a>';  		
						}
					}, {
			            field : 'id', 
			            hidden: 'true'
			        }, {
						field : 'code',
						title : '任务号',
						width : '150',
						align : 'center',
						sortable: true,
						formatter : formatCellTooltip
					},{
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
					},{
						field : 'createTime',
						title : '录入时间',
						width : '130',
						align : 'center',
						sortable: true,
						formatter : DateTimeFormatter
					},{
						field : 'confirmTime',
						title : '完成时间',
						width : '130',
						align : 'center',
						sortable: true,
						formatter : DateTimeFormatter
					} ]],
			        columns : [ [{
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
						closeDialog(rowIndex);
					}
				});
		
				// 分页信息
				$('#' + datagrid).datagrid('getPager').pagination({
					pageSize : "${defaultPageSize}",
					pageNumber : 1,
					displayMsg : '当前显示 {from} - {to} 条记录    共  {total} 条记录',
					onSelectPage : function(pageNumber, pageSize) {//分页触发  
						var data = {
							'task_code': $("#tq_task_code").textbox("getValue"),
							'parts_name': $("#tq_parts_name").textbox("getValue"),
							'parts_producer': $("#tq_parts_producer").val(),
							'parts_producerCode': $("#tq_parts_producerCode").textbox("getValue"),
							'startProTime' : $("#tq_startProTime").val(),
							'endProTime' : $("#tq_endProTime").val(),
							'matName': $("#tq_matName").textbox("getValue"),
							'matNo': $("#tq_matNo").textbox("getValue"),
							'mat_producer': $("#tq_mat_producer").val(),
							'v_code': $("#tq_v_code").combobox('getValue'),
							'v_proAddr': $("#tq_v_proAddr").combobox('getValue'),
							'applicat_name': $("#tq_applicat_name").textbox("getValue"),
							'applicat_depart': $("#tq_applicat_depart").textbox("getValue"),
							'applicat_org': $('#tq_applicat_org').combotree('getValue'),
							'startCreateTime' : $("#tq_startCreateTime").val(),
							'endCreateTime' : $("#tq_endCreateTime").val(),
							'startConfirmTime' : $("#tq_startConfirmTime").val(),
							'endConfirmTime' : $("#tq_endConfirmTime").val(),
							'reason': $("#tq_reason").textbox("getValue"),
							'source': $("#tq_source").textbox("getValue"),
							'pageNum' : pageNumber,
							'pageSize' : pageSize
						}
						getData(datagrid, getDataUrl, data);
					}
				});
				
				// 零件生产商
				$("#tq_parts_producer").autocomplete("${ctx}/ots/getProducerList?type=1", {
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
				$("#tq_parts_producer").result(function(event, data, formatted){ 
					var obj = eval("(" + data + ")"); //转换成js对象 
					$("#tq_parts_producer").val(obj.text);
				});
				
				// 材料生产商
				$("#tq_mat_producer").autocomplete("${ctx}/ots/getProducerList?type=2", {
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
				$("#tq_mat_producer").result(function(event, data, formatted){ 
					var obj = eval("(" + data + ")"); //转换成js对象 
					$("#tq_mat_producer").val(obj.text);
				});
				
				// 机构单位
				$('#tq_applicat_org').combotree({
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
			});
		
			function doSearch() {
				var data = {
					'task_code': $("#tq_task_code").textbox("getValue"),
					'parts_name': $("#tq_parts_name").textbox("getValue"),
					'parts_producer': $("#tq_parts_producer").val(),
					'parts_producerCode': $("#tq_parts_producerCode").textbox("getValue"),
					'startProTime' : $("#tq_startProTime").val(),
					'endProTime' : $("#tq_endProTime").val(),
					'matName': $("#tq_matName").textbox("getValue"),
					'matNo': $("#tq_matNo").textbox("getValue"),
					'mat_producer': $("#tq_mat_producer").val(),
					'v_code': $("#tq_v_code").combobox('getValue'),
					'v_proAddr': $("#tq_v_proAddr").combobox('getValue'),
					'applicat_name': $("#tq_applicat_name").textbox("getValue"),
					'applicat_depart': $("#tq_applicat_depart").textbox("getValue"),
					'applicat_org': $('#tq_applicat_org').combotree('getValue'),
					'startCreateTime' : $("#tq_startCreateTime").val(),
					'endCreateTime' : $("#tq_endCreateTime").val(),
					'startConfirmTime' : $("#tq_startConfirmTime").val(),
					'endConfirmTime' : $("#tq_endConfirmTime").val(),
					'reason': $("#tq_reason").textbox("getValue"),
					'source': $("#tq_source").textbox("getValue")
				}
				getData(datagrid, getDataUrl, data);
			}
		
			function doClear() {
				$("#tq_task_code").textbox("setValue","");
				$("#tq_parts_name").textbox("setValue","");
				$("#tq_parts_producer").val("");
				$("#tq_parts_producerCode").textbox("setValue","");
				$("#tq_startProTime").val("");
				$("#tq_endProTime").val("");
				$("#tq_matName").textbox("setValue","");
				$("#tq_matNo").textbox("setValue","");
				$("#tq_mat_producer").val("");
				$("#tq_v_code").textbox("setValue","");
				$("#tq_v_proAddr").textbox("setValue","");
				$("#tq_applicat_name").textbox("setValue","");
				$("#tq_applicat_depart").textbox("setValue","");
				$('#tq_applicat_org').combotree('setValue', "");
				$("#tq_startCreateTime").val('');
				$("#tq_endCreateTime").val('');
				$("#tq_startConfirmTime").val('');
				$("#ttq_endConfirmTime").val('');
				$("#tq_reason").textbox("clear");
				$("#tq_source").textbox("clear");
				
				getData(datagrid, getDataUrl, {});
			}
			
			// 关掉对话时回调
			function closeDialog(msg) {
				$('#detailDialog').dialog('close');
				tipMsg(msg, function(){
					$('#' + datagrid).datagrid('reload');
				});
			}
			
			function detail(id) {
				$('#detailDialog').dialog({
					title : '任务详情',
					width : 1200,
					height : 660,
					closed : false,
					cache : false,
					top: 300,
					href : "${ctx}/query/detail?id=" + id,
					modal : true
				});
				//$('#detailDialog').window('center');
				
				top.parent.scrollTo(0, 300);
			}
			
			
			// 关掉对话时回调
			function closeDialog(index) {
				var rows = $('#' + datagrid).datagrid('getRows');
				var row = rows[index];

				if (!isNull(row)) {
					$("#qCode").textbox("setValue", row.code);
					
					// 车型信息
					$("#v_code").textbox("setValue", row.info.vehicle.code);
					$("#v_proAddr").textbox("setValue", row.info.vehicle.proAddr);
					$("#v_remark").textbox("setValue", row.info.vehicle.remark);
					$("#v_proTime").datebox('setValue',formatDate(row.info.vehicle.proTime));
					$("#v_id").val(row.info.vehicle.id);
					
					// 零件信息
					$("#p_name").textbox("setValue", row.info.parts.name);
					$("#p_code").textbox("setValue", row.info.parts.code);
					$("#p_producer").val(row.info.parts.producer);
					$("#p_producerCode").textbox("setValue", row.info.parts.producerCode);
					$("#p_proTime").datebox('setValue',formatDate(row.info.parts.proTime));
					$("#p_num").textbox("setValue", row.info.parts.num);
					$("#p_proNo").textbox("setValue", row.info.parts.proNo);
					$("#p_place").textbox("setValue", row.info.parts.place);
					$("#p_remark").textbox("setValue", row.info.parts.remark);
					$("#p_id").val(row.info.parts.id);
					
					// 材料信息
					$("#m_matName").textbox("setValue", row.info.material.matName);
					$("#m_matNo").textbox("setValue", row.info.material.matNo);
					$("#m_producer").val(row.info.material.producer);
					$("#m_matColor").textbox("setValue", row.info.material.matColor);
					$("#m_proNo").textbox("setValue", row.info.material.proNo);
					$("#m_num").textbox("setValue", row.info.material.num);
					$("#m_remark").textbox("setValue", row.info.material.remark);
					$("#m_id").val(row.info.material.id);
				}
				$('#taskDialog').dialog('close');
			}
		</script>

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

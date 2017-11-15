<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<html>
	<head>
		<meta charset="utf-8">
		<title>SGMW</title>
		<%@include file="../common/source.jsp"%>
		
		<style type="text/css">
			.qlabel{
				display: inline-block;
				width: 75px;
				text-align: right;
			}
			
			.title{
				ont-size: 12px;
				text-transform: uppercase;
				font-weight: 600;
				text-align:center
			}
			
			.count{
				font-size: 50px;
				font-weight: 700;
				text-align:center;
				padding-top: 20px;"
			}
			
			.info-box{
				width: 150px;
				height:150px; 
				color: white;
				float: left;
			}
			
			.icon{
	        	width:16px;
	        	height: 16px;
	        	display: inline-block;
	        }
		</style>
		
		<script type="text/javascript">
			function vehicleInfo() {
				$('#vehicleDialog').dialog({
					title : '整车信息',
					width : 1000,
					height : 520,
					closed : false,
					cache : false,
					href : "${ctx}/vehicle/list",
					modal : true
				});
			}
			
			function materialInfo() {
				$('#materialDialog').dialog({
					title : '原材料信息',
					width : 1000,
					height : 520,
					closed : false,
					cache : false,
					href : "${ctx}/material/list",
					modal : true
				});
				$('#materialDialog').window('center');
			}
			
			
			function partsInfo() {
				$('#partsDialog').dialog({
					title : '零部件信息',
					width : 1000,
					height : 550,
					closed : false,
					cache : false,
					href : "${ctx}/parts/list",
					modal : true
				});
				$('#partsDialog').window('center');
			}
			
			function getResult(){
				var startConfirmTime = $("#q_startConfirmTime").val();
				var endConfirmTime = $("#q_endConfirmTime").val();
				var taskType = $("#q_taskType").combobox("getValue");
				var v_id = $("#v_id").val();
				var p_id = $("#p_id").val();
				var m_id = $("#m_id").val();
				
				if(isNull(startConfirmTime) || isNull(endConfirmTime)){
					errorMsg("请选择确定时间");
					return false;
				}
				
				$.ajax({ 
					url: "${ctx}/statistic/getResult",
					data: {
						"startConfirmTime": startConfirmTime,
						"endConfirmTime": endConfirmTime, 
						"taskType": taskType,
						"v_id": v_id,
						"p_id": p_id,
						"m_id": m_id
					},
					success: function(data){
						if(data.success){
							$("#taskNum").html(data.data.taskNum);
							$("#passNum").html(data.data.passNum);
							$("#onceNum").html(data.data.onceNum);
							$("#twiceNum").html(data.data.twiceNum);
						}
					}
				});
			}
			
			function clearInput(type){
				if(type == 1){
					$("#v_id").val('');
					$("#v_code").textbox('clear');
				}else if(type == 2){
					$("#p_id").val('');
					$("#p_code").textbox('clear');
				}else{
					$("#m_id").val('');
					$("#m_matName").textbox('clear');
				}
			}
			
			function clearAll(){
				$("#q_startConfirmTime").val('');
				$("#q_endConfirmTime").val('');
				$("#q_taskType").combobox('select', "");
				
				$("#v_id").val('');
				$("#v_code").textbox('clear');
				
				$("#p_id").val('');
				$("#p_code").textbox('clear');
				
				$("#m_id").val('');
				$("#m_matName").textbox('clear');
				
				$("#taskNum").html("0");
				$("#passNum").html("0");
				$("#onceNum").html("0");
				$("#twiceNum").html("0"); 
			}
		</script>
	</head>
	
	<body>
		<%@include file="../common/header.jsp"%>
		
		<!--banner-->
		<div class="inbanner XSLR">
			<span style="font-size: 30px;font-weight: bold; margin-top: 70px; display: inline-block; margin-left: 80px;color: #4169E1">${menuName}</span>
		</div>
	
		<div style="margin-top: 25px; padding-left: 20px; margin-bottom: 10px;font-size:12px;margin-left: 5%;margin-right: 5%;height: 500px; ">
			<div>
				<div>
					<span class="qlabel">任务类型：</span>
					<select id="q_taskType" name="q_taskType" style="width:140px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
						<option value="">全部</option>
						<option value="1">车型OTS阶段任务</option>
						<option value="2">车型PPAP阶段任务</option>
						<option value="3">车型SOP阶段任务</option>
						<option value="4">非车型材料任务</option>
					</select>&nbsp;&nbsp;
					
					<span class="qlabel">整车：</span>
					<input type="hidden" id="v_id" name="v_id">
					<input id="v_code" name="v_code" class="easyui-textbox" style="width: 138px;" disabled> &nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="vehicleInfo()" title="选择"><i class="icon icon-search"></i></a>&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="clearInput(1)" title="清除"><i class="icon icon-clear"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;
				
					<span class="qlabel">零部件：</span>
					<input type="hidden" id="p_id" name="p_id">
					<input id="p_code" name="p_code" class="easyui-textbox" style="width: 138px;" disabled> &nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="partsInfo()" title="选择"><i class="icon icon-search"></i></a>&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="clearInput(2)" title="清除"><i class="icon icon-clear"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">原材料：</span>
					<input type="hidden" id="m_id" name="m_id">
					<input id="m_matName" name="m_matName" class="easyui-textbox" style="width: 138px;"> &nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="materialInfo()" title="选择"><i class="icon icon-search"></i></a>&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="clearInput(3)" title="清除"><i class="icon icon-clear"></i></a>
				</div>
				
				<div style="margin-top:10px;">
					<span class="qlabel">确认时间：</span>
					<input type="text" id="q_startConfirmTime" name="q_startConfirmTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'q_endConfirmTime\')}'})" class="textbox" style="line-height: 23px;width:120px;display:inline-block"/> - 
					<input type="text" id="q_endConfirmTime" name="q_endConfirmTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'q_startConfirmTime\')}'})" class="textbox"  style="line-height: 23px;width:120px;display:inline-block;"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px;" onclick="getResult()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" style="width:80px;" onclick="clearAll()">清空</a>
				</div>
			</div>

			<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>

			<div style="margin-top: 50px;">
				<div style="font-weight: bold; color: #1874CD;margin-bottom: 30px;font-size:20px;">统计结果：</div>
				<div class="info-box" style="background-color: #57889c;">
					<div class="count" id="taskNum" >0</div>
					<div class="title">任务数量</div>
				</div>
				<div class="info-box" style="background-color: #26c281;margin-left: 50px;">
					<div class="count" id="passNum" >0</div>
					<div class="title">合格数量</div>
				</div>
				<div class="info-box" style="background-color: #e65097;margin-left: 50px;">
					<div class="count" id="onceNum" >0</div>
					<div class="title">一次不合格数量</div>
				</div>
				<div class="info-box" style="background-color: #d95043;margin-left: 50px;">
					<div class="count" id="twiceNum" >0</div>
					<div class="title">两次不合格数量</div>
				</div>
			</div>

			<div id="vehicleDialog"></div>
			<div id="materialDialog"></div>
			<div id="partsDialog"></div>
		</div>

		<!-- footer -->
		<%@include file="../common/footer.jsp"%>
		
	</body>	
</html>
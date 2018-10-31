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
				font-size: 15px;
				text-transform: uppercase;
				font-weight: 600;
				text-align:center;
				margin-top:25px;
				margin-bottom: 10px;
			}
			
			.count{
				font-size: 20px;
				font-weight: 700;
				padding-top: 10px;"
			}
			
			.info-box{
				width: 220px;
				height:150px; 
				color: white;
				float: left;
			}
			
			.icon{
	        	width:16px;
	        	height: 16px;
	        	display: inline-block;
	        }
	        
	        .title1{
	        	display:inline-block;
	        	width: 80px;
	        	margin-left: 20px;
	        	font-size: 15px;
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
			$(function(){
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
			});
		
			function getResult(){
				$.ajax({ 
					url: "${ctx}/statistic/getResult",
					data: {
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
						'startConfirmTime' : $("#q_startConfirmTime").val(),
						'endConfirmTime' : $("#q_endConfirmTime").val(),
						'taskType': getSelectTaskType(),
						'reason': $("#reason").textbox("getValue"),
						'source': $("#source").textbox("getValue")
					},
					success: function(data){
						if(data.success){
							var taskNum = data.data.taskNum;
							var passNum = data.data.passNum;
							var onceNum = data.data.onceNum;
							
							$("#taskNum").html(taskNum);
							$("#passNum").html(passNum);
							$("#onceNum").html(onceNum);
							
							var passNumPer = percentNum(passNum, taskNum);
							var onceNumPer = percentNum(onceNum, taskNum);
							
							$("#passNum_per").html(passNumPer);
							$("#onceNum_per").html(onceNumPer);
						}
					}
				});
			}
			
			function getSelectTaskType(){
				var types =  $("#q_taskType").combobox('getValues');
				var val = ""
				
				if(!isNull(types)){
					for(var i = 0; i < types.length; i++){
						if(i != types.length - 1){
							val += types[i] + ",";
						}else{
							val += types[i];
						}
					}
				}
				return val;
			}
			
			function percentNum(num, num2) { 
			   if(num == 0 || num2 == 0){
				   return "0 %";
			   }
			   return (Math.round(num / num2 * 10000) / 100.00 + " %"); //小数点后两位百分比
			}
			
			function clearAll(){
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
				$("#q_startConfirmTime").val('');
				$("#q_endConfirmTime").val('');
				$("#q_taskType").combobox("clear");
				$("#reason").textbox("clear");
				$("#source").textbox("clear");
				
				$("#taskNum").html("0");
				$("#passNum").html("0");
				$("#onceNum").html("0");
				$("#passNum_per").html("0 %");
				$("#onceNum_per").html("0 %");
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
							<option value="${vo.code}">${vo.code}</option>
						</c:forEach>
					</select>
				</div>
				
				<div style="margin-top: 5px;">
					<span class="qlabel">生产基地：</span>
					<select id="q_v_proAddr" name="q_v_proAddr" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
						<option value="">请选择</option>
						<c:forEach items="${addressList}" var="vo">
							<option value="${vo.name}">${vo.name}</option>
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
					<span class="qlabel">任务类型：</span>
					<input class="easyui-combobox" id="q_taskType" name="q_taskType" style="width:168px;" data-options="multiple:true,panelHeight: 'auto', valueField: 'value', textField: 'label',data: [{ label: '准图谱建立'    ,value: '1'},{label:'图谱试验抽查-开发阶段'   ,value: '2'},{label: '图谱试验抽查-量产阶段'   ,value: '3'},{label: '第三方委托'   ,value: '4'}]" />
					 &nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">抽检原因：</span>
					<select id="reason" name="reason" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
						<option value="">全部</option>
						<c:forEach items="${optionList}" var="vo">
							<c:if test="${vo.type == 2}">
								<option value="${vo.name}">${vo.name}</option>
							</c:if>
						</c:forEach>
					</select> &nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">费用出处：</span>
					<select id="source" name="source" style="width:160px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
						<option value="">请选择</option>
						<c:forEach items="${optionList}" var="vo">
							<c:if test="${vo.type == 3}">
								<option value="${vo.name}">${vo.name}</option>
							</c:if>
						</c:forEach>
					</select> &nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="qlabel">完成时间：</span>
					<input type="text" id="q_startConfirmTime" name="q_startConfirmTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'q_endConfirmTime\')}'})" class="textbox" style="line-height: 23px;width:80px;display:inline-block"/> - 
					<input type="text" id="q_endConfirmTime" name="q_endConfirmTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'q_startConfirmTime\')}'})" class="textbox"  style="line-height: 23px;width:80px;display:inline-block;"/> &nbsp;&nbsp;&nbsp;
					
				</div>
				
				<div style="margin-top:10px;">
				
					<span class="qlabel">录入时间：</span>
					<input type="text" id="q_startCreateTime" name="q_startCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'q_endCreateTime\')}'})" class="textbox" style="line-height: 23px;width:80px;display:inline-block"/> - 
					<input type="text" id="q_endCreateTime" name="q_endCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'q_startCreateTime\')}'})" class="textbox"  style="line-height: 23px;width:80px;display:inline-block;"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px;" onclick="getResult()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" style="width:80px;" onclick="clearAll()">清空</a>
				</div>
			</div>

			<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>

			<div style="margin-top: 20px;">
				<div style="font-weight: bold; color: #1874CD;font-size:20px;margin-bottom: 15px;">统计结果</div>
				<div style="margin-bottom: 30px;">
					<a href="${ctx}/statistic/export" class="easyui-linkbutton" data-options="iconCls:'icon-import'" style="width:80px;" title="导出结果">导出结果</a>&nbsp;&nbsp;
					<a href="${ctx}/statistic/exportTask" class="easyui-linkbutton" data-options="iconCls:'icon-import'" style="width:80px;" title="导出任务">导出任务</a>
				</div>
				
				<div class="info-box" style="background-color: #57889c;">
					<div class="title">任务数量</div>
					<div class="count" id="taskNum" style="text-align: center;font-size: 50px;">0</div>
				</div>
				
				<div class="info-box" style="background-color: #26c281;margin-left: 50px;">
					<div class="title">合格 </div>
					<div class="count">
						<span class="title1">数量</span>
						<span id="passNum">0</span>
					</div>
					<div class="count">
						<span class="title1">比例</span>
						<span id="passNum_per">0 %</span>
					</div>
				</div>
				
				<div class="info-box" style="background-color: #e65097;margin-left: 50px;">
					<div class="title">一次不合格</div>
					<div class="count">
						<span class="title1">数量</span>
						<span id="onceNum">0</span>
					</div>
					<div class="count">
						<span class="title1">比例</span>
						<span id="onceNum_per">0 %</span>
					</div>
				</div>
			</div>
		</div>

		<!-- footer -->
		<%@include file="../common/footer.jsp"%>
		
	</body>	
</html>
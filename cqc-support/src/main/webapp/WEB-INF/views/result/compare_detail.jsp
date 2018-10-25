<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<div style="margin-left: 20px; margin-top: 10px;">
		<a id="showBtn" href="javascript:void(0);" onclick="expand()" style="color:red;">展开</a>
		<a id="hideBtn" href="javascript:void(0);" onclick="expand()" style="display: none; color: red;">收起</a>
	</div>

	<div style="margin-left: 10px;margin-top:20px;">
		<div class="title">申请人信息</div>
		<div style="width: 98%;display:none;" id="applicatDiv">
			<table class="info">
				<tr class="single-row">
					<td class="title-td">申请人：</td>
					<td class="value-td">${facadeBean.applicat.nickName}</td>
					<td class="title-td">科室：</td>
					<td class="value-td">${facadeBean.applicat.department}</td>
				</tr>
				<tr class="single-row">
					<td class="title-td">机构/单位：</td>
					<td class="value-td">${facadeBean.applicat.org.name}</td>
					<td class="title-td">联系方式：</td>
					<td class="value-td">${facadeBean.applicat.mobile}</td>
				</tr>
				<tr class="couple-row">
					<td class="title-td">备注：</td>
					<td class="value-td" colspan="3">${facadeBean.applicat.remark}</td>
				</tr>
			</table>
		</div>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		
		<div class="title">整车信息</div>
		<div style="width: 98%;display: none;" id="vehicleDiv">
			<table class="info">
				<tr class="single-row">
					<td class="title-td">代码：</td>
					<td class="value-td">${facadeBean.info.vehicle.code}</td>
					<td class="title-td">生产基地：</td>
					<td class="value-td">${facadeBean.info.vehicle.proAddr}</td>
				</tr>
				<tr class="couple-row">
					<td class="title-td">生产日期：</td>
					<td class="value-td"><fmt:formatDate value='${facadeBean.info.vehicle.proTime}' type="date" pattern="yyyy-MM-dd"/></td>
					<td class="title-td">备注：</td>
					<td class="value-td">${facadeBean.info.vehicle.remark}</td>
				</tr>
			</table>
		</div>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		
		<div class="title">零部件信息</div>
		<div style="width: 98%; display: none;" id="partsDiv">
			<table class="info">
				<tr class="single-row">
					<td class="title-td">零件名称：</td>
					<td class="value-td">${facadeBean.info.parts.name}</td>
					<td class="title-td">零件图号：</td>
					<td class="value-td">${facadeBean.info.parts.code}</td>
				</tr>
				<tr class="couple-row">
					<td class="title-td">供应商：</td>
					<td class="value-td">${facadeBean.info.parts.producer}</td>
					<td class="title-td">供应商代码：</td>
					<td class="value-td">${facadeBean.info.parts.producerCode}</td>
				</tr>
				<tr class="single-row">
					<td class="title-td">生产日期：</td>
					<td class="value-td"><fmt:formatDate value='${facadeBean.info.parts.proTime}' type="date" pattern="yyyy-MM-dd"/></td>
					<td class="title-td">样件数量：</td>
					<td class="value-td">${facadeBean.info.parts.num}</td>
				</tr>
				<tr class="single-row">
					<td class="title-td">样件批号：</td>
					<td class="value-td">${facadeBean.info.parts.proNo}</td>
					<td class="title-td">生产场地：</td>
					<td class="value-td">${facadeBean.info.parts.place}</td>
				</tr>
				<tr class="couple-row">
					<td class="title-td">备注：</td>
					<td class="value-td" colspan="3">${facadeBean.info.parts.remark}</td>
				</tr>
			</table>
		</div>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		
		<div class="title">原材料信息</div>
		<div style="width: 98%;display: none;" id="materialDiv">
			<table class="info">
				<tr class="single-row">
					<td class="title-td">材料名称：</td>
					<td class="value-td">${facadeBean.info.material.matName}</td>
					<td class="title-td">材料牌号：</td>
					<td class="value-td">${facadeBean.info.material.matNo}</td>
				
				</tr>
				
				<tr class="couple-row">
					<td class="title-td">供应商：</td>
					<td class="value-td">${facadeBean.info.material.producer}</td>
					<td class="title-td">材料颜色：</td>
					<td class="value-td">${facadeBean.info.material.matColor}</td>
				</tr>
				
				<tr class="single-row">
					<td class="title-td">材料批号：</td>
					<td class="value-td">${facadeBean.info.material.proNo}</td>
					<td class="title-td">样品数量：</td>
					<td class="value-td">${facadeBean.info.material.num}</td>
				</tr>
				
				<tr class="single-row">
					<td class="title-td">备注：</td>
					<td class="value-td" colspan="3">${facadeBean.info.material.remark}</td>
				</tr>
			</table>
		</div>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		
		<div class="title">抽样原因</div>
		<div style="width: 98%;">
			<table class="info">
				<tr class="single-row">
					<td class="title-td">样件来源：</td>
					<td class="value-td">${facadeBean.reason.origin }</td>
					<td class="title-td">抽样原因：</td>
					<td class="value-td">${facadeBean.reason.reason}</td>
				</tr>
				<tr class="single-row">
					<td class="title-td">其他原因描述：</td>
					<td class="value-td">${facadeBean.reason.otherRemark }</td>
					<td class="title-td">费用出处：</td>
					<td class="value-td">${facadeBean.reason.source}</td>
				</tr>
				<tr class="single-row">
					<td class="title-td">备注：</td>
					<td class="value-td">${facadeBean.reason.remark }</td>
				</tr>
			</table>
		</div>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		<div class="title">结果对比</div>
		
		<c:if test="${not empty facadeBean.partsAtlId }">
			<div class="title" style="margin-top:15px;">零部件图谱对比（基准-抽样）</div>
			<c:forEach items="${pAtlasResult}" var="m">
				<div style="margin-bottom: 10px;">
					<c:choose>
						<c:when test="${m.key == 1}">
							<div class="title1">红外光分析图谱</div>
						</c:when>
						<c:when test="${m.key == 2}">
							<div class="title1">差热分析图谱</div>
						</c:when>
						<c:when test="${m.key == 4}">
							<div class="title1">样品照片</div>
						</c:when>
						<c:otherwise>
							<div class="title1">热重分析图谱</div>
						</c:otherwise>
					</c:choose>
					
					<table>
						<tr>
							<td style="padding-left: 15px;">
								<c:if test="${not empty m.value.standard_pic }">
									<a href="${resUrl}/${m.value.standard_pic}" target= _blank><img src="${resUrl}/${m.value.standard_pic}" style="width: 400px;height: 250px;"></a>
								</c:if>
								<c:if test="${empty m.value.standard_pic }">
									<span class="img-span">基准图谱为空</span>
								</c:if>
							</td>
							<td style="padding-left: 35px;">
								<c:if test="${not empty m.value.sampling_pic }">
									<a href="${resUrl}/${m.value.sampling_pic}" target= _blank><img src="${resUrl}/${m.value.sampling_pic}" style="width: 400px;height: 250px;"></a>
								</c:if>
								<c:if test="${empty m.value.sampling_pic }">
									<span class="img-span">抽样图谱为空</span>
								</c:if>
							</td>
						</tr>
					</table>
				</div>
			</c:forEach>
			
			<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		</c:if>
		
		<c:if test="${not empty facadeBean.matAtlId }">
			<div class="title" style="margin-top:15px;">原材料图谱对比（基准-抽样）</div>
			<c:forEach items="${mAtlasResult}" var="m">
				<div style="margin-bottom: 10px;">
					<c:choose>
						<c:when test="${m.key == 1}">
							<div class="title1">红外光分析图谱</div>
						</c:when>
						<c:when test="${m.key == 2}">
							<div class="title1">差热分析图谱</div>
						</c:when>
						<c:when test="${m.key == 4}">
							<div class="title1">样品照片</div>
						</c:when>
						<c:otherwise>
							<div class="title1">热重分析图谱</div>
						</c:otherwise>
					</c:choose>
					
					<table>
						<tr>
							<td style="padding-left: 15px;">
								<c:if test="${not empty m.value.standard_pic }">
									<a href="${resUrl}/${m.value.standard_pic}" target= _blank><img src="${resUrl}/${m.value.standard_pic}" style="width: 400px; height: 250px;"></a>
								</c:if>
								<c:if test="${empty m.value.standard_pic }">
									<span class="img-span">基准图谱为空</span>
								</c:if>
							</td>
							<td style="padding-left: 35px;">
								<c:if test="${not empty m.value.sampling_pic }">
									<a href="${resUrl}/${m.value.sampling_pic}" target= _blank><img src="${resUrl}/${m.value.sampling_pic}" style="width: 400px; height: 250px;"></a>
								</c:if>
								<c:if test="${empty m.value.sampling_pic }">
									<span class="img-span">抽样图谱为空</span>
								</c:if>
							</td>
						</tr>
					</table>
				</div>
			</c:forEach>
		</c:if>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		
		<div class="title" style="margin-top:15px;">一致性判定</div>
		<div>
			<table style="width: 98%;font-size: 14px;">
				<tr style="background: #F0F0F0;height: 30px;font-weight:bold;text-align:center;">
					<td>类型</td>
					<td>样品照片</td>
					<td>红外光分析</td>
					<td>差热分析</td>
					<td>热重分析</td>
					<td>结论</td>
				</tr>			
				
				<c:if test="${not empty facadeBean.partsAtlId }">
					<tr>
						<td style="font-weight:bold;">零部件</td>
						<td align="center">
							<div style="margin-top:5px;">
								<label><input name="p_temp" type="radio" value="1" checked/>一致</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<label><input name="p_temp" type="radio" value="2" />不一致 </label> 
							</div>
							<div style="margin-top:5px;">
								<textarea id="p_temp_remark" name="p_temp_remark" rows="1" cols="25"></textarea>
							</div>
						</td>
						<td align="center">
							<div style="margin-top:5px;">
								<label><input name="p_inf" type="radio" value="1" checked/>一致</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<label><input name="p_inf" type="radio" value="2" />不一致 </label> 
							</div>
							<div style="margin-top:5px;">
								<textarea id="p_inf_remark" name="p_inf_remark" rows="1" cols="25"></textarea>
							</div>
						</td>
						<td align="center">
							<div style="margin-top:5px;">
								<label><input name="p_dt" type="radio" value="1" checked/>一致</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<label><input name="p_dt" type="radio" value="2" />不一致 </label> 
							</div>
							<div style="margin-top:5px;">
								<textarea id="p_dt_remark" name="p_dt_remark" rows="1" cols="25"></textarea>
							</div>
						</td>
						<td align="center">
							<div style="margin-top:5px;">
								<label><input name="p_tg" type="radio" value="1" checked/>一致</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
								<label><input name="p_tg" type="radio" value="2" />不一致 </label> 
							</div>
							<div style="margin-top:5px;">
								<textarea  id="p_tg_remark" name="p_dt_remark" rows="1" cols="25"></textarea>
							</div>
						</td>
						<td align="center">
							<div style="margin-top:5px;">
								<label><input name="p_result" type="radio" value="1" checked/>一致</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
								<label><input name="p_result" type="radio" value="2" />不一致 </label> 
							</div> 
							<div style="margin-top:5px;">
								<textarea id="p_result_remark" name="p_dt_remark" rows="1" cols="25"></textarea>
							</div>
						</td>
					</tr>
				</c:if>
				
				<c:if test="${not empty facadeBean.matAtlId }">
					<tr>
						<td style="font-weight:bold;">原材料</td>
						<td align="center">
							<div style="margin-top:5px;">
								<label><input name="m_temp" type="radio" value="1" checked/>一致</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<label><input name="m_temp" type="radio" value="2" />不一致 </label> 
							</div>
							<div style="margin-top:5px;">
								<textarea id="m_temp_remark" name="m_temp_remark" rows="1" cols="25"></textarea>
							</div>
						</td>
						<td align="center">
							<div style="margin-top:10px;">
								<label><input name="m_inf" type="radio" value="1" checked/>一致</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
								<label><input name="m_inf" type="radio" value="2" />不一致 </label> 
							</div> 
							<div style="margin-top:5px;">
								<textarea id="m_inf_remark" name="m_inf_remark" rows="1" cols="25"></textarea>
							</div>
						</td>
						<td align="center">
							<div style="margin-top:10px;">
								<label><input name="m_dt" type="radio" value="1" checked/>一致</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
								<label><input name="m_dt" type="radio" value="2" />不一致 </label> 
							</div> 
							<div style="margin-top:5px;">
								<textarea id="m_dt_remark" name="m_dt_remark" rows="1" cols="25"></textarea>
							</div>
						</td>
						<td align="center">
							<div style="margin-top:10px;">
								<label><input name="m_tg" type="radio" value="1" checked/>一致</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
								<label><input name="m_tg" type="radio" value="2" />不一致 </label> 
							</div> 
							<div style="margin-top:5px;">
								<textarea id="m_tg_remark" name="m_tg_remark" rows="1" cols="25"></textarea>
							</div>
						</td>
						<td align="center">
							<div style="margin-top:10px;">
								<label><input name="m_result" type="radio" value="1" checked/>一致</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
								<label><input name="m_result" type="radio" value="2" />不一致 </label> 
							</div> 
							<div style="margin-top:5px;">
								<textarea id="m_result_remark" name="m_result_remark" rows="1" cols="25"></textarea>
							</div>
						</td>
					</tr>
				</c:if>
			</table>
		</div>
		
		
		<div style="margin-top:15px;font-weight:bold;color:red;" align="center" id="errorMsg"></div>
		<div align="center" style="margin-top:10px;margin-bottom: 20px;">
			<a href="javascript:void(0);"  onclick="doSubmit(1)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">提交</a>&nbsp;&nbsp;
			<a href="javascript:void(0);"  onclick="doSubmit(2)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">结果异常，重新上传</a>
		</div>
	</div>
			
	<script type="text/javascript">
		// 是否提交中
		var saving = false;
	
		function doSubmit(state){
			if(saving){
				return false;
			}
			saving = true;
			
			// 零部件
			var p_temp = $("input[name='p_temp']:checked").val();
			var p_temp_remark = $("#p_temp_remark").val();
			
			var p_inf = $("input[name='p_inf']:checked").val();
			var p_inf_remark = $("#p_inf_remark").val();
			
			var p_dt = $("input[name='p_dt']:checked").val();
			var p_dt_remark = $("#p_dt_remark").val();
			
			var p_tg = $("input[name='p_tg']:checked").val();
			var p_tg_remark = $("#p_tg_remark").val();
			
			var p_result = $("input[name='p_result']:checked").val();
			var p_result_remark = $("#p_result_remark").val();
			
			// 原材料
			var m_temp = $("input[name='m_temp']:checked").val();
			var m_temp_remark = $("#m_temp_remark").val();
			
			var m_inf = $("input[name='m_inf']:checked").val();
			var m_inf_remark = $("#m_inf_remark").val();
			
			var m_dt = $("input[name='m_dt']:checked").val();
			var m_dt_remark = $("#m_dt_remark").val();
			
			var m_tg = $("input[name='m_tg']:checked").val();
			var m_tg_remark = $("#m_tg_remark").val();
			
			var m_result = $("input[name='m_result']:checked").val();
			var m_result_remark = $("#m_result_remark").val();
			
			$.ajax({
				url: "${ctx}/result/compareResult",
				data: {
					"taskId": "${facadeBean.id}",
					"p_inf": p_inf,
					"p_inf_remark": p_inf_remark,
					"p_dt": p_dt,
					"p_dt_remark": p_dt_remark,
					"p_tg": p_tg,
					"p_tg_remark": p_tg_remark,
					"p_result": p_result,
					"p_result_remark": p_result_remark,
					"m_inf": m_inf,
					"m_inf_remark": m_inf_remark,
					"m_dt": m_dt,
					"m_dt_remark": m_dt_remark,
					"m_tg": m_tg,
					"m_tg_remark": m_tg_remark,
					"m_result": m_result,
					"m_result_remark": m_result_remark,
					"state": state,
					"m_temp": m_temp,
					"m_temp_remark" :m_temp_remark,
					"p_temp": p_temp,
					"p_temp_remark" :p_temp_remark
				},
				success: function(data){
					saving = false;
					if(data.success){
						closeDialog(data.msg);
					}else{
						$("#errorMsg").html(data.msg);						
					}
				}
			});
		}
		
		function expand(){
			$("#vehicleDiv").toggle();
			$("#partsDiv").toggle();
			$("#materialDiv").toggle();
			$("#showBtn").toggle();
			$("#hideBtn").toggle();
			$("#taskInfoDiv").toggle();
			$("#applicatDiv").toggle();
			$("#atlDiv").toggle();
		}
	</script>	
	
	<style type="text/css">
		.title {
			margin-left: 10px;
			margin-bottom: 8px;
			font-size: 14px;
			color: #1874CD;
    		font-weight: bold;
		}
		
		.title1 {
			margin-left: 10px;
			margin-bottom: 8px;
			font-size: 14px;
			color: red;
    		font-weight: bold;
		}
		
		.title-span{
			display: inline-block;
			width: 80px;
		}
		
		.info{
			width:98%;
			margin-left: 5px;
			font-size: 14px;
			border-collapse:collapse;
		}
		
		.info tr{
			height: 30px;
		}
		
		.title-td {
			width:13%;
			padding-left: 5px;
			font-weight: bold;
		}
		
		.value-td{
			width:32%;
			padding-left: 5px;
		}
		
		.value-td1{
			background: #f5f5f5;
			padding-left: 5px;
		}
		
		.req-span{
			font-weight: bold;
			color: red;
		}
		
		.icon{
			width:16px;
			height: 16px;
			display: inline-block;
		}
		
		
		.img-span{
			width: 400px;
			height: 250px;
			display:inline-block;
			border:0.5px dashed #C9C9C9;
			text-align:center;
			line-height:250px;
		}
		
		.single-row{
			background: #F0F0F0;
		}
		
		.couple-row{
			background: #f5f5f5;
		}
		
		.remark-span{
			font-weight: bold;
		}
	</style>
	
</body>

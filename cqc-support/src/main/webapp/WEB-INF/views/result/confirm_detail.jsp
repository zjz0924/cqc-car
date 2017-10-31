<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<div style="margin-left: 10px;margin-top:20px;">
		<div class="title">整车信息</div>
		<div style="width: 98%;">
			<table class="info">
				<tr>
					<td class="title-td">代码：</td>
					<td class="value-td">${facadeBean.info.vehicle.code}</td>
					<td class="title-td">车型：</td>
					<td class="value-td">${facadeBean.info.vehicle.type}</td>
				</tr>
				<tr>
					<td class="title-td">生产日期：</td>
					<td class="value-td"><fmt:formatDate value='${facadeBean.info.vehicle.proTime}' type="date" pattern="yyyy-MM-dd"/></td>
					<td class="title-td">生产地址：</td>
					<td class="value-td">${facadeBean.info.vehicle.proAddr}</td>
				</tr>
				<tr>
					<td class="title-td">备注：</td>
					<td class="value-td">${facadeBean.info.vehicle.remark}</td>
				</tr>
			</table>
		</div>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		
		<div class="title">零部件信息</div>
		<div style="width: 98%;">
			<table class="info">
				<tr>
					<td class="title-td">代码：</td>
					<td class="value-td">${facadeBean.info.parts.code}</td>
					<td class="title-td">名称：</td>
					<td class="value-td">${facadeBean.info.parts.name}</td>
				</tr>
				<tr>
					<td class="title-td">生产商：</td>
					<td class="value-td">${facadeBean.info.parts.org.name}</td>
					<td class="title-td">生产批号：</td>
					<td class="value-td">${facadeBean.info.parts.proNo}</td>
				</tr>
				<tr>
					<td class="title-td">生产日期：</td>
					<td class="value-td"><fmt:formatDate value='${facadeBean.info.parts.proTime}' type="date" pattern="yyyy-MM-dd"/></td>
					<td class="title-td">生产地址：</td>
					<td class="value-td">${facadeBean.info.parts.place}</td>
				</tr>
				<tr>
					<td class="title-td">关键零件：</td>
					<td class="value-td">
						<c:choose>
							<c:when test="${facadeBean.info.parts.isKey == 0}">
								否
							</c:when>
							<c:otherwise>
								是
							</c:otherwise>
						</c:choose>
					</td>
					<td class="title-td">零件型号</td>
					<td class="value-td">
						${facadeBean.info.parts.keyCode}
					</td>
				</tr>
				
				<tr>
					<td class="title-td">备注：</td>
					<td class="value-td">${facadeBean.info.parts.remark}</td>
				</tr>
			</table>
		</div>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		
		<div class="title">原材料信息</div>
		<div style="width: 98%;">
			<table class="info">
				<tr>
					<td class="title-td">材料名称：</td>
					<td class="value-td">${facadeBean.info.material.matName}</td>
					<td class="title-td">生产批号：</td>
					<td class="value-td">${facadeBean.info.material.proNo}</td>
				</tr>
				
				<tr>
					<td class="title-td">生产商：</td>
					<td class="value-td">${facadeBean.info.material.org.name}</td>
					<td class="title-td">生产商地址：</td>
					<td class="value-td">${facadeBean.info.material.org.addr}</td>
				</tr>
				
				<tr>
					<td class="title-td">材料牌号：</td>
					<td class="value-td">${facadeBean.info.material.matNo}</td>
					<td class="title-td">材料颜色：</td>
					<td class="value-td">${facadeBean.info.material.matColor}</td>
				</tr>
				
				<tr>
					<td class="title-td">材料成分表：</td>
					<td class="value-td">
						<c:if test="${not empty facadeBean.info.material.pic}">
							<a target="_blank" href="${resUrl}/${facadeBean.info.material.pic}">
								<img src="${resUrl}/${facadeBean.info.material.pic}" style="width: 100px;height: 50px;"></img>
							</a>
						</c:if>
					</td>
					<td class="title-td">备注：</td>
					<td class="value-td">${facadeBean.info.material.remark}</td>
				</tr>
			</table>
		</div>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		<div class="title">试验结果</div>
		
		<div class="title" style="margin-top:15px;">零部件型式试验结果</div>
		<c:forEach items="${pPfResult}" var="m">
			<div style="margin-left: 10px; margin-bottom: 5px; font-weight: bold;color: red;">
				第${m.key}次试验
				<span style="float:right;margin-right: 25px;">报告上传时间：<fmt:formatDate value='${m.value[0].createTime }' type="date" pattern="yyyy-MM-dd HH:mm:ss"/></span>
			</div>
			<c:forEach items="${m.value}" var="vo" varStatus="vst">
				<table class="info">
					<tr>
						<td class="title-td">试验项目：</td>
						<td class="value-td" colspan="3">${vo.project}</td>
						
					</tr>
					<tr>
						<td class="title-td">参考标准：</td>
						<td class="value-td">${vo.standard}</td>
						<td class="title-td">试验要求：</td>
						<td class="value-td">${vo.require}</td>
					</tr>
					<tr>
						<td class="title-td">试验结果：</td>
						<td class="value-td">${vo.result}</td>
						<td class="title-td">结果评价：</td>
						<td class="value-td">${vo.evaluate}</td>
					</tr>
					
					<tr>
						<td></td>	
					</tr>
				</table>
			</c:forEach>
		</c:forEach>
		
		<div class="title" style="margin-top:15px;">零部件图谱试验结果</div>
		<c:forEach items="${pAtlasResult}" var="m">
			<div style="margin-left: 10px; margin-bottom: 5px; font-weight: bold;color: red;">
				第${m.key}次试验
				<span style="float:right;margin-right: 25px;">报告上传时间：<fmt:formatDate value='${m.value[0].createTime }' type="date" pattern="yyyy-MM-dd HH:mm:ss"/></span>
			</div>
			<table class="info">
				<tr>
					<td class="title-td">图谱类型</td>
					<td class="title-td">图谱描述</td>
					<td class="title-td">选择图谱</td>
				</tr>
			
				<c:forEach items="${m.value}" var="vo" varStatus="vst">
					<tr>
						<td class="value-td">
							<c:if test="${vo.type == 1}">红外光分析</c:if>
							<c:if test="${vo.type == 2}">差热扫描</c:if>
							<c:if test="${vo.type == 3}">热重分析</c:if>
						</td>
						<td class="value-td">${vo.remark}</td>
						<td class="value-td"><a href="${resUrl}/${vo.pic}" target="_blank"><img src="${resUrl}/${vo.pic}" style="width: 100px;height: 50px;"></a></td>
					</tr>
				</c:forEach>
			</table>
		</c:forEach>
		
		<div class="title" style="margin-top:15px;">原材料型式试验结果</div>
		<c:forEach items="${mPfResult}" var="m">
			<div style="margin-left: 10px; margin-bottom: 5px; font-weight: bold;color: red;">
				第${m.key}次试验
				<span style="float:right;margin-right: 25px;">报告上传时间：<fmt:formatDate value='${m.value[0].createTime }' type="date" pattern="yyyy-MM-dd HH:mm:ss"/></span>
			</div>
			<c:forEach items="${m.value}" var="vo" varStatus="vst">
				<table class="info">
					<tr>
						<td class="title-td">试验项目：</td>
						<td class="value-td" colspan="3">${vo.project}</td>
						
					</tr>
					<tr>
						<td class="title-td">参考标准：</td>
						<td class="value-td">${vo.standard}</td>
						<td class="title-td">试验要求：</td>
						<td class="value-td">${vo.require}</td>
					</tr>
					<tr>
						<td class="title-td">试验结果：</td>
						<td class="value-td">${vo.result}</td>
						<td class="title-td">结果评价：</td>
						<td class="value-td">${vo.evaluate}</td>
					</tr>
					
					<tr>
						<td></td>	
					</tr>
				</table>
			</c:forEach>
		</c:forEach>
		
		<div class="title" style="margin-top:15px;">原材料图谱试验结果</div>
		<c:forEach items="${mAtlasResult}" var="m">
			<div style="margin-left: 10px; margin-bottom: 5px; font-weight: bold;color: red;">
				第${m.key}次试验
				<span style="float:right;margin-right: 25px;">报告上传时间：<fmt:formatDate value='${m.value[0].createTime }' type="date" pattern="yyyy-MM-dd HH:mm:ss"/></span>
			</div>
			<table class="info">
				<tr>
					<td class="title-td">图谱类型</td>
					<td class="title-td">图谱描述</td>
					<td class="title-td">选择图谱</td>
				</tr>
			
				<c:forEach items="${m.value}" var="vo" varStatus="vst">
					<tr>
						<td class="value-td">
							<c:if test="${vo.type == 1}">红外光分析</c:if>
							<c:if test="${vo.type == 2}">差热扫描</c:if>
							<c:if test="${vo.type == 3}">热重分析</c:if>
						</td>
						<td class="value-td">${vo.remark}</td>
						<td class="value-td"><a href="${resUrl}/${vo.pic}" target="_blank"><img src="${resUrl}/${vo.pic}" style="width: 100px;height: 50px;"></a></td>
					</tr>
				</c:forEach>
			</table>
		</c:forEach>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		<div class="title" style="margin-top:15px;">结果确认</div>
		
		<!-- OTS 结果确认  -->
		<c:if test="${facadeBean.type == 1}">
			<div style="margin-left: 15px;">
				<div style="margin-bottom: 5px;">零部件图谱试验结果：
					<c:choose>
						<c:when test="${facadeBean.partsAtlResult == 3 }">
							<span id="partsAtl1">
								<a href="javascript:void(0);"  onclick="doSubmit(1, 1)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">全格</a>&nbsp;&nbsp;
								<a href="javascript:void(0);"  onclick="doSubmit(2, 1)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">不全格</a>
							</span>
							<span id="partsAtl2" style="color:green;display:none;">合格</span>
							<span id="partsAtl3" style="color:red;display:none;">不合格</span>
						</c:when>
						<c:when test="${facadeBean.partsAtlResult == 4 }">
							<span style="color:green;">合格</span>
						</c:when>
						<c:otherwise>
							试验进行中
						</c:otherwise>
					</c:choose>
				</div>
				
				<div style="margin-bottom: 5px;">零部件型式试验结果：
					<c:choose>
						<c:when test="${facadeBean.partsPatResult == 3}">
							<span id="partsPat1">
								<a href="javascript:void(0);"  onclick="doSubmit(1, 2)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">全格</a>&nbsp;&nbsp;
								<a href="javascript:void(0);"  onclick="doSubmit(2, 2)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">不全格</a>
							</span>
							<span id="partsPat2" style="color:green;display:none;">合格</span>
							<span id="partsPat3" style="color:red;display:none;">不合格</span>
						</c:when>
						<c:when test="${facadeBean.partsPatResult == 4 }">
							<span style="color:green;">合格</span>
						</c:when>
						<c:otherwise>
							试验进行中
						</c:otherwise>
					</c:choose>
				</div>
				
				<div style="margin-bottom: 5px;">原材料图谱试验结果：
					<c:choose>
						<c:when test="${facadeBean.matAtlResult == 3}">
							<span id="matAtl1">
								<a href="javascript:void(0);"  onclick="doSubmit(1, 3)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">全格</a>&nbsp;&nbsp;
								<a href="javascript:void(0);"  onclick="doSubmit(2, 3)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">不全格</a>
							</span>
							<span id="matAtl2" style="color:green;display:none;">合格</span>
							<span id="matAtl3" style="color:red;display:none;">不合格</span>
						</c:when>
						<c:when test="${facadeBean.matAtlResult == 4 }">
							<span style="color:green;">合格</span>
						</c:when>
						<c:otherwise>
							试验进行中
						</c:otherwise>
					</c:choose>
				</div>
				
				<div style="margin-bottom: 5px;">原材料型式试验结果：
					<c:choose>
						<c:when test="${facadeBean.matPatResult == 3}">
							<span id="matPat1">
								<a href="javascript:void(0);"  onclick="doSubmit(1, 4)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">全格</a>&nbsp;&nbsp;
								<a href="javascript:void(0);"  onclick="doSubmit(2, 4)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">不合格</a>
							</span>
							<span id="matPat2" style="color:green;display:none;">合格</span>
							<span id="matPat3" style="color:red;display:none;">不合格</span>
						</c:when>
						<c:when test="${facadeBean.matPatResult == 4 }">
							<span style="color:green;">合格</span>
						</c:when>
						<c:otherwise>
							试验进行中
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			
			<div style="margin-top:15px;font-weight:bold;color:red;" align="center" id="errorMsg"></div>
			<div align="center" style="margin-top:10px;margin-bottom: 20px;">
				<a href="javascript:void(0);"  onclick="doSubmit(1, 5)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">全部合格</a>
				<a href="javascript:void(0);"  onclick="doSubmit(2, 5)" class="easyui-linkbutton" data-options="iconCls:'icon-no'">全部不合格</a>
			</div>
		</c:if>
		
		<!-- PPAP 对比结果确认 -->
		<c:if test="${facadeBean.type == 2}">
			<div style="margin-left: 15px;">
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
								<c:otherwise>
									<div class="title1">热重分析图谱</div>
								</c:otherwise>
							</c:choose>
							
							<table>
								<tr>
									<td style="padding-left: 15px;">
										<a href="${resUrl}/${m.value.standard_pic}" target= _blank><img src="${resUrl}/${m.value.standard_pic}" style="width: 400px;height: 250px;"></a>
									</td>
									<td style="padding-left: 35px;">
										<a href="${resUrl}/${m.value.sampling_pic}" target= _blank><img src="${resUrl}/${m.value.sampling_pic}" style="width: 400px;height: 250px;"></a>
									</td>
								</tr>
							</table>
						</div>
					</c:forEach>
					
					<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
					
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
								<c:otherwise>
									<div class="title1">热重分析图谱</div>
								</c:otherwise>
							</c:choose>
							
							<table>
								<tr>
									<td style="padding-left: 15px;">
										<a href="${resUrl}/${m.value.standard_pic}" target= _blank><img src="${resUrl}/${m.value.standard_pic}" style="width: 400px; height: 250px;"></a>
									</td>
									<td style="padding-left: 35px;">
										<a href="${resUrl}/${m.value.sampling_pic}" target= _blank><img src="${resUrl}/${m.value.sampling_pic}" style="width: 400px; height: 250px;"></a>
									</td>
								</tr>
							</table>
						</div>
					</c:forEach>
			
			
			
			</div>
		</c:if>
		
	</div>
			
	<script type="text/javascript">
		function doSubmit(result, type){
			
			$.ajax({
				url: "${ctx}/result/confirmResult?time=" + new Date(),
				data: {
					"taskId": "${facadeBean.id}",
					"result": result,
					"type": type
				},
				success: function(data){
					if(data.success){
						
						if(result == 1){
							if(type == 1){
								$("#partsAtl2").show();
								$("#partsAtl1").hide();
							}else if(type == 2){
								$("#partsPat2").show();
								$("#partsPat1").hide();
							}else if(type == 3){
								$("#matAtl2").show();
								$("#matAtl1").hide();
							}else if(type == 4){
								$("#matPat2").show();
								$("#matPat1").hide();
							}else{
								closeDialog(data.msg);
							}
						}else{
							if(type == 1){
								$("#partsAtl3").show();
								$("#partsAtl1").hide();
							}else if(type == 2){
								$("#partsPat3").show();
								$("#partsPat1").hide();
							}else if(type == 3){
								$("#matAtl3").show();
								$("#matAtl1").hide();
							}else if(type == 4){
								$("#matPat3").show();
								$("#matPat1").hide();
							}else{
								closeDialog(data.msg);
							}
						}
						
						// 全部确认完
						var flag = true;
						if(($("#partsAtl1").is(":hidden") || $("#partsAtl1").length < 1) && ($("#partsPat1").is(":hidden") || $("#partsPat1").length < 1) && ($("#matAtl1").is(":hidden") || $("#matAtl1").length < 1) && ($("#matPat1").is(":hidden") || $("#matPat1").length < 1)){
							closeDialog("操作成功");
						}
						
					}else{
						$("#errorMsg").html(data.msg);						
					}
				}
			});
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
		
		.title-span{
			display: inline-block;
			width: 80px;
		}
		
		.info{
			width:98%;
			margin-left: 5px;
			font-size: 14px;
		}
		
		.info tr{
			height: 30px;
		}
		
		.title-td {
			width:13%;
			background: #F0F0F0;
			padding-left: 5px;
			font-weight: bold;
		}
		
		.value-td{
			width:32%;
			background: #f5f5f5;
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
		
	</style>
	
</body>

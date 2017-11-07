<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<c:if test="${applyRecord.type == 1 }">
		<div style="margin-left: 10px;margin-top:20px;">
			<div class="title">整车信息</div>
			<c:if test="${empty newVehicle}">
				<div style="width: 98%;">
					<table class="info" style="width: 98%;">
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
			</c:if>
			
			<c:if test="${not empty newVehicle}">
				<table class="info">
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>代码：</span>
							<span class="val" title="${facadeBean.info.vehicle.code }">${facadeBean.info.vehicle.code }</span>
						</td>
						<td class="input-td">
							<span class="val red-color" title="${newVehicle.code }">${newVehicle.code }</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>车型：</span>
							<span class="val" title="${facadeBean.info.vehicle.type }">${facadeBean.info.vehicle.type }</span>
						</td>
						<td class="input-td">
							<span class="val red-color" title="${newVehicle.type }">${newVehicle.type }</span>
						</td>
					</tr>
	
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>生产日期：</span>
							<span class="val" title="<fmt:formatDate value='${facadeBean.info.vehicle.proTime }' type="date" pattern="yyyy-MM-dd"/>"><fmt:formatDate value='${facadeBean.info.vehicle.proTime }' type="date" pattern="yyyy-MM-dd"/></span>
						</td>
						<td class="input-td">
							<span class="val red-color" title="<fmt:formatDate value='${newVehicle.proTime }' type="date" pattern="yyyy-MM-dd"/>"><fmt:formatDate value='${newVehicle.proTime }' type="date" pattern="yyyy-MM-dd"/></span>
						</td>
					</tr>
	
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>生产地址：</span>
							<span class="val" title="${facadeBean.info.vehicle.proAddr }">${facadeBean.info.vehicle.proAddr }</span>
						</td>
						<td class="input-td">
							<span class="val red-color" title="${newVehicle.proAddr }">${newVehicle.proAddr }</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span">&nbsp;备注：</span> 
							<span class="val" title="${facadeBean.info.vehicle.remark }">${facadeBean.info.vehicle.remark }</span>
						</td>
						<td class="input-td">
							<span class="val red-color" title="${newVehicle.remark }">${newVehicle.remark }</span>
						</td>
					</tr>
				</table>
			</c:if>
		</div>
	
		<div style="margin-left: 10px;margin-top:20px;">
			<div class="title">零部件信息</div>
			
			<c:if test="${empty newParts}">
				<div style="width: 98%;">
					<table class="info" style="width: 98%;">
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
			</c:if>
			
			<c:if test="${not empty newParts}">
				<table class="info">
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>零件号：</span> 
							<span class="val" title="${facadeBean.info.parts.code}">${facadeBean.info.parts.code}</span>
						</td>
						<td class="input-td">
							<span class="val red-color" title="${newParts.code}">${newParts.code}</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>名称：</span>
							<span class="val" title="${facadeBean.info.parts.name}">${facadeBean.info.parts.name}</span>
						</td>
						<td class="input-td">
							<span class="val red-color" title="${newParts.name}">${newParts.name}</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>生产商：</span> 
							<span class="val" title="${facadeBean.info.parts.org.name}">${facadeBean.info.parts.org.name}</span>
						</td>
						<td class="input-td">
							<span class="val red-color" title="${newParts.org.name}">${newParts.org.name}</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>生产批号：</span> 
							<span class="val" title="${facadeBean.info.parts.proNo }">${facadeBean.info.parts.proNo }</span>
						</td>
						<td class="input-td">
							<span class="val red-color" title="${newParts.proNo }">${newParts.proNo }</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>生产日期：</span> 
							<span class="val" title="<fmt:formatDate value='${facadeBean.info.parts.proTime }' type="date" pattern="yyyy-MM-dd"/>"><fmt:formatDate value='${facadeBean.info.parts.proTime }' type="date" pattern="yyyy-MM-dd"/></span>
						</td>
						<td class="input-td">
							<span class="val red-color" title="<fmt:formatDate value='${newParts.proTime }' type="date" pattern="yyyy-MM-dd"/>"><fmt:formatDate value='${newParts.proTime }' type="date" pattern="yyyy-MM-dd"/></span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>生产场地：</span> 
							<span class="val" title="${facadeBean.info.parts.place }">${facadeBean.info.parts.place }</span>
						</td>
						<td class="input-td">
							<span class="val red-color" title="${newParts.place }">${newParts.place }</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>关键零件：</span> 
							<span class="val" title="<c:if test="${facadeBean.info.parts.isKey == 0 }">否</c:if><c:if test="${facadeBean.info.parts.isKey == 1 }">是</c:if>"><c:if test="${facadeBean.info.parts.isKey == 0 }">否</c:if><c:if test="${facadeBean.info.parts.isKey == 1 }">是</c:if></span>
						</td>
						<td class="input-td">
							<span class="val red-color" title="<c:if test="${newParts.isKey == 0 }">否</c:if><c:if test="${newParts.isKey == 1 }">是</c:if>"><c:if test="${newParts.isKey == 0 }">否</c:if><c:if test="${newParts.isKey == 1 }">是</c:if></span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span">零件型号：</span> 
							<span class="val" title="${facadeBean.info.parts.keyCode }">${facadeBean.info.parts.keyCode }</span>
						</td>
						<td class="input-td">
							<span class="val red-color" title="${newParts.keyCode }">${newParts.keyCode }</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span">&nbsp;备注：</span> 
							<span class="val" title="${facadeBean.info.parts.remark }">${facadeBean.info.parts.remark }</span>
						</td>
						<td class="input-td">
							<span class="val red-color" title="${newParts.remark }">${newParts.remark }</span>	
						</td>
					</tr>
				</table>
			</c:if>
		</div>
	
		<div style="margin-left: 10px;margin-top:20px;">
			<div class="title">原材料信息</div>
			
			<c:if test="${empty newMaterial}">
				<div style="width: 98%;">
					<table class="info" style="width: 98%;">
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
									<a target="_blank" href="${resUrl}/${facadeBean.info.material.pic}">${facadeBean.info.material.pic }</a>
								</c:if>
							</td>
							<td class="title-td">备注：</td>
							<td class="value-td">${facadeBean.info.material.remark}</td>
						</tr>
					</table>
				</div>
			</c:if>
			
			<c:if test="${not empty newMaterial}">
				<table class="info">
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>材料名称：</span> 
							<span class="val" title="${facadeBean.info.material.matName }">${facadeBean.info.material.matName }</span>
						</td>
						<td class="input-td">
							<span class="val red-color" title="${newMaterial.matName }">${newMaterial.matName }</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>生产批号：</span> 
							<span class="val" title="${facadeBean.info.material.proNo }">${facadeBean.info.material.proNo }</span>
						</td>
						<td class="input-td">
							<span class="val red-color" title="${newMaterial.proNo }">${newMaterial.proNo }</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>生产商：</span> 
							<span class="val" title="${facadeBean.info.material.org.name }">${facadeBean.info.material.org.name }</span>
						</td>
						<td class="input-td">
							<span class="val red-color" title="${newMaterial.org.name }">${newMaterial.org.name }</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>材料牌号：</span> 
							<span class="val" title="${facadeBean.info.material.matNo }">${facadeBean.info.material.matNo }</span>
						</td>
						<td class="input-td">
							<span class="val red-color" title="${newMaterial.matNo }">${newMaterial.matNo }</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>材料颜色：</span> 
							<span class="val" title="${facadeBean.info.material.matColor }">${facadeBean.info.material.matColor }</span>
						</td>
						<td class="input-td">
							<span class="val red-color" title="${newMaterial.matColor }">${newMaterial.matColor }</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>成分表：</span> 
							<c:if test="${not empty facadeBean.info.material.pic }">
								<a target= _blank  href="${resUrl}/${facadeBean.info.material.pic }">${facadeBean.info.material.pic }</a>
							</c:if>
						</td>
						
						<td class="input-td">
							<c:if test="${not empty newMaterial.pic }">
								<a target= _blank  href="${resUrl}/${newMaterial.pic }">${newMaterial.pic }</a>
							</c:if>
						</td>
					</tr>
					<tr>	
						<td>
							<span class="title-span">备注：</span> 
							<span class="val" title="${facadeBean.info.material.remark }">${facadeBean.info.material.remark }</span>	
						</td>
						<td class="input-td">
							<span class="val red-color" title="${newMaterial.remark }">${newMaterial.remark }</span>
						</td>
					</tr>
				</table>
			</c:if>
		</div>
	</c:if>
	
	<c:if test="${applyRecord.type == 2 }">
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
				
		<div class="title">零部件试验结果</div>
		<table class="info">
			<tr>
				<td style="background: #F0F0F0;font-weight:bold;">序号</td>
				<td class="title-td">试验项目</td>
				<td class="title-td">参考标准</td>
				<td class="title-td">试验要求</td>
				<td class="title-td">试验结果</td>
				<td class="title-td">结果评价</td>
				<td class="title-td">备注</td>
			</tr>
		
			<c:forEach items="${pPfResult_old}" var="vo" varStatus="status">
				<tr>
					<td style="background: #f5f5f5;padding-left:5px;">${status.index + 1}</td>
					<td class="value-td1">
						<span class="val" title="${vo.project}">${vo.project}</span>
					</td>
					<td class="value-td1">
						<span class="val" title="${vo.standard}">${vo.standard}</span>
					</td>
					<td class="value-td1">
						<span class="val" title="${vo.require}">${vo.require}</span>
					</td>
					<td class="value-td1">
						<span class="val" title="${vo.result}">${vo.result}</span>
					</td>
					<td class="value-td1">
						<span class="val" title="${vo.evaluate}">${vo.evaluate}</span>
					</td>
					<td class="value-td1">
						<span class="val" title="${vo.remark}">${vo.remark}</span>
					</td>
				</tr>
			</c:forEach>
		</table>
		
		<div style="margin-left: 10px;color:red;margin-top: 20px;">修改后结果：</div>
		<table class="info">
			<tr>
				<td style="background: #F0F0F0;font-weight:bold;">序号</td>
				<td class="title-td">试验项目</td>
				<td class="title-td">参考标准</td>
				<td class="title-td">试验要求</td>
				<td class="title-td">试验结果</td>
				<td class="title-td">结果评价</td>
				<td class="title-td">备注</td>
			</tr>
		
			<c:forEach items="${pPfResult_new}" var="vo" varStatus="status">
				<tr>
					<td style="background: #f5f5f5;padding-left:5px;">${status.index + 1}</td>
					<td class="value-td1">
						<span class="val red-color" title="${vo.project}">${vo.project}</span>
					</td>
					<td class="value-td1">
						<span class="val red-color" title="${vo.standard}">${vo.standard}</span>
					</td>
					<td class="value-td1">
						<span class="val red-color" title="${vo.require}">${vo.require}</span>
					</td>
					<td class="value-td1">
						<span class="val red-color" title="${vo.result}">${vo.result}</span>
					</td>
					<td class="value-td1">
						<span class="val red-color" title="${vo.evaluate}">${vo.evaluate}</span>
					</td>
					<td class="value-td1">
						<span class="val red-color" title="${vo.remark}">${vo.remark}</span>
					</td>
				</tr>
			</c:forEach>
		</table>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		
		<table class="info">
			<tr>
				<td class="title-td">图谱类型</td>
				<td class="title-td">图谱描述</td>
				<td class="title-td">选择图谱</td>
			</tr>
		
			<c:forEach items="${pAtlasResult_old}" var="vo" varStatus="vst">
				<tr>
					<td class="value-td">
						<c:if test="${vo.type == 1}">红外光分析</c:if>
						<c:if test="${vo.type == 2}">差热扫描</c:if>
						<c:if test="${vo.type == 3}">热重分析</c:if>
					</td>
					<td class="value-td">${vo.remark }</td>
					<td class="value-td">
						<a href="${resUrl}/${vo.pic}" target="_blank"><img src="${resUrl}/${vo.pic}" style="width: 100px;height: 50px;"></a>
					</td>
				</tr>
			</c:forEach>
		</table>
		
		<div style="margin-left: 10px;color:red;margin-top: 20px;">修改后结果：</div>
		<table class="info">
			<tr>
				<td class="title-td">图谱类型</td>
				<td class="title-td">图谱描述</td>
				<td class="title-td">选择图谱</td>
			</tr>
		
			<c:forEach items="${pAtlasResult_new}" var="vo" varStatus="vst">
				<tr>
					<td class="value-td">
						<c:if test="${vo.type == 1}">红外光分析</c:if>
						<c:if test="${vo.type == 2}">差热扫描</c:if>
						<c:if test="${vo.type == 3}">热重分析</c:if>
					</td>
					<td class="value-td">${vo.remark }</td>
					<td class="value-td">
						<a href="${resUrl}/${vo.pic}" target="_blank"><img src="${resUrl}/${vo.pic}" style="width: 100px;height: 50px;"></a>
					</td>
				</tr>
			</c:forEach>
		</table>
		
		<div class="title" style="margin-top: 10px;">原材料试验结果</div>
		<table class="info">
			<tr>
				<td style="background: #F0F0F0;font-weight:bold;">序号</td>
				<td class="title-td">试验项目</td>
				<td class="title-td">参考标准</td>
				<td class="title-td">试验要求</td>
				<td class="title-td">试验结果</td>
				<td class="title-td">结果评价</td>
				<td class="title-td">备注</td>
			</tr>
		
			<c:forEach items="${mPfResult_old}" var="vo" varStatus="status">
				<tr>
					<td style="background: #f5f5f5;padding-left:5px;">${status.index + 1}</td>
					<td class="value-td1">
						<span class="val" title="${vo.project}">${vo.project}</span>
					</td>
					<td class="value-td1">
						<span class="val" title="${vo.standard}">${vo.standard}</span>
					</td>
					<td class="value-td1">
						<span class="val" title="${vo.require}">${vo.require}</span>
					</td>
					<td class="value-td1">
						<span class="val" title="${vo.result}">${vo.result}</span>
					</td>
					<td class="value-td1">
						<span class="val" title="${vo.evaluate}">${vo.evaluate}</span>
					</td>
					<td class="value-td1">
						<span class="val" title="${vo.remark}">${vo.remark}</span>
					</td>
				</tr>
			</c:forEach>
		</table>
		
		<div style="margin-left: 10px;color:red;margin-top: 20px;">修改后结果：</div>
		<table class="info">
			<tr>
				<td style="background: #F0F0F0;font-weight:bold;">序号</td>
				<td class="title-td">试验项目</td>
				<td class="title-td">参考标准</td>
				<td class="title-td">试验要求</td>
				<td class="title-td">试验结果</td>
				<td class="title-td">结果评价</td>
				<td class="title-td">备注</td>
			</tr>
		
			<c:forEach items="${mPfResult_new}" var="vo" varStatus="status">
				<tr>
					<td style="background: #f5f5f5;padding-left:5px;">${status.index + 1}</td>
					<td class="value-td1">
						<span class="val red-color" title="${vo.project}">${vo.project}</span>
					</td>
					<td class="value-td1">
						<span class="val red-color" title="${vo.standard}">${vo.standard}</span>
					</td>
					<td class="value-td1">
						<span class="val red-color" title="${vo.require}">${vo.require}</span>
					</td>
					<td class="value-td1">
						<span class="val red-color" title="${vo.result}">${vo.result}</span>
					</td>
					<td class="value-td1">
						<span class="val red-color" title="${vo.evaluate}">${vo.evaluate}</span>
					</td>
					<td class="value-td1">
						<span class="val red-color" title="${vo.remark}">${vo.remark}</span>
					</td>
				</tr>
			</c:forEach>
		</table>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		
		<table class="info">
			<tr>
				<td class="title-td">图谱类型</td>
				<td class="title-td">图谱描述</td>
				<td class="title-td">选择图谱</td>
			</tr>
		
			<c:forEach items="${mAtlasResult_old}" var="vo" varStatus="vst">
				<tr>
					<td class="value-td">
						<c:if test="${vo.type == 1}">红外光分析</c:if>
						<c:if test="${vo.type == 2}">差热扫描</c:if>
						<c:if test="${vo.type == 3}">热重分析</c:if>
					</td>
					<td class="value-td">${vo.remark }</td>
					<td class="value-td">
						<a href="${resUrl}/${vo.pic}" target="_blank"><img src="${resUrl}/${vo.pic}" style="width: 100px;height: 50px;"></a>
					</td>
				</tr>
			</c:forEach>
		</table>
		
		<div style="margin-left: 10px;color:red;margin-top: 20px;">修改后结果：</div>
		<table class="info">
			<tr>
				<td class="title-td">图谱类型</td>
				<td class="title-td">图谱描述</td>
				<td class="title-td">选择图谱</td>
			</tr>
		
			<c:forEach items="${mAtlasResult_new}" var="vo" varStatus="vst">
				<tr>
					<td class="value-td">
						<c:if test="${vo.type == 1}">红外光分析</c:if>
						<c:if test="${vo.type == 2}">差热扫描</c:if>
						<c:if test="${vo.type == 3}">热重分析</c:if>
					</td>
					<td class="value-td">${vo.remark }</td>
					<td class="value-td">
						<a href="${resUrl}/${vo.pic}" target="_blank"><img src="${resUrl}/${vo.pic}" style="width: 100px;height: 50px;"></a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	
	
		
	 <div id="errorMsg" style="font-weight:bold;color:red;text-align:center;margin-top:10px;"></div>
	 <div style="text-align:center;margin-top:15px;margin-bottom: 15px;" class="data-row">
		<a href="javascript:void(0);"  onclick="notPass()" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">终止</a>
	 </div>

	 <div id="dlg" class="easyui-dialog" title="终止" style="width: 400px; height: 250px; padding: 10px" closed="true" data-options="modal:true">
		<input id="remark" class="easyui-textbox" label="终止原因：" labelPosition="top" multiline="true" style="width: 350px;height: 100px;"/>
		
		<div style="font-weight:bold;color:red;text-align:center;margin-top:10px;" id="remark_error"></div>
		<div align=center style="margin-top: 15px;">
			<a href="javascript:void(0);"  onclick="doSubmit()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">提交</a>&nbsp;&nbsp;
			<a href="javascript:void(0);"  onclick="doCancel()" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
	
	<script type="text/javascript">
		function doSubmit(result, remark){
			$("#errorMsg").html("");
			
			var remark = $("#remark").textbox("getValue");
			if(isNull(remark)){
				$("#remark_error").html("请输入原因");
				$("#remark").next('span').find('input').focus();
				return false;
			}
			$("#remark_error").html("");
			
			$.ajax({
				url: "${ctx}/apply/end",
				data: {
					"id": "${applyRecord.id}",
					"remark": remark
				},
				success: function(data){
					if(data.success){
						$("#dlg").dialog("close");
						closeDialog(data.msg);
					}else{
						$("#remark_error").html(data.msg);
					}
				}
			});
		}
		
		function notPass(catagory){
			$("#remark").textbox("setValue", "");
			$("#dlg").dialog("open");
		}
		
		function doCancel(){
			$("#dlg").dialog("close");
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
		
		.red-color{
			color: red;
			font-weight: bold;
		}
	
	</style>
		
		
	
</body>

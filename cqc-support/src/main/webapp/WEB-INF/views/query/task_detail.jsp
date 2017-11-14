<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<div style="margin-left: 10px;margin-top:20px;margin-bottom:30px;">
		<div class="title">任务信息</div>
		<div style="width: 98%;">
			<table class="info">
				<tr>
					<td class="title-td">任务号：</td>
					<td class="value-td">${facadeBean.code}</td>
					<td class="title-td">任务类型：</td>
					<td class="value-td">
						<c:if test="${facadeBean.type == 1}">OTS阶段任务</c:if>
						<c:if test="${facadeBean.type == 2}">PPAP阶段任务</c:if>
						<c:if test="${facadeBean.type == 3}">SOP阶段任务</c:if>
						<c:if test="${facadeBean.type == 4}">材料研究所任务</c:if>
					</td>
				</tr>
				<tr>
					<td class="title-td">录入时间：</td>
					<td class="value-td"><fmt:formatDate value='${facadeBean.createTime}' type="date" pattern="yyyy-MM-dd"/></td>
					<td class="title-td">完成时间：</td>
					<td class="value-td"><fmt:formatDate value='${facadeBean.confirmTime}' type="date" pattern="yyyy-MM-dd"/></td>
				</tr>
				<tr>
					<td class="title-td">状态：</td>
					<td class="value-td">
						<c:if test="${facadeBean.type == 1 or facadeBean.type == 4}">
							<c:if test="${facadeBean.state == 1}">审核中</c:if>
							<c:if test="${facadeBean.state == 2}">审核不通过</c:if>
							<c:if test="${facadeBean.state == 3}">试验中</c:if>
							<c:if test="${facadeBean.state == 4}">完成</c:if>
							<c:if test="${facadeBean.state == 5}">申请修改</c:if>
							<c:if test="${facadeBean.state == 6}">申请不通过</c:if>
						</c:if>
						
						<c:if test="${facadeBean.type == 2 or facadeBean.type == 3}">
							<c:if test="${facadeBean.state == 1}">审批中</c:if>
							<c:if test="${facadeBean.state == 2}">审批不通过</c:if>
							<c:if test="${facadeBean.state == 3}">结果上传中</c:if>
							<c:if test="${facadeBean.state == 4}">结果比对中</c:if>
							<c:if test="${facadeBean.state == 5}">结果发送中</c:if>
							<c:if test="${facadeBean.state == 6}">结果确认中</c:if>
							<c:if test="${facadeBean.state == 7}">完成</c:if>
							<c:if test="${facadeBean.state == 8}">申请修改</c:if>
							<c:if test="${facadeBean.state == 9}">申请不通过</c:if>
							<c:if test="${facadeBean.state == 10}">等待是否二次抽样</c:if>
							<c:if test="${facadeBean.state == 11}">中止任务</c:if>
						</c:if>
					</td>
					<td class="title-td">备注：</td>
					<td class="value-td"><c:if test="${facadeBean.state == 11}">${facadeBean.remark}</c:if></td>
				</tr>
			</table>
		</div>
	
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
	
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
		
		<c:if test="${facadeBean.type != 4 }">
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
		</c:if>
		
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
							<a target="_blank" href="${resUrl}/${facadeBean.info.material.pic}">${fn:substringAfter(facadeBean.info.material.pic, "/")}</a>
						</c:if>
					</td>
					<td class="title-td">备注：</td>
					<td class="value-td">${facadeBean.info.material.remark}</td>
				</tr>
			</table>
		</div>
		
		<!-- OTS/GS 结果确认  -->
		<c:if test="${facadeBean.type == 1 or facadeBean.type == 4}">
			<c:if test="${facadeBean.state >= 4 }">
				<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
				<div class="title">试验结果</div>
				
				<c:if test="${facadeBean.type == 1 }">
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
				</c:if>
				
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
			</c:if>
		</c:if>
		
		<!-- PPAP 对比结果确认 -->
		<c:if test="${facadeBean.type == 2 or facadeBean.type == 3 }">
			<c:if test="${facadeBean.state >= 6 }">
				<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
				<div class="title">对比结果</div>
				
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
	
				<div style="border: 0.5px dashed #C9C9C9; width: 98%; margin-top: 15px; margin-bottom: 15px;"></div>
				<div class="title">结论</div>
				<div style="margin-bottom:20px;">
					<table style="width: 98%; font-size: 14px;">
						<tr style="background: #F0F0F0; height: 30px; font-weight: bold; text-align: center;">
							<td>类型</td>
							<td>红外光分析</td>
							<td>差热分析</td>
							<td>热重分析</td>
							<td>结论</td>
						</tr>
						
						<c:forEach items="${compareResult}" var="m">
							<tr>
								<td style="font-weight:bold;">${m.key}</td>
								<c:forEach items="${m.value}" var="vo" varStatus="vst">
									<td align="center">
										<div style="margin-top:5px;">
											<label><input name="${m.key}_radio_${vst.index}" type="radio" value="1" <c:if test="${vo.state == 1}">checked</c:if> disabled/>一致</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<label><input name="${m.key}_radio_${vst.index}" type="radio" value="2" <c:if test="${vo.state == 2}">checked</c:if> disabled/>不一致 </label> 
										</div>
										<div style="margin-top:5px;">
											<textarea rows="1" cols="25" disabled>${vo.remark}</textarea>
										</div>
									</td>
								</c:forEach>
							</tr>
						</c:forEach>
					</table>
				</div>
			</c:if>
		</c:if>
	</div>
			
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
		
	</style>
	
</body>

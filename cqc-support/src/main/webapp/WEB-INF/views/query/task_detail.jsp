<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<div style="margin-left: 10px;margin-top:20px;margin-bottom:30px;">
		<div class="title">任务信息</div>
		<div style="width: 98%;">
			<table class="info">
				<tr class="single-row">
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
				<tr class="couple-row">
					<td class="title-td">录入时间：</td>
					<td class="value-td"><fmt:formatDate value='${facadeBean.createTime}' type="date" pattern="yyyy-MM-dd"/></td>
					<td class="title-td">完成时间：</td>
					<td class="value-td"><fmt:formatDate value='${facadeBean.confirmTime}' type="date" pattern="yyyy-MM-dd"/></td>
				</tr>
				<tr class="single-row">
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
					<td class="value-td"><c:if test="${facadeBean.state == 6 or facadeBean.state == 11}">${facadeBean.remark}</c:if></td>
				</tr>
				<tr class="couple-row">
					<td class="title-td">结果：</td>
					<td class="value-td">
						<c:if test="${(facadeBean.type == 1 or facadeBean.type == 4) and facadeBean.state == 4}">
							<c:if test="${facadeBean.failNum == 0}">合格</c:if>
							<c:if test="${facadeBean.failNum == 1}">一次不合格</c:if>
							<c:if test="${facadeBean.failNum == 2}">二次不合格</c:if>
						</c:if>
						<c:if test="${(facadeBean.type == 2 or facadeBean.type == 3) and facadeBean.state == 7}">
							<c:if test="${facadeBean.failNum == 0}">合格</c:if>
							<c:if test="${facadeBean.failNum == 1}">一次不合格</c:if>
							<c:if test="${facadeBean.failNum == 2}">二次不合格</c:if>
						</c:if>
					</td>
					<td class="title-td">原因：</td>
					<td class="value-td">
						<c:if test="${facadeBean.failNum >= 0}">
							${facadeBean.remark}
						</c:if>
					</td>
				</tr>
			</table>
		</div>
	
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
	
		<div class="title">整车信息</div>
		<div style="width: 98%;">
			<table class="info">
				<tr class="single-row">
					<td class="title-td">代码：</td>
					<td class="value-td">${facadeBean.info.vehicle.code}</td>
					<td class="title-td">车型：</td>
					<td class="value-td">${facadeBean.info.vehicle.type}</td>
				</tr>
				<tr class="couple-row">
					<td class="title-td">生产日期：</td>
					<td class="value-td"><fmt:formatDate value='${facadeBean.info.vehicle.proTime}' type="date" pattern="yyyy-MM-dd"/></td>
					<td class="title-td">生产地址：</td>
					<td class="value-td">${facadeBean.info.vehicle.proAddr}</td>
				</tr>
				<tr class="single-row">
					<td class="title-td">备注：</td>
					<td class="value-td" colspan="3">${facadeBean.info.vehicle.remark}</td>
				</tr>
			</table>
		</div>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		
		<c:if test="${facadeBean.type != 4 }">
			<div class="title">零部件信息</div>
			<div style="width: 98%;">
				<table class="info">
					<tr class="single-row">
						<td class="title-td">代码：</td>
						<td class="value-td">${facadeBean.info.parts.code}</td>
						<td class="title-td">名称：</td>
						<td class="value-td">${facadeBean.info.parts.name}</td>
					</tr>
					<tr class="couple-row">
						<td class="title-td">生产商：</td>
						<td class="value-td">${facadeBean.info.parts.org.name}</td>
						<td class="title-td">生产批号：</td>
						<td class="value-td">${facadeBean.info.parts.proNo}</td>
					</tr>
					<tr class="single-row">
						<td class="title-td">生产日期：</td>
						<td class="value-td"><fmt:formatDate value='${facadeBean.info.parts.proTime}' type="date" pattern="yyyy-MM-dd"/></td>
						<td class="title-td">生产地址：</td>
						<td class="value-td">${facadeBean.info.parts.place}</td>
					</tr>
					<tr class="couple-row">
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
					
					<tr class="single-row">
						<td class="title-td">联系人：</td>
						<td class="value-td">${facadeBean.info.parts.contacts}</td>
						
						<td class="title-td">联系电话：</td>
						<td class="value-td">${facadeBean.info.parts.phone}</td>
					</tr>
					
					<tr class="couple-row">
						<td class="title-td">备注：</td>
						<td class="value-td" colspan="3">${facadeBean.info.parts.remark}</td>
					</tr>
				</table>
			</div>
			
			<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		</c:if>
		
		<div class="title">原材料信息</div>
		<div style="width: 98%;">
			<table class="info">
				<tr class="single-row">
					<td class="title-td">材料名称：</td>
					<td class="value-td">${facadeBean.info.material.matName}</td>
					<td class="title-td">生产批号：</td>
					<td class="value-td">${facadeBean.info.material.proNo}</td>
				</tr>
				
				<tr class="couple-row">
					<td class="title-td">生产商：</td>
					<td class="value-td">${facadeBean.info.material.org.name}</td>
					<td class="title-td">生产商地址：</td>
					<td class="value-td">${facadeBean.info.material.org.addr}</td>
				</tr>
				
				<tr class="single-row">
					<td class="title-td">材料牌号：</td>
					<td class="value-td">${facadeBean.info.material.matNo}</td>
					<td class="title-td">材料颜色：</td>
					<td class="value-td">${facadeBean.info.material.matColor}</td>
				</tr>
				
				<tr class="couple-row">
					<td class="title-td">联系人：</td>
					<td class="value-td">${facadeBean.info.material.contacts}</td>
					
					<td class="title-td">联系电话：</td>
					<td class="value-td">${facadeBean.info.material.phone}</td>
				</tr>
				
				<tr class="single-row">
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
			<c:if test="${facadeBean.state >= 2 }">
				<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
				<div class="title">试验结果</div>
				
				<c:if test="${facadeBean.type == 1 }">
					<div class="title" style="margin-top:15px;">零部件型式试验结果</div>
					
					<c:if test="${not empty pPfResult}">
						<c:forEach items="${pPfResult}" var="m">
							<div style="margin-left: 10px; margin-bottom: 5px; font-weight: bold;color: red;">
								第${m.key}次试验
								<span style="float:right;margin-right: 25px;">报告上传时间：<fmt:formatDate value='${m.value[0].createTime }' type="date" pattern="yyyy-MM-dd HH:mm:ss"/></span>
							</div>
							<table class="info">
								<tr class="single-row">
									<td class="table-title" style="width: 5%;">序号</td>
									<td class="table-title"><span class="req-span">*</span>试验项目</td>
									<td class="table-title"><span class="req-span">*</span>参考标准</td>
									<td class="table-title"><span class="req-span">*</span>试验要求</td>
									<td class="table-title"><span class="req-span">*</span>试验结果</td>
									<td class="table-title"><span class="req-span">*</span>结果评价</td>
									<td class="table-title">备注</td>
								</tr>
								<c:forEach items="${m.value}" var="vo" varStatus="vst">
									<tr>
										<td>${vst.index + 1 }</td>
										<td><input class="easyui-textbox" style="width:125px" value="${vo.project}"></td>
										<td><input class="easyui-textbox" style="width:125px" value="${vo.standard}"></td>
										<td><input class="easyui-textbox" style="width:125px" value="${vo.require}"></td>
										<td><input class="easyui-textbox" style="width:125px" value="${vo.result}"></td>
										<td><input class="easyui-textbox" style="width:125px" value="${vo.evaluate}"></td>
										<td><input class="easyui-textbox" style="width:125px" value="${vo.remark}"></td>
									</tr>
								</c:forEach>
							</table>
						</c:forEach>
					</c:if>
					
					<c:if test="${empty pPfResult}">
						<div style="margin-left:20px;color:red;font-weight:bold;">暂无</div>
					</c:if>
					
					
					<div class="title" style="margin-top:15px;">零部件图谱试验结果</div>
					<c:if test="${not empty pAtlasResult}">
						<c:forEach items="${pAtlasResult}" var="m">
							<div style="margin-left: 10px; margin-bottom: 5px; font-weight: bold;color: red;">
								第${m.key}次试验
								<span style="float:right;margin-right: 25px;">报告上传时间：<fmt:formatDate value='${m.value[0].createTime }' type="date" pattern="yyyy-MM-dd HH:mm:ss"/></span>
							</div>
							<table class="info">
								<tr class="single-row">
									<td class="title-td">图谱类型</td>
									<td class="title-td">图谱描述</td>
									<td class="title-td">选择图谱</td>
								</tr>
							
								<c:forEach items="${m.value}" var="vo" varStatus="vst">
									<tr style="line-height: 60px;">
										<td class="value-td">
											<c:if test="${vo.type == 1}">红外光分析</c:if>
											<c:if test="${vo.type == 2}">差热扫描</c:if>
											<c:if test="${vo.type == 3}">热重分析</c:if>
											<c:if test="${vo.type == 4}">样品照片</c:if>
										</td>
										<td class="value-td" title="${vo.remark}" style="word-break : break-all;line-height: 20px;">${vo.remark}</td>
										<td class="value-td">
											<c:if test="${not empty vo.pic}">
												<a href="${resUrl}/${vo.pic}" target="_blank"><img src="${resUrl}/${vo.pic}" style="width: 100px;height: 50px;"></a>									</c:if>
											<c:if test="${empty vo.pic}">
												<span class="img-span1">暂无</span>
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</table>
						</c:forEach>
					</c:if>
					
					<c:if test="${empty pAtlasResult}">
						<div style="margin-left:20px;color:red;font-weight:bold;">暂无</div>
					</c:if>
				</c:if>
				
				<div class="title" style="margin-top:15px;">原材料型式试验结果</div>
				
				<c:if test="${not empty mPfResult}">
					<c:forEach items="${mPfResult}" var="m">
						<div style="margin-left: 10px; margin-bottom: 5px; font-weight: bold;color: red;">
							第${m.key}次试验
							<span style="float:right;margin-right: 25px;">报告上传时间：<fmt:formatDate value='${m.value[0].createTime }' type="date" pattern="yyyy-MM-dd HH:mm:ss"/></span>
						</div>
						<table class="info">
							<tr class="single-row">
								<td class="table-title" style="width: 5%;">序号</td>
								<td class="table-title"><span class="req-span">*</span>试验项目</td>
								<td class="table-title"><span class="req-span">*</span>参考标准</td>
								<td class="table-title"><span class="req-span">*</span>试验要求</td>
								<td class="table-title"><span class="req-span">*</span>试验结果</td>
								<td class="table-title"><span class="req-span">*</span>结果评价</td>
								<td class="table-title">备注</td>
							</tr>
							<c:forEach items="${m.value}" var="vo" varStatus="vst">
								<tr>
									<td>${vst.index + 1 }</td>
									<td><input class="easyui-textbox" style="width:125px" value="${vo.project}"></td>
									<td><input class="easyui-textbox" style="width:125px" value="${vo.standard}"></td>
									<td><input class="easyui-textbox" style="width:125px" value="${vo.require}"></td>
									<td><input class="easyui-textbox" style="width:125px" value="${vo.result}"></td>
									<td><input class="easyui-textbox" style="width:125px" value="${vo.evaluate}"></td>
									<td><input class="easyui-textbox" style="width:125px" value="${vo.remark}"></td>
								</tr>
							</c:forEach>
						</table>
					</c:forEach>
				</c:if>
				
				<c:if test="${empty mPfResult}">
					<div style="margin-left:20px;color:red;font-weight:bold;">暂无</div>
				</c:if>
				
				<div class="title" style="margin-top:15px;">原材料图谱试验结果</div>
				<c:if test="${not empty mAtlasResult}">
					<c:forEach items="${mAtlasResult}" var="m">
						<div style="margin-left: 10px; margin-bottom: 5px; font-weight: bold;color: red;">
							第${m.key}次试验
							<span style="float:right;margin-right: 25px;">报告上传时间：<fmt:formatDate value='${m.value[0].createTime }' type="date" pattern="yyyy-MM-dd HH:mm:ss"/></span>
						</div>
						<table class="info">
							<tr class="single-row">
								<td class="title-td">图谱类型</td>
								<td class="title-td">图谱描述</td>
								<td class="title-td">选择图谱</td>
							</tr>
						
							<c:forEach items="${m.value}" var="vo" varStatus="vst">
								<tr style="line-height: 60px;">
									<td class="value-td">
										<c:if test="${vo.type == 1}">红外光分析</c:if>
										<c:if test="${vo.type == 2}">差热扫描</c:if>
										<c:if test="${vo.type == 3}">热重分析</c:if>
										<c:if test="${vo.type == 4}">样品照片</c:if>
									</td>
									<td class="value-td" title="${vo.remark}" style="word-break : break-all;line-height: 20px;">${vo.remark}</td>
									<td class="value-td">
										<c:if test="${not empty vo.pic}">
											<a href="${resUrl}/${vo.pic}" target="_blank"><img src="${resUrl}/${vo.pic}" style="width: 100px;height: 50px;"></a>									</c:if>
										<c:if test="${empty vo.pic}">
											<span class="img-span1">暂无</span>
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</table>
					</c:forEach>
				</c:if>
				
				<c:if test="${empty mAtlasResult}">
					<div style="margin-left:20px;color:red;font-weight:bold;">暂无</div>
				</c:if>
			</c:if>
		</c:if>
		
		<!-- PPAP 对比结果确认 -->
		<c:if test="${facadeBean.type == 2 or facadeBean.type == 3 }">
			<c:if test="${facadeBean.state >= 6 }">
				<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
				<div class="title">对比结果</div>
				
				<div style="margin-left: 15px;">
					<c:if test="${not empty pAtlasResult}">
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
										<div class="title1">样品照片图谱</div>
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
					
					<c:if test="${not empty mAtlasResult}">	
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
										<div class="title1">样品照片图谱</div>
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
					   
					   <div style="border: 0.5px dashed #C9C9C9; width: 98%; margin-top: 15px; margin-bottom: 15px;"></div>
					 </c:if>
				  </div>
				
				<div class="title">结论</div>
				<div style="margin-bottom:20px;">
					<table style="width: 98%; font-size: 14px;">
						<tr style="background: #F0F0F0; height: 30px; font-weight: bold; text-align: center;">
							<td>类型</td>
							<td>样品照片</td>
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
		
		.img-span{
			width: 400px;
			height: 250px;
			display:inline-block;
			border:0.5px dashed #C9C9C9;
			text-align:center;
			line-height:250px;
		}
		
		.img-span1{
			width: 100px;
			height: 50px;
			display:inline-block;
			border:0.5px dashed #C9C9C9;
			text-align:center;
			line-height:50px;
		}
		
		.title1 {
			margin-left: 10px;
			margin-bottom: 8px;
			font-size: 14px;
			color: red;
    		font-weight: bold;
		}
		
		.single-row{
			background: #F0F0F0;
		}
		
		.couple-row{
			background: #f5f5f5;
		}
		
		.table-title{
			padding-left: 5px;
			font-weight: bold;
		}
	</style>
	
</body>

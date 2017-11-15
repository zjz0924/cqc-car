<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<div style="margin-left: 10px;margin-top:20px;">
		<div class="title">整车信息</div>
		<div style="width: 98%;">
			<table class="info">
				<tr>
					<td class="title-td">代码：</td>
					<td class="value-td">${facadeBean.task.info.vehicle.code}</td>
					<td class="title-td">车型：</td>
					<td class="value-td">${facadeBean.task.info.vehicle.type}</td>
				</tr>
				<tr>
					<td class="title-td">生产日期：</td>
					<td class="value-td"><fmt:formatDate value='${facadeBean.task.info.vehicle.proTime}' type="date" pattern="yyyy-MM-dd"/></td>
					<td class="title-td">生产地址：</td>
					<td class="value-td">${facadeBean.task.info.vehicle.proAddr}</td>
				</tr>
				<tr>
					<td class="title-td">备注：</td>
					<td class="value-td">${facadeBean.task.info.vehicle.remark}</td>
				</tr>
			</table>
		</div>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		
		<c:if test="${facadeBean.task.type != 4}">
			<div class="title">零部件信息</div>
			<div style="width: 98%;">
				<table class="info">
					<tr>
						<td class="title-td">代码：</td>
						<td class="value-td">${facadeBean.task.info.parts.code}</td>
						<td class="title-td">名称：</td>
						<td class="value-td">${facadeBean.task.info.parts.name}</td>
					</tr>
					<tr>
						<td class="title-td">生产商：</td>
						<td class="value-td">${facadeBean.task.info.parts.org.name}</td>
						<td class="title-td">生产批号：</td>
						<td class="value-td">${facadeBean.task.info.parts.proNo}</td>
					</tr>
					<tr>
						<td class="title-td">生产日期：</td>
						<td class="value-td"><fmt:formatDate value='${facadeBean.task.info.parts.proTime}' type="date" pattern="yyyy-MM-dd"/></td>
						<td class="title-td">生产地址：</td>
						<td class="value-td">${facadeBean.task.info.parts.place}</td>
					</tr>
					<tr>
						<td class="title-td">关键零件：</td>
						<td class="value-td">
							<c:choose>
								<c:when test="${facadeBean.task.info.parts.isKey == 0}">
									否
								</c:when>
								<c:otherwise>
									是
								</c:otherwise>
							</c:choose>
						</td>
						<td class="title-td">零件型号</td>
						<td class="value-td">
							${facadeBean.task.info.parts.keyCode}
						</td>
					</tr>
					
					<tr>
						<td class="title-td">备注：</td>
						<td class="value-td">${facadeBean.task.info.parts.remark}</td>
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
					<td class="value-td">${facadeBean.task.info.material.matName}</td>
					<td class="title-td">生产批号：</td>
					<td class="value-td">${facadeBean.task.info.material.proNo}</td>
				</tr>
				
				<tr>
					<td class="title-td">生产商：</td>
					<td class="value-td">${facadeBean.task.info.material.org.name}</td>
					<td class="title-td">生产商地址：</td>
					<td class="value-td">${facadeBean.task.info.material.org.addr}</td>
				</tr>
				
				<tr>
					<td class="title-td">材料牌号：</td>
					<td class="value-td">${facadeBean.task.info.material.matNo}</td>
					<td class="title-td">材料颜色：</td>
					<td class="value-td">${facadeBean.task.info.material.matColor}</td>
				</tr>
				
				<tr>
					<td class="title-td">材料成分表：</td>
					<td class="value-td">
						<c:if test="${not empty facadeBean.task.info.material.pic}">
							<a target="_blank" href="${resUrl}/${facadeBean.task.info.material.pic}">${fn:substringAfter(facadeBean.task.info.material.pic, "/")}</a>
						</c:if>
					</td>
					<td class="title-td">备注：</td>
					<td class="value-td">${facadeBean.task.info.material.remark}</td>
				</tr>
			</table>
		</div>
		
		<!-- OTS 结果确认  -->
		<c:if test="${facadeBean.task.type == 1 || facadeBean.task.type == 4}">
			<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
			<div class="title">试验结果</div>
			
			<c:if test="${facadeBean.task.type == 1}">
				<c:if test="${facadeBean.labType == 2}">
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
				</c:if>
				
				<c:if test="${facadeBean.labType == 1}">
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
			</c:if>
			
			<c:if test="${facadeBean.labType == 4}">
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
			</c:if>
			
			<c:if test="${facadeBean.labType == 3}">
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
		<c:if test="${facadeBean.task.type == 2 || facadeBean.task.type == 3}">
			<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
			<div class="title">对比结果</div> ${facadeBean.labType}
			
			<div style="margin-left: 15px;">
				<c:if test="${facadeBean.labType == 1 }">
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
				</c:if>
					
				<c:if test="${facadeBean.labType == 3 }">
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
				</c:if>
			</div>

			<div style="border: 0.5px dashed #C9C9C9; width: 98%; margin-top: 15px; margin-bottom: 15px;"></div>
			<div class="title">结论</div>
			<div>
				<table style="width: 98%; font-size: 14px;">
					<tr style="background: #F0F0F0; height: 30px; font-weight: bold; text-align: center;">
						<td>类型</td>
						<td>红外光分析</td>
						<td>差热分析</td>
						<td>热重分析</td>
						<td>结论</td>
					</tr>
					
					<c:forEach items="${compareResult}" var="m">
						<c:if test="${(facadeBean.labType == 1 and m.key == '零部件') or (facadeBean.labType == 3 and m.key == '原材料')}">
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
						</c:if>
					</c:forEach>
				</table>
			</div>
		</c:if>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		<div class="title" style="margin-top:15px;">结果确认</div>
	
		<div style="margin-left: 15px;">
			第 <span style="color:red;font-weight:bold;">${facadeBean.times}</span> 次实验，结果确认：<c:if test="${ facadeBean.labResult == 1}"><span style="color:green;font-weight:bold;">合格</span></c:if><c:if test="${ facadeBean.labResult == 2}"><span style="color:red;font-weight:bold;">不合格</span></c:if>
		</div>
		
		
		<c:choose>
			<c:when test="${type == 1}">
				<!-- 待发送 -->
				<div align="center" style="margin-top:10px;margin-bottom: 20px;">
					<a href="javascript:void(0);"  onclick="toSend()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">发送</a>
				</div>
				
				<div id="expItemDialog"></div>
			</c:when>
			<c:otherwise>
				<!-- 已发送 -->
				<div class="title" style="margin-top:15px;">费用详情</div>
				
				<div style="margin-bottom: 50px;">
					<table class="info">
						<tr>
							<td class="title-td">序号</td>
							<td class="title-td">试验项目</td>
							<td class="title-td">参考标准</td>
							<td class="title-td">单价</td>
							<td class="title-td">数量</td>
							<td class="title-td">价格</td>
							<td class="title-td">备注</td>
						</tr>
						
						<c:forEach items="${itemList}" var="vo" varStatus="vst">
							<tr>
								<td class="value-td1">${vst.index + 1 }</td>
								<td class="value-td1">${vo.project }</td>
								<td class="value-td1">${vo.standard }</td>
								<td class="value-td1">${vo.price }</td>
								<td class="value-td1">${vo.num }</td>
								<td class="value-td1">${vo.total }</td>
								<td class="value-td1">${vo.remark }</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
			
	<script type="text/javascript">
	
		function toSend(){
			$('#expItemDialog').dialog({
				title : '费用清单',
				width : 800,
				height : 400,
				closed : false,
				cache : false,
				href : "${ctx}/cost/expItemDetail?id=${facadeBean.id}",
				modal : true
			});
			$('#expItemDialog').window('center');
		}
		
		function doCancel(){
			$("#expItemDialog").dialog("close");
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

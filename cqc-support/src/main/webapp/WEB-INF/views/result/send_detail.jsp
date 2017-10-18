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
					<td class="value-td">${facadeBean.info.parts.producer}</td>
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
					<td class="title-td">生产工艺：</td>
					<td class="value-td">${facadeBean.info.parts.technology}</td>
					<td class="title-td">照片：</td>
					<td class="value-td">
						<c:if test="${not empty facadeBean.info.parts.pic}">
							<a target="_blank" href="${resUrl}/${facadeBean.info.parts.pic}">
								<img src="${resUrl}/${facadeBean.info.parts.pic}" style="width: 100px;height: 50px;"></img>
							</a>
						</c:if>
					</td>
				</tr>
				
				<tr>
					<td class="title-td">材料名称：</td>
					<td class="value-td">${facadeBean.info.parts.matName}</td>
					<td class="title-td">材料牌号：</td>
					<td class="value-td">${facadeBean.info.parts.matNo}</td>
				</tr>
				
				<tr>
					<td class="title-td">材料颜色：</td>
					<td class="value-td">${facadeBean.info.parts.matColor}</td>
					<td class="title-td">材料生产商：</td>
					<td class="value-td">${facadeBean.info.parts.matProducer}</td>
				</tr>
				
				<tr>
					<td class="title-td">备注：</td>
					<td class="value-td">${facadeBean.info.parts.remark}</td>
				</tr>
			</table>
		</div>
		
		<div class="title" style="margin-top:15px;">型式试验结果</div>
		<c:choose>
			<c:when test="${facadeBean.patternResult == 0}">
				<div style="margin-left: 10px;">结果报告还没有上传</div>
			</c:when>
			<c:otherwise>
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
				
			</c:otherwise>
		</c:choose>
		
		<div class="title" style="margin-top:15px;">图谱试验结果</div>
		<c:choose>
			<c:when test="${facadeBean.atlasResult == 0}">
				<div style="margin-left: 10px;">结果报告还没有上传</div>
			</c:when>
			<c:otherwise>
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
			</c:otherwise>
		</c:choose>
		
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
					<td class="title-td">材料生产商：</td>
					<td class="value-td">${facadeBean.info.material.matProducer}</td>
					<td class="title-td">生产商地址：</td>
					<td class="value-td">${facadeBean.info.material.producerAdd}</td>
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
		
		<div class="title" style="margin-top:15px;">型式试验结果</div>
		<c:choose>
			<c:when test="${facadeBean.patternResult == 0}">
				<div style="margin-left: 10px;">结果报告还没有上传</div>
			</c:when>
			<c:otherwise>
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
				
			</c:otherwise>
		</c:choose>
		
		<div class="title" style="margin-top:15px;">图谱试验结果</div>
		<c:choose>
			<c:when test="${facadeBean.atlasResult == 0}">
				<div style="margin-left: 10px;">结果报告还没有上传</div>
			</c:when>
			<c:otherwise>
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
			</c:otherwise>
		</c:choose>
				
		<div style="margin-top:10px;font-weight:bold;color:red;" align="center" id="atlasError"></div>
		<div align="center" style="margin-top:10px;margin-bottom: 20px;">
			<c:choose>
				<c:when test="${facadeBean.atlasResult == 1 and facadeBean.patternResult == 1}">
					<a href="javascript:void(0);"  onclick="doSubmit()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">发送结果</a>
				</c:when>
				<c:when test="${facadeBean.atlasResult == 1 }">
					<a href="javascript:void(0);"  onclick="doSubmit()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">发送图谱结果</a>
				</c:when>
				<c:otherwise>   
			        <a href="javascript:void(0);"  onclick="doSubmit()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">发送型式结果</a>
			    </c:otherwise>   
			</c:choose>
			
			<a href="javascript:void(0);"  onclick="doCancel()" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	
	</div>
			
	
	<script type="text/javascript">
		// 发送结果保存
		function doSubmit(){
	
		}

		function doCancel(){
			$("#uploadDetailDialog").dialog("close");
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
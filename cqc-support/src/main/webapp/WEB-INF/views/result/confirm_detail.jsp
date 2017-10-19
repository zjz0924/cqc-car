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
		
		<c:choose>
			<c:when test="${type == 2}">
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
				
					<c:forEach items="${pAtlasResult}" var="m">
						<div style="margin-left: 10px; margin-bottom: 5px; margin-top: 10px; font-weight: bold;color: red;">
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
			</c:when>
			<c:otherwise>
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
					
					<c:forEach items="${mAtlasResult}" var="m">
						<div style="margin-left: 10px; margin-bottom: 5px; margin-top: 10px; font-weight: bold;color: red;">
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
		
		<div style="margin-top:15px;font-weight:bold;color:red;" align="center" id="errorMsg"></div>
		<div align="center" style="margin-top:10px;margin-bottom: 20px;">
			<a href="javascript:void(0);"  onclick="doSubmit(1)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">合格</a>
			<a href="javascript:void(0);"  onclick="doSubmit(2)" class="easyui-linkbutton" data-options="iconCls:'icon-no'">不合格</a>
		</div>
	</div>
			
	
	<script type="text/javascript">
		function doSubmit(result){
			$.ajax({
				url: "${ctx}/result/confirmResult?time=" + new Date(),
				data: {
					"taskId": "${facadeBean.id}",
					"type": "${type}",
					"result": result
				},
				success: function(data){
					if(data.success){
						closeDialog(data.msg);
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

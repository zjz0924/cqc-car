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
		<div class="title">结果对比</div>
		
		<div class="title" style="margin-top:15px;">零部件图谱对比</div>
		<c:forEach items="${pAtlasResult}" var="m">
			<div style="margin-bottom: 10px;">
				<c:choose>
					<c:when test="${m.key == 1}">
						<div class="title">红外光分析图谱</div>
					</c:when>
					<c:when test="${m.key == 2}">
						<div class="title">差热分析图谱</div>
					</c:when>
					<c:otherwise>
						<div class="title">热重分析图谱</div>
					</c:otherwise>
				</c:choose>
				
				<table>
					<tr>
						<td style="padding-left: 15px;"><div><img src="${resUrl}/${m.value.standard_pic}" style="width: 400px;height: 250px;"></div></td>
						<td style="padding-left: 25px;"><div><img src="${resUrl}/${m.value.sampling_pic}" style="width: 400px;height: 250px;"></div></td>
					</tr>
				</table>
			</div>
		</c:forEach>
		
		<div class="title" style="margin-top:15px;">原材料图谱试验结果</div>
		<c:forEach items="${mAtlasResult}" var="m">
			<div style="margin-bottom: 10px;">
				<c:choose>
					<c:when test="${m.key == 1}">
						<div class="title">红外光分析图谱</div>
					</c:when>
					<c:when test="${m.key == 2}">
						<div class="title">差热分析图谱</div>
					</c:when>
					<c:otherwise>
						<div class="title">热重分析图谱</div>
					</c:otherwise>
				</c:choose>
				
				<table>
					<tr>
						<td style="padding-left: 15px;"><div><img src="${resUrl}/${m.value.standard_pic}" style="width: 400px; height: 250px;"></div></td>
						<td style="padding-left: 25px;"><div><img src="${resUrl}/${m.value.sampling_pic}" style="width: 400px; height: 250px;"></div></td>
					</tr>
				</table>
			</div>
		</c:forEach>
		
		<div style="margin-top:15px;font-weight:bold;color:red;" align="center" id="errorMsg"></div>
		<div align="center" style="margin-top:10px;margin-bottom: 20px;">
			<a href="javascript:void(0);"  onclick="doSubmit(1)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">正常</a>
			<a href="javascript:void(0);"  onclick="doSubmit(2)" class="easyui-linkbutton" data-options="iconCls:'icon-no'">异常</a>
		</div>
	</div>
			
	<script type="text/javascript">
		function doSubmit(result){
			
			$.ajax({
				url: "${ctx}/result/compareResult?time=" + new Date(),
				data: {
					"taskId": "${facadeBean.id}",
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

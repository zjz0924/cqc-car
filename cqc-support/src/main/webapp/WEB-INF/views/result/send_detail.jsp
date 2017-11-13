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
		
		<c:if test="${facadeBean.type != 4}">
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
		
		<c:if test="${(facadeBean.partsPatId == currentAccount.org.id or currentAccount.role.code == superRoleCole) and ( facadeBean.partsPatResult == 2) }">
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
		
		<c:if test="${(facadeBean.partsAtlId == currentAccount.org.id or currentAccount.role.code == superRoleCole) and (facadeBean.partsAtlResult == 2) }">
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
		
		<c:if test="${(facadeBean.matPatId == currentAccount.org.id or currentAccount.role.code == superRoleCole) and (facadeBean.matPatResult == 2) }">
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
		
		<c:if test="${(facadeBean.matAtlId == currentAccount.org.id or currentAccount.role.code == superRoleCole) and (facadeBean.matAtlResult == 2) }">
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
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		<div class="title" style="margin-top:15px;">结果发送</div>
		<div style="margin-left: 15px;">
			<c:if test="${(facadeBean.partsAtlId == currentAccount.org.id or currentAccount.role.code == superRoleCole) and (facadeBean.partsAtlResult == 2) }">
				<div style="margin-bottom: 5px;">零部件图谱试验结果：<input id="pAtlOrg" name="pAtlOrg"/>&nbsp;&nbsp;&nbsp;&nbsp;<span id="pAtlOrgError" style="color:red;"></span></div>
			</c:if>
			
			<c:if test="${(facadeBean.partsPatId == currentAccount.org.id or currentAccount.role.code == superRoleCole) and ( facadeBean.partsPatResult == 2) }">
				<div style="margin-bottom: 5px;">零部件型式试验结果：<input id="pPatOrg" name="pPatOrg"/>&nbsp;&nbsp;&nbsp;&nbsp;<span id="pPatOrgError" style="color:red;"></span></div>
			</c:if>
			
			<c:if test="${(facadeBean.matAtlId == currentAccount.org.id or currentAccount.role.code == superRoleCole) and (facadeBean.matAtlResult == 2) }">
				<div style="margin-bottom: 5px;">原材料图谱试验结果：<input id="mAtlOrg" name="mAtlOrg"/>&nbsp;&nbsp;&nbsp;&nbsp;<span id="mAtlOrgError" style="color:red;"></span></div>
			</c:if>
			
			<c:if test="${(facadeBean.matPatId == currentAccount.org.id or currentAccount.role.code == superRoleCole) and (facadeBean.matPatResult == 2) }">
				<div style="margin-bottom: 5px;">原材料型式试验结果：<input id="mPatOrg" name="mPatOrg"/>&nbsp;&nbsp;&nbsp;&nbsp;<span id="mPatOrgError" style="color:red;"></span></div>
			</c:if>
		</div>
				
		<div style="margin-top:10px;font-weight:bold;color:red;" align="center" id="atlasError"></div>
		<div align="center" style="margin-top:10px;margin-bottom: 20px;">
			<a id="sendBtn" href="javascript:void(0);"  onclick="doSubmit(3)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">发送结果</a>
			<a id="cancelBtn" href="javascript:void(0);"  onclick="doCancel()" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
			
	
	<script type="text/javascript">
		var pAtlOrg;
		var pPatOrg;
		var mAtlOrg;
		var mPatOrg 
	
		$(function(){
			// 零部件图谱试验结果
			pAtlOrg = $("#pAtlOrg").length;
			if(pAtlOrg > 0){
				$('#pAtlOrg').combotree({
					url: '${ctx}/org/tree',
					multiple: true,
					animate: true,
					width: '250px',
					panelHeight: '150px'
				});
			
				// 只有最底层才能选择
				var pAtlOrgTree = $('#pAtlOrg').combotree('tree');	
				pAtlOrgTree.tree({
					checkbox: function(node){
					   if(isNull(node.children)){
							return true;
					   }else{
						   return false;
					   }
				   }
				});
			}
			
			// 零部件型式试验结果
			pPatOrg = $("#pPatOrg").length;
			if(pPatOrg > 0){
				$('#pPatOrg').combotree({
					url: '${ctx}/org/tree',
					multiple: true,
					animate: true,
					width: '250px',
					panelHeight: '150px'
				});
			
				// 只有最底层才能选择
				var pPatOrgTree = $('#pPatOrg').combotree('tree');	
				pPatOrgTree.tree({
					checkbox: function(node){
					   if(isNull(node.children)){
							return true;
					   }else{
						   return false;
					   }
				   }
				});
			}
			
			
			// 原材料图谱试验结果
			mAtlOrg = $("#mAtlOrg").length;
			if(mAtlOrg > 0){
				$('#mAtlOrg').combotree({
					url: '${ctx}/org/tree',
					multiple: true,
					animate: true,
					width: '250px',
					panelHeight: '150px'
				});
			
				// 只有最底层才能选择
				var mAtlOrgTree = $('#mAtlOrg').combotree('tree');	
				mAtlOrgTree.tree({
					checkbox: function(node){
					   if(isNull(node.children)){
							return true;
					   }else{
						   return false;
					   }
				   }
				});
			}
			
			
			// 原材料型式试验结果
			mPatOrg = $("#mPatOrg").length;
			if(mPatOrg > 0){
				$('#mPatOrg').combotree({
					url: '${ctx}/org/tree',
					multiple: true,
					animate: true,
					width: '250px',
					panelHeight: '150px'
				});
			
				// 只有最底层才能选择
				var mPatOrgTree = $('#mPatOrg').combotree('tree');	
				mPatOrgTree.tree({
					checkbox: function(node){
					   if(isNull(node.children)){
							return true;
					   }else{
						   return false;
					   }
				   }
				});
			}
			
		});
	
		// 发送结果保存
		function doSubmit(type){
			var pAtlOrgVal = "";
			var pPatOrgVal = "";
			var mAtlOrgVal = "";
			var mPatOrgVal = "";
			
			$("#sendBtn").hide();
			$("#cancelBtn").hide();
			$("#atlasError").html("结果发送中，请稍等");
			
			if(pAtlOrg > 0){
				pAtlOrgVal= $("#pAtlOrg").combotree("getValues");
				if(isNull(pAtlOrgVal)){
					$("#pAtlOrgError").html("请选择要发送的机构");
					$("#sendBtn").show();
					$("#cancelBtn").show();
					$("#atlasError").html("");
					return false;
				}
				$("#pAtlOrgError").html("");
			}
			
			if(pPatOrg > 0){
				pPatOrgVal= $("#pPatOrg").combotree("getValues");
				if(isNull(pPatOrgVal)){
					$("#pPatOrgError").html("请选择要发送的机构");
					$("#sendBtn").show();
					$("#cancelBtn").show();
					$("#atlasError").html("");
					return false;
				}
				$("#pPatOrgError").html("");
			}
			
			if(mAtlOrg > 0){
				mAtlOrgVal= $("#mAtlOrg").combotree("getValues");
				if(isNull(mAtlOrgVal)){
					$("#mAtlOrgError").html("请选择要发送的机构");
					$("#sendBtn").show();
					$("#cancelBtn").show();
					$("#atlasError").html("");
					return false;
				}
				$("#mAtlOrgError").html("");
			}
			
			if(mPatOrg > 0){
				mPatOrgVal= $("#mPatOrg").combotree("getValues");
				if(isNull(mPatOrgVal)){
					$("#mPatOrgError").html("请选择要发送的机构");
					$("#sendBtn").show();
					$("#cancelBtn").show();
					$("#atlasError").html("");
					return false;
				}
				$("#mPatOrgError").html("");
			}			
			
			$.ajax({
				url: "${ctx}/result/sendResult?time=" + new Date(),
				data: {
					"taskId": '${facadeBean.id}',
					"pAtlOrgVal": pAtlOrgVal.toString(),
					"pPatOrgVal": pPatOrgVal.toString(),
					"mAtlOrgVal": mAtlOrgVal.toString(),
					"mPatOrgVal": mPatOrgVal.toString(),
				},
				success: function(data){
					if(data.success){
						closeDialog(data.msg);
					}else{
						$("#atlasError").html(data.msg);
						$("#sendBtn").show();
						$("#cancelBtn").show();
					}
				}
			});
		}

		function doCancel(){
			$("#sendDetailDialog").dialog("close");
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

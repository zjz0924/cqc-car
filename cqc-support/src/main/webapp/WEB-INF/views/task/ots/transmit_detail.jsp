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

		 <div style="text-align:center;margin-top:25px;margin-bottom: 15px;" class="data-row">
			<a href="javascript:void(0);"  onclick="doTransmit()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">分配任务</a>&nbsp;&nbsp;
			<a href="javascript:void(0);"  onclick="$('#transmitDetailDialog').dialog('close');" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>

		<div id="dlg" class="easyui-dialog" title="任务下达" style="width: 500px; height: 250px; padding: 10px" closed="true" data-options="modal:true">
			<div>
				<span class="title-span">零部件图谱试验：</span>
				<input id="partsAtlId" name="partsAtlId">
			</div>
			<div style="margin-top:5px;">
				<span class="title-span">原材料图谱试验： </span>
				<input id="matAtlId" name="matAtlId">
			</div>
			<div style="margin-top:5px;">
				<span class="title-span">零部件型式试验： </span>
				<input id="partsPatId" name="partsPatId">
			</div>
			<div style="margin-top:5px;">
				<span class="title-span">原材料型式试验： </span>
				<input id="matPatId" name="matPatId">
			</div>
			
			<div align=center style="margin-top: 15px;">
				<a href="javascript:void(0);"  onclick="doSubmit()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">提交</a>&nbsp;&nbsp;
				<a href="javascript:void(0);"  onclick="doCancel()" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
			</div>
		</div>
	</div>
			
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
			width: 100px;
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
	
	<script type="text/javascript">
		$(function(){
			
			// 零部件图谱
			$('#partsAtlId').combotree({
				url: '${ctx}/org/getTreeByType?type=3',
				multiple: false,
				animate: true,
				width: '250px'				
			});
			
			// 只有最底层才能选择
			var partsAtlIdTree = $('#partsAtlId').combotree('tree');	
			partsAtlIdTree.tree({
			   onBeforeSelect: function(node){
				   if(isNull(node.children)){
						return true;
				   }else{
					   return false;
				   }
			   }
			});
			
			// 原材料图谱
			$('#matAtlId').combotree({
				url: '${ctx}/org/getTreeByType?type=3',
				multiple: false,
				animate: true,
				width: '250px'					
			});
			
			// 只有最底层才能选择
			var matAtlIdTree = $('#matAtlId').combotree('tree');	
			matAtlIdTree.tree({
			   onBeforeSelect: function(node){
				   if(isNull(node.children)){
						return true;
				   }else{
					   return false;
				   }
			   }
			});
			
			
			// 零部件型式
			$('#partsPatId').combotree({
				url: '${ctx}/org/getTreeByType?type=3',
				multiple: false,
				animate: true,
				width: '250px'				
			});
			
			// 只有最底层才能选择
			var partsPatIdTree = $('#partsPatId').combotree('tree');	
			partsPatIdTree.tree({
			   onBeforeSelect: function(node){
				   if(isNull(node.children)){
						return true;
				   }else{
					   return false;
				   }
			   }
			});
			
			
			// 原材料型式
			$('#matPatId').combotree({
				url: '${ctx}/org/getTreeByType?type=3',
				multiple: false,
				animate: true,
				width: '250px'				
			});
			
			// 只有最底层才能选择
			var matPatIdTree = $('#matPatId').combotree('tree');	
			matPatIdTree.tree({
			   onBeforeSelect: function(node){
				   if(isNull(node.children)){
						return true;
				   }else{
					   return false;
				   }
			   }
			});
			
			// 默认选中CQC实验室
			$("#partsAtlId").combotree("setValue", 20);
			$("#matAtlId").combotree("setValue", 20);
			$("#partsPatId").combotree("setValue", 20);
			$("#matPatId").combotree("setValue", 20);
		});
		
		
		function doTransmit(){
			$("#partsAtlId").combotree("setValue", "");
			$("#matAtlId").combotree("setValue", "");
			$("#partsPatId").combotree("setValue", "");
			$("#matPatId").combotree("setValue", "");
			$("#dlg").dialog("open");
		}
		
		function doSubmit(){
			var partsAtlId = $("#partsAtlId").combotree("getValue");
			var matAtlId = $("#matAtlId").combotree("getValue");
			var partsPatId = $("#partsPatId").combotree("getValue");
			var matPatId = $("#matPatId").combotree("getValue");
			
			if(isNull(partsAtlId)){
				errorMsg("请为零部件图谱试验选择实验室");
				return false;
			}
			
			if(isNull(matAtlId)){
				errorMsg("请为原材料图谱试验选择实验室");
				return false;
			}
			
			if(isNull(partsPatId)){
				errorMsg("请为零部件型式试验选择实验室");
				return false;
			}
			
			if(isNull(matPatId)){
				errorMsg("请为原材料型式试验选择实验室");
				return false;
			}
			
			$.ajax({
				url: "${ctx}/ots/transmit",
				data: {
					"id": '${facadeBean.id}',
					"partsAtlId": partsAtlId,
					"matAtlId": matAtlId,
					"partsPatId": partsPatId,
					"matPatId": matPatId
				},
				success: function(data){
					if(data.success){
						$("#dlg").dialog("close");
						closeDialog(data.msg);
					}else{
						errorMsg(data.msg);						
					}
				}
			});
		}
		
		function doCancel(){
			$("#dlg").dialog("close");
		}
	</script>	
	
</body>

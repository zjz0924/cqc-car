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
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		
		<div class="title">试验信息</div>
		<div>
			<table class="info">
				<tr>
					<td class="title-td">试验名称</td>
					<td class="title-td">分配实验室</td>
				</tr>
				
				<tr>
					<td class="value-td">图谱试验</td>
					<td class="value-td">${facadeBean.atlas.name}</td>
				</tr>
				
				<tr>
					<td class="value-td">型式试验</td>
					<td class="value-td">${facadeBean.pattern.name}</td>
				</tr>
			</table>
		</div>

		 <div style="text-align:center;margin-top:25px;margin-bottom: 15px;" class="data-row">
			<a href="javascript:void(0);"  onclick="approve(${facadeBean.id}, 1, '')" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">同意</a>&nbsp;&nbsp;
			<a href="javascript:void(0);"  onclick="notPass()" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">不同意</a>
		</div>

		<div id="dlg" class="easyui-dialog" title="审批" style="width: 400px; height: 200px; padding: 10px" closed="true" data-options="modal:true">
			<input id="remark" class="easyui-textbox" label="不同意原因：" labelPosition="top" multiline="true" style="width: 350px;height: 100px;"/>
			
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
		function approve(id, type, remark){
			$.ajax({
				url: "${ctx}/ots/approve",
				data: {
					"id": id,
					"type": type,
					"remark": remark
				},
				success: function(data){
					if(data.success){
						closeDialog(data.msg);
					}else{
						errorMsg(data.msg);						
					}
				}
			});
		}
		
		function notPass(){
			$("#remark").textbox("setValue", "");
			$("#dlg").dialog("open");
		}
		
		function doSubmit(){
			var remark = $("#remark").textbox("getValue");
			if(isNull(remark)){
				errorMsg("请输入原因");
				$("#remark").next('span').find('input').focus();
				return false;
			}
			
			approve("${facadeBean.id}", 2, remark);
			$("#dlg").dialog("close");
		}
		
		function doCancel(){
			$("#dlg").dialog("close");
		}
	</script>	
	
</body>
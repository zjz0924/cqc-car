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
		
		<c:choose>
			<c:when test="${type == 1}">
			
			</c:when>
			<c:otherwise>
				<form method="POST" enctype="multipart/form-data" id="uploadForm">
					<input type="hidden" id="taskId" name="taskId" value="${facadeBean.id}">
					<div class="title">图谱试验结果</div>
					<div>
						<table class="info">
							<tr>
								<td class="title-td">图谱类型</td>
								<td class="title-td">图谱描述</td>
								<td class="title-td">选择图谱</td>
							</tr>
							
							<tr>
								<td class="value-td">热重分析</td>
								<td class="value-td"><input id="tgLab" name="tgLab" class="easyui-textbox" style="width:230px"></td>
								<td class="value-td">
									<span class="req-span">*</span>
									<input id="tgLab_pic" name="tgLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
									<span id="tg_error" class="req-span"></span>
								</td>
							</tr>
							
							<tr>
								<td class="value-td">红外光分析</td>
								<td class="value-td"><input id="infLab" name="infLab" class="easyui-textbox" style="width:230px"></td>
								<td class="value-td">
									<span class="req-span">*</span>
									<input id="infLab_pic" name="infLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
									<span id="inf_error" class="req-span"></span>
								</td>
							</tr>
							
							<tr>
								<td class="value-td">差热扫描</td>
								<td class="value-td"><input id="dtLab" name="dtLab" class="easyui-textbox" style="width:230px"></td>
								<td class="value-td">
									<span class="req-span">*</span>
									<input id="dtLab_pic" name="dtLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
									<span id="dt_error" class="req-span"></span>
								</td>
							</tr>
							
						</table>
					</div>
				
					<div align="center" style="margin-top:25px;">
						<a href="javascript:void(0);"  onclick="doSubmit()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">上传</a>
						<a href="javascript:void(0);"  onclick="doCancel()" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
					</div>
				</form>
			</c:otherwise>
		</c:choose>
	</div>
			
	
	<script type="text/javascript">
		function doSubmit(){
			// 热重分析图谱
			var tgLabDir = $("#tgLab_pic").filebox("getValue");
			if (!isNull(tgLabDir)) {
				var suffix = tgLabDir.substr(tgLabDir.lastIndexOf("."));
				if (".jpg" != suffix && ".png" != suffix && ".jpeg" != suffix && ".gif" != suffix) {
					$("#tg_error").html("图片格式");
					$("#tgLab_pic").focus();
					return false;
				}
			}else{
				$("#tg_error").html("必选");
				return false;
			}
			$("#tg_error").html("");
			
			// 红外光分析图谱
			var infLabDir = $("#infLab_pic").filebox("getValue");
			if (!isNull(infLabDir)) {
				var suffix = infLabDir.substr(infLabDir.lastIndexOf("."));
				if (".jpg" != suffix && ".png" != suffix && ".jpeg" != suffix && ".gif" != suffix) {
					$("#inf_error").html("图片格式");
					$("#infLab_pic").focus();
					return false;
				}
			}else{
				$("#inf_error").html("必选");
				return false;
			}
			$("#inf_error").html("");
			
			// 差热扫描图谱
			var dtLabDir = $("#dtLab_pic").filebox("getValue");
			if (!isNull(dtLabDir)) {
				var suffix = dtLabDir.substr(dtLabDir.lastIndexOf("."));
				if (".jpg" != suffix && ".png" != suffix && ".jpeg" != suffix && ".gif" != suffix) {
					$("#dt_error").html("图片格式");
					$("#dtLab_pic").focus();
					return false;
				}
			}else{
				$("#dt_error").html("必选");
				return false;
			}
			$("#dt_error").html("");
			
			/*
			var tgLab = $("#tgLab").textbox("getValue");
			var infLab = $("#infLab").textbox("getValue");
			var dtLab = $("#dtLab").textbox("getValue");  */
			
			$('#uploadForm').ajaxSubmit({
				url: "${ctx}/result/atlasUpload?time=" + new Date(),
				dataType : 'text',
				success:function(msg){
					var data = eval('(' + msg + ')');
					if(data.success){
						closeDialog(data.msg);
					}else{
						errorMsg(data.msg);
					}
				}
			});
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
		
		.req-span{
			font-weight: bold;
			color: red;
		}
		
	</style>
	
</body>

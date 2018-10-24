<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<div style="margin-left: 10px;margin-top:20px;">
		
		<c:if test="${not empty recordList}">
			<div style="margin-bottom: 20px;margin-left: 10px;">
				<span style="font-weight:bold;color:red;">审批记录（不通过）：</span>
				<c:forEach items="${recordList}" var="vo" varStatus="vst">
       	    		<div style="margin-top:5px; margin-bottom: 5px;margin-left: 5px;">
       	    			<fmt:formatDate value='${vo.createTime}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>&nbsp;&nbsp;&nbsp;&nbsp;
						<c:choose>
							<c:when test="${vo.catagory == 1}">
								<span>零部件图谱试验</span>
							</c:when>
							<c:when test="${vo.catagory == 2}">
								<span>原材料图谱试验</span>
							</c:when>
							<c:when test="${vo.catagory == 3}">
								<span>零部件型式试验</span>
							</c:when>
							<c:when test="${vo.catagory == 4}">
								<span>原材料型式试验</span>
							</c:when>
							<c:otherwise>   
						        <span>所有试验</span>  
						  </c:otherwise>
						</c:choose>&nbsp;&nbsp;&nbsp;&nbsp;
						审批意见：<span style="font-weight:bold;">${vo.remark}</span>
       	    		</div>
       	    	</c:forEach> 
			</div>
		</c:if>
		
		<div class="title">申请人信息</div>
		<div style="width: 98%;">
			<table class="info">
				<tr class="single-row">
					<td class="title-td">申请人：</td>
					<td class="value-td">${facadeBean.applicat.nickName}</td>
					<td class="title-td">科室：</td>
					<td class="value-td">${facadeBean.applicat.department}</td>
				</tr>
				<tr class="single-row">
					<td class="title-td">机构/单位：</td>
					<td class="value-td">${facadeBean.applicat.org.name}</td>
					<td class="title-td">联系方式：</td>
					<td class="value-td">${facadeBean.applicat.mobile}</td>
				</tr>
				<tr class="couple-row">
					<td class="title-td">备注：</td>
					<td class="value-td" colspan="3">${facadeBean.applicat.remark}</td>
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
					<td class="title-td">生产基地：</td>
					<td class="value-td">${facadeBean.info.vehicle.proAddr}</td>
				</tr>
				<tr class="couple-row">
					<td class="title-td">生产日期：</td>
					<td class="value-td"><fmt:formatDate value='${facadeBean.info.vehicle.proTime}' type="date" pattern="yyyy-MM-dd"/></td>
					<td class="title-td">备注：</td>
					<td class="value-td">${facadeBean.info.vehicle.remark}</td>
				</tr>
			</table>
		</div>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		
		<div class="title">零部件信息</div>
		<div style="width: 98%;">
			<table class="info">
				<tr class="single-row">
					<td class="title-td">零件名称：</td>
					<td class="value-td">${facadeBean.info.parts.name}</td>
					<td class="title-td">零件图号：</td>
					<td class="value-td">${facadeBean.info.parts.code}</td>
				</tr>
				<tr class="couple-row">
					<td class="title-td">供应商：</td>
					<td class="value-td">${facadeBean.info.parts.producer}</td>
					<td class="title-td">供应商代码：</td>
					<td class="value-td">${facadeBean.info.parts.producerCode}</td>
				</tr>
				<tr class="single-row">
					<td class="title-td">生产日期：</td>
					<td class="value-td"><fmt:formatDate value='${facadeBean.info.parts.proTime}' type="date" pattern="yyyy-MM-dd"/></td>
					<td class="title-td">样件数量：</td>
					<td class="value-td">${facadeBean.info.parts.num}</td>
				</tr>
				<tr class="single-row">
					<td class="title-td">样件批号：</td>
					<td class="value-td">${facadeBean.info.parts.proNo}</td>
					<td class="title-td">生产场地：</td>
					<td class="value-td">${facadeBean.info.parts.place}</td>
				</tr>
				<tr class="couple-row">
					<td class="title-td">备注：</td>
					<td class="value-td" colspan="3">${facadeBean.info.parts.remark}</td>
				</tr>
			</table>
		</div>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		
		<div class="title">原材料信息</div>
		<div style="width: 98%;">
			<table class="info">
				<tr class="single-row">
					<td class="title-td">材料名称：</td>
					<td class="value-td">${facadeBean.info.material.matName}</td>
					<td class="title-td">材料牌号：</td>
					<td class="value-td">${facadeBean.info.material.matNo}</td>
				
				</tr>
				
				<tr class="couple-row">
					<td class="title-td">供应商：</td>
					<td class="value-td">${facadeBean.info.material.producer}</td>
					<td class="title-td">材料颜色：</td>
					<td class="value-td">${facadeBean.info.material.matColor}</td>
				</tr>
				
				<tr class="single-row">
					<td class="title-td">材料批号：</td>
					<td class="value-td">${facadeBean.info.material.proNo}</td>
					<td class="title-td">样品数量：</td>
					<td class="value-td">${facadeBean.info.material.num}</td>
				</tr>
				
				<tr class="single-row">
					<td class="title-td">备注：</td>
					<td class="value-td" colspan="3">${facadeBean.info.material.remark}</td>
				</tr>
			</table>
		</div>

		 <div style="text-align:center;margin-top:25px;margin-bottom: 15px;" class="data-row">
			<a href="javascript:void(0);"  onclick="doTransmit()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">分配任务</a>&nbsp;&nbsp;
			<a href="javascript:void(0);"  onclick="$('#transmitDetailDialog').dialog('close');" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>

		<div id="dlg" class="easyui-dialog" title="任务下达" style="width: 550px; height: 350px; padding: 10px; overflow-y: hidden;" closed="true" data-options="modal:true">
			
			<c:if test="${empty facadeBean.partsAtlId and not empty partAtl}">
				<div>
					<span class="title-span">零部件图谱试验：</span>
					<input id="partsAtlId" name="partsAtlId">&nbsp;&nbsp;&nbsp;&nbsp;
				
					<div style="margin-top:5px;">
						任务号：&nbsp;&nbsp;&nbsp;&nbsp;<input id="partsAtlCode" name="partsAtlCode" class="easyui-textbox"  style="width:195px;">&nbsp;&nbsp;&nbsp;&nbsp;
						商定完成时间：<input id="partsAtlTime" name="partsAtlTime" class="easyui-datebox" style="width:140px;" data-options="editable:false">
						<div style="margin-top:5px;">
							测试要求：<input id="partsAtlReq" name="partsAtlReq" class="easyui-textbox"  style="width:86%;">
						</div>
					</div>
					<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
				</div>
			</c:if>
			
			<c:if test="${empty facadeBean.matAtlId and not empty materialAtl}">
				<div style="margin-top:5px;">
					<span class="title-span">原材料图谱试验： </span>
					<input id="matAtlId" name="matAtlId">&nbsp;&nbsp;&nbsp;&nbsp;
				
					<div style="margin-top:5px;">
						任务号：&nbsp;&nbsp;&nbsp;&nbsp;<input id="matAtlCode" name="matAtlCode" class="easyui-textbox"  style="width:195px;">&nbsp;&nbsp;&nbsp;&nbsp;
						商定完成时间：<input id="matAtlTime" name="matAtlTime" class="easyui-datebox" style="width:140px;" data-options="editable:false">
						<div style="margin-top:5px;">
							测试要求：<input id="matAtlReq" name="matAtlReq" class="easyui-textbox"  style="width:86%;">
						</div>
					</div>
					<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
				</div>
			</c:if>
			
			<div align=center style="margin-top: 15px;">
				<a href="javascript:void(0);"  onclick="doSubmit()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">提交</a>&nbsp;&nbsp;
				<a href="javascript:void(0);"  onclick="doCancel()" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
			</div>
		</div>
	</div>
			
	<style type="text/css">
		.red-font{
		   color:red;
		   font-weight: bold;
		}
	
		.title {
			margin-left: 10px;
			margin-bottom: 8px;
			font-size: 14px;
			color: #1874CD;
    		font-weight: bold;
		}
		
		.title-span{
			display: inline-block;
			width: 120px;
			font-weight:bold;
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
		
		.single-row{
			background: #F0F0F0;
		}
		
		.couple-row{
			background: #f5f5f5;
		}
	</style>
	
	<script type="text/javascript">
		var partsAtlId;
		var matAtlId;
		var partsPatId;
		var matPatId;
		// 是否提交中
		var saving = false;
		
		$(function(){	
			partsAtlId = "${facadeBean.partsAtlId}";
			if(isNull(partsAtlId) && !isNull("${partAtl}")){
				// 零部件图谱
				$('#partsAtlId').combotree({
					url: '${ctx}/org/getTreeByType?type=3',
					multiple: false,
					animate: true,
					width: '377px',
					onBeforeSelect: function(node){
					   if(isNull(node.children)){
							return true;
					   }else{
						   return false;
					   }
					}
				});
			}
			
			matAtlId = "${facadeBean.matAtlId}";
			if(isNull(matAtlId) && !isNull("${materialAtl}")){
				// 原材料图谱
				$('#matAtlId').combotree({
					url: '${ctx}/org/getTreeByType?type=3',
					multiple: false,
					animate: true,
					width: '377px',
					onBeforeSelect: function(node){
					   if(isNull(node.children)){
							return true;
					   }else{
						   return false;
					   }
					}
				});
			}
		});
		
		
		function doTransmit(){
			$("#matAtlId").combotree({ disabled: false });
			$("#matAtlId").combotree("setValue", "20");
			
			$("#partsAtlId").combotree({ disabled: false });
			$("#partsAtlId").combotree("setValue", "20");
			
			// 清空原来输入的值
			$("#partsAtlCode").textbox("setValue", "");
			$("#partsAtlTime").datebox("setValue", "");
			$("#partsAtlReq").textbox("setValue", "");
			
			// 清空原来输入的值
			$("#matAtlCode").textbox("setValue", "");
			$("#matAtlTime").datebox("setValue", "");
			$("#matAtlReq").textbox("setValue", "");
			
			$("#dlg").dialog("open");
			
			// 移去滚动条
			window.parent.parent.scrollY(515);
		}
		
		function doSubmit(){
			var partsAtlId_val;
			var matAtlId_val;
			// 零部件图谱试验说明
			var partsAtlCode;
			var partsAtlTime;
			var partsAtlReq;
			// 原材料图谱试验说明
			var matAtlCode;
			var matAtlTime;
			var matAtlReq;
			
			if(saving){
				return false;
			}
			saving = true;
			
			if(isNull(partsAtlId) && !isNull("${partAtl}")){
				partsAtlId_val = $("#partsAtlId").combotree("getValue");
				if(isNull(partsAtlId_val)){
					errorMsg("请为零部件图谱试验选择实验室");
					saving = false;
					return false;
				}
			}
			
			if(isNull(matAtlId) && !isNull("${materialAtl}")){
				matAtlId_val = $("#matAtlId").combotree("getValue");
				if(isNull(matAtlId_val)){
					errorMsg("请为原材料图谱试验选择实验室");
					saving = false;
					return false;
				}
			}
			
			if(!isNull(partsAtlId_val)){
				partsAtlCode = $("#partsAtlCode").textbox("getValue");
				partsAtlTime = $("#partsAtlTime").datebox("getValue");
				partsAtlReq = $("#partsAtlReq").textbox("getValue");
			}
			
			if(!isNull(matAtlId_val)){
				matAtlCode = $("#matAtlCode").textbox("getValue");
				matAtlTime = $("#matAtlTime").datebox("getValue");
				matAtlReq = $("#matAtlReq").textbox("getValue");
			}
			
			$.ajax({
				url: "${ctx}/ots/transmit",
				data: {
					"id": '${facadeBean.id}',
					"partsAtlId": partsAtlId_val,
					"matAtlId": matAtlId_val,
					"partsAtlCode": partsAtlCode,
					"partsAtlTime": partsAtlTime,
					"partsAtlReq": partsAtlReq,
					"matAtlCode": matAtlCode,
					"matAtlTime": matAtlTime,
					"matAtlReq": matAtlReq,
				},
				success: function(data){
					if(data.success){
						$("#dlg").dialog("close");
						closeDialog(data.msg);
					}else{
						saving = false;
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

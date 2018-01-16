<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<div style="margin-left: 10px;margin-top:20px;">
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
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		
		<c:choose>
			<c:when test="${approveType == 3}">
				<c:if test="${not empty labReqList}">
					<div class="title">试验说明</div>
					<div style="margin-bottom: 20px;">
						<table class="info">
							<tr class="single-row">
								<td class="title-td">试验名称</td>
								<td class="title-td">任务号</td>
								<td class="title-td">实验要求</td>
								<td class="title-td">商定完成时间</td>
							</tr>
							
							<c:forEach items="${labReqList}" var="vo">
								<tr>
									<td>
										<c:choose>
											<c:when test="${vo.type eq 1}">零部件图谱试验</c:when>
											<c:when test="${vo.type eq 2}">原材料图谱试验</c:when>
											<c:when test="${vo.type eq 3}">零部件型式试验</c:when>
											<c:when test="${vo.type eq 4}">原材料型式试验</c:when>
										</c:choose>
									</td>
									<td>${vo.code}</td>
									<td style="word-break : break-all;line-height: 20px;">${vo.remark }</td>
									<td><fmt:formatDate value='${vo.time}' type="date" pattern="yyyy-MM-dd"/></td>
								</tr>
							</c:forEach>
						</table>
					</div>	
				</c:if>
			
				<div class="title">试验分配</div>
				<div>
					<table class="info">
						<tr class="single-row">
							<td class="title-td">试验名称</td>
							<td class="title-td">分配实验室</td>
						</tr>
						
						<tr>
							<td class="value-td">零部件图谱试验</td>
							<td class="value-td">
								<c:if test="${not empty facadeBean.partsAtl}">
									${facadeBean.partsAtl.name}
								</c:if>
								<c:if test="${empty facadeBean.partsAtl}">
									不分配
								</c:if>
							</td>
						</tr>
						
						<tr>
							<td class="value-td">原材料图谱试验</td>
							<td class="value-td">
								<c:if test="${not empty facadeBean.matAtl}">
									${facadeBean.matAtl.name}
								</c:if>
								<c:if test="${empty facadeBean.matAtl}">
									不分配
								</c:if>
							</td>
						</tr>
					</table>
				</div>
				
				<div style="text-align:center;margin-top:25px;margin-bottom: 15px;" class="data-row">
					<a href="javascript:void(0);"  onclick="approve(1, '', 3)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">同意</a>&nbsp;&nbsp;
					<a href="javascript:void(0);"  onclick="notPass(3)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">不同意</a>
				</div>
			
			</c:when>
			<c:when test="${approveType == 2}"> 
				<div class="title">试验结果</div>
		
				<div class="title">零部件图谱试验结果</div>
				<table class="info">
					<tr class="single-row">
						<td class="title-td">图谱类型</td>
						<td class="title-td">图谱描述</td>
						<td class="title-td">选择图谱</td>
					</tr>
				
					<c:forEach items="${pAtlasResult_old}" var="vo" varStatus="vst">
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
				
				<div style="margin-left: 10px;color:red;margin-top: 20px;">修改后结果：</div>
				<table class="info">
					<tr class="single-row">
						<td class="title-td">图谱类型</td>
						<td class="title-td">图谱描述</td>
						<td class="title-td">选择图谱</td>
					</tr>
				
					<c:forEach items="${pAtlasResult_new}" var="vo" varStatus="vst">
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
			
				<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		
				<div class="title">原材料图谱试验结果</div>
				<table class="info">
					<tr class="single-row">
						<td class="title-td">图谱类型</td>
						<td class="title-td">图谱描述</td>
						<td class="title-td">选择图谱</td>
					</tr>
				
					<c:forEach items="${mAtlasResult_old}" var="vo" varStatus="vst">
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
				
				<div style="margin-left: 10px;color:red;margin-top: 20px;">修改后结果：</div>
				<table class="info">
					<tr class="single-row">
						<td class="title-td">图谱类型</td>
						<td class="title-td">图谱描述</td>
						<td class="title-td">选择图谱</td>
					</tr>
				
					<c:forEach items="${mAtlasResult_new}" var="vo" varStatus="vst">
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
				
				 <div style="text-align:center;margin-top:15px;margin-bottom: 15px;" class="data-row">
					<a href="javascript:void(0);"  onclick="approve(1,'', 2)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">同意</a>&nbsp;&nbsp;
					<a href="javascript:void(0);"  onclick="notPass(2)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">不同意</a>
				 </div>
			</c:when>
		</c:choose>

		<div id="dlg" class="easyui-dialog" title="审批" style="width: 400px; height: 200px; padding: 10px" closed="true" data-options="modal:true">
			<input id="remark" class="easyui-textbox" label="不同意原因：" labelPosition="top" multiline="true" style="width: 350px;height: 100px;"/>
			<input type="hidden" id="catagory" name="catagory">
			
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
		
		.img-span1{
			width: 100px;
			height: 50px;
			display:inline-block;
			border:0.5px dashed #C9C9C9;
			text-align:center;
			line-height:50px;
		}
	</style>
	
	<script type="text/javascript">
		// 是否提交中
		var saving = false;
	
		function approve(result, remark, catagory){
			if(saving){
				return false;
			}
			saving = true;
			
			$.ajax({
				url: "${ctx}/ppap/approve",
				data: {
					"id": "${facadeBean.id}",
					"result": result,
					"remark": remark,
					"catagory": catagory
				},
				success: function(data){
					saving = false;
					if(data.success){
						closeDialog(data.msg);
					}else{
						errorMsg(data.msg);						
					}
				}
			});
		}
		
		function notPass(catagory){
			$("#catagory").val(catagory);
			$("#remark").textbox("setValue", "");
			$("#dlg").dialog("open");
		}
		
		function doSubmit(){
			var remark = $("#remark").textbox("getValue");
			var catagory = $("#catagory").val(); 
			if(isNull(remark)){
				errorMsg("请输入原因");
				$("#remark").next('span').find('input').focus();
				return false;
			}
			
			approve(2, remark, catagory);
			$("#dlg").dialog("close");
		}
		
		function doCancel(){
			$("#dlg").dialog("close");
		}
	</script>	
	
</body>

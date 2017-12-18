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
		
		<c:if test="${taskType == 1}">
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
						<td class="title-td">备注：</td>
						<td class="value-td" colspan="3">${facadeBean.info.parts.remark}</td>
					</tr>
				</table>
			</div>
			
			<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		</c:if>
		
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
				<div class="title">试验信息</div>
				<div>
					<table class="info">
						<tr>
							<td class="title-td">试验名称</td>
							<td class="title-td">分配实验室</td>
							<td class="title-td">操作</td>
						</tr>
						
						<c:if test="${taskType == 1}">
							<tr>
								<td class="value-td">零部件图谱试验</td>
								<td class="value-td">${facadeBean.partsAtl.name}</td>
								<td>
									<c:if test="${not empty facadeBean.partsAtl}">
										<span id="partsAtl1" <c:if test="${facadeBean.partsAtlResult != 0}">style="display:none;"</c:if>>
											<a href="javascript:void(0);"  onclick="approve(1,'', 1)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">同意</a>
											<a href="javascript:void(0);"  onclick="notPass(1)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">不同意</a>
										</span>
										<span id="partsAtl2" style="color:green;display:none;">同意</span>
										<span id="partsAtl3" style="color:red;display:none;">不同意</span>
									</c:if>
								</td>
							</tr>
						</c:if>
						
						<tr>
							<td class="value-td">原材料图谱试验</td>
							<td class="value-td">${facadeBean.matAtl.name}</td>
							<td>
								<c:if test="${not empty facadeBean.matAtl}">
									<span id="matAtl1" <c:if test="${facadeBean.matAtlResult != 0}">style="display:none;"</c:if>>
										<a href="javascript:void(0);"  onclick="approve(1,'', 2)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">同意</a>
										<a href="javascript:void(0);"  onclick="notPass(2)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">不同意</a>
									</span>
									<span id="matAtl2" style="color:green;display:none;">同意</span>
									<span id="matAtl3" style="color:red;display:none;">不同意</span>
								</c:if>
							</td>
						</tr>
						
						<c:if test="${taskType == 1}">
							<tr>
								<td class="value-td">零部件型式试验</td>
								<td class="value-td">${facadeBean.partsPat.name}</td>
								<td>
									<c:if test="${not empty facadeBean.partsPat}">
										<span id="partsPat1" <c:if test="${facadeBean.partsPatResult != 0}">style="display:none;"</c:if>>
											<a href="javascript:void(0);"  onclick="approve(1,'', 3)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">同意</a>
											<a href="javascript:void(0);"  onclick="notPass(3)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">不同意</a>
										</span>
										<span id="partsPat2" style="color:green;display:none;">同意</span>
										<span id="partsPat3" style="color:red;display:none;">不同意</span>
									</c:if>
								</td>
							</tr>
						</c:if>
						
						<tr>
							<td class="value-td">原材料型式试验</td>
							<td class="value-td">${facadeBean.matPat.name}</td>
							<td>
								<c:if test="${not empty facadeBean.matPat}">
									<span id="matPat1" <c:if test="${facadeBean.matPatResult != 0}">style="display:none;"</c:if>>
										<a href="javascript:void(0);"  onclick="approve(1,'', 4)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">同意</a>
										<a href="javascript:void(0);"  onclick="notPass(4)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">不同意</a>
									</span>
									<span id="matPat2" style="color:green;display:none;">同意</span>
									<span id="matPat3" style="color:red;display:none;">不同意</span>
								</c:if>
							</td>
						</tr>
					</table>
				</div>
		
				<c:if test="${taskType == 1}">
					<c:if test="${facadeBean.partsAtlResult == 0 and facadeBean.matAtlResult == 0 and facadeBean.partsPatResult ==0 and facadeBean.matPatResult == 0}">
						 <div style="text-align:center;margin-top:25px;margin-bottom: 15px;" class="data-row">
							<a id="allAgree" href="javascript:void(0);"  onclick="approve(1,'', 5)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">全部同意</a>&nbsp;&nbsp;
							<a id="allNotAgree" href="javascript:void(0);"  onclick="notPass(5)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">全部不同意</a>
						</div>
					</c:if>
				</c:if>
				<c:if test="${taskType == 4}">
					<c:if test="${facadeBean.matAtlResult == 0 and facadeBean.matPatResult == 0}">
						 <div style="text-align:center;margin-top:25px;margin-bottom: 15px;" class="data-row">
							<a id="allAgree" href="javascript:void(0);"  onclick="approve(1,'', 5)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">全部同意</a>&nbsp;&nbsp;
							<a id="allNotAgree" href="javascript:void(0);"  onclick="notPass(5)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">全部不同意</a>
						</div>
					</c:if>
				</c:if>
			</c:when>
			<c:when test="${approveType == 2}">  
				<div class="title">试验结果</div>
				
				<c:if test="${taskType == 1 }">
					<div class="title">零部件试验结果</div>
					<table class="info">
						<tr class="single-row">
							<td style="font-weight:bold;">序号</td>
							<td class="title-td">试验项目</td>
							<td class="title-td">参考标准</td>
							<td class="title-td">试验要求</td>
							<td class="title-td">试验结果</td>
							<td class="title-td">结果评价</td>
							<td class="title-td">备注</td>
						</tr>
					
						<c:forEach items="${pPfResult_old}" var="vo" varStatus="status">
							<tr>
								<td style="padding-left:5px;">${status.index + 1}</td>
								<td class="value-td1">
									<span class="val" title="${vo.project}">${vo.project}</span>
								</td>
								<td class="value-td1">
									<span class="val" title="${vo.standard}">${vo.standard}</span>
								</td>
								<td class="value-td1">
									<span class="val" title="${vo.require}">${vo.require}</span>
								</td>
								<td class="value-td1">
									<span class="val" title="${vo.result}">${vo.result}</span>
								</td>
								<td class="value-td1">
									<span class="val" title="${vo.evaluate}">${vo.evaluate}</span>
								</td>
								<td class="value-td1">
									<span class="val" title="${vo.remark}">${vo.remark}</span>
								</td>
							</tr>
						</c:forEach>
					</table>
					
					<div style="margin-left: 10px;color:red;margin-top: 20px;">修改后结果：</div>
					<table class="info">
						<tr class="single-row">
							<td style="font-weight:bold;">序号</td>
							<td class="title-td">试验项目</td>
							<td class="title-td">参考标准</td>
							<td class="title-td">试验要求</td>
							<td class="title-td">试验结果</td>
							<td class="title-td">结果评价</td>
							<td class="title-td">备注</td>
						</tr>
					
						<c:forEach items="${pPfResult_new}" var="vo" varStatus="status">
							<tr>
								<td style="padding-left:5px;">${status.index + 1}</td>
								<td class="value-td1">
									<span class="val red-color" title="${vo.project}">${vo.project}</span>
								</td>
								<td class="value-td1">
									<span class="val red-color" title="${vo.standard}">${vo.standard}</span>
								</td>
								<td class="value-td1">
									<span class="val red-color" title="${vo.require}">${vo.require}</span>
								</td>
								<td class="value-td1">
									<span class="val red-color" title="${vo.result}">${vo.result}</span>
								</td>
								<td class="value-td1">
									<span class="val red-color" title="${vo.evaluate}">${vo.evaluate}</span>
								</td>
								<td class="value-td1">
									<span class="val red-color" title="${vo.remark}">${vo.remark}</span>
								</td>
							</tr>
						</c:forEach>
					</table>
					
					<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
					
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
								</td>
								<td class="value-td" title="${vo.remark}" style="word-break : break-all;line-height: 20px;">${vo.remark}</td>
								<td class="value-td">
									<a href="${resUrl}/${vo.pic}" target="_blank"><img src="${resUrl}/${vo.pic}" style="width: 100px;height: 50px;"></a>
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
								</td>
								<td class="value-td" title="${vo.remark}" style="word-break : break-all;line-height: 20px;">${vo.remark}</td>
								<td class="value-td">
									<a href="${resUrl}/${vo.pic}" target="_blank"><img src="${resUrl}/${vo.pic}" style="width: 100px;height: 50px;"></a>
								</td>
							</tr>
						</c:forEach>
					</table>
				</c:if>
				
				<div class="title" style="margin-top: 10px;">原材料试验结果</div>
				<table class="info">
					<tr class="single-row">
						<td style="font-weight:bold;">序号</td>
						<td class="title-td">试验项目</td>
						<td class="title-td">参考标准</td>
						<td class="title-td">试验要求</td>
						<td class="title-td">试验结果</td>
						<td class="title-td">结果评价</td>
						<td class="title-td">备注</td>
					</tr>
				
					<c:forEach items="${mPfResult_old}" var="vo" varStatus="status">
						<tr>
							<td style="padding-left:5px;">${status.index + 1}</td>
							<td class="value-td1">
								<span class="val" title="${vo.project}">${vo.project}</span>
							</td>
							<td class="value-td1">
								<span class="val" title="${vo.standard}">${vo.standard}</span>
							</td>
							<td class="value-td1">
								<span class="val" title="${vo.require}">${vo.require}</span>
							</td>
							<td class="value-td1">
								<span class="val" title="${vo.result}">${vo.result}</span>
							</td>
							<td class="value-td1">
								<span class="val" title="${vo.evaluate}">${vo.evaluate}</span>
							</td>
							<td class="value-td1">
								<span class="val" title="${vo.remark}">${vo.remark}</span>
							</td>
						</tr>
					</c:forEach>
				</table>
				
				<div style="margin-left: 10px;color:red;margin-top: 20px;">修改后结果：</div>
				<table class="info">
					<tr class="single-row">
						<td style="font-weight:bold;">序号</td>
						<td class="title-td">试验项目</td>
						<td class="title-td">参考标准</td>
						<td class="title-td">试验要求</td>
						<td class="title-td">试验结果</td>
						<td class="title-td">结果评价</td>
						<td class="title-td">备注</td>
					</tr>
				
					<c:forEach items="${mPfResult_new}" var="vo" varStatus="status">
						<tr>
							<td style="padding-left:5px;">${status.index + 1}</td>
							<td class="value-td1">
								<span class="val red-color" title="${vo.project}">${vo.project}</span>
							</td>
							<td class="value-td1">
								<span class="val red-color" title="${vo.standard}">${vo.standard}</span>
							</td>
							<td class="value-td1">
								<span class="val red-color" title="${vo.require}">${vo.require}</span>
							</td>
							<td class="value-td1">
								<span class="val red-color" title="${vo.result}">${vo.result}</span>
							</td>
							<td class="value-td1">
								<span class="val red-color" title="${vo.evaluate}">${vo.evaluate}</span>
							</td>
							<td class="value-td1">
								<span class="val red-color" title="${vo.remark}">${vo.remark}</span>
							</td>
						</tr>
					</c:forEach>
				</table>
				
				<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
				
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
							</td>
							<td class="value-td" title="${vo.remark}" style="word-break : break-all;line-height: 20px;">${vo.remark}</td>
							<td class="value-td">
								<a href="${resUrl}/${vo.pic}" target="_blank"><img src="${resUrl}/${vo.pic}" style="width: 100px;height: 50px;"></a>
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
							</td>
							<td class="value-td" title="${vo.remark}" style="word-break : break-all;line-height: 20px;">${vo.remark}</td>
							<td class="value-td">
								<a href="${resUrl}/${vo.pic}" target="_blank"><img src="${resUrl}/${vo.pic}" style="width: 100px;height: 50px;"></a>
							</td>
						</tr>
					</c:forEach>
				</table>
				
				 <div style="text-align:center;margin-top:15px;margin-bottom: 15px;" class="data-row">
					<a href="javascript:void(0);"  onclick="approve(1,'', 7)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">同意</a>&nbsp;&nbsp;
					<a href="javascript:void(0);"  onclick="notPass(7)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">不同意</a>
				 </div>
				
			</c:when>
		</c:choose>
		

		<div id="dlg" class="easyui-dialog" title="审批" style="width: 400px; height: 200px; padding: 10px" closed="true" data-options="modal:true">
			<input type="hidden" id="catagory" name="catagory">
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
		
		.red-color{
			color: red;
			font-weight: bold;
		}
		
		.single-row{
			background: #F0F0F0;
		}
		
		.couple-row{
			background: #f5f5f5;
		}
	</style>
	
	<script type="text/javascript">
		// 是否提交中
		var saving = false;
	
		$(function(){
			
			var approveType = "${approveType}";
			var taskType = "${taskType}";
			
			// 正常流程
			if(approveType == 3){
				
				if(taskType == 1){
					// 零部件图谱试验结果
					var partsAtlResult = "${facadeBean.partsAtlResult}";
					if(partsAtlResult == 1){
						$("#partsAtl2").show();
					}else if(partsAtlResult == 6){
						$("#partsAtl3").show();
					}
					
					// 零部件型式试验结果
					var partsPatResult = "${facadeBean.partsPatResult}";
					if(partsPatResult == 1){
						$("#partsPat2").show();
					}else if(partsPatResult == 6){
						$("#partsPat3").show();
					}
				}
				
				// 原材料图谱试验结果
				var matAtlResult = "${facadeBean.matAtlResult}";
				if(matAtlResult == 1){
					$("#matAtl2").show();
				}else if(matAtlResult == 6){
					$("#matAtl3").show();
				}
				
				// 原材料型式试验结果
				var matPatResult = "${facadeBean.matPatResult}";
				if(matPatResult == 1){
					$("#matPat2").show();
				}else if(matPatResult == 6){
					$("#matPat3").show();
				}
			}
		});
	
		
		function approve(result, remark, catagory){
			if(saving){
				return false;
			}
			saving = true;
			
			$.ajax({
				url: "${ctx}/ots/approve",
				data: {
					"id": "${facadeBean.id}",
					"result": result,
					"remark": remark,
					"catagory": catagory
				},
				success: function(data){
					if(data.success){
						var approveType = "${approveType}";
						var taskType = "${taskType}";
						saving = false;
						
						// 正常流程
						if(approveType == 3){
							if(result == 1){
								if(catagory == 1){
									$("#partsAtl1").hide();
									$("#partsAtl2").show();
								}else if(catagory == 2){
									$("#matAtl1").hide();
									$("#matAtl2").show();
								}else if(catagory == 3){
									$("#partsPat1").hide();
									$("#partsPat2").show();
								}else if(catagory == 4){
									$("#matPat1").hide();
									$("#matPat2").show();
								}else{
									closeDialog(data.msg);
								}
							}else{
								if(catagory == 1){
									$("#partsAtl1").hide();
									$("#partsAtl3").show();
								}else if(catagory == 2){
									$("#matAtl1").hide();
									$("#matAtl3").show();
								}else if(catagory == 3){
									$("#partsPat1").hide();
									$("#partsPat3").show();
								}else if(catagory == 4){
									$("#matPat1").hide();
									$("#matPat3").show();
								}else{
									closeDialog(data.msg);
								}
							}
							
							// 隐藏 全部同意/全部不同意 按钮
							if(catagory != 5){
								$("#allAgree").hide();
								$("#allNotAgree").hide();
							}
							
							// 全部审批完
							if(taskType == 1){
								if (($("#partsAtl1").length < 1 || $("#partsAtl1").is(":hidden"))
										&& ($("#matAtl1").length < 1 || $("#matAtl1").is(":hidden"))
										&& ($("#partsPat1").length < 1 || $("#partsPat1").is(":hidden"))
										&& ($("#matPat1").length < 1 || $("#matPat1").is(":hidden"))) {
									closeDialog("操作成功");
								}
							} else if (taskType == 4) {
								if (($("#matAtl1").length < 1 || $("#matAtl1").is(":hidden")) && ($("#matPat1").length < 1 || $("#matPat1").is(":hidden"))) {
									closeDialog("操作成功");
								}
							}
						} else {
							closeDialog(data.msg);
						}
					} else {
						errorMsg(data.msg);
					}
				}
			});
		}

		function notPass(catagory) {
			$("#catagory").val(catagory);
			$("#remark").textbox("setValue", "");
			$("#dlg").dialog("open");
		}

		function doSubmit() {
			var remark = $("#remark").textbox("getValue");
			var catagory = $("#catagory").val();
			if (isNull(remark)) {
				errorMsg("请输入原因");
				$("#remark").next('span').find('input').focus();
				return false;
			}

			approve(2, remark, catagory);
			$("#dlg").dialog("close");
		}

		function doCancel() {
			$("#dlg").dialog("close");
		}
	</script>	
	
</body>

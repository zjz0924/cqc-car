<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<div style="margin-left: 20px; margin-top: 10px;">
		<a id="showBtn" href="javascript:void(0);" onclick="expand()" style="color:red;">展开</a>
		<a id="hideBtn" href="javascript:void(0);" onclick="expand()" style="display: none; color: red;">收起</a>
	</div>

	<div style="margin-left: 10px;margin-top:20px;">
		<div class="title">申请人信息</div>
		<div style="width: 98%;display:none;" id="applicatDiv">
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
		
		<div class="title">车型信息</div>
		<div style="width: 98%;display: none;" id="vehicleDiv">
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
		
		<div class="title">零件信息</div>
		<div style="width: 98%; display: none;" id="partsDiv">
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
	
		<div class="title">材料信息</div>
		<div style="width: 98%;display: none;" id="materialDiv">
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
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		
		<c:if test="${facadeBean.type == 2 || facadeBean.type == 3 }">
			<div class="title">任务信息</div>
			<div style="width: 98%;display: none;" id="taskInfoDiv">
				<table class="info">
					<tr class="single-row">
						<td class="title-td">申请人：</td>
						<td class="value-td">${facadeBean.taskInfo.applicant}</td>
						<td class="title-td">科室：</td>
						<td class="value-td">${facadeBean.taskInfo.department}</td>
					</tr>
					
					<tr class="couple-row">
						<td class="title-td">零件图号：</td>
						<td class="value-td">${facadeBean.taskInfo.figure}</td>
						<td class="title-td">样品数量：</td>
						<td class="value-td">${facadeBean.taskInfo.num}</td>
					</tr>
					
					<tr class="single-row">
						<td class="title-td">样品来源：</td>
						<td class="value-td">${facadeBean.taskInfo.origin}</td>
						<td class="title-td">抽检原因：</td>
						<td class="value-td">${facadeBean.taskInfo.reason}</td>
					</tr>
					
					<tr class="couple-row">
						<td class="title-td">实验费用出处：</td>
						<td class="value-td">${facadeBean.taskInfo.provenance}</td>
					</tr>
				</table>
			</div>
			<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		</c:if>
		
		<div class="title">试验结果</div>
		
		<c:if test="${(facadeBean.partsPatId == currentAccount.org.id or currentAccount.role.code == superRoleCole) and ( facadeBean.partsPatResult == 2) }">
			<div class="title" style="margin-top:15px;">零部件型式试验结果&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>${facadeBean.partsPat.name }</span></div>
			
			<div style="margin-left:10px;margin-bottom: 10px;">
				<c:forEach items="${labReqList}" var="vo">
					<c:if test="${vo.type eq 3}">
						<span class="remark-span">试验编号：</span> ${facadeBean.partsPatCode}<span class="remark-span" style="margin-left: 20px;">任务号：</span> ${vo.code}<span class="remark-span" style="margin-left: 20px;">商定完成时间：</span><fmt:formatDate value='${vo.time}' type="date" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;<span class="remark-span" style="margin-left: 20px;">试验要求</span>：${vo.remark }
					</c:if>
				</c:forEach>
			</div>
			
			<c:forEach items="${pPfResult}" var="m">
				<div style="margin-left: 10px; margin-bottom: 5px; font-weight: bold;color: red;">
					第${m.key}次试验
					<span style="float:right;margin-right: 25px;">报告上传时间：<fmt:formatDate value='${m.value[0].createTime }' type="date" pattern="yyyy-MM-dd HH:mm:ss"/></span>
				</div>
				
				<table class="info">
					<tr class="single-row">
						<td class="table-title" style="width: 5%;">序号</td>
						<td class="table-title"><span class="req-span">*</span>试验项目</td>
						<td class="table-title"><span class="req-span">*</span>参考标准</td>
						<td class="table-title"><span class="req-span">*</span>试验要求</td>
						<td class="table-title"><span class="req-span">*</span>试验结果</td>
						<td class="table-title"><span class="req-span">*</span>结果评价</td>
						<td class="table-title">备注</td>
					</tr>
					<c:forEach items="${m.value}" var="vo" varStatus="vst">
						<tr>
							<td>${vst.index + 1 }</td>
							<td><input class="easyui-textbox" style="width:170px" value="${vo.project}"></td>
							<td><input class="easyui-textbox" style="width:170px" value="${vo.standard}"></td>
							<td><input class="easyui-textbox" style="width:170px" value="${vo.require}"></td>
							<td><input class="easyui-textbox" style="width:170px" value="${vo.result}"></td>
							<td><input class="easyui-textbox" style="width:170px" value="${vo.evaluate}"></td>
							<td><input class="easyui-textbox" style="width:170px" value="${vo.remark}"></td>
						</tr>
					</c:forEach>
				</table>
			</c:forEach>
			
			<c:if test="${not empty attach.partsFile}">
				<div style="margin-top: 10px;margin-left: 10px;font-weight: bold;">
					试验结果附件：<a target="_blank" href="${resUrl}/${attach.partsFile}" download="${attach.partsFileName}">${attach.partsFileName}</a>
				</div>
			</c:if>
			
			<div style="margin-top: 30px;">	
				<table class="info">
					<tr class="single-row">
						<td class="remark-span"><span class="req-span">*</span>试验结论</td>
						<td class="remark-span">备注</td>
					</tr>
					
					<tr>
						<td class="value-td1">
							<select id="partsPat_conclusion" name="partsPat_conclusion" disabled style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'" >
								<option value="">请选择</option>
								<option value="合格" <c:if test="${partsPatConclusion.conclusion == '合格' }">selected="selected"</c:if>>合格</option>
								<option value="不合格" <c:if test="${partsPatConclusion.conclusion == '不合格' }">selected="selected"</c:if>>不合格</option>
								<option value="其它" <c:if test="${partsPatConclusion.conclusion == '其它' }">selected="selected"</c:if>>其它</option>
								<option value="基准" <c:if test="${partsPatConclusion.conclusion == '基准' }">selected="selected"</c:if>>基准</option>
							</select>
							<span id="partsPat_conclusion_error" class="req-span"></span>
						</td>
						
						<td class="value-td1">
							<input id="partsPat_remark" name="partsPat_remark" value="${partsPatConclusion.remark }" disabled class="easyui-textbox" style="width:950px" >
						</td>
					</tr>
				</table>
			</div>
		</c:if>
		
		<c:if test="${(facadeBean.partsAtlId == currentAccount.org.id or currentAccount.role.code == superRoleCole) and (facadeBean.partsAtlResult == 2) }">
			<div class="title" style="margin-top:15px;">零部件图谱试验结果&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>${facadeBean.partsAtl.name }</span></div>
			<div style="margin-left:10px;margin-bottom: 10px;">
				<c:forEach items="${labReqList}" var="vo">
					<c:if test="${vo.type eq 1}">
						<span class="remark-span">试验编号：</span> ${facadeBean.partsAtlCode}<span class="remark-span" style="margin-left: 20px;">任务号：</span> ${vo.code}<span class="remark-span" style="margin-left: 20px;">商定完成时间：</span><fmt:formatDate value='${vo.time}' type="date" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;<span class="remark-span" style="margin-left: 20px;">试验要求</span>：${vo.remark }
					</c:if>
				</c:forEach>
			</div>
			
			<c:forEach items="${pAtlasResult}" var="m">
				<div style="margin-left: 10px; margin-bottom: 5px; font-weight: bold;color: red;">
					第${m.key}次试验
					<span style="float:right;margin-right: 25px;">报告上传时间：<fmt:formatDate value='${m.value[0].createTime }' type="date" pattern="yyyy-MM-dd HH:mm:ss"/></span>
				</div>
				<table class="info">
					<tr class="single-row">
						<td class="title-td">图谱类型</td>
						<td class="title-td">图谱描述</td>
						<td class="title-td">选择图谱</td>
					</tr>
				
					<c:forEach items="${m.value}" var="vo" varStatus="vst">
						<tr style="line-height: 60px;">
							<td class="value-td">
								<c:if test="${vo.type == 4}">样品照片</c:if>
								<c:if test="${vo.type == 1}">红外光分析</c:if>
								<c:if test="${vo.type == 2}">差热扫描</c:if>
								<c:if test="${vo.type == 3}">热重分析</c:if>
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
			</c:forEach>
			
			<div style="margin-top: 30px;">	
				<table class="info">
					<tr class="single-row">
						<td class="remark-span"><span class="req-span">*</span>试验结论</td>
						<td class="remark-span">备注</td>
					</tr>
					
					<tr>
						<td class="value-td1">
							<select id="partsAtl_conclusion" name="partsAtl_conclusion" style="width:168px;" disabled class="easyui-combobox" data-options="panelHeight: 'auto'" >
								<option value="">请选择</option>
								<option value="合格" <c:if test="${partsAtlConclusion.conclusion == '合格' }">selected="selected"</c:if>>合格</option>
								<option value="不合格" <c:if test="${partsAtlConclusion.conclusion == '不合格' }">selected="selected"</c:if>>不合格</option>
								<option value="其它" <c:if test="${partsAtlConclusion.conclusion == '其它' }">selected="selected"</c:if>>其它</option>
								<option value="基准" <c:if test="${partsAtlConclusion.conclusion == '基准' }">selected="selected"</c:if>>基准</option>
							</select>
							<span id="partsAtl_conclusion_error" class="req-span"></span>
						</td>
						<td class="value-td1">
							<input id="partsAtl_remark" name="partsAtl_remark" value="${partsAtlConclusion.remark }" disabled class="easyui-textbox" style="width:950px" >
						</td>
					</tr>
				</table>
			</div>
		</c:if>
		
		<c:if test="${(facadeBean.matPatId == currentAccount.org.id or currentAccount.role.code == superRoleCole) and (facadeBean.matPatResult == 2) }">
			<div class="title" style="margin-top:15px;">原材料型式试验结果&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>${facadeBean.matPat.name }</span></div>
			<div style="margin-left:10px;margin-bottom: 10px;">
				<c:forEach items="${labReqList}" var="vo">
					<c:if test="${vo.type eq 4}">
						<span class="remark-span">试验编号：</span> ${facadeBean.matPatCode}<span class="remark-span" style="margin-left: 20px;">任务号：</span> ${vo.code}<span class="remark-span" style="margin-left: 20px;">商定完成时间：</span><fmt:formatDate value='${vo.time}' type="date" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;<span class="remark-span" style="margin-left: 20px;">试验要求</span>：${vo.remark }
					</c:if>
				</c:forEach>
			</div>
					
			<c:forEach items="${mPfResult}" var="m">
				<div style="margin-left: 10px; margin-bottom: 5px; font-weight: bold;color: red;">
					第${m.key}次试验
					<span style="float:right;margin-right: 25px;">报告上传时间：<fmt:formatDate value='${m.value[0].createTime }' type="date" pattern="yyyy-MM-dd HH:mm:ss"/></span>
				</div>
				<table class="info">
					<tr class="single-row">
						<td class="table-title" style="width: 5%;">序号</td>
						<td class="table-title"><span class="req-span">*</span>试验项目</td>
						<td class="table-title"><span class="req-span">*</span>参考标准</td>
						<td class="table-title"><span class="req-span">*</span>试验要求</td>
						<td class="table-title"><span class="req-span">*</span>试验结果</td>
						<td class="table-title"><span class="req-span">*</span>结果评价</td>
						<td class="table-title">备注</td>
					</tr>
					<c:forEach items="${m.value}" var="vo" varStatus="vst">
						<tr>
							<td>${vst.index + 1 }</td>
							<td><input class="easyui-textbox" style="width:170px" value="${vo.project}"></td>
							<td><input class="easyui-textbox" style="width:170px" value="${vo.standard}"></td>
							<td><input class="easyui-textbox" style="width:170px" value="${vo.require}"></td>
							<td><input class="easyui-textbox" style="width:170px" value="${vo.result}"></td>
							<td><input class="easyui-textbox" style="width:170px" value="${vo.evaluate}"></td>
							<td><input class="easyui-textbox" style="width:170px" value="${vo.remark}"></td>
						</tr>
					</c:forEach>
				</table>
			</c:forEach>
			
			
			<c:if test="${not empty attach.materialFile}">
				<div style="margin-top: 10px;margin-left: 10px;font-weight: bold;">
					试验结果附件：<a target="_blank" href="${resUrl}/${attach.materialFile}" download="${attach.materialFileName}">${attach.materialFileName}</a>
				</div>
			</c:if>
			
			<div style="margin-top: 30px;">	
				<table class="info">
					<tr class="single-row">
						<td class="remark-span"><span class="req-span">*</span>试验结论</td>
						<td class="remark-span">备注</td>
					</tr>
					
					<tr>
						<td class="value-td1">
							<select id="matPat_conclusion" name="matPat_conclusion" style="width:168px;" disabled class="easyui-combobox" data-options="panelHeight: 'auto'">
								<option value="">请选择</option>
								<option value="合格" <c:if test="${matPatConclusion.conclusion == '合格' }">selected="selected"</c:if>>合格</option>
								<option value="不合格" <c:if test="${matPatConclusion.conclusion == '不合格' }">selected="selected"</c:if>>不合格</option>
								<option value="其它" <c:if test="${matPatConclusion.conclusion == '其它' }">selected="selected"</c:if>>其它</option>
								<option value="基准" <c:if test="${matPatConclusion.conclusion == '基准' }">selected="selected"</c:if>>基准</option>
							</select>
							<span id="matPat_conclusion_error" class="req-span"></span>
						</td>
						
						<td class="value-td1">
							<input id="matPat_remark" name="matPat_remark" value="${matPatConclusion.remark }" disabled class="easyui-textbox" style="width:950px" >
						</td>
					</tr>
				</table>
			</div>
		</c:if>
		
		<c:if test="${(facadeBean.matAtlId == currentAccount.org.id or currentAccount.role.code == superRoleCole) and (facadeBean.matAtlResult == 2) }">
			<div class="title" style="margin-top:15px;">原材料图谱试验结果&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>${facadeBean.matAtl.name }</span></div>
			<div style="margin-left:10px;margin-bottom: 10px;">
				<c:forEach items="${labReqList}" var="vo">
					<c:if test="${vo.type eq 2}">
						<span class="remark-span">试验编号：</span> ${facadeBean.partsAtlCode}<span class="remark-span" style="margin-left: 20px;">任务号：</span> ${vo.code}<span class="remark-span" style="margin-left: 20px;">商定完成时间：</span><fmt:formatDate value='${vo.time}' type="date" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;<span class="remark-span" style="margin-left: 20px;">试验要求</span>：${vo.remark }
					</c:if>
				</c:forEach>
			</div>
			
			<c:forEach items="${mAtlasResult}" var="m">
				<div style="margin-left: 10px; margin-bottom: 5px; font-weight: bold;color: red;">
					第${m.key}次试验
					<span style="float:right;margin-right: 25px;">报告上传时间：<fmt:formatDate value='${m.value[0].createTime }' type="date" pattern="yyyy-MM-dd HH:mm:ss"/></span>
				</div>
				<table class="info">
					<tr class="single-row">
						<td class="title-td">图谱类型</td>
						<td class="title-td">图谱描述</td>
						<td class="title-td">选择图谱</td>
					</tr>
				
					<c:forEach items="${m.value}" var="vo" varStatus="vst">
						<tr style="line-height: 60px;">
							<td class="value-td">
								<c:if test="${vo.type == 4}">样品照片</c:if>
								<c:if test="${vo.type == 1}">红外光分析</c:if>
								<c:if test="${vo.type == 2}">差热扫描</c:if>
								<c:if test="${vo.type == 3}">热重分析</c:if>
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
			</c:forEach>
			
			<div style="margin-top: 30px;">	
				<table class="info">
					<tr class="single-row">
						<td class="remark-span"><span class="req-span">*</span>试验结论</td>
						<td class="remark-span">备注</td>
					</tr>
					
					<tr>
						<td class="value-td1">
							<select id="matAtl_conclusion" name="matAtl_conclusion" style="width:168px;" disabled class="easyui-combobox" data-options="panelHeight: 'auto'" >
								<option value="">请选择</option>
								<option value="合格" <c:if test="${matAtlConclusion.conclusion == '合格' }">selected="selected"</c:if>>合格</option>
								<option value="不合格" <c:if test="${matAtlConclusion.conclusion == '不合格' }">selected="selected"</c:if>>不合格</option>
								<option value="其它" <c:if test="${matAtlConclusion.conclusion == '其它' }">selected="selected"</c:if>>其它</option>
								<option value="基准" <c:if test="${matAtlConclusion.conclusion == '基准' }">selected="selected"</c:if>>基准</option>
							</select>
							<span id="matAtl_conclusion_error" class="req-span"></span>
						</td>
						
						<td class="value-td1">
							<input id="matAtl_remark" name="matAtl_remark" value="${matAtlConclusion.remark }" disabled class="easyui-textbox" style="width:950px" >
						</td>
					</tr>
				</table>
			</div>
			
		</c:if>
		
		<c:if test="${facadeBean.type == 2 or facadeBean.type == 3 }">
			<div class="title" style="margin-top: 30px;">结论</div>
			<div>
				<table style="width: 98%; font-size: 14px;">
					<tr style="background: #F0F0F0; height: 30px; font-weight: bold; text-align: center;">
						<td>类型</td>
						<td>样品照片</td>
						<td>红外光分析</td>
						<td>差热分析</td>
						<td>热重分析</td>
						<td>结论</td>
					</tr>
					
					<c:forEach items="${compareResult}" var="m">
						<tr>
							<td style="font-weight:bold;">${m.key}</td>
							<c:forEach items="${m.value}" var="vo" varStatus="vst">
								<td align="center">
									<div style="margin-top:5px;">
										<label><input name="${m.key}_radio_${vst.index}" type="radio" value="1" <c:if test="${vo.state == 1}">checked</c:if> disabled/>一致</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<label><input name="${m.key}_radio_${vst.index}" type="radio" value="2" <c:if test="${vo.state == 2}">checked</c:if> disabled/>不一致 </label> 
									</div>
									<div style="margin-top:5px;">
										<textarea rows="1" cols="25" disabled>${vo.remark}</textarea>
									</div>
								</td>
							</c:forEach>
						</tr>
					</c:forEach>
				</table>
			</div>
		</c:if>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		<div class="title" style="margin-top:15px;">结果发送</div>
		<div style="margin-left: 15px;">
			<c:if test="${(facadeBean.partsAtlId == currentAccount.org.id or currentAccount.role.code == superRoleCole) and (facadeBean.partsAtlResult == 2) }">
				<div style="margin-bottom: 5px;">零部件图谱试验结果：
					<input id="pAtlText" class="inputxt" readonly="readonly">
					<input id="pAtlValue" class="inputxt" type="hidden">
					<a onclick="chooseUser('pAtl')" href="javascript:void(0)" class="easyui-linkbutton l-btn l-btn-plain" icon="icon-search">选择</a>
					<a onclick="clearValue('pAtl')" href="javascript:void(0)" class="easyui-linkbutton l-btn l-btn-plain" icon="icon-redo">清空</a>&nbsp;&nbsp;&nbsp;&nbsp;
					
					<span id="pAtlError" style="color:red;"></span>
				</div>
			</c:if>
			
			<c:if test="${(facadeBean.partsPatId == currentAccount.org.id or currentAccount.role.code == superRoleCole) and ( facadeBean.partsPatResult == 2) }">
				<div style="margin-bottom: 5px;">零部件型式试验结果：
					<input id="pPatText" class="inputxt" readonly="readonly">
					<input id="pPatValue" class="inputxt" type="hidden">
					<a onclick="chooseUser('pPat')" href="javascript:void(0)" class="easyui-linkbutton l-btn l-btn-plain" icon="icon-search">选择</a>
					<a onclick="clearValue('pPat')" href="javascript:void(0)" class="easyui-linkbutton l-btn l-btn-plain" icon="icon-redo">清空</a>&nbsp;&nbsp;&nbsp;&nbsp;
					
					<span id="pPatError" style="color:red;"></span>
				</div>
			</c:if>
			
			<c:if test="${(facadeBean.matAtlId == currentAccount.org.id or currentAccount.role.code == superRoleCole) and (facadeBean.matAtlResult == 2) }">
				<div style="margin-bottom: 5px;">原材料图谱试验结果：
					<input id="mAtlText" class="inputxt" readonly="readonly">
					<input id="mAtlValue" class="inputxt" type="hidden">
					<a onclick="chooseUser('mAtl')" href="javascript:void(0)" class="easyui-linkbutton l-btn l-btn-plain" icon="icon-search">选择</a>
					<a onclick="clearValue('mAtl')" href="javascript:void(0)" class="easyui-linkbutton l-btn l-btn-plain" icon="icon-redo">清空</a>&nbsp;&nbsp;&nbsp;&nbsp;
					
					<span id="mAtlError" style="color:red;"></span>
				</div>
			</c:if>
			
			<c:if test="${(facadeBean.matPatId == currentAccount.org.id or currentAccount.role.code == superRoleCole) and (facadeBean.matPatResult == 2) }">
				<div style="margin-bottom: 5px;">原材料型式试验结果：
					<input id="mPatText" class="inputxt" readonly="readonly">
					<input id="mPatValue" class="inputxt" type="hidden">
					<a onclick="chooseUser('mPat')" href="javascript:void(0)" class="easyui-linkbutton l-btn l-btn-plain" icon="icon-search">选择</a>
					<a onclick="clearValue('mPat')" href="javascript:void(0)" class="easyui-linkbutton l-btn l-btn-plain" icon="icon-redo">清空</a>&nbsp;&nbsp;&nbsp;&nbsp;
					
					<span id="mPatError" style="color:red;"></span>
				</div>
			</c:if>
		</div>
				
		<div style="margin-top:30px;font-weight:bold;color:red;" align="center" id="atlasError"></div>
		<div align="center" style="margin-top:10px;margin-bottom: 20px;">
			<a id="sendBtn" href="javascript:void(0);"  onclick="doSubmit(1)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">发送结果</a>
			<a id="redoBtn" href="javascript:void(0);"  onclick="doSubmit(2)" class="easyui-linkbutton" data-options="iconCls:'icon-redo'">跳过</a>
			<a id="cancelBtn" href="javascript:void(0);"  onclick="doCancel()" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
	
	<div id="userDialog"></div>	
	
	<script type="text/javascript">
		var pAtlUser;
		var pPatUser;
		var mAtlUser;
		var mPatUser;
		// 是否提交中
		var saving = false;
	
		$(function(){
			pAtlUser = $("#pAtlText").length;
			pPatUser = $("#pPatText").length;
			mAtlUser = $("#mAtlText").length;
			mPatUser = $("#mPatText").length;
			
			var sendEmails = "${sendEmails}";
			var sendNames = "${sendNames}";
			
			if(!isNull(sendEmails)){
				if(pAtlUser > 0){
					$("#pAtlText").val(sendNames);
					$("#pAtlValue").val(sendEmails);
				}
				
				if(pPatUser > 0){
					$("#pPatText").val(sendNames);
					$("#pPatValue").val(sendEmails);
				}
				
				if(mAtlUser > 0){
					$("#mAtlText").val(sendNames);
					$("#mAtlValue").val(sendEmails);
				}
				
				if(mPatUser > 0){
					$("#mPatText").val(sendNames);
					$("#mPatValue").val(sendEmails);
				}	
			}
		});
	
		/** 发送结果保存
		  * type： 1-发送结果， 2-不发送，直接跳过 
		**/
		function doSubmit(type){
			if(saving){
				return false;
			}
			saving = true;
			
			var pAtlVal = "";
			var pPatVal = "";
			var mAtlVal = "";
			var mPatVal = "";
			
			$("#sendBtn").hide();
			$("#cancelBtn").hide();
			$("#redoBtn").hide();
			$("#atlasError").html("结果发送中，请稍等");
			
			if(type == 1){
				if(pAtlUser > 0){
					pAtlVal= $("#pAtlValue").val();
					if(isNull(pAtlVal)){
						$("#pAtlError").html("请选择要发送的用户");
						$("#sendBtn").show();
						$("#cancelBtn").show();
						$("#redoBtn").show();
						$("#atlasError").html("");
						saving = false;
						return false;
					}
					$("#pAtlError").html("");
				}
				
				if(pPatUser > 0){
					pPatVal= $("#pPatValue").val();
					if(isNull(pPatVal)){
						$("#pPatError").html("请选择要发送的用户");
						$("#sendBtn").show();
						$("#cancelBtn").show();
						$("#redoBtn").show();
						$("#atlasError").html("");
						saving = false;
						return false;
					}
					$("#pPatError").html("");
				}
				
				if(mAtlUser > 0){
					mAtlVal= $("#mAtlValue").val();
					if(isNull(mAtlVal)){
						$("#mAtlError").html("请选择要发送的用户");
						$("#sendBtn").show();
						$("#cancelBtn").show();
						$("#redoBtn").show();
						$("#atlasError").html("");
						saving = false;
						return false;
					}
					$("#mAtlError").html("");
				}
				
				if(mPatUser > 0){
					mPatVal= $("#mPatValue").val();
					if(isNull(mPatVal)){
						$("#mPatError").html("请选择要发送的用户");
						$("#sendBtn").show();
						$("#cancelBtn").show();
						$("#redoBtn").show();
						$("#atlasError").html("");
						saving = false;
						return false;
					}
					$("#mPatError").html("");
				}	
			}
					
			$.ajax({
				url: "${ctx}/result/sendResult",
				type: "post",
				data: {
					"taskId": '${facadeBean.id}',
					"pAtlVal": pAtlVal,
					"pPatVal": pPatVal,
					"mAtlVal": mAtlVal,
					"mPatVal": mPatVal,
					"type": type
				},
				success: function(data){
					saving = false;
					if(data.success){
						closeDialog(data.msg);
					}else{
						$("#atlasError").html(data.msg);
						$("#sendBtn").show();
						$("#cancelBtn").show();
						$("#redoBtn").show();
					}
				}
			});
		}

		function doCancel(){
			$("#sendDetailDialog").dialog("close");
		}

		function expand(){
			$("#vehicleDiv").toggle();
			$("#partsDiv").toggle();
			$("#materialDiv").toggle();
			$("#showBtn").toggle();
			$("#hideBtn").toggle();
			$("#taskInfoDiv").toggle();
			$("#applicatDiv").toggle();
		}
		
		function clearValue(id){
			$("#" + id + "Text").val("");
			$("#" + id + "Value").val("");
			$("#" + id + "Error").html("");
		}
		
		function chooseUser(id){
			$('#userDialog').dialog({
				title : '用户信息',
				width : 1100,
				height : 550,
				closed : false,
				cache : false,
				top: 600,
				href : "${ctx}/result/userList?type=" + id,
				modal : true
			});
			top.parent.scrollTo(0, 600);
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
			padding-left: 5px;
			font-weight: bold;
		}
		
		.value-td{
			width:32%;
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
		
		.table-title{
			padding-left: 5px;
			font-weight: bold;
		}
		
		.remark-span{
			font-weight: bold;
		}
		
		.inputxt{
			border: 1px solid #D7D7D7;
		    border-radius: 3PX;
		    height: 25px;
		    padding: 7px 0 7px 5px!important;
		    line-height: 14PX;
		    font-size: 12px;
		    display: inline-block;
		    width: 400px;
		}
	</style>
	
</body>

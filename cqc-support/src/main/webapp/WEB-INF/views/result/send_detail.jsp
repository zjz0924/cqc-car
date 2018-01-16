<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<div style="margin-left: 20px; margin-top: 10px;">
		<a id="showBtn" href="javascript:void(0);" onclick="expand()" style="color:red;">展开</a>
		<a id="hideBtn" href="javascript:void(0);" onclick="expand()" style="display: none; color: red;">收起</a>
	</div>

	<div style="margin-left: 10px;margin-top:20px;">
		<div class="title">整车信息</div>
		<div style="width: 98%;display: none;" id="vehicleDiv">
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
		
		<c:if test="${facadeBean.type != 4}">
			<div class="title">零部件信息</div>
			<div style="width: 98%; display: none;" id="partsDiv">
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
		</c:if>
		
		<div class="title">原材料信息</div>
		<div style="width: 98%;display: none;" id="materialDiv">
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
		<div class="title">试验结果</div>
		
		<c:if test="${(facadeBean.partsPatId == currentAccount.org.id or currentAccount.role.code == superRoleCole) and ( facadeBean.partsPatResult == 2) }">
			<div class="title" style="margin-top:15px;">零部件型式试验结果</div>
			
			<div style="margin-left:10px;margin-bottom: 10px;">
				<c:forEach items="${labReqList}" var="vo">
					<c:if test="${vo.type eq 3}">
						<span class="remark-span">任务号：</span> ${vo.code}<span class="remark-span" style="margin-left: 20px;">商定完成时间：</span><fmt:formatDate value='${vo.time}' type="date" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;<span class="remark-span" style="margin-left: 20px;">试验要求</span>：${vo.remark }
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
			
			<div style="margin-top: 30px;">	
				<table class="info">
					<tr class="single-row">
						<td class="remark-span"><span class="req-span">*</span>试验结论</td>
						<td class="remark-span"><span class="req-span">*</span>报告编号</td>
						<td class="remark-span"><span class="req-span">*</span>主检</td>
						<td class="remark-span"><span class="req-span">*</span>审核</td>
						<td class="remark-span"><span class="req-span">*</span>签发</td>
						<td class="remark-span"><span class="req-span">*</span>收样时间</td>
						<td class="remark-span"><span class="req-span">*</span>试验时间</td>
						<td class="remark-span"><span class="req-span">*</span>签发时间</td>
						<td class="remark-span">备注</td>
					</tr>
					
					<tr>
						<td class="value-td1">
							<select id="partsPat_conclusion" name="partsPat_conclusion" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'" >
								<option value="">请选择</option>
								<option value="合格" <c:if test="${partsPatConclusion.conclusion == '合格' }">selected="selected"</c:if>>合格</option>
								<option value="不合格" <c:if test="${partsPatConclusion.conclusion == '不合格' }">selected="selected"</c:if>>不合格</option>
								<option value="其它" <c:if test="${partsPatConclusion.conclusion == '其它' }">selected="selected"</c:if>>其它</option>
							</select>
							<span id="partsPat_conclusion_error" class="req-span"></span>
						</td>
						<td class="value-td1">
							<input id="partsPat_repNum" name="partsPat_repNum" value="${partsPatConclusion.repNum }" class="easyui-textbox" style="width:115px" >
						</td>
						<td class="value-td1">
							<input id="partsPat_mainInspe" name="partsPat_mainInspe" value="${partsPatConclusion.mainInspe }" class="easyui-textbox" style="width:115px" >
						</td>
						
						<td class="value-td1">
							<input id="partsPat_examine" name="partsPat_examine" value="${partsPatConclusion.examine }" class="easyui-textbox" style="width:115px" >
						</td>
						
						<td class="value-td1">
							<input id="partsPat_issue" name="partsPat_issue" value="${partsPatConclusion.issue }" class="easyui-textbox" style="width:115px" >
						</td>
						
						<td class="value-td1">
							<input id="partsPat_receiveDate" name="partsPat_receiveDate" value="${partsPatConclusion.receiveDate }" class="easyui-datebox" style="width:115px" data-options="editable:false" >
						</td>
						
						<td class="value-td1">
							<input id="partsPat_examineDate" name="partsPat_examineDate" value="${partsPatConclusion.examineDate }" class="easyui-datebox" style="width:115px" data-options="editable:false" >
						</td>
						
						<td class="value-td1">
							<input id="partsPat_issueDate" name="partsPat_issueDate" value="${partsPatConclusion.issueDate }" class="easyui-datebox" style="width:115px" data-options="editable:false" >
						</td>
						
						<td class="value-td1">
							<input id="partsPat_remark" name="partsPat_remark" value="${partsPatConclusion.remark }" class="easyui-textbox" style="width:115px" >
						</td>
					</tr>
				</table>
			</div>
		</c:if>
		
		<c:if test="${(facadeBean.partsAtlId == currentAccount.org.id or currentAccount.role.code == superRoleCole) and (facadeBean.partsAtlResult == 2) }">
			<div class="title" style="margin-top:15px;">零部件图谱试验结果</div>
			<div style="margin-left:10px;margin-bottom: 10px;">
				<c:forEach items="${labReqList}" var="vo">
					<c:if test="${vo.type eq 1}">
						<span class="remark-span">任务号：</span> ${vo.code}<span class="remark-span" style="margin-left: 20px;">商定完成时间：</span><fmt:formatDate value='${vo.time}' type="date" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;<span class="remark-span" style="margin-left: 20px;">试验要求</span>：${vo.remark }
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
						<td class="remark-span"><span class="req-span">*</span>报告编号</td>
						<td class="remark-span"><span class="req-span">*</span>主检</td>
						<td class="remark-span"><span class="req-span">*</span>审核</td>
						<td class="remark-span"><span class="req-span">*</span>签发</td>
						<td class="remark-span"><span class="req-span">*</span>收样时间</td>
						<td class="remark-span"><span class="req-span">*</span>试验时间</td>
						<td class="remark-span"><span class="req-span">*</span>签发时间</td>
						<td class="remark-span">备注</td>
					</tr>
					
					<tr>
						<td class="value-td1">
							<select id="partsAtl_conclusion" name="partsAtl_conclusion" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'" >
								<option value="">请选择</option>
								<option value="合格" <c:if test="${partsAtlConclusion.conclusion == '合格' }">selected="selected"</c:if>>合格</option>
								<option value="不合格" <c:if test="${partsAtlConclusion.conclusion == '不合格' }">selected="selected"</c:if>>不合格</option>
								<option value="其它" <c:if test="${partsAtlConclusion.conclusion == '其它' }">selected="selected"</c:if>>其它</option>
							</select>
							<span id="partsAtl_conclusion_error" class="req-span"></span>
						</td>
						<td class="value-td1">
							<input id="partsAtl_repNum" name="partsAtl_repNum" value="${partsAtlConclusion.repNum }" class="easyui-textbox" style="width:115px" >
						</td>
						<td class="value-td1">
							<input id="partsAtl_mainInspe" name="partsAtl_mainInspe" value="${partsAtlConclusion.mainInspe }" class="easyui-textbox" style="width:115px" >
						</td>
						
						<td class="value-td1">
							<input id="partsAtl_examine" name="partsAtl_examine" value="${partsAtlConclusion.examine }" class="easyui-textbox" style="width:115px" >
						</td>
						
						<td class="value-td1">
							<input id="partsAtl_issue" name="partsAtl_issue" value="${partsAtlConclusion.issue }" class="easyui-textbox" style="width:115px" >
						</td>
						
						<td class="value-td1">
							<input id="partsAtl_receiveDate" name="partsAtl_receiveDate" value="${partsAtlConclusion.receiveDate }" class="easyui-datebox" style="width:115px" data-options="editable:false" >
						</td>
						
						<td class="value-td1">
							<input id="partsAtl_examineDate" name="partsAtl_examineDate" value="${partsAtlConclusion.examineDate }" class="easyui-datebox" style="width:115px" data-options="editable:false" >
						</td>
						
						<td class="value-td1">
							<input id="partsAtl_issueDate" name="partsAtl_issueDate" value="${partsAtlConclusion.issueDate }" class="easyui-datebox" style="width:115px" data-options="editable:false" >
						</td>
						
						<td class="value-td1">
							<input id="partsAtl_remark" name="partsAtl_remark" value="${partsAtlConclusion.remark }" class="easyui-textbox" style="width:115px" >
						</td>
					</tr>
				</table>
			</div>
		</c:if>
		
		<c:if test="${(facadeBean.matPatId == currentAccount.org.id or currentAccount.role.code == superRoleCole) and (facadeBean.matPatResult == 2) }">
			<div class="title" style="margin-top:15px;">原材料型式试验结果</div>
			<div style="margin-left:10px;margin-bottom: 10px;">
				<c:forEach items="${labReqList}" var="vo">
					<c:if test="${vo.type eq 4}">
						<span class="remark-span">任务号：</span> ${vo.code}<span class="remark-span" style="margin-left: 20px;">商定完成时间：</span><fmt:formatDate value='${vo.time}' type="date" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;<span class="remark-span" style="margin-left: 20px;">试验要求</span>：${vo.remark }
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
			
			<div style="margin-top: 30px;">	
				<table class="info">
					<tr class="single-row">
						<td class="remark-span"><span class="req-span">*</span>试验结论</td>
						<td class="remark-span"><span class="req-span">*</span>报告编号</td>
						<td class="remark-span"><span class="req-span">*</span>主检</td>
						<td class="remark-span"><span class="req-span">*</span>审核</td>
						<td class="remark-span"><span class="req-span">*</span>签发</td>
						<td class="remark-span"><span class="req-span">*</span>收样时间</td>
						<td class="remark-span"><span class="req-span">*</span>试验时间</td>
						<td class="remark-span"><span class="req-span">*</span>签发时间</td>
						<td class="remark-span">备注</td>
					</tr>
					
					<tr>
						<td class="value-td1">
							<select id="matPat_conclusion" name="matPat_conclusion" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
								<option value="">请选择</option>
								<option value="合格" <c:if test="${matPatConclusion.conclusion == '合格' }">selected="selected"</c:if>>合格</option>
								<option value="不合格" <c:if test="${matPatConclusion.conclusion == '不合格' }">selected="selected"</c:if>>不合格</option>
								<option value="其它" <c:if test="${matPatConclusion.conclusion == '其它' }">selected="selected"</c:if>>其它</option>
							</select>
							<span id="matPat_conclusion_error" class="req-span"></span>
						</td>
						<td class="value-td1">
							<input id="matPat_repNum" name="matPat_repNum" value="${matPatConclusion.repNum }" class="easyui-textbox" style="width:115px">
						</td>
						<td class="value-td1">
							<input id="matPat_mainInspe" name="matPat_mainInspe" value="${matPatConclusion.mainInspe }" class="easyui-textbox" style="width:115px" >
						</td>
						
						<td class="value-td1">
							<input id="matPat_examine" name="matPat_examine" value="${matPatConclusion.examine }" class="easyui-textbox" style="width:115px" >
						</td>
						
						<td class="value-td1">
							<input id="matPat_issue" name="matPat_issue" value="${matPatConclusion.issue }" class="easyui-textbox" style="width:115px" >
						</td>
						
						<td class="value-td1">
							<input id="matPat_receiveDate" name="matPat_receiveDate" value="${matPatConclusion.receiveDate }" class="easyui-datebox" style="width:115px" data-options="editable:false" >
						</td>
						
						<td class="value-td1">
							<input id="matPat_examineDate" name="matPat_examineDate" value="${matPatConclusion.examineDate }" class="easyui-datebox" style="width:115px" data-options="editable:false" >
						</td>
						
						<td class="value-td1">
							<input id="matPat_issueDate" name="matPat_issueDate" value="${matPatConclusion.issueDate }" class="easyui-datebox" style="width:115px" data-options="editable:false" >
						</td>
						
						<td class="value-td1">
							<input id="matPat_remark" name="matPat_remark" value="${matPatConclusion.remark }" class="easyui-textbox" style="width:115px" >
						</td>
					</tr>
				</table>
			</div>
		</c:if>
		
		<c:if test="${(facadeBean.matAtlId == currentAccount.org.id or currentAccount.role.code == superRoleCole) and (facadeBean.matAtlResult == 2) }">
			<div class="title" style="margin-top:15px;">原材料图谱试验结果</div>
			<div style="margin-left:10px;margin-bottom: 10px;">
				<c:forEach items="${labReqList}" var="vo">
					<c:if test="${vo.type eq 2}">
						<span class="remark-span">任务号：</span> ${vo.code}<span class="remark-span" style="margin-left: 20px;">商定完成时间：</span><fmt:formatDate value='${vo.time}' type="date" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;<span class="remark-span" style="margin-left: 20px;">试验要求</span>：${vo.remark }
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
						<td class="remark-span"><span class="req-span">*</span>报告编号</td>
						<td class="remark-span"><span class="req-span">*</span>主检</td>
						<td class="remark-span"><span class="req-span">*</span>审核</td>
						<td class="remark-span"><span class="req-span">*</span>签发</td>
						<td class="remark-span"><span class="req-span">*</span>收样时间</td>
						<td class="remark-span"><span class="req-span">*</span>试验时间</td>
						<td class="remark-span"><span class="req-span">*</span>签发时间</td>
						<td class="remark-span">备注</td>
					</tr>
					
					<tr>
						<td class="value-td1">
							<select id="matAtl_conclusion" name="matAtl_conclusion" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'" >
								<option value="">请选择</option>
								<option value="合格" <c:if test="${matAtlConclusion.conclusion == '合格' }">selected="selected"</c:if>>合格</option>
								<option value="不合格" <c:if test="${matAtlConclusion.conclusion == '不合格' }">selected="selected"</c:if>>不合格</option>
								<option value="其它" <c:if test="${matAtlConclusion.conclusion == '其它' }">selected="selected"</c:if>>其它</option>
							</select>
							<span id="matAtl_conclusion_error" class="req-span"></span>
						</td>
						<td class="value-td1">
							<input id="matAtl_repNum" name="matAtl_repNum" value="${matAtlConclusion.repNum }" class="easyui-textbox" style="width:115px" >
						</td>
						<td class="value-td1">
							<input id="matAtl_mainInspe" name="matAtl_mainInspe" value="${matAtlConclusion.mainInspe }" class="easyui-textbox" style="width:115px" >
						</td>
						
						<td class="value-td1">
							<input id="matAtl_examine" name="matAtl_examine" value="${matAtlConclusion.examine }" class="easyui-textbox" style="width:115px" >
						</td>
						
						<td class="value-td1">
							<input id="matAtl_issue" name="matAtl_issue" value="${matAtlConclusion.issue }" class="easyui-textbox" style="width:115px" >
						</td>
						
						<td class="value-td1">
							<input id="matAtl_receiveDate" name="matAtl_receiveDate" value="${matAtlConclusion.receiveDate }" class="easyui-datebox" style="width:115px" data-options="editable:false" >
						</td>
						
						<td class="value-td1">
							<input id="matAtl_examineDate" name="matAtl_examineDate" value="${matAtlConclusion.examineDate }" class="easyui-datebox" style="width:115px" data-options="editable:false" >
						</td>
						
						<td class="value-td1">
							<input id="matAtl_issueDate" name="matAtl_issueDate" value="${matAtlConclusion.issueDate }" class="easyui-datebox" style="width:115px" data-options="editable:false" >
						</td>
						
						<td class="value-td1">
							<input id="matAtl_remark" name="matAtl_remark" value="${matAtlConclusion.remark }" class="easyui-textbox" style="width:115px" >
						</td>
					</tr>
				</table>
			</div>
			
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
			<a id="sendBtn" href="javascript:void(0);"  onclick="doSubmit(1)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">发送结果</a>
			<a id="redoBtn" href="javascript:void(0);"  onclick="doSubmit(2)" class="easyui-linkbutton" data-options="iconCls:'icon-redo'">跳过</a>
			<a id="cancelBtn" href="javascript:void(0);"  onclick="doCancel()" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
			
	
	<script type="text/javascript">
		var pAtlOrg;
		var pPatOrg;
		var mAtlOrg;
		var mPatOrg; 
		// 是否提交中
		var saving = false;
	
		$(function(){
			// 默认发送的机构ID
			var sendOrgId = "${sendOrgId}";
			
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
				
				if(!isNull(sendOrgId)){
					$("#pAtlOrg").combotree("setValue", sendOrgId);
				}
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
				
				if(!isNull(sendOrgId)){
					$("#pPatOrg").combotree("setValue", sendOrgId);
				}
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
				
				if(!isNull(sendOrgId)){
					$("#mAtlOrg").combotree("setValue", sendOrgId);
				}
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
				
				if(!isNull(sendOrgId)){
					$("#mPatOrg").combotree("setValue", sendOrgId);
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
			
			var pAtlOrgVal = "";
			var pPatOrgVal = "";
			var mAtlOrgVal = "";
			var mPatOrgVal = "";
			
			$("#sendBtn").hide();
			$("#cancelBtn").hide();
			$("#redoBtn").hide();
			$("#atlasError").html("结果发送中，请稍等");
			
			if(type == 1){
				if(pAtlOrg > 0){
					pAtlOrgVal= $("#pAtlOrg").combotree("getValues");
					if(isNull(pAtlOrgVal)){
						$("#pAtlOrgError").html("请选择要发送的机构");
						$("#sendBtn").show();
						$("#cancelBtn").show();
						$("#redoBtn").show();
						$("#atlasError").html("");
						saving = false;
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
						$("#redoBtn").show();
						$("#atlasError").html("");
						saving = false;
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
						$("#redoBtn").show();
						$("#atlasError").html("");
						saving = false;
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
						$("#redoBtn").show();
						$("#atlasError").html("");
						saving = false;
						return false;
					}
					$("#mPatOrgError").html("");
				}	
			}
					
			$.ajax({
				url: "${ctx}/result/sendResult",
				data: {
					"taskId": '${facadeBean.id}',
					"pAtlOrgVal": pAtlOrgVal.toString(),
					"pPatOrgVal": pPatOrgVal.toString(),
					"mAtlOrgVal": mAtlOrgVal.toString(),
					"mPatOrgVal": mPatOrgVal.toString(),
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
	</style>
	
</body>

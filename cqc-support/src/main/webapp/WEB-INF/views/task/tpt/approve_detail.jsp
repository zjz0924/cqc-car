<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<div style="margin-left: 10px;margin-top:20px;">
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
		
		<div class="title">抽样原因</div>
		<div style="width: 98%;">
			<table class="info">
				<tr class="single-row">
					<td class="title-td">样件来源：</td>
					<td class="value-td">${facadeBean.reason.origin }</td>
					<td class="title-td">抽样原因：</td>
					<td class="value-td">${facadeBean.reason.reason}</td>
				</tr>
				<tr class="single-row">
					<td class="title-td">其他原因描述：</td>
					<td class="value-td">${facadeBean.reason.otherRemark }</td>
					<td class="title-td">费用出处：</td>
					<td class="value-td">${facadeBean.reason.source}</td>
				</tr>
				<tr class="single-row">
					<td class="title-td">备注：</td>
					<td class="value-td">${facadeBean.reason.remark }</td>
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
							<td class="title-td">试验编号</td>
							<td class="title-td">试验名称</td>
							<td class="title-td">分配实验室</td>
						</tr>
						
						<c:if test="${not empty facadeBean.partsAtl}">
							<tr>
								<td class="value-td">${facadeBean.partsAtlCode }</td>
								<td class="value-td">零部件图谱试验</td>
								<td class="value-td">
									<c:choose>
										<c:when test="${facadeBean.partsAtlResult != 0}">
											${facadeBean.partsAtl.name}
										</c:when>
										<c:otherwise>
											<input id="partsAtlId" name="partsAtlId">
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:if>
						
						<c:if test="${not empty facadeBean.matAtl}">
							<tr>
								<td class="value-td">${facadeBean.matAtlCode }</td>
								<td class="value-td">原材料图谱试验</td>
								<td class="value-td">
									<c:choose>
										<c:when test="${facadeBean.matAtlResult != 0}">
											${facadeBean.matAtl.name}
										</c:when>
										<c:otherwise>
											<input id="matAtlId" name="matAtlId">
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:if>
						
						<c:if test="${not empty facadeBean.partsPat}">
							<tr>
								<td class="value-td">${facadeBean.partsPatCode }</td>
								<td class="value-td">零部件型式试验</td>
								<td class="value-td">
									<c:choose>
										<c:when test="${facadeBean.partsPatResult != 0}">
											${facadeBean.partsPat.name}
										</c:when>
										<c:otherwise>
											<input id="partsPatId" name="partsPatId">
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:if>
						
						<c:if test="${not empty facadeBean.matPat}">
							<tr>
								<td class="value-td">${facadeBean.matPatCode }</td>
								<td class="value-td">原材料型式试验</td>
								<td class="value-td">
									<c:choose>
										<c:when test="${facadeBean.matPatResult != 0}">
											${facadeBean.matPat.name}
										</c:when>
										<c:otherwise>
											<input id="matPatId" name="matPatId">
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:if>
					</table>
				</div>
		
				 <div style="text-align:center;margin-top:25px;margin-bottom: 15px;" class="data-row">
					<a id="allAgree" href="javascript:void(0);"  onclick="approve(1,'', 5)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">全部同意</a>&nbsp;&nbsp;
					<a id="allNotAgree" href="javascript:void(0);"  onclick="notPass(5)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">全部不同意</a>
				</div>
			</c:when>
			<c:when test="${approveType == 2}">  
				<div class="title">试验结果</div>
				
				<c:if test="${taskType == 1 }">
					<div class="title">零部件试验结果</div>
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
					
						<c:forEach items="${pPfResult_old}" var="vo" varStatus="status">
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
					
					<div style="margin-left: 10px;color:red;margin-top: 20px;">修改后结果：</div>
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
					
						<c:forEach items="${pPfResult_new}" var="vo" varStatus="status">
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
					
					
					<div style="margin-top: 30px;">	
						<table class="info">
							<tr class="single-row">
								<td class="remark-span"><span class="req-span">*</span>试验结论</td>
								<td class="remark-span">备注</td>
							</tr>
							
							<tr>
								<td class="value-td1">
									<select id="partsPat_conclusion" name="partsPat_conclusion" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'" >
										<option value="">请选择</option>
										<option value="合格" <c:if test="${partsPatConclusion_old.conclusion == '合格' }">selected="selected"</c:if>>合格</option>
										<option value="不合格" <c:if test="${partsPatConclusion_old.conclusion == '不合格' }">selected="selected"</c:if>>不合格</option>
										<option value="其它" <c:if test="${partsPatConclusion_old.conclusion == '其它' }">selected="selected"</c:if>>其它</option>
									</select>
									<span id="partsPat_conclusion_error" class="req-span"></span>
								</td>
								<td class="value-td1">
									<input id="partsPat_remark" name="partsPat_remark" value="${partsPatConclusion_old.remark }" class="easyui-textbox" style="width:195px" >
								</td>
							</tr>
						</table>
					</div>
					
					<div style="margin-left: 10px;color:red;margin-top: 20px;">修改后结果：</div>
					
					<div style="margin-top: 5px;">	
						<table class="info">
							<tr class="single-row">
								<td class="remark-span"><span class="req-span">*</span>试验结论</td>
								<td class="remark-span">备注</td>
							</tr>
							
							<tr>
								<td class="value-td1">
									<select id="partsPat_conclusion" name="partsPat_conclusion" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'" >
										<option value="">请选择</option>
										<option value="合格" <c:if test="${partsPatConclusion_new.conclusion == '合格' }">selected="selected"</c:if>>合格</option>
										<option value="不合格" <c:if test="${partsPatConclusion_new.conclusion == '不合格' }">selected="selected"</c:if>>不合格</option>
										<option value="其它" <c:if test="${partsPatConclusion_new.conclusion == '其它' }">selected="selected"</c:if>>其它</option>
									</select>
									<span id="partsPat_conclusion_error" class="req-span"></span>
								</td>
								
								<td class="value-td1">
									<input id="partsPat_remark" name="partsPat_remark" value="${partsPatConclusion_new.remark }" class="easyui-textbox" style="width:195px" >
								</td>
							</tr>
						</table>
					</div>
					
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
					
					<div style="margin-top: 30px;">	
						<table class="info">
							<tr class="single-row">
								<td class="remark-span"><span class="req-span">*</span>试验结论</td>
								<td class="remark-span">备注</td>
							</tr>
							
							<tr>
								<td class="value-td1">
									<select id="partsAtl_conclusion" name="partsAtl_conclusion" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'" >
										<option value="">请选择</option>
										<option value="合格" <c:if test="${partsAtlConclusion_old.conclusion == '合格' }">selected="selected"</c:if>>合格</option>
										<option value="不合格" <c:if test="${partsAtlConclusion_old.conclusion == '不合格' }">selected="selected"</c:if>>不合格</option>
										<option value="其它" <c:if test="${partsAtlConclusion_old.conclusion == '其它' }">selected="selected"</c:if>>其它</option>
									</select>
									<span id="partsAtl_conclusion_error" class="req-span"></span>
								</td>
								<td class="value-td1">
									<input id="partsAtl_remark" name="partsAtl_remark" value="${partsAtlConclusion_old.remark }" class="easyui-textbox" style="width:195px" >
								</td>
							</tr>
						</table>
					</div>
					
					<div style="margin-left: 10px;color:red;margin-top: 20px;">修改后结果：</div>
					
					<div style="margin-top: 5px;">	
						<table class="info">
							<tr class="single-row">
								<td class="remark-span"><span class="req-span">*</span>试验结论</td>
								<td class="remark-span">备注</td>
							</tr>
							
							<tr>
								<td class="value-td1">
									<select id="partsAtl_conclusion" name="partsAtl_conclusion" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'" >
										<option value="">请选择</option>
										<option value="合格" <c:if test="${partsAtlConclusion_new.conclusion == '合格' }">selected="selected"</c:if>>合格</option>
										<option value="不合格" <c:if test="${partsAtlConclusion_new.conclusion == '不合格' }">selected="selected"</c:if>>不合格</option>
										<option value="其它" <c:if test="${partsAtlConclusion_new.conclusion == '其它' }">selected="selected"</c:if>>其它</option>
									</select>
									<span id="partsAtl_conclusion_error" class="req-span"></span>
								</td>
								<td class="value-td1">
									<input id="partsAtl_remark" name="partsAtl_remark" value="${partsAtlConclusion_new.remark }" class="easyui-textbox" style="width:195px" >
								</td>
							</tr>
						</table>
					</div>
					
				</c:if>
				
				<div class="title" style="margin-top: 10px;">原材料试验结果</div>
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
				
					<c:forEach items="${mPfResult_old}" var="vo" varStatus="status">
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
				
				<div style="margin-left: 10px;color:red;margin-top: 20px;">修改后结果：</div>
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
				
					<c:forEach items="${mPfResult_new}" var="vo" varStatus="status">
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
				
				<div style="margin-top: 30px;">	
					<table class="info">
						<tr class="single-row">
							<td class="remark-span"><span class="req-span">*</span>试验结论</td>
							<td class="remark-span">备注</td>
						</tr>
						
						<tr>
							<td class="value-td1">
								<select id="matPat_conclusion" name="matPat_conclusion" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
									<option value="">请选择</option>
									<option value="合格" <c:if test="${matPatConclusion_old.conclusion == '合格' }">selected="selected"</c:if>>合格</option>
									<option value="不合格" <c:if test="${matPatConclusion_old.conclusion == '不合格' }">selected="selected"</c:if>>不合格</option>
									<option value="其它" <c:if test="${matPatConclusion_old.conclusion == '其它' }">selected="selected"</c:if>>其它</option>
								</select>
								<span id="matPat_conclusion_error" class="req-span"></span>
							</td>
							<td class="value-td1">
								<input id="matPat_remark" name="matPat_remark" value="${matPatConclusion_old.remark }" class="easyui-textbox" style="width:195px" >
							</td>
						</tr>
					</table>
				</div>
				
				<div style="margin-left: 10px;color:red;margin-top: 20px;">修改后结果：</div>
				
				<div style="margin-top: 5px;">	
					<table class="info">
						<tr class="single-row">
							<td class="remark-span"><span class="req-span">*</span>试验结论</td>
							<td class="remark-span">备注</td>
						</tr>
						
						<tr>
							<td class="value-td1">
								<select id="matPat_conclusion" name="matPat_conclusion" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
									<option value="">请选择</option>
									<option value="合格" <c:if test="${matPatConclusion_new.conclusion == '合格' }">selected="selected"</c:if>>合格</option>
									<option value="不合格" <c:if test="${matPatConclusion_new.conclusion == '不合格' }">selected="selected"</c:if>>不合格</option>
									<option value="其它" <c:if test="${matPatConclusion_new.conclusion == '其它' }">selected="selected"</c:if>>其它</option>
								</select>
								<span id="matPat_conclusion_error" class="req-span"></span>
							</td>
							<td class="value-td1">
								<input id="matPat_remark" name="matPat_remark" value="${matPatConclusion_new.remark }" class="easyui-textbox" style="width:195px" >
							</td>
						</tr>
					</table>
				</div>
				
				
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
				
				<div style="margin-top: 30px;">	
					<table class="info">
						<tr class="single-row">
							<td class="remark-span"><span class="req-span">*</span>试验结论</td>
							<td class="remark-span">备注</td>
						</tr>
						
						<tr>
							<td class="value-td1">
								<select id="matAtl_conclusion" name="matAtl_conclusion" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'" >
									<option value="">请选择</option>
									<option value="合格" <c:if test="${matAtlConclusion_old.conclusion == '合格' }">selected="selected"</c:if>>合格</option>
									<option value="不合格" <c:if test="${matAtlConclusion_old.conclusion == '不合格' }">selected="selected"</c:if>>不合格</option>
									<option value="其它" <c:if test="${matAtlConclusion_old.conclusion == '其它' }">selected="selected"</c:if>>其它</option>
								</select>
								<span id="matAtl_conclusion_error" class="req-span"></span>
							</td>
							<td class="value-td1">
								<input id="matAtl_remark" name="matAtl_remark" value="${matAtlConclusion_old.remark }" class="easyui-textbox" style="width:195px" >
							</td>
						</tr>
					</table>
				</div>
				
				<div style="margin-left: 10px;color:red;margin-top: 20px;">修改后结果：</div>
				
				<div style="margin-top: 5px;">	
					<table class="info">
						<tr class="single-row">
							<td class="remark-span"><span class="req-span">*</span>试验结论</td>
							<td class="remark-span">备注</td>
						</tr>
						
						<tr>
							<td class="value-td1">
								<select id="matAtl_conclusion" name="matAtl_conclusion" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'" >
									<option value="">请选择</option>
									<option value="合格" <c:if test="${matAtlConclusion_new.conclusion == '合格' }">selected="selected"</c:if>>合格</option>
									<option value="不合格" <c:if test="${matAtlConclusion_new.conclusion == '不合格' }">selected="selected"</c:if>>不合格</option>
									<option value="其它" <c:if test="${matAtlConclusion_new.conclusion == '其它' }">selected="selected"</c:if>>其它</option>
								</select>
								<span id="matAtl_conclusion_error" class="req-span"></span>
							</td>
							<td class="value-td1">
								<input id="matAtl_remark" name="matAtl_remark" value="${matAtlConclusion_new.remark }" class="easyui-textbox" style="width:195px" >
							</td>
						</tr>
					</table>
				</div>
				
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
			width:25%;
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
		
		.img-span1{
			width: 100px;
			height: 50px;
			display:inline-block;
			border:0.5px dashed #C9C9C9;
			text-align:center;
			line-height:50px;
		}
		
		.remark-span{
			font-weight: bold;
		}
		
		.table-title{
			padding-left: 5px;
			font-weight: bold;
		}
	</style>
	
	<script type="text/javascript">
		// 是否提交中
		var saving = false;
	
		$(function(){
			var approveType = "${approveType}";
			
			// 正常流程
			if(approveType == 3){
				
				// 零部件图谱试验结果
				if(!isNull("${facadeBean.partsAtlId}")){
					var partsAtlResult = "${facadeBean.partsAtlResult}";
					if(partsAtlResult == 1){
						$("#partsAtl2").show();
					}else if(partsAtlResult == 6){
						$("#partsAtl3").show();
					}else if(partsAtlResult == 0){
						$('#partsAtlId').combotree({
							url: '${ctx}/org/getTreeByType?type=3',
							multiple: false,
							animate: true,
							width: '250px'				
						});
						setupTree("partsAtlId");
						
						$("#partsAtlId").combotree("setValue", "${facadeBean.partsAtl.id}");
					}
				}
				
				// 零部件型式试验结果
				if(!isNull("${facadeBean.partsPatId}")){
					var partsPatResult = "${facadeBean.partsPatResult}";
					if(partsPatResult == 1){
						$("#partsPat2").show();
					}else if(partsPatResult == 6){
						$("#partsPat3").show();
					}else if(partsPatResult == 0){
						$('#partsPatId').combotree({
							url: '${ctx}/org/getTreeByType?type=3',
							multiple: false,
							animate: true,
							width: '250px'				
						});
						setupTree("partsPatId");
						
						$("#partsPatId").combotree("setValue", "${facadeBean.partsPat.id}");
					}
				}
				
				// 原材料图谱试验结果
				if(!isNull("${facadeBean.matAtlId}")){
					var matAtlResult = "${facadeBean.matAtlResult}";
					if(matAtlResult == 1){
						$("#matAtl2").show();
					}else if(matAtlResult == 6){
						$("#matAtl3").show();
					}else if(matAtlResult == 0){
						$('#matAtlId').combotree({
							url: '${ctx}/org/getTreeByType?type=3',
							multiple: false,
							animate: true,
							width: '250px'				
						});
						setupTree("matAtlId");
						
						$("#matAtlId").combotree("setValue", "${facadeBean.matAtl.id}");
					}
				}
				
				// 原材料型式试验结果
				if(!isNull("${facadeBean.matPatId}")){
					var matPatResult = "${facadeBean.matPatResult}";
					if(matPatResult == 1){
						$("#matPat2").show();
					}else if(matPatResult == 6){
						$("#matPat3").show();
					}else if(matPatResult == 0){
						$('#matPatId').combotree({
							url: '${ctx}/org/getTreeByType?type=3',
							multiple: false,
							animate: true,
							width: '250px'				
						});
						setupTree("matPatId");
						
						$("#matPatId").combotree("setValue", "${facadeBean.matPat.id}");
					}
				}
			}
		});
	
		
		function approve(result, remark, catagory){
			if(saving){
				return false;
			}
			saving = true;
			
			var partsAtlId = "";
			var partsPatId = "";
			
			var partsAtlResult = "${facadeBean.partsAtlResult}";
			if(partsAtlResult == 0 && !isNull("${facadeBean.partsAtlId}")){
				partsAtlId = $("#partsAtlId").combotree("getValue");
			}
			
			var partsPatResult = "${facadeBean.partsPatResult}";
			if(partsPatResult == 0 && !isNull("${facadeBean.partsPatId}")){
				partsPatId = $("#partsPatId").combotree("getValue");
			}
				
			var matAtlResult = "${facadeBean.matAtlResult}";
			var matAtlId = "";
			if(matAtlResult == 0 && !isNull("${facadeBean.matAtlId}")){
				matAtlId = $("#matAtlId").combotree("getValue");
			}
			
			var matPatResult = "${facadeBean.matPatResult}";
			var matPatId = "";
			if(matPatResult == 0 && !isNull("${facadeBean.matPatId}")){
				matPatId = $("#matPatId").combotree("getValue");
			}
			
			$.ajax({
				url: "${ctx}/tpt/approve",
				data: {
					"id": "${facadeBean.id}",
					"result": result,
					"remark": remark,
					"catagory": catagory,
					"partsAtlId": partsAtlId,
					"matAtlId": matAtlId,
					"partsPatId": partsPatId,
					"matPatId": matPatId
				},
				success: function(data){
					if(data.success){
						var approveType = "${approveType}";
						saving = false;
						
						closeDialog(data.msg);
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
			
			// 移去滚动条
			window.parent.parent.scrollY(475);
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
		
		
		// 只有最底层才能选择
		function setupTree(id){
			var treeObj = $('#' + id).combotree('tree');	
			treeObj.tree({
			   onBeforeSelect: function(node){
				   if(isNull(node.children)){
						return true;
				   }else{
					   return false;
				   }
			   }
			});
		}
	</script>	
	
</body>

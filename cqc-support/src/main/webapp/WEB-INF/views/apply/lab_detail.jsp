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
		
		<div class="title">抽样原因</div>
		<div style="width: 98%;display:none;" id="reasonDiv">
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
		
		<c:if test="${not empty labReqList}">
			<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
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
									<c:when test="${vo.type eq 1}">零件图谱试验</c:when>
									<c:when test="${vo.type eq 2}">材料图谱试验</c:when>
									<c:when test="${vo.type eq 3}">零件型式试验</c:when>
									<c:when test="${vo.type eq 4}">材料型式试验</c:when>
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
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		<div class="title">试验结果</div>
		<form method="POST" enctype="multipart/form-data" id="uploadForm">
			<c:if test="${(facadeBean.partsPatId == currentAccount.org.id or currentAccount.role.code == superRoleCole)}">
				<c:if test="${facadeBean.type == 4 }">					
					<div class="title" style="margin-top:15px;">零件型式试验结果&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);"  onclick="addResult('p')" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a></div>
					<table class="info" id="p_pfTable">
						<tr class="single-row">
							<td class="remark-span">序号</td>
							<td class="remark-span"><span class="req-span">*</span>试验项目</td>
							<td class="remark-span"><span class="req-span">*</span>参考标准</td>
							<td class="remark-span"><span class="req-span">*</span>试验要求</td>
							<td class="remark-span"><span class="req-span">*</span>试验结果</td>
							<td class="remark-span"><span class="req-span">*</span>结果评价</td>
							<td class="remark-span">备注</td>
							<td class="remark-span">操作</td>
						</tr>
					
						<c:forEach items="${pPfResult}" var="vo" varStatus="status">
							<tr p_num="p_${status.index+ 1}">
								<td style="background: #f5f5f5;padding-left:5px;">${status.index + 1}</td>
								<td class="value-td1">
									<input id="p_project_${status.index+ 1}" name="p_project_${status.index+ 1}" value="${vo.project}" class="easyui-textbox" style="width:170px">
									<span id="p_project_${status.index+ 1}_error" class="req-span"></span>
								</td>
								<td class="value-td1">
									<input id="p_standard_${status.index+ 1}" name="p_standard_${status.index+ 1}" value="${vo.standard }" class="easyui-textbox" style="width:170px">
									<span id="p_standard_${status.index+ 1}_error" class="req-span"></span>
								</td>
								<td class="value-td1">
									<input id="p_require_${status.index+ 1}" name="p_require_${status.index+ 1}"  value="${vo.require }" class="easyui-textbox" style="width:170px">
									<span id="p_require_${status.index+ 1}_error" class="req-span"></span>
								</td>
								<td class="value-td1">
									<input id="p_result_${status.index+ 1}" name="p_result_${status.index+ 1}" value="${vo.result }" class="easyui-textbox" style="width:170px">
									<span id="p_result_${status.index+ 1}_error" class="req-span"></span>
								</td>
								<td class="value-td1">
									<input id="p_evaluate_${status.index+ 1}" name="p_evaluate_${status.index+ 1}" value="${vo.evaluate }" class="easyui-textbox" style="width:170px">
									<span id="p_evaluate_${status.index+ 1}_error" class="req-span"></span>
								</td>
								<td class="value-td1">
									<input id="p_remark_${status.index+ 1}" name="p_remark_${status.index+ 1}" value="${vo.remark }" class="easyui-textbox" style="width:170px">
									<span id="p_remark_${status.index+ 1}_error" class="req-span"></span>
								</td>
								
								<td style="background: #f5f5f5;padding-left:5px;">
									<a href="javascript:void(0);"  onclick="deleteResult('p','p_${status.index+ 1}')"><i class="icon icon-cancel"></i></a>
								</td>
							</tr>
						</c:forEach>
					</table>
					
					<div style="margin-top: 10px;margin-left: 10px;font-weight: bold;">
						试验结果附件： <c:if test="${not empty attach.partsFileName}"><a style="margin-right: 30px;" target="_blank" href="${resUrl}/${attach.partsFileName}">${attach.partsFileName}</a></c:if>
						<input class="easyui-filebox" id="partsResultAttachFile" name="partsResultAttachFile" style="width: 300px;margin-left: 20px;" data-options="buttonText: '选择文件'">
					</div>
					
					<div style="color:red;margin-top: 10px;margin-left: 10px;font-weight: bold;" id="p_pfTable_error"></div>
					
					<div style="margin-top: 20px;">	
						<table class="info">
							<tr class="single-row">
								<td class="remark-span"><span class="req-span">*</span>试验结论</td>
								<td class="remark-span">备注</td>
							</tr>
							
							<tr>
								<td class="value-td1">
									<select id="partsPat_conclusion" name="partsPat_conclusion" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
										<option value="">请选择</option>
										<option value="合格" <c:if test="${partsPatConclusion.conclusion == '合格' }">selected="selected"</c:if>>合格</option>
										<option value="不合格" <c:if test="${partsPatConclusion.conclusion == '不合格' }">selected="selected"</c:if>>不合格</option>
										<option value="其它" <c:if test="${partsPatConclusion.conclusion == '其它' }">selected="selected"</c:if>>其它</option>
										<option value="基准" <c:if test="${partsPatConclusion.conclusion == '基准' }">selected="selected"</c:if>>基准</option>
									</select>
									<span id="partsPat_conclusion_error" class="req-span"></span>
								</td>
								<td class="value-td1">
									<input id="partsPat_remark" name="partsPat_remark" value="${partsPatConclusion.remark }" class="easyui-textbox" style="width:950px">
									<span id="partsPat_remark_error" class="req-span"></span>
								</td>
							</tr>
						</table>
					</div>
				</c:if>
			</c:if>
		
			<c:if test="${(facadeBean.partsAtlId == currentAccount.org.id or currentAccount.role.code == superRoleCole)}">
				<div class="title" style="margin-top:15px;">零件图谱试验结果</div>
				<table class="info" id="p_arTable">
					<tr class="single-row">
						<td class="title-td">图谱类型</td>
						<td class="title-td">图谱描述</td>
						<td class="title-td">选择图谱</td>
					</tr>
				
					<c:if test="${not empty pAtlasResult}">
						<c:forEach items="${pAtlasResult}" var="vo" varStatus="vst">
							<tr>
								<td class="value-td">
									<c:if test="${vo.type == 1}">红外光分析</c:if>
									<c:if test="${vo.type == 2}">差热扫描</c:if>
									<c:if test="${vo.type == 3}">热重分析</c:if>
									<c:if test="${vo.type == 4}">样品照片</c:if>
								</td>
								<td class="value-td">
									<c:choose>
										<c:when test="${vo.type == 1}">
											<input id="p_infLab" name="p_infLab" value="${vo.remark }" class="easyui-textbox" style="width:230px">
										</c:when>
										<c:when test="${vo.type == 2}">
											<input id="p_dtLab" name="p_dtLab" value="${vo.remark }" class="easyui-textbox" style="width:230px">
										</c:when>
										<c:when test="${vo.type == 4}">
											<input id="p_tempLab" name="p_tempLab" value="${vo.remark }" class="easyui-textbox" style="width:230px">
										</c:when>
										<c:otherwise>
											<input id="p_tgLab" name="p_tgLab" value="${vo.remark }" class="easyui-textbox" style="width:230px">
										</c:otherwise>
									</c:choose>
								</td>
								<td class="value-td">
									<c:if test="${not empty vo.pic}">
										<a href="${resUrl}/${vo.pic}" target="_blank"><img src="${resUrl}/${vo.pic}" style="width: 100px;height: 50px;"></a>
									</c:if>
									<c:if test="${empty vo.pic}">
										<span class="img-span">暂无</span>
									</c:if>
									
									<c:choose>
										<c:when test="${vo.type == 1}">
											<input id="p_infLab_pic" name="p_infLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
											<span id="p_inf_error" class="req-span"></span>
										</c:when>
										<c:when test="${vo.type == 2}">
											<input id="p_dtLab_pic" name="p_dtLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
											<span id="p_dt_error" class="req-span"></span>
										</c:when>
										<c:when test="${vo.type == 4}">
											<input id="p_tempLab_pic" name="p_tempLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
											<span id="p_temp_error" class="req-span"></span>
										</c:when>
										<c:otherwise>
											<input id="p_tgLab_pic" name="p_tgLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
											<span id="p_tg_error" class="req-span"></span>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty pAtlasResult}">
						<tr>
							<td class="value-td">样品照片</td>
							<td class="value-td"><input id="p_tempLab" name="p_tempLab" class="easyui-textbox" style="width:230px"></td>
							<td class="value-td">
								<input id="p_tempLab_pic" name="p_tempLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
								<span id="p_temp_error" class="req-span"></span>
							</td>
						</tr>
						<tr>
							<td class="value-td">红外光分析</td>
							<td class="value-td"><input id="p_infLab" name="p_infLab" class="easyui-textbox" style="width:230px"></td>
							<td class="value-td">
								<input id="p_infLab_pic" name="p_infLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
								<span id="p_inf_error" class="req-span"></span>
							</td>
						</tr>
						<tr>
							<td class="value-td">差热扫描</td>
							<td class="value-td"><input id="p_dtLab" name="p_dtLab" class="easyui-textbox" style="width:230px"></td>
							<td class="value-td">
								<input id="p_dtLab_pic" name="p_dtLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
								<span id="p_dt_error" class="req-span"></span>
							</td>
						</tr>
						
						<tr>
							<td class="value-td">热重分析</td>
							<td class="value-td"><input id="p_tgLab" name="p_tgLab" value="${vo.remark }" class="easyui-textbox" style="width:230px"></td>
							<td class="value-td">
								<input id="p_tgLab_pic" name="p_tgLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
								<span id="p_tg_error" class="req-span"></span>
							</td>
						</tr>
					</c:if>
				</table>
				
				<div style="margin-top: 20px;">	
					<table class="info">
						<tr class="single-row">
							<td class="remark-span"><span class="req-span">*</span>试验结论</td>
							<td class="remark-span">备注</td>
						</tr>
						
						<tr>
							<td class="value-td1">
								<select id="partsAtl_conclusion" name="partsAtl_conclusion" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
									<option value="">请选择</option>
									<option value="合格" <c:if test="${partsAtlConclusion.conclusion == '合格' }">selected="selected"</c:if>>合格</option>
									<option value="不合格" <c:if test="${partsAtlConclusion.conclusion == '不合格' }">selected="selected"</c:if>>不合格</option>
									<option value="其它" <c:if test="${partsAtlConclusion.conclusion == '其它' }">selected="selected"</c:if>>其它</option>
									<option value="基准" <c:if test="${partsAtlConclusion.conclusion == '基准' }">selected="selected"</c:if>>基准</option>
								</select>
								<span id="partsAtl_conclusion_error" class="req-span"></span>
							</td>
							<td class="value-td1">
								<input id="partsAtl_remark" name="partsAtl_remark" value="${partsAtlConclusion.remark }" class="easyui-textbox" style="width:950px">
								<span id="partsAtl_remark_error" class="req-span"></span>
							</td>
						</tr>
					</table>
				</div>
				
			</c:if>
		
			<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
			
			<c:if test="${facadeBean.type == 4 }">
				<c:if test="${(facadeBean.matPatId == currentAccount.org.id or currentAccount.role.code == superRoleCole)}">
					<div class="title" style="margin-top:15px;">材料型式试验结果&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);"  onclick="addResult('m')" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a></div>
					<table class="info" id="m_pfTable">
						<tr class="single-row">
							<td class="remark-span">序号</td>
							<td class="remark-span"><span class="req-span">*</span>试验项目</td>
							<td class="remark-span"><span class="req-span">*</span>参考标准</td>
							<td class="remark-span"><span class="req-span">*</span>试验要求</td>
							<td class="remark-span"><span class="req-span">*</span>试验结果</td>
							<td class="remark-span"><span class="req-span">*</span>结果评价</td>
							<td class="remark-span">备注</td>
							<td class="remark-span">操作</td>
						</tr>
							
						<c:forEach items="${mPfResult}" var="vo" varStatus="status">
							<tr m_num="m_${status.index+ 1}">
								<td style="background: #f5f5f5;padding-left:5px;">${status.index + 1}</td>
								<td class="value-td1">
									<input id="m_project_${status.index+ 1}" name="m_project_${status.index + 1}" value="${vo.project}" class="easyui-textbox" style="width:170px">
									<span id="m_project_${status.index}_error" class="req-span"></span>
								</td>
								<td class="value-td1">
									<input id="m_standard_${status.index+ 1}" name="m_standard_${status.index + 1}" value="${vo.standard }" class="easyui-textbox" style="width:170px">
									<span id="m_standard_${status.index}_error" class="req-span"></span>
								</td>
								<td class="value-td1">
									<input id="m_require_${status.index+ 1}" name="m_require_${status.index + 1}" value="${vo.require }" class="easyui-textbox" style="width:170px">
									<span id="m_require_${status.index}_error" class="req-span"></span>
								</td>
								<td class="value-td1">
									<input id="m_result_${status.index+ 1}" name="m_result_${status.index+ 1}"  value="${vo.result }" class="easyui-textbox" style="width:170px">
									<span id="m_result_${status.index+ 1}_error" class="req-span"></span>
								</td>
								<td class="value-td1">
									<input id="m_evaluate_${status.index+ 1}" name="m_evaluate_${status.index+ 1}" value="${vo.evaluate }" class="easyui-textbox" style="width:170px">
									<span id="m_evaluate_${status.index+ 1}_error" class="req-span"></span>
								</td>
								<td class="value-td1">
									<input id="m_remark_${status.index+ 1}" name="m_remark_${status.index+ 1}" value="${vo.remark }" class="easyui-textbox" style="width:170px">
									<span id="m_remark_${status.index+ 1}_error" class="req-span"></span>
								</td>
								
								<td style="background: #f5f5f5;padding-left:5px;">
									<a href="javascript:void(0);"  onclick="deleteResult('m','m_${status.index+ 1}')"><i class="icon icon-cancel"></i></a>
								</td>
							</tr>
						</c:forEach>
					</table>
					
					<div style="margin-top: 10px;margin-left: 10px;font-weight: bold;">
						试验结果附件：<c:if test="${not empty attach.materialFileName}"><a style="margin-right: 30px;" target="_blank" href="${resUrl}/${attach.materialFileName}">${attach.materialFileName}</a></c:if>
						<input class="easyui-filebox" id="materialResultAttachFile" name="materialResultAttachFile" style="width: 300px;" data-options="buttonText: '选择文件'">
					</div>
					
					<div style="color:red;margin-top: 10px;margin-left: 10px;font-weight: bold;" id="m_pfTable_error"></div>
					
					<div style="margin-top: 20px;">	
						<table class="info">
							<tr class="single-row">
								<td class="remark-span"><span class="req-span">*</span>试验结论</td>
								<td class="remark-span">备注</td>
							</tr>
							
							<tr>
								<td class="value-td1">
									<select id="matPat_conclusion" name="matPat_conclusion" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
										<option value="">请选择</option>
										<option value="合格" <c:if test="${matPatConclusion.conclusion == '合格' }">selected="selected"</c:if>>合格</option>
										<option value="不合格" <c:if test="${matPatConclusion.conclusion == '不合格' }">selected="selected"</c:if>>不合格</option>
										<option value="其它" <c:if test="${matPatConclusion.conclusion == '其它' }">selected="selected"</c:if>>其它</option>
										<option value="基准" <c:if test="${matPatConclusion.conclusion == '基准' }">selected="selected"</c:if>>基准</option>
									</select>
									<span id="matPat_conclusion_error" class="req-span"></span>
								</td>
								<td class="value-td1">
									<input id="matPat_remark" name="matPat_remark" value="${matPatConclusion.remark }"  class="easyui-textbox" style="width:950px">
									<span id="matPat_remark_error" class="req-span"></span>
								</td>
							</tr>
						</table>
					</div>
					
				</c:if>
			</c:if>
			
			<c:if test="${(facadeBean.matAtlId == currentAccount.org.id or currentAccount.role.code == superRoleCole)}">
				<div class="title" style="margin-top:15px;">材料图谱试验结果</div>
				<table class="info" id="m_arTable">
					<tr class="single-row">
						<td class="title-td">图谱类型</td>
						<td class="title-td">图谱描述</td>
						<td class="title-td">选择图谱</td>
					</tr>
				
					<c:if test="${not empty mAtlasResult}">
						<c:forEach items="${mAtlasResult}" var="vo" varStatus="vst">
							<tr>
								<td class="value-td">
									<c:if test="${vo.type == 1}">红外光分析</c:if>
									<c:if test="${vo.type == 2}">差热扫描</c:if>
									<c:if test="${vo.type == 3}">热重分析</c:if>
									<c:if test="${vo.type == 4}">样品照片</c:if>
								</td>
								<td class="value-td">
									<c:choose>
										<c:when test="${vo.type == 1 }">
											<input id="m_infLab" name="m_infLab" value="${vo.remark}" class="easyui-textbox" style="width:230px">
										</c:when>
										<c:when test="${vo.type == 2}">
											<input id="m_dtLab" name="m_dtLab" value="${vo.remark}" class="easyui-textbox" style="width:230px">
										</c:when>
										<c:when test="${vo.type == 4}">
											<input id="m_tempLab" name="m_tempLab" value="${vo.remark}" class="easyui-textbox" style="width:230px">
										</c:when>		
										<c:otherwise>
											<input id="m_tgLab" name="m_tgLab" value="${vo.remark}" class="easyui-textbox" style="width:230px">
										</c:otherwise>								
									</c:choose>
								</td>
								<td class="value-td">
									<c:if test="${not empty vo.pic}">
										<a href="${resUrl}/${vo.pic}" target="_blank"><img src="${resUrl}/${vo.pic}" style="width: 100px;height: 50px;"></a>
									</c:if>
									<c:if test="${empty vo.pic}">
										<span class="img-span">暂无</span>
									</c:if>
									
									<c:choose>
										<c:when test="${vo.type == 1 }">
											<input id="m_infLab_pic" name="m_infLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
											<span id="m_inf_error" class="req-span"></span>
										</c:when>
										<c:when test="${vo.type == 2}">
											<input id="m_dtLab_pic" name="m_dtLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
											<span id="m_dt_error" class="req-span"></span>
										</c:when>
										<c:when test="${vo.type == 4}">
											<input id="m_tempLab_pic" name="m_tempLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
											<span id="m_temp_error" class="req-span"></span>
										</c:when>
										<c:otherwise>
											<input id="m_tgLab_pic" name="m_tgLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
											<span id="m_tg_error" class="req-span"></span>
										</c:otherwise>								
									</c:choose>	
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty mAtlasResult }">
						<tr>
							<td class="value-td">样品照片</td>
							<td class="value-td"><input id="m_tempLab" name="m_tempLab" class="easyui-textbox" style="width:230px"></td>
							<td class="value-td">
								<input id="m_tempLab_pic" name="m_tempLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
								<span id="m_temp_error" class="req-span"></span>
							</td>
						</tr>
						
						<tr>
							<td class="value-td">红外光分析</td>
							<td class="value-td"><input id="m_infLab" name="m_infLab" class="easyui-textbox" style="width:230px"></td>
							<td class="value-td">
								<input id="m_infLab_pic" name="m_infLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
								<span id="m_inf_error" class="req-span"></span>
							</td>
						</tr>
						
						<tr>
							<td class="value-td">差热扫描</td>
							<td class="value-td"><input id="m_dtLab" name="m_dtLab" class="easyui-textbox" style="width:230px"></td>
							<td class="value-td">
								<input id="m_dtLab_pic" name="m_dtLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
								<span id="m_dt_error" class="req-span"></span>
							</td>
						</tr>
						
						<tr>
							<td class="value-td">热重分析</td>
							<td class="value-td"><input id="m_tgLab" name="m_tgLab" class="easyui-textbox" style="width:230px"></td>
							<td class="value-td">
								<input id="m_tgLab_pic" name="m_tgLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
								<span id="m_tg_error" class="req-span"></span>
							</td>
						</tr>
					</c:if>
				</table>
				
				<div style="margin-top: 20px;">	
					<table class="info">
						<tr class="single-row">
							<td class="remark-span"><span class="req-span">*</span>试验结论</td>
							<td class="remark-span">备注</td>
						</tr>
						
						<tr>
							<td class="value-td1">
								<select id="matAtl_conclusion" name="matAtl_conclusion" style="width:168px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
									<option value="">请选择</option>
									<option value="合格" <c:if test="${matAtlConclusion.conclusion == '合格' }">selected="selected"</c:if>>合格</option>
									<option value="不合格" <c:if test="${matAtlConclusion.conclusion == '不合格' }">selected="selected"</c:if>>不合格</option>
									<option value="其它" <c:if test="${matAtlConclusion.conclusion == '其它' }">selected="selected"</c:if>>其它</option>
									<option value="基准" <c:if test="${matAtlConclusion.conclusion == '基准' }">selected="selected"</c:if>>基准</option>
								</select>
								<span id="matAtl_conclusion_error" class="req-span"></span>
							</td>
							<td class="value-td1">
								<input id="matAtl_remark" name="matAtl_remark" value="${matAtlConclusion.remark }" class="easyui-textbox" style="width:950px">
								<span id="matAtl_remark_error" class="req-span"></span>
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
						
						<tr>
							<td style="font-weight:bold;">零件</td>
							<td align="center">
								<div style="margin-top:5px;">
									<label><input name="p_temp" type="radio" value="1" <c:if test="${p_temp.state == 1}">checked</c:if>/>一致</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<label><input name="p_temp" type="radio" value="2" <c:if test="${p_temp.state == 2}">checked</c:if>/>不一致 </label> 
								</div>
								<div style="margin-top:5px;">
									<textarea id="p_temp_remark" name="p_temp_remark"  rows="1" cols="25">${p_temp.remark}</textarea>
								</div>
							</td>
							<td align="center">
								<div style="margin-top:5px;">
									<label><input name="p_inf" type="radio" value="1" <c:if test="${p_inf.state == 1}">checked</c:if>/>一致</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<label><input name="p_inf" type="radio" value="2" <c:if test="${p_inf.state == 2}">checked</c:if>/>不一致 </label> 
								</div>
								<div style="margin-top:5px;">
									<textarea id="p_inf_remark" name="p_inf_remark" rows="1" cols="25">${p_inf.remark}</textarea>
								</div>
							</td>
							<td align="center">
								<div style="margin-top:5px;">
									<label><input name="p_dt" type="radio" value="1" <c:if test="${p_dt.state == 1}">checked</c:if>/>一致</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<label><input name="p_dt" type="radio" value="2" <c:if test="${p_dt.state == 2}">checked</c:if>/>不一致 </label> 
								</div>
								<div style="margin-top:5px;">
									<textarea id="p_dt_remark" name="p_dt_remark" rows="1" cols="25">${p_dt.remark}</textarea>
								</div>
							</td>
							<td align="center">
								<div style="margin-top:5px;">
									<label><input name="p_tg" type="radio" value="1" <c:if test="${p_tg.state == 1}">checked</c:if>/>一致</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
									<label><input name="p_tg" type="radio" value="2" <c:if test="${p_tg.state == 2}">checked</c:if>/>不一致 </label> 
								</div>
								<div style="margin-top:5px;">
									<textarea  id="p_tg_remark" name="p_tg_remark"  rows="1" cols="25">${p_tg.remark}</textarea>
								</div>
							</td>
							<td align="center">
								<div style="margin-top:5px;">
									<label><input name="p_result" type="radio" value="1" <c:if test="${p_result.state == 1}">checked</c:if>/>一致</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
									<label><input name="p_result" type="radio" value="2" <c:if test="${p_result.state == 2}">checked</c:if>/>不一致 </label> 
								</div> 
								<div style="margin-top:5px;">
									<textarea id="p_result_remark" name="p_result_remark" rows="1" cols="25">${p_result.remark}</textarea>
								</div>
							</td>
						</tr>
						
						<tr>
							<td style="font-weight:bold;">材料</td>
							<td align="center">
								<div style="margin-top:5px;">
									<label><input name="m_temp" type="radio" value="1" <c:if test="${m_temp.state == 1}">checked</c:if>/>一致</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<label><input name="m_temp" type="radio" value="2" <c:if test="${m_temp.state == 2}">checked</c:if>/>不一致 </label> 
								</div>
								<div style="margin-top:5px;">
									<textarea id="m_temp_remark" name="m_temp_remark" rows="1" cols="25">${m_temp.remark}</textarea>
								</div>
							</td>
							<td align="center">
								<div style="margin-top:10px;">
									<label><input name="m_inf" type="radio" value="1" <c:if test="${m_inf.state == 1}">checked</c:if>/>一致</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
									<label><input name="m_inf" type="radio" value="2" <c:if test="${m_inf.state == 2}">checked</c:if>/>不一致 </label> 
								</div> 
								<div style="margin-top:5px;">
									<textarea id="m_inf_remark" name="m_inf_remark" rows="1" cols="25">${m_inf.remark}</textarea>
								</div>
							</td>
							<td align="center">
								<div style="margin-top:10px;">
									<label><input name="m_dt" type="radio" value="1" <c:if test="${m_dt.state == 1}">checked</c:if>/>一致</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
									<label><input name="m_dt" type="radio" value="2" <c:if test="${m_dt.state == 2}">checked</c:if>/>不一致 </label> 
								</div> 
								<div style="margin-top:5px;">
									<textarea id="m_dt_remark" name="m_dt_remark" rows="1" cols="25">${m_dt.remark}</textarea>
								</div>
							</td>
							<td align="center">
								<div style="margin-top:10px;">
									<label><input name="m_tg" type="radio" value="1" <c:if test="${m_tg.state == 1}">checked</c:if>/>一致</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
									<label><input name="m_tg" type="radio" value="2" <c:if test="${m_tg.state == 2}">checked</c:if>/>不一致 </label> 
								</div> 
								<div style="margin-top:5px;">
									<textarea id="m_tg_remark" name="m_tg_remark" rows="1" cols="25">${m_tg.remark}</textarea>
								</div>
							</td>
							<td align="center">
								<div style="margin-top:10px;">
									<label><input name="m_result" type="radio" value="1" <c:if test="${m_result.state == 1}">checked</c:if>/>一致</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
									<label><input name="m_result" type="radio" value="2" <c:if test="${m_result.state == 2}">checked</c:if>/>不一致 </label> 
								</div> 
								<div style="margin-top:5px;">
									<textarea id="m_result_remark" name="m_result_remark" rows="1" cols="25">${m_result.remark}</textarea>
								</div>
							</td>
						</tr>
					
					
					</table>
				</div>
			</c:if>
					
			<div style="margin-top:10px;font-weight:bold;color:red;" align="center" id="atlasError"></div>
			<div align="center" style="margin-top:10px;margin-bottom: 20px;">
				<a href="javascript:void(0);"  onclick="doSubmit()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">提交</a>
				<a href="javascript:void(0);"  onclick="doCancel()" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
			</div>
		</form>
	</div>
			
	
	<script type="text/javascript">
		// 是否提交中
		var saving = false;
		
		// 结果保存
		function doSubmit(type){
			if(saving){
				return false;
			}
			saving = true;
			
			// 零件图谱结论
			var partsAtl_result = [];
			// 材料图谱结论
			var matAtl_result = [];
			// 零件型式结论
			var partsPat_result = [];
			// 材料型式结论
			var matPat_result = [];
			// 试验结论结果
			var conclusionDataArray = [];
			
			var p_arTable =  $("#p_arTable").length;
			var m_arTable = $("#m_arTable").length;
			
			var pAtlasResult = "${pAtlasResult}";
			var mAtlasResult = "${mAtlasResult}";
			
			// 零件结果
			if(p_arTable > 0){
				// 样品照片
				var p_tempLabDir = $("#p_tempLab_pic").filebox("getValue");
				if (!isNull(p_tempLabDir)) {
					var suffix = p_tempLabDir.substr(p_tempLabDir.lastIndexOf("."));
					if (".jpg" != suffix && ".png" != suffix && ".jpeg" != suffix && ".gif" != suffix) {
						$("#p_temp_error").html("图片格式");
						$("#p_tempLab_pic").focus();
						saving = false;
						return false;
					}
				}else{
					if(isNull(pAtlasResult)){
						$("#p_temp_error").html("请选择图片");
						saving = false;
						return false;
					}
				}
				$("#p_temp_error").html("");
				
				
				// 热重分析图谱
				var p_tgLabDir = $("#p_tgLab_pic").filebox("getValue");
				if (!isNull(p_tgLabDir)) {
					var suffix = p_tgLabDir.substr(p_tgLabDir.lastIndexOf("."));
					if (".jpg" != suffix && ".png" != suffix && ".jpeg" != suffix && ".gif" != suffix) {
						$("#p_tg_error").html("图片格式");
						$("#p_tgLab_pic").focus();
						saving = false;
						return false;
					}
				}else{
					if(isNull(pAtlasResult)){
						$("#p_tg_error").html("请选择图片");
						saving = false;
						return false;
					}
				}
				$("#p_tg_error").html("");
				
				// 红外光分析图谱
				var p_infLabDir = $("#p_infLab_pic").filebox("getValue");
				if (!isNull(p_infLabDir)) {
					var suffix = p_infLabDir.substr(p_infLabDir.lastIndexOf("."));
					if (".jpg" != suffix && ".png" != suffix && ".jpeg" != suffix && ".gif" != suffix) {
						$("#p_inf_error").html("图片格式");
						$("#p_infLab_pic").focus();
						saving = false;
						return false;
					}
				}else{
					if(isNull(pAtlasResult)){
						$("#p_inf_error").html("请选择图片");
						saving = false;
						return false;
					}
				}
				$("#p_inf_error").html("");
				
				// 差热扫描图谱
				var p_dtLabDir = $("#p_dtLab_pic").filebox("getValue");
				if (!isNull(p_dtLabDir)) {
					var suffix = p_dtLabDir.substr(p_dtLabDir.lastIndexOf("."));
					if (".jpg" != suffix && ".png" != suffix && ".jpeg" != suffix && ".gif" != suffix) {
						$("#p_dt_error").html("图片格式");
						$("#p_dtLab_pic").focus();
						saving = false;
						return false;
					}
				}else{
					if(isNull(pAtlasResult)){
						$("#p_dt_error").html("请选择图片");
						saving = false;
						return false;
					}
				}
				$("#p_dt_error").html("");
				
				// 结论结果
				partsAtl_result = assembleConclusion("partsAtl");
				if(partsAtl_result == false){
					saving = false;
					return false;
				}
			}
			
			// 材料结果
			if(m_arTable > 0){
				// 样品照片
				var m_tempLabDir = $("#m_tempLab_pic").filebox("getValue");
				if (!isNull(m_tempLabDir)) {
					var suffix = m_tempLabDir.substr(m_tempLabDir.lastIndexOf("."));
					if (".jpg" != suffix && ".png" != suffix && ".jpeg" != suffix && ".gif" != suffix) {
						$("#m_temp_error").html("图片格式");
						$("#m_tempLab_pic").focus();
						saving = false;
						return false;
					}
				}else{
					if(isNull(mAtlasResult)){
						$("#m_temp_error").html("请选择图片");
						saving = false;
						return false;
					}
				}
				$("#m_temp_error").html("");
				
				// 热重分析图谱
				var m_tgLabDir = $("#m_tgLab_pic").filebox("getValue");
				if (!isNull(m_tgLabDir)) {
					var suffix = m_tgLabDir.substr(m_tgLabDir.lastIndexOf("."));
					if (".jpg" != suffix && ".png" != suffix && ".jpeg" != suffix && ".gif" != suffix) {
						$("#m_tg_error").html("图片格式");
						$("#m_tgLab_pic").focus();
						saving = false;
						return false;
					}
				}else{
					if(isNull(mAtlasResult)){
						$("#m_tg_error").html("请选择图片");
						saving = false;
						return false;
					}
				}
				$("#m_tg_error").html("");

				// 红外光分析图谱
				var m_infLabDir = $("#m_infLab_pic").filebox("getValue");
				if (!isNull(m_infLabDir)) {
					var suffix = m_infLabDir.substr(m_infLabDir.lastIndexOf("."));
					if (".jpg" != suffix && ".png" != suffix && ".jpeg" != suffix && ".gif" != suffix) {
						$("#m_inf_error").html("图片格式");
						$("#m_infLab_pic").focus();
						saving = false;
						return false;
					}
				}else{
					if(isNull(mAtlasResult)){
						$("#m_inf_error").html("请选择图片");
						saving = false;
						return false;
					}
				}
				$("#m_inf_error").html("");

				// 差热扫描图谱
				var m_dtLabDir = $("#m_dtLab_pic").filebox("getValue");
				if (!isNull(m_dtLabDir)) {
					var suffix = m_dtLabDir.substr(m_dtLabDir.lastIndexOf("."));
					if (".jpg" != suffix && ".png" != suffix && ".jpeg" != suffix && ".gif" != suffix) {
						$("#m_dt_error").html("图片格式");
						$("#m_dtLab_pic").focus();
						saving = false;
						return false;
					}
				}else{
					if(isNull(mAtlasResult)){
						$("#m_dt_error").html("请选择图片");
						saving = false;
						return false;
					}
				}
				$("#m_dt_error").html("");
				
				// 结论结果
				matAtl_result = assembleConclusion("matAtl");
				if(matAtl_result == false){
					saving = false;
					return false;
				}
			}
			
			var dataArray = [];
			var date = new Date();
			var flag = true;
			var p_result = [];
			var m_result = [];
			
			var p_pfTable =  $("#p_pfTable").length;
			var m_pfTable = $("#m_pfTable").length;
			
			// 零件试验结果
			if(p_pfTable > 0){
				// 附件
				var partsResultAttachFile = $("#partsResultAttachFile").filebox("getValue");
				
				if($("tr[p_num]").length < 1 && isNull(partsResultAttachFile)){
					$("#p_pfTable_error").html("请添加零件型试结果");
					saving = false;
					return false;
				}
				$("#p_pfTable_error").html("");
				
				// 试验结果
				p_result = assemble("p", date);
				if(p_result == false){
					saving = false;
					return false;
				}
				
				// 结论结果
				partsPat_result = assembleConclusion("partsPat");
				if(partsPat_result == false){
					saving = false;
					return false;
				}
			}
			
			// 材料试验结果
			if(m_pfTable > 0){
				// 附件
				var materialResultAttachFile = $("#materialResultAttachFile").filebox("getValue");
				
				if($("tr[m_num]").length < 1){
					$("#m_pfTable_error").html("请添加材料型试结果");
					saving = false;
					return false;
				}else{
					$("#m_pfTable_error").html("");
				}
				
				// 试验结果
				m_result = assemble("m", date);
				if(m_result == false){
					saving = false;
					return false;
				}
				
				// 结论结果
				matPat_result = assembleConclusion("matPat");
				if(matPat_result == false){
					saving = false;
					return false;
				}
			}
			dataArray = p_result.concat(m_result);
			
			// 试验结论
			conclusionDataArray.push.apply(conclusionDataArray, partsAtl_result);
			conclusionDataArray.push.apply(conclusionDataArray, matAtl_result);
			conclusionDataArray.push.apply(conclusionDataArray, partsPat_result);
			conclusionDataArray.push.apply(conclusionDataArray, matPat_result);
			
			$('#uploadForm').ajaxSubmit({
				url: "${ctx}/apply/labInfoSave",
				dataType : 'text',
				type: 'post',
				data: {
					"taskId": '${facadeBean.id}',
					"result": JSON.stringify(dataArray),
					"conclusionResult":  JSON.stringify(conclusionDataArray)
				},
				success:function(msg){
					saving = false;
					var data = eval('(' + msg + ')');
					if(data.success){
						closeDialog(data.msg, "labDetailDialog");
					}else{
						$("#atlasError").html(data.msg);
					}
				}
			});
		}

		function doCancel(){
			$("#labDetailDialog").dialog("close");
		}
		
		
		/**
		 *  添加试验结果
		 *  @param type 种类: m-材料， p-零件
		 */
		function addResult(type){
			var num;
			for(var i = 1; i >= 1 ; i++){
				var len = $("tr["+ type + "_num="+ type + "_" + i + "]").length;
				if(len < 1){
					num = i;
					break;
				}
			}
			
			var str = "<tr "+ type +"_num='"+ type + "_" + num +"'>"
					+	 "<td style='background: #f5f5f5;padding-left:5px;'>"+ num + "</td>"
					+	 "<td class='value-td1'>"
					+		"<input id='"+ type + "_project_"+ num +"' name='"+ type + "_project_"+ num +"' class='easyui-textbox' style='width:170px'>"
					+		"<span id='"+ type + "_project_"+ num + "_error' class='req-span'></span>"
					+	 "</td>"
					+	 "<td class='value-td1'>"
					+	    "<input id='"+ type + "_standard_"+ num +"' name='"+ type + "_standard_"+ num +"' class='easyui-textbox' style='width:170px'>"
					+	    "<span id='"+ type + "_standard_"+ num +"_error' class='req-span'></span>"
					+	 "</td>"
					+	 "<td class='value-td1'>"
					+	    "<input id='"+ type + "_require_"+ num +"' name='"+ type + "_require_"+ num +"' class='easyui-textbox' style='width:170px'>"
					+	    "<span id='"+ type + "_require_"+ num +"_error' class='req-span'></span>"
					+	 "</td>"
					+	 "<td class='value-td1'>"
					+	    "<input id='"+ type + "_result_"+ num +"' name='"+ type + "_result_"+ num +"' class='easyui-textbox' style='width:170px'>"
					+	    "<span id='"+ type + "_result_"+ num +"_error' class='req-span'></span>"
					+	 "</td>"
					+	 "<td class='value-td1'>"
					+	    "<input id='"+ type + "_evaluate_"+ num +"' name='"+ type + "_evaluate_"+ num +"' class='easyui-textbox' style='width:170px'>"
					+	    "<span id='"+ type + "_evaluate_"+ num +"_error' class='req-span'></span>"
					+	 "</td>"
					+	 "<td class='value-td1'>"
					+	    "<input id='"+ type + "_remark_"+ num +"' name='"+ type + "_remark_"+ num +"' class='easyui-textbox' style='width:170px'>"
					+	    "<span id='"+ type + "_remark_"+ num +"_error' class='req-span'></span>"
					+	 "</td>"
					+	 "<td style='background: #f5f5f5;padding-left:5px;'>"
					+	    "<a href='javascript:void(0);'  onclick=\"deleteResult(\'"+ type + "\','"+ type +"_"+ num +"')\"><i class='icon icon-cancel'></i></a>"
					+	 "</td>"
					+"</tr>";
			
			$("#"+ type + "_pfTable").append(str);
			
			// 渲染输入框
			$.parser.parse($("#"+ type + "_project_"+ num).parent());
			$.parser.parse($("#"+ type + "_standard_"+ num).parent());
			$.parser.parse($("#"+ type + "_require_"+ num).parent());
			$.parser.parse($("#"+ type + "_result_"+ num).parent());
			$.parser.parse($("#"+ type + "_evaluate_"+ num).parent());
			$.parser.parse($("#"+ type + "_remark_"+ num).parent());
		}
		
		function deleteResult(type, num){
			$("tr["+ type +"_num='"+ num +"']").remove();
		}

		
		// 组装数据
		function assemble(type, date){
			var dataArray = [];
			var flag = true;
			
			$("tr[" + type + "_num]").each(function(){
				var num = $(this).attr(type + "_num");
				var array = num.split("_");
				num = array[1];
				
				// 实验项目
				var project = $("#"+ type +"_project_" + num).textbox("getValue");
				if(isNull(project)){
					$("#"+ type +"_project_"+ num +"_error").html("必填");
					flag = false;
					return false;
				}else{
					$("#"+ type +"_project_"+ num +"_error").html("");
				}
				
				//参考标准
				var standard = $("#"+ type +"_standard_" + num).textbox("getValue");
				if(isNull(standard)){
					$("#"+ type +"_standard_"+ num +"_error").html("必填");
					flag = false;
					return false;
				}else{
					$("#"+ type +"_standard_"+ num +"_error").html("");
				}
				
				// 试验要求
				var require = $("#"+ type +"_require_" + num).textbox("getValue");
				if(isNull(require)){
					$("#"+ type +"_require_"+ num +"_error").html("必填");
					flag = false;
					return false;
				}else{
					$("#"+ type +"_require_"+ num +"_error").html("");
				}
				
				// 试验结果
				var result = $("#"+ type +"_result_" + num).textbox("getValue");
				if(isNull(result)){
					$("#"+ type +"_result_"+ num +"_error").html("必填");
					flag = false;
					return false;
				}else{
					$("#"+ type +"_result_"+ num +"_error").html("");
				}
				
				// 结果评价
				var evaluate = $("#"+ type +"_evaluate_" + num).textbox("getValue");
				if(isNull(evaluate)){
					$("#"+ type +"_evaluate_"+ num +"_error").html("必填");
					flag = false;
					return false;
				}else{
					$("#"+ type +"_evaluate_"+ num +"_error").html("");
				}
				
				var remark = $("#"+ type +"_remark_" + num).textbox("getValue");
				
				var obj = new Object();
				obj.project = project;
				obj.standard = standard;
				obj.require = require;
				obj.result = result;
				obj.evaluate = evaluate;
				obj.remark = remark;
				obj.tId = '${facadeBean.id}';
				obj.createTime = date;
				obj.catagory = type == "p"? 1: 2;
				obj.expNo = type == "p"? "${pNum}": "${mNum}";
				dataArray.push(obj);
			});
			
			if(flag == false){
				return false;
			}else{
				return dataArray;
			}
		}
		
		function expand(){
			$("#vehicleDiv").toggle();
			$("#partsDiv").toggle();
			$("#materialDiv").toggle();
			$("#showBtn").toggle();
			$("#hideBtn").toggle();
			$("#taskInfoDiv").toggle();
			$("#applicatDiv").toggle();
			$("#reasonDiv").toggle();
		}
		
		// 实验结论-组装数据
		function assembleConclusion(type){
			var dataArray = [];
			
			// 试验结论
			var conclusion = $("#"+ type +"_conclusion").combobox("getValue");
			if(isNull(conclusion)){
				$("#"+ type +"_conclusion_error").html("必填");
				return false;
			}else{
				$("#"+ type +"_conclusion_error").html("");
			}
			
			// 备注
			var remark = $("#"+ type +"_remark").textbox("getValue");
			
			var obj = new Object();
			obj.conclusion = conclusion;
			obj.remark = remark;
			obj.taskId = "${facadeBean.id}";
			if(type == "partsAtl"){
				obj.type = 1;
			}else if(type == "matAtl"){
				obj.type = 2;
			}else if(type == "partsPat"){
				obj.type = 3;
			}else{
				obj.type = 4;
			}
			dataArray.push(obj);
			return dataArray;
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
		
		.img-span{
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
		
	</style>
	
</body>

<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<div style="margin-left: 20px; margin-top: 10px;">
		<a id="showBtn" href="javascript:void(0);" onclick="expand()" style="color:red;">展开</a>
		<a id="hideBtn" href="javascript:void(0);" onclick="expand()" style="display: none; color: red;">收起</a>
	</div>
	
	<div style="margin-left: 10px;margin-top:10px;">
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
		<div style="width: 98%;display:none" id="materialDiv">
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
		
		<div class="title">试验结果 
			<c:if test="${type == 1}">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0);"  onclick="importResult()" class="easyui-linkbutton" data-options="iconCls:'icon-import'">导入结果</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0);"  onclick="exportResult()" class="easyui-linkbutton" data-options="iconCls:'icon-export'">导出结果</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0);"  onclick="exportTemplate()" class="easyui-linkbutton" data-options="iconCls:'icon-large-smartart'">下载模板</a>
			</c:if>
		</div>
		
		<c:choose>
			<c:when test="${type == 1}">
				<form method="POST" enctype="multipart/form-data" id="patResultForm">
					<input type="hidden" id="taskId" name="taskId" value="${facadeBean.id}">
				
					<!-- 零件型式试验结果-start  -->
					<c:if test="${(facadeBean.partsPatId == currentAccount.org.id or currentAccount.role.code == superRoleCole) and (facadeBean.partsPatResult == 1)  }">
						<div class="title" style="margin-top:15px;">
							零件型式试验结果&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);"  onclick="addResult('p')" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
						</div>
						<div style="margin-left:10px;margin-bottom: 10px;">
							<c:forEach items="${labReqList}" var="vo">
								<c:if test="${vo.type eq 3}">
									<span class="remark-span">试验编号：</span> ${facadeBean.partsPatCode}<span class="remark-span" style="margin-left: 20px;">任务号：</span> ${vo.code}<span class="remark-span" style="margin-left: 20px;">商定完成时间：</span><fmt:formatDate value='${vo.time}' type="date" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;<span class="remark-span" style="margin-left: 20px;">试验要求</span>：${vo.remark }
								</c:if>
							</c:forEach>
						</div>
						
						<div>
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
								
								<c:forEach var="i" begin="1" end="1" varStatus="status">
									<tr p_num="p_${status.index}">
										<td style="background: #f5f5f5;padding-left:5px;">${status.index}</td>
										<td class="value-td1">
											<input id="p_project_${status.index}" name="p_project_${status.index}" class="easyui-textbox" style="width:170px">
											<span id="p_project_${status.index}_error" class="req-span"></span>
										</td>
										<td class="value-td1">
											<input id="p_standard_${status.index}" name="p_standard_${status.index}" class="easyui-textbox" style="width:170px">
											<span id="p_standard_${status.index}_error" class="req-span"></span>
										</td>
										<td class="value-td1">
											<input id="p_require_${status.index}" name="p_require_${status.index}" class="easyui-textbox" style="width:170px">
											<span id="p_require_${status.index}_error" class="req-span"></span>
										</td>
										
										<td class="value-td1">
											<input id="p_result_${status.index}" name="p_result_${status.index}" class="easyui-textbox" style="width:170px">
											<span id="p_result_${status.index}_error" class="req-span"></span>
										</td>
										
										<td class="value-td1">
											<input id="p_evaluate_${status.index}" name="p_evaluate_${status.index}" class="easyui-textbox" style="width:170px">
											<span id="p_evaluate_${status.index}_error" class="req-span"></span>
										</td>
										
										<td class="value-td1">
											<input id="p_remark_${status.index}" name="p_remark_${status.index}" class="easyui-textbox" style="width:170px">
											<span id="p_remark_${status.index}_error" class="req-span"></span>
										</td>
										
										<td style="background: #f5f5f5;padding-left:5px;">
											<a href="javascript:void(0);"  onclick="deleteResult('p','p_${status.index}')"><i class="icon icon-cancel"></i></a>
										</td>
									</tr>
								</c:forEach>
							</table>
						</div>
						
						<div style="margin-top: 10px;margin-left: 10px;font-weight: bold;">
							试验结果附件：<input class="easyui-filebox" id="partsResultAttachFile" name="partsResultAttachFile" style="width: 300px" data-options="buttonText: '选择文件'">
						</div>
						
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
											<option value="合格">合格</option>
											<option value="不合格">不合格</option>
											<option value="其它">其它</option>
											<option value="基准">基准</option>
										</select>
										<span id="partsPat_conclusion_error" class="req-span"></span>
									</td>
									
									<td class="value-td1">
										<input id="partsPat_remark" name="partsPat_remark" class="easyui-textbox" style="width:950px">
										<span id="partsPat_remark_error" class="req-span"></span>
									</td>
								</tr>
							</table>
						</div>
					</c:if>
					<!-- 零件型式试验结果-end -->
					
					<!-- 材料型式试验结果-start  -->
					<c:if test="${(facadeBean.matPatId == currentAccount.org.id or currentAccount.role.code == superRoleCole) and (facadeBean.matPatResult == 1) }">
						<div class="title" style="margin-top:15px;">
							材料型式试验结果&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);"  onclick="addResult('m')" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
						</div>
						<div style="margin-left:10px;margin-bottom: 10px;">
							<c:forEach items="${labReqList}" var="vo">
								<c:if test="${vo.type eq 4}">
									<span class="remark-span">试验编号：</span> ${facadeBean.matPatCode}<span class="remark-span" style="margin-left: 20px;">任务号：</span> ${vo.code}<span class="remark-span" style="margin-left: 20px;">商定完成时间：</span><fmt:formatDate value='${vo.time}' type="date" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;<span class="remark-span" style="margin-left: 20px;">试验要求</span>：${vo.remark }
								</c:if>
							</c:forEach>
						</div>
						<div>
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
								
								<c:forEach var="i" begin="1" end="1" varStatus="status">
									<tr m_num="m_${status.index}">
										<td style="background: #f5f5f5;padding-left:5px;">${status.index}</td>
										<td class="value-td1">
											<input id="m_project_${status.index}" name="m_project_${status.index}" class="easyui-textbox" style="width:170px">
											<span id="m_project_${status.index}_error" class="req-span"></span>
										</td>
										<td class="value-td1">
											<input id="m_standard_${status.index}" name="m_standard_${status.index}" class="easyui-textbox" style="width:170px">
											<span id="m_standard_${status.index}_error" class="req-span"></span>
										</td>
										<td class="value-td1">
											<input id="m_require_${status.index}" name="m_require_${status.index}" class="easyui-textbox" style="width:170px">
											<span id="m_require_${status.index}_error" class="req-span"></span>
										</td>
										<td class="value-td1">
											<input id="m_result_${status.index}" name="m_result_${status.index}" class="easyui-textbox" style="width:170px">
											<span id="m_result_${status.index}_error" class="req-span"></span>
										</td>
										<td class="value-td1">
											<input id="m_evaluate_${status.index}" name="m_evaluate_${status.index}" class="easyui-textbox" style="width:170px">
											<span id="m_evaluate_${status.index}_error" class="req-span"></span>
										</td>
										<td class="value-td1">
											<input id="m_remark_${status.index}" name="m_remark_${status.index}" class="easyui-textbox" style="width:170px">
											<span id="m_remark_${status.index}_error" class="req-span"></span>
										</td>
										
										<td style="background: #f5f5f5;padding-left:5px;">
											<a href="javascript:void(0);"  onclick="deleteResult('m','m_${status.index}')"><i class="icon icon-cancel"></i></a>
										</td>
									</tr>
								</c:forEach>
							</table>
						</div>
						
						<div style="margin-top: 10px;margin-left: 10px;font-weight: bold;">
							试验结果附件：<input class="easyui-filebox" id="materialResultAttachFile" name="materialResultAttachFile" style="width: 300px" data-options="buttonText: '选择文件'">
						</div>
						
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
											<option value="合格">合格</option>
											<option value="不合格">不合格</option>
											<option value="其它">其它</option>
											<option value="基准">基准</option>
										</select>
										<span id="matPat_conclusion_error" class="req-span"></span>
									</td>
									<td class="value-td1">
										<input id="matPat_remark" name="matPat_remark" class="easyui-textbox" style="width:950px">
										<span id="matPat_remark_error" class="req-span"></span>
									</td>
								</tr>
							</table>
						</div>
					</c:if>
					<!-- 材料型式试验结果-end  -->
				</form>
				
				<!-- Excel 导入 -->
				<div id="excelDialog" class="easyui-dialog" title="结果导入" style="width: 300px; height: 200px; padding: 10px;top:700px;" data-options="modal: true" closed="true">
					<form method="POST" enctype="multipart/form-data" id="resultUploadForm">
						<div>
							请选择要导入的文件（<span style="color: red;">只支持 Excel</span>）：
						</div>
						
						<div style="margin-top: 10px;">
							<input class="easyui-filebox" id="upfile" name="upfile" style="width: 90%" data-options="buttonText: '选择文件'">
							<p id="fileInfo" style="color:red;margin-top:5px;"></p>
						</div>
						
						<div style="margin-top: 15px;">
							<a href="javascript:void(0);" class="easyui-linkbutton" style="width: 90%" onclick="importExcel()">上传</a>
						</div>
						
						<div id="result" style="margin-top:5px;"></div>
					</form>
				</div>
				
				<div style="margin-top:10px;font-weight:bold;color:red;" align="center" id="patternError"></div>
				<div align="center" style="margin-top:10px;margin-bottom:15px;">
					<a href="javascript:void(0);"  onclick="upload()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">上传</a>
					<a href="javascript:void(0);"  onclick="doCancel()" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
				</div>
			</c:when>
			<c:otherwise>
				<form method="POST" enctype="multipart/form-data" id="uploadForm">
					<input type="hidden" id="taskId" name="taskId" value="${facadeBean.id}">
					
					<!-- 零件图谱试验结果-start -->
					<c:if test="${(facadeBean.partsAtlId == currentAccount.org.id or currentAccount.role.code == superRoleCole) and (facadeBean.partsAtlResult == 1) }">
						<div class="title" style="margin-top:15px;">零件图谱试验结果</div>
						<div style="margin-left:10px;margin-bottom: 10px;">
							<c:forEach items="${labReqList}" var="vo">
								<c:if test="${vo.type eq 1}">
									<span class="remark-span">试验编号：</span> ${facadeBean.partsAtlCode}<span class="remark-span" style="margin-left: 20px;">任务号：</span> ${vo.code}<span class="remark-span" style="margin-left: 20px;">商定完成时间：</span><fmt:formatDate value='${vo.time}' type="date" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;<span class="remark-span" style="margin-left: 20px;">试验要求</span>：${vo.remark }
								</c:if>
							</c:forEach>
						</div>
						<div>
							<table class="info" id="p_arTable">
								<tr class="single-row">
									<td class="title-td">图谱类型</td>
									<td class="title-td">图谱描述</td>
									<td class="title-td">选择图谱</td>
								</tr>
								
								<tr>
									<td class="value-td">样品照片</td>
									<td class="value-td"><input id="p_tempLab" name="p_tempLab" class="easyui-textbox" style="width:230px"></td>
									<td class="value-td">
										<span class="req-span">*</span>
										<input id="p_tempLab_pic" name="p_tempLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
										<span id="p_temp_error" class="req-span"></span>
									</td>
								</tr>
								
								<tr>
									<td class="value-td">红外光分析</td>
									<td class="value-td"><input id="p_infLab" name="p_infLab" class="easyui-textbox" style="width:230px"></td>
									<td class="value-td">
										<span class="req-span">*</span>
										<input id="p_infLab_pic" name="p_infLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
										<span id="p_inf_error" class="req-span"></span>
									</td>
								</tr>
								
								<tr>
									<td class="value-td">差热扫描</td>
									<td class="value-td"><input id="p_dtLab" name="p_dtLab" class="easyui-textbox" style="width:230px"></td>
									<td class="value-td">
										<span class="req-span">*</span>
										<input id="p_dtLab_pic" name="p_dtLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
										<span id="p_dt_error" class="req-span"></span>
									</td>
								</tr>
								
								<tr>
									<td class="value-td">热重分析</td>
									<td class="value-td"><input id="p_tgLab" name="p_tgLab" class="easyui-textbox" style="width:230px"></td>
									<td class="value-td">
										<span class="req-span">*</span>
										<input id="p_tgLab_pic" name="p_tgLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
										<span id="p_tg_error" class="req-span"></span>
									</td>
								</tr>
							</table>
						</div>
						
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
											<option value="合格">合格</option>
											<option value="不合格">不合格</option>
											<option value="其它">其它</option>
											<option value="基准">基准</option>
										</select>
										<span id="partsAtl_conclusion_error" class="req-span"></span>
									</td>
									
									<td class="value-td1">
										<input id="partsAtl_remark" name="partsAtl_remark" class="easyui-textbox" style="width:950px">
										<span id="partsAtl_remark_error" class="req-span"></span>
									</td>
								</tr>
							</table>
						</div>
						
					</c:if>
					<!-- 零件图谱试验结果-end -->
					
					<!-- 材料图谱试验结果-start -->
					<c:if test="${(facadeBean.matAtlId == currentAccount.org.id or currentAccount.role.code == superRoleCole) and (facadeBean.matAtlResult == 1) }">
						<div class="title" style="margin-top:15px;">材料图谱试验结果</div>
						<div style="margin-left:10px;margin-bottom: 10px;">
							<c:forEach items="${labReqList}" var="vo">
								<c:if test="${vo.type eq 2}">
									<span class="remark-span">试验编号：</span> ${facadeBean.matAtlCode}<span class="remark-span" style="margin-left: 20px;">任务号：</span> ${vo.code}<span class="remark-span" style="margin-left: 20px;">商定完成时间：</span><fmt:formatDate value='${vo.time}' type="date" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;<span class="remark-span" style="margin-left: 20px;">试验要求</span>：${vo.remark }
								</c:if>
							</c:forEach>
						</div>
						<div>
							<table class="info" id="m_arTable">
								<tr class="single-row">
									<td class="title-td">图谱类型</td>
									<td class="title-td">图谱描述</td>
									<td class="title-td">选择图谱</td>
								</tr>
								
								<tr>
									<td class="value-td">样品照片</td>
									<td class="value-td"><input id="m_tempLab" name="m_tempLab" class="easyui-textbox" style="width:230px"></td>
									<td class="value-td">
										<span class="req-span">*</span>
										<input id="m_tempLab_pic" name="m_tempLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
										<span id="m_temp_error" class="req-span"></span>
									</td>
								</tr>
								
								<tr>
									<td class="value-td">红外光分析</td>
									<td class="value-td"><input id="m_infLab" name="m_infLab" class="easyui-textbox" style="width:230px"></td>
									<td class="value-td">
										<span class="req-span">*</span>
										<input id="m_infLab_pic" name="m_infLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
										<span id="m_inf_error" class="req-span"></span>
									</td>
								</tr>
								
								<tr>
									<td class="value-td">差热扫描</td>
									<td class="value-td"><input id="m_dtLab" name="m_dtLab" class="easyui-textbox" style="width:230px"></td>
									<td class="value-td">
										<span class="req-span">*</span>
										<input id="m_dtLab_pic" name="m_dtLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
										<span id="m_dt_error" class="req-span"></span>
									</td>
								</tr>
								
								<tr>
									<td class="value-td">热重分析</td>
									<td class="value-td"><input id="m_tgLab" name="m_tgLab" class="easyui-textbox" style="width:230px"></td>
									<td class="value-td">
										<span class="req-span">*</span>
										<input id="m_tgLab_pic" name="m_tgLab_pic" class="easyui-filebox" style="width:200px" data-options="buttonText: '选择'">
										<span id="m_tg_error" class="req-span"></span>
									</td>
								</tr>
							</table>
						</div>
						
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
											<option value="合格">合格</option>
											<option value="不合格">不合格</option>
											<option value="其它">其它</option>
											<option value="基准">基准</option>
										</select>
										<span id="matAtl_conclusion_error" class="req-span"></span>
									</td>
									<td class="value-td1">
										<input id="matAtl_remark" name="matAtl_remark" class="easyui-textbox" style="width:950px">
										<span id="matAtl_remark_error" class="req-span"></span>
									</td>
								</tr>
							</table>
						</div>
					</c:if>
					<!-- 材料图谱试验结果-end -->
				
					<div style="margin-top:10px;font-weight:bold;color:red;" align="center" id="atlasError"></div>
					<div align="center" style="margin-top:10px;">
						<a href="javascript:void(0);"  onclick="doSubmit()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">上传</a>
						<a href="javascript:void(0);"  onclick="doCancel()" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
					</div>
				</form>
					
			</c:otherwise>
		</c:choose>
	</div>
	
	<script type="text/javascript">
		// 是否提交中
		var saving = false;
	
		// 图谱结果保存
		function doSubmit(){
			if(saving){
				return false;
			}
			saving = true;
			
			var m_arTable = $("#m_arTable").length;
			// 零件图谱结论
			var partsAtl_result = [];
			// 材料图谱结论
			var matAtl_result = [];
			// 试验结论结果
			var conclusionDataArray = [];
			
			var p_arTable =  $("#p_arTable").length;
			
			// 零件结果
			if(p_arTable > 0){
				// 样品图谱
				var p_tempLabDir = $("#p_tempLab_pic").filebox("getValue");
				if (!isNull(p_tempLabDir)) {
					var suffix = p_tempLabDir.substr(p_tempLabDir.lastIndexOf("."));
					if (".jpg" != suffix && ".png" != suffix && ".jpeg" != suffix && ".gif" != suffix && ".JPG" != suffix && ".PNG" != suffix && ".JPEG" != suffix && ".GIF" != suffix) {
						$("#p_temp_error").html("图片格式");
						$("#p_tempLab_pic").focus();
						saving = false;
						return false;
					}
				}else{
					$("#p_temp_error").html("必选");
					saving = false;
					return false;
				}
				$("#p_temp_error").html("");
				
				// 红外光分析图谱
				var p_infLabDir = $("#p_infLab_pic").filebox("getValue");
				if (!isNull(p_infLabDir)) {
					var suffix = p_infLabDir.substr(p_infLabDir.lastIndexOf("."));
					if (".jpg" != suffix && ".png" != suffix && ".jpeg" != suffix && ".gif" != suffix && ".JPG" != suffix && ".PNG" != suffix && ".JPEG" != suffix && ".GIF" != suffix) {
						$("#p_inf_error").html("图片格式");
						$("#p_infLab_pic").focus();
						saving = false;
						return false;
					}
				}else{
					$("#p_inf_error").html("必选");
					saving = false;
					return false;
				}
				$("#p_inf_error").html("");
				
				// 差热扫描图谱
				var p_dtLabDir = $("#p_dtLab_pic").filebox("getValue");
				if (!isNull(p_dtLabDir)) {
					var suffix = p_dtLabDir.substr(p_dtLabDir.lastIndexOf("."));
					if (".jpg" != suffix && ".png" != suffix && ".jpeg" != suffix && ".gif" != suffix && ".JPG" != suffix && ".PNG" != suffix && ".JPEG" != suffix && ".GIF" != suffix) {
						$("#p_dt_error").html("图片格式");
						$("#p_dtLab_pic").focus();
						saving = false;
						return false;
					}
				}else{
					$("#p_dt_error").html("必选");
					saving = false;
					return false;
				}
				$("#p_dt_error").html("");
				
				// 热重分析图谱
				var p_tgLabDir = $("#p_tgLab_pic").filebox("getValue");
				if (!isNull(p_tgLabDir)) {
					var suffix = p_tgLabDir.substr(p_tgLabDir.lastIndexOf("."));
					if (".jpg" != suffix && ".png" != suffix && ".jpeg" != suffix && ".gif" != suffix && ".JPG" != suffix && ".PNG" != suffix && ".JPEG" != suffix && ".GIF" != suffix) {
						$("#p_tg_error").html("图片格式");
						$("#p_tgLab_pic").focus();
						saving = false;
						return false;
					}
				}else{
					$("#p_tg_error").html("必选");
					saving = false;
					return false;
				}
				$("#p_tg_error").html("");
				
				// 结论结果
				partsAtl_result = assembleConclusion("partsAtl");
				if(partsAtl_result == false){
					saving = false;
					return false;
				}
			}
			
			// 材料结果
			if(m_arTable > 0){
				// 样品图谱
				var m_tempLabDir = $("#m_tempLab_pic").filebox("getValue");
				if (!isNull(m_tempLabDir)) {
					var suffix = m_tempLabDir.substr(m_tempLabDir.lastIndexOf("."));
					if (".jpg" != suffix && ".png" != suffix && ".jpeg" != suffix && ".gif" != suffix && ".JPG" != suffix && ".PNG" != suffix && ".JPEG" != suffix && ".GIF" != suffix) {
						$("#m_temp_error").html("图片格式");
						$("#m_tempLab_pic").focus();
						saving = false;
						return false;
					}
				}else{
					$("#m_temp_error").html("必选");
					saving = false;
					return false;
				}
				$("#m_temp_error").html("");
				
				// 红外光分析图谱
				var m_infLabDir = $("#m_infLab_pic").filebox("getValue");
				if (!isNull(m_infLabDir)) {
					var suffix = m_infLabDir.substr(m_infLabDir.lastIndexOf("."));
					if (".jpg" != suffix && ".png" != suffix && ".jpeg" != suffix && ".gif" != suffix && ".JPG" != suffix && ".PNG" != suffix && ".JPEG" != suffix && ".GIF" != suffix) {
						$("#m_inf_error").html("图片格式");
						$("#m_infLab_pic").focus();
						saving = false;
						return false;
					}
				}else{
					$("#m_inf_error").html("必选");
					saving = false;
					return false;
				}
				$("#m_inf_error").html("");
				
				// 差热扫描图谱
				var m_dtLabDir = $("#m_dtLab_pic").filebox("getValue");
				if (!isNull(m_dtLabDir)) {
					var suffix = m_dtLabDir.substr(m_dtLabDir.lastIndexOf("."));
					if (".jpg" != suffix && ".png" != suffix && ".jpeg" != suffix && ".gif" != suffix && ".JPG" != suffix && ".PNG" != suffix && ".JPEG" != suffix && ".GIF" != suffix) {
						$("#m_dt_error").html("图片格式");
						$("#m_dtLab_pic").focus();
						saving = false;
						return false;
					}
				}else{
					$("#m_dt_error").html("必选");
					saving = false;
					return false;
				}
				$("#m_dt_error").html("");
				
				// 热重分析图谱
				var m_tgLabDir = $("#m_tgLab_pic").filebox("getValue");
				if (!isNull(m_tgLabDir)) {
					var suffix = m_tgLabDir.substr(m_tgLabDir.lastIndexOf("."));
					if (".jpg" != suffix && ".png" != suffix && ".jpeg" != suffix && ".gif" != suffix && ".JPG" != suffix && ".PNG" != suffix && ".JPEG" != suffix && ".GIF" != suffix) {
						$("#m_tg_error").html("图片格式");
						$("#m_tgLab_pic").focus();
						saving = false;
						return false;
					}
				}else{
					$("#m_tg_error").html("必选");
					saving = false;
					return false;
				}
				$("#m_tg_error").html("");
				
				// 结论结果
				matAtl_result = assembleConclusion("matAtl");
				if(matAtl_result == false){
					saving = false;
					return false;
				}
			}
			
			conclusionDataArray = partsAtl_result.concat(matAtl_result);
			
			$('#uploadForm').ajaxSubmit({
				url: "${ctx}/result/atlasUpload",
				dataType : 'text',
				data: {
					"conclusionResult": JSON.stringify(conclusionDataArray)
				},
				success:function(msg){
					saving = false;
					var data = eval('(' + msg + ')');
					if(data.success){
						closeDialog(data.msg);
					}else{
						$("#atlasError").html(data.msg);
					}
				}
			});
		}
		
		// 型式试验结果上传
		function upload(){
			if(saving){
				return false;
			}
			saving = true;
			
			// 试验结果
			var dataArray = [];
			// 试验结论结果
			var conclusionDataArray = [];
			var date = new Date();
			var flag = true;
			// 零件结果
			var p_result = [];
			// 材料结果
			var m_result = [];
			// 零件型式结论
			var partsPat_result = [];
			// 材料型式结论
			var matPat_result = [];
			
			var p_pfTable =  $("#p_pfTable").length;
			var m_pfTable = $("#m_pfTable").length;
			var taskType = "${facadeBean.type}";
			
			// 零件试验结果
			if(p_pfTable > 0){
				// 附件
				var partsResultAttachFile = $("#partsResultAttachFile").filebox("getValue");
				
				if($("tr[p_num]").length < 1 && isNull(partsResultAttachFile)){
					$("#patternError").html("请添加零件试验结果或者上传附件");
					saving = false;
					return false;
				}
				$("#patternError").html("");
				
				if($("tr[p_num]").length > 0){
					// 试验结果
					p_result = assemble("p", date);
					if(p_result == false){
						saving = false;
						return false;
					}
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
				
				if($("tr[m_num]").length < 1 && isNull(materialResultAttachFile)){
					$("#patternError").html("请添加材料试验结果或者上传附件");
					saving = false;
					return false;
				}
				$("#patternError").html("");
				
				if($("tr[m_num]").length > 0){
					// 试验结果
					m_result = assemble("m", date);
					if(m_result == false){
						saving = false;
						return false;
					}
				}
				
				// 结论结果
				matPat_result = assembleConclusion("matPat");
				if(matPat_result == false){
					saving = false;
					return false;
				}
			}
			
			dataArray = p_result.concat(m_result);
			conclusionDataArray = partsPat_result.concat(matPat_result);
			
			$('#patResultForm').ajaxSubmit({
				url: "${ctx}/result/patternUpload",
				type:'post',
				dataType:"json",
				data: {
					"result": JSON.stringify(dataArray),
					"conclusionResult": JSON.stringify(conclusionDataArray)
				},
				success:function(data){
					saving = false;
					if(data.success){
						closeDialog(data.msg);
					}else{
						$("#patternError").html(data.msg);
					}
				},
				error: function(data){
					saving = false;
					$("#patternError").html("系统提示：提交失败，如上传附件，请检查附件是否超过50M");
				}
			});
		}
		
		function doCancel(){
			$("#uploadDetailDialog").dialog("close");
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
			return num;
		}
		
		function deleteResult(type, num){
			$("tr["+ type +"_num='"+ num +"']").remove();
		}
		
		
		// 试验结果-组装数据
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
				// 备注
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
		
		// 组装数据
		function assembleForExport(type){
			var dataArray = [];
			var flag = true;
			
			$("tr[" + type + "_num]").each(function(){
				var num = $(this).attr(type + "_num");
				var array = num.split("_");
				num = array[1];
				
				// 实验项目
				var project = $("#"+ type +"_project_" + num).textbox("getValue");
				//参考标准
				var standard = $("#"+ type +"_standard_" + num).textbox("getValue");
				// 试验要求
				var require = $("#"+ type +"_require_" + num).textbox("getValue");
				// 试验结果
				var result = $("#"+ type +"_result_" + num).textbox("getValue");
				// 结果评价
				var evaluate = $("#"+ type +"_evaluate_" + num).textbox("getValue");
				// 备注
				var remark = $("#"+ type +"_remark_" + num).textbox("getValue");
				
				var obj = new Object();
				obj.project = project;
				obj.standard = standard;
				obj.require = require;
				obj.result = result;
				obj.evaluate = evaluate;
				obj.remark = remark;
				obj.tId = '${facadeBean.id}';
				obj.catagory = type == "p"? 1: 2;
				
				dataArray.push(obj);
			});
			return dataArray;
		}
		
		function importResult(){
			$("#result").html("");
			$('#excelDialog').dialog('open');
		}
		
		function importExcel(){
			$("#result").html("");
			
			var fileDir = $("#upfile").filebox("getValue");
			var suffix = fileDir.substr(fileDir.lastIndexOf("."));
			if ("" == fileDir) {
				$("#fileInfo").html("请选择要导入的Excel文件");
				return false;
			}
			if (".xls" != suffix && ".xlsx" != suffix) {
				$("#fileInfo").html("请选择Excel格式的文件导入！");
				return false;
			}
			$("#fileInfo").html("");
			
			$('#resultUploadForm').ajaxSubmit({
				url : "${ctx}/result/importResult",
				dataType : 'text',
				success : function(msg) {
					var data = eval('(' + msg + ')');
					$("#upfile").filebox("clear");
					$("#result").html(data.msg);
					
					if(data.success){
						var results = eval('(' + data.data + ')');
						if(!isNull(results)){
							for(var i = 0; i < results.length; i++){
								var obj = results[i];
								if(obj.catagory == 1){
									var num = addResult("p");
									setInputVal("p_project_" + num, obj.project);
									setInputVal("p_standard_" + num, obj.standard);
									setInputVal("p_require_" + num, obj.require);
									setInputVal("p_result_" + num, obj.result);
									setInputVal("p_evaluate_" + num, obj.evaluate);
									setInputVal("p_remark_" + num, obj.remark);
								}else{
									var num = addResult("m");
									setInputVal("m_project_" + num, obj.project);
									setInputVal("m_standard_" + num, obj.standard);
									setInputVal("m_require_" + num, obj.require);
									setInputVal("m_result_" + num, obj.result);
									setInputVal("m_evaluate_" + num, obj.evaluate);
									setInputVal("m_remark_" + num, obj.remark);
								}
								
							}	
						}
					}
				}
			});
		}
		
		function exportResult(){
			var date = new Date();
			var excelForm = $("<form></form>");
			excelForm.attr('method','post') 
			excelForm.attr('action',"${ctx}/result/exportResult");  
			
			var mResult = $("<input type='hidden' name='mResult' />")  
		    mResult.attr('value',JSON.stringify(assembleForExport("m"))); 
			
			var pResult = $("<input type='hidden' name='pResult' />")  
		    pResult.attr('value', JSON.stringify(assembleForExport("p"))); 
			
			excelForm.append(mResult);  
			excelForm.append(pResult); 
			excelForm.appendTo('body').submit();
		}
		
		function exportTemplate(){
			window.location.href = "${ctx}/resources/template/型式试验结果.xlsx";
		}
		
		function setInputVal(id, val){
			if(!isNull(val)){
				$("#" + id).textbox("setValue", val);
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
		
		.remark-span{
			font-weight: bold;
		}
		
	</style>
	
</body>

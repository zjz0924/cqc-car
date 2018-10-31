<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<form method="POST" enctype="multipart/form-data" id="uploadForm">
		<input type="hidden" id="t_id" name="t_id" value="${facadeBean.id }">
		<input type="hidden" id="v_id" name="v_id" value="${facadeBean.info.vehicle.id}">
		<input type="hidden" id="p_id" name="p_id" value="${facadeBean.info.parts.id }">
		<input type="hidden" id="m_id" name="m_id" value="${facadeBean.info.material.id }">
		<input type="hidden" id="draft" name="draft" value="${facadeBean.draft }">
		<input type="hidden" id="reason_id" name="reason_id" value="${facadeBean.reason.id }">
	
		<div style="margin-left: 10px;margin-top:20px;">
			
			<c:if test="${not empty facadeBean.id }">
				<div style="margin-bottom: 20px;margin-left: 10px;">
					当前状态： <c:choose>
						       <c:when test="${facadeBean.state == 1}">
						       		<span style="color:green; font-weight:bold;">审核中</span>
						       </c:when>
						       <c:otherwise>
						       	    <span style="color:red; font-weight:bold;">审核不通过</span>
						       	    
						       	    <div style="border: 1px dashed #C9C9C9;width: 97%;margin-top: 10px;">
						       	    	<c:forEach items="${recordList}" var="vo" varStatus="vst">
						       	    		<div style="margin-top:5px; margin-bottom: 5px;margin-left: 5px;">
						       	    			第&nbsp;<span style="font-weight:bold;">${vst.index + 1}</span>&nbsp;次审核&nbsp;&nbsp;&nbsp;&nbsp;<fmt:formatDate value='${vo.createTime}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>&nbsp;&nbsp;&nbsp;&nbsp;审核意见：<span style="font-weight:bold;">${vo.remark}</span>
						       	    		</div>
						       	    	</c:forEach> 
						       	    </div>
						       </c:otherwise>
						   </c:choose>
				</div>		
			</c:if>
			
			<!-- 申请人信息 -->
			<div style="margin-top:20px;">
				<div class="title">申请人信息</div>
				<table class="info">
					<tr>
						<td>
							<span class="title-span">申请人：</span> 
							<input class="easyui-textbox" value="${applicat.nickName }" disabled style="width:150px;">
						</td>
						<td>
							<span class="title-span">科室：</span> 
							<input class="easyui-textbox" disabled value="${applicat.department }" style="width:150px;">
						</td>
						<td>
							<span class="title-span">机构/单位：</span> 
							<input class="easyui-textbox" value="${applicat.org.name }" disabled style="width:150px;">
						</td>
						<td>
							<span class="title-span">联系方式：</span> 
							<input class="easyui-textbox"  disabled value="${applicat.mobile }" disabled style="width:150px;">
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span">备注：</span> 
							<input class="easyui-textbox" value="${applicat.remark }" disabled style="width:150px;">
						</td>
					</tr>
				</table>
			</div>	
			
			<div style="margin-top:20px;">
				<div class="title">试验类型</div>
				<table class="info">
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>类型：</span> 
							 <input type="checkbox" id="partAtl" name="atlType" value="1">零件图谱试验&nbsp;&nbsp;&nbsp;&nbsp;
							 <input type="checkbox" id="materialAtl" name="atlType" value="2">材料图谱试验&nbsp;&nbsp;&nbsp;&nbsp;
							 <input type="checkbox" id="partsPat" name="atlType" value="3">零件型式试验&nbsp;&nbsp;&nbsp;&nbsp;
							 <input type="checkbox" id="matPat" name="atlType" value="4">材料型式试验
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>测试项目：</span> 
							<input id="atlItem" name="atlItem" class="easyui-textbox" value="${facadeBean.atlItem }" style="width:400px;">
							
							<span class="title-span">备注：</span> 
							<input id="atlRemark" name="atlRemark" class="easyui-textbox" value="${facadeBean.atlRemark }" style="width:400px;">
						</td>
					</tr>
				</table>
			</div>
			
			<div style="margin-top:20px;">
			<div class="title">抽样原因</div>
				<table class="info">
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>样件来源：</span> 
							<select id="origin" name="origin" style="width:160px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
								<option value="">请选择</option>
								<c:forEach items="${optionList}" var="vo">
									<c:if test="${vo.type == 1}">
										<option value="${vo.name}" <c:if test="${facadeBean.reason.origin == vo.name }">selected="selected"</c:if>>${vo.name}</option>
									</c:if>
								</c:forEach>
							</select>
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>抽样原因：</span> 
							<select id="reason" name="reason" style="width:160px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
								<option value="">请选择</option>
								<c:forEach items="${optionList}" var="vo">
									<c:if test="${vo.type == 2}">
										<option value="${vo.name}" <c:if test="${facadeBean.reason.reason == vo.name }">selected="selected"</c:if>>${vo.name}</option>
									</c:if>
								</c:forEach>
							</select>
						</td>
						<td>
							<span class="title-span" style="width: 120px;">其他原因描述：</span> 
							<input id="otherRemark" name="otherRemark" class="easyui-textbox" value="${facadeBean.reason.otherRemark }" style="width:350px;">	
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>费用出处：</span> 
							<select id="source" name="source" style="width:160px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
								<option value="">请选择</option>
								<c:forEach items="${optionList}" var="vo">
									<c:if test="${vo.type == 3}">
										<option value="${vo.name}" <c:if test="${facadeBean.reason.source == vo.name }">selected="selected"</c:if>>${vo.name}</option>
									</c:if>
								</c:forEach>
							</select>
						</td>
						<td colspan="3">
							<span class="title-span">备注：</span> 
							<input id="reasonRemark" name="reasonRemark" class="easyui-textbox" value="${facadeBean.reason.remark }" style="width:280px;">	
						</td>
					</tr>
				</table>
			</div>
			
		
			<!-- 整车信息 -->
			<div class="title" style="margin-top:20px;">整车信息&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="vehicleInfo()" title="检索"><i class="icon icon-search"></i></a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="addVehicle()" title="清空"><i class="icon icon-edit"></i></a>
			</div>
			
			<table class="info">
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>车型代码：</span> 
						<select id="v_code" name="v_code" style="width:160px;" class="easyui-combobox" data-options="panelHeight: '200px'">
							<option value="">请选择</option>
							<c:forEach items="${carCodeList}" var="vo">
								<option value="${vo.code}" <c:if test="${facadeBean.info.vehicle.code == vo.code }">selected="selected"</c:if>>${vo.code}</option>
							</c:forEach>
						</select>
					</td>
					<td>
						<span class="title-span">生产日期：</span> 
						<input id="v_proTime" name="v_proTime" type="text" class="easyui-datebox" data-options="editable:false " value="<fmt:formatDate value='${facadeBean.info.vehicle.proTime }' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>"  style="width:150px;">
					</td>
					<td>
						<span class="title-span"><span class="req-span">*</span>生产基地：</span> 
						<select id="v_proAddr" name="v_proAddr" style="width:160px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
							<option value="">请选择</option>
							<c:forEach items="${addressList}" var="vo">
								<option value="${vo.name}" <c:if test="${facadeBean.info.vehicle.proAddr == vo.name }">selected="selected"</c:if>>${vo.name}</option>
							</c:forEach>
						</select>
					</td>
					<td>
						<span class="title-span">&nbsp;备注：</span> 
						<input id="v_remark" name="v_remark" class="easyui-textbox" value="${facadeBean.info.vehicle.remark }" style="width:150px;">	
					</td>
				</tr>
					
			</table>
		</div>
	
		<div style="margin-left: 10px;margin-top:20px;">
			<div class="title">零部件信息&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="partsInfo()"><i class="icon icon-search"></i></a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="addParts()" title="清空"><i class="icon icon-edit"></i></a>
			</div>
			
			<table class="info">
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>零件名称：</span> 
						<input id="p_name" name="p_name" class="easyui-textbox" value="${facadeBean.info.parts.name }" style="width:150px;">
					</td>
					<td>
						<span class="title-span">零件图号：</span> 
						<input id="p_code" name="p_code" class="easyui-textbox" value="${facadeBean.info.parts.code }" style="width:150px;">
					</td>
					<td>
						<span class="title-span"><span class="req-span">*</span>供应商：</span> 
						<input id="p_producer" name="p_producer" type="text" value="${facadeBean.info.parts.producer }" class="inputAutocomple" style="width:150px;">
					</td>
					<td>
						<span class="title-span" style="width: 105px;"><span class="req-span">*</span>供应商代码：</span> 
						<input id="p_producerCode" name="p_producerCode" class="easyui-textbox" value="${facadeBean.info.parts.producerCode }" style="width:150px;">
					</td>
				</tr>
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>生产日期：</span> 
						<input id="p_proTime" name="p_proTime" type="text" class="easyui-datebox" data-options="editable:false" value="<fmt:formatDate value='${facadeBean.info.parts.proTime }' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>"  style="width:150px;">
					</td>
					<td>
						<span class="title-span">样件数量：</span> 
						<input id="p_num" name="p_num" type="text" class="easyui-textbox" value="${facadeBean.info.parts.num }" style="width:150px;">
					</td>
					<td>
						<span class="title-span">样件批号：</span> 
						<input id="p_proNo" name="p_proNo" class="easyui-textbox" value="${facadeBean.info.parts.proNo }"  style="width:150px;">
					</td>
					<td>
						<span class="title-span" style="width: 105px;">生产场地：</span> 
						<input id="p_place" name="p_place" class="easyui-textbox" value="${facadeBean.info.parts.place }"  style="width:150px;">
					</td>
				</tr>
				<tr>
					<td>
						<span class="title-span">&nbsp;备注：</span> 
						<input id="p_remark" name="p_remark" class="easyui-textbox" value="${facadeBean.info.parts.remark }" style="width:150px;">	
					</td>
				</tr>
			</table>
		</div>
	
		<div style="margin-left: 10px;margin-top:20px;">
			<div class="title">原材料信息&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="materialInfo()"><i class="icon icon-search"></i></a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="addMaterial()" title="清空"><i class="icon icon-edit"></i></a>
			</div>
				
			<table class="info">
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>材料名称：</span> 
						<input id="m_matName" name="m_matName" class="easyui-textbox" value="${facadeBean.info.material.matName }" style="width:150px;">
					</td>
					<td>
						<span class="title-span"><span class="req-span">*</span>材料牌号：</span> 
						<input id="m_matNo" name="m_matNo" class="easyui-textbox" value="${facadeBean.info.material.matNo }" style="width:150px;">
					</td>
					<td>
						<span class="title-span"><span class="req-span">*</span>供应商：</span> 
						<input id="m_producer" name="m_producer" type="text"  value="${facadeBean.info.material.producer }" class="inputAutocomple">
					</td>
					<td>
						<span class="title-span">材料颜色：</span> 
						<input id="m_matColor" name="m_matColor" class="easyui-textbox" value="${facadeBean.info.material.matColor }" style="width:150px;">
					</td>
				</tr>
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>材料批号：</span> 
						<input id="m_proNo" name="m_proNo" class="easyui-textbox" value="${facadeBean.info.material.proNo }" style="width:150px;">
					</td>
					
					<td>
						<span class="title-span">样品数量：</span> 
						<input id="m_num" name="m_num" class="easyui-textbox" value="${facadeBean.info.material.num }" style="width:150px;">
					</td>
					
					<td>
						<span class="title-span">备注：</span> 
						<input id="m_remark" name="m_remark" class="easyui-textbox" value="${facadeBean.info.material.remark }" style="width:150px;">	
					</td>
				</tr>
			</table>
		</div>
		
		
		<div style="margin-left: 10px;margin-top:20px;">
			<div class="title">权限信息</div>
			
			<div class="permission">
				<span class="permissionSpan">审核人员：</span>
				<input id="examineAccountName" class="inputxt" readonly="readonly" value="${examineAccount.nickName}">
				<input id="examineAccountId" name="examineAccountId" class="inputxt" type="hidden" value="${examineAccount.id}">
				
				<a onclick="chooseUser('examine')" href="javascript:void(0)" class="easyui-linkbutton l-btn l-btn-plain" icon="icon-search">选择</a>
				<a onclick="clearValue('examine')" href="javascript:void(0)" class="easyui-linkbutton l-btn l-btn-plain" icon="icon-redo">清空</a>
			</div>
			
			<div class="permission">
				<span class="permissionSpan">下达任务人员：</span>
				<input id="trainsmitAccountName" class="inputxt" readonly="readonly" value="${trainsmitAccount.nickName }">
				<input id="trainsmitAccountId" name="trainsmitAccountId" class="inputxt" type="hidden" value="${trainsmitAccount.id}">
				
				<a onclick="chooseUser('trainsmit')" href="javascript:void(0)" class="easyui-linkbutton l-btn l-btn-plain" icon="icon-search">选择</a>
				<a onclick="clearValue('trainsmit')" href="javascript:void(0)" class="easyui-linkbutton l-btn l-btn-plain" icon="icon-redo">清空</a>	
			</div>
			
			<div class="permission">
				<span class="permissionSpan">审批人员：</span>
				<input id="approveAccountName" class="inputxt" readonly="readonly" value="${approveAccount.nickName }">
				<input id="approveAccountId" name="approveAccountId" class="inputxt" type="hidden" value="${approveAccount.id}">
				
				<a onclick="chooseUser('approve')" href="javascript:void(0)" class="easyui-linkbutton l-btn l-btn-plain" icon="icon-search">选择</a>
				<a onclick="clearValue('approve')" href="javascript:void(0)" class="easyui-linkbutton l-btn l-btn-plain" icon="icon-redo">清空</a>
			</div>
		</div>
	
		 <div style="text-align:center;margin-top:35px;" class="data-row">
			<a href="javascript:void(0);"  onclick="save(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>&nbsp;&nbsp;
			<a href="javascript:void(0);"  onclick="save(1)" class="easyui-linkbutton" data-options="iconCls:'icon-large-smartart'">暂存</a>
			<span id="exception_error" class="error-message"></span>
		</div>
	</form>
	
	<div id="vehicleDialog"></div>
	<div id="materialDialog"></div>
	<div id="partsDialog"></div>
	<div id="userDialog"></div>
	
		<style type="text/css">
			.title-span{
				display: inline-block;
				width: 85px;
				padding-right: 5px;
				text-align: right; 
			}
			
	        .req-span{
	        	font-weight: bold;
	        	color: red;
	        }
	        
	        .info{
	        	border: 1px dashed #C9C9C9;
	        	margin-left:10px;
	        	margin-right: 10px;
	        	font-size: 14px;
	        	padding-top: 5px;
	        	padding-bottom: 5px;
	        }
	        
	        .info tr{
	        	height: 35px;
	        }
	        
	        .title{
	        	margin-left:10px;
	        	margin-bottom:8px;
	        	font-size: 14px;
	        	color: #1874CD;
    			font-weight: bold;
	        }
	        
	        .icon{
	        	width:16px;
	        	height: 16px;
	        	display: inline-block;
	        }
	        
	        .inputAutocomple{
				border: 1px solid #D3D3D3;
			    outline-style: none;
			    resize: none;
				position: relative;
			    background-color: #fff;
			    vertical-align: middle;
			    display: inline-block;
			    overflow: hidden;
			    white-space: nowrap;
			    margin: 0;
			    padding: 4px;
			    border-radius: 5px 5px 5px 5px;
				height: 22px;
			    line-height: 22px;
			    font-size: 12px;
			}
			
			.inputxt{
				border: 1px solid #D7D7D7;
			    border-radius: 3PX;
			    height: 25px;
			    padding: 7px 0 7px 5px!important;
			    line-height: 14PX;
			    font-size: 12px;
			    display: inline-block;
			    width: 150px;
			}
			
			.permission{
				margin-left: 20px;
    			margin-bottom: 15px;
			}
			
			.permissionSpan{
				width: 100px;
			    display: inline-block;
			    font-weight: bold;
			}
		</style>
		
		<script type="text/javascript">
			// 是否提交中
			var saving = false;
			
			$(function(){
				// 图谱类型
				if(!isNull("${partAtl}")){
					$("#partAtl").prop("checked",true);
				}
				if(!isNull("${materialAtl}")){
					$("#materialAtl").prop("checked",true);
				}
				if(!isNull("${partsPat}")){
					$("#partsPat").prop("checked",true);
				}
				if(!isNull("${matPat}")){
					$("#matPat").prop("checked",true);
				}
				
				$("#p_producer").autocomplete("${ctx}/ots/getProducerList?type=1", {
					formatItem: function(row,i,max) {
						var obj =eval("(" + row + ")");//转换成js对象
						return obj.text;
					},
					formatResult: function(row) {
						var obj =eval("(" + row + ")");
						return obj.text;
					}
				});
				
				//选择后处理方法
				$("#p_producer").result(function(event, data, formatted){ 
					var obj = eval("(" + data + ")"); //转换成js对象 
					$("#p_producer").val(obj.text);
				});
				
				$("#m_producer").autocomplete("${ctx}/ots/getProducerList?type=2", {
					formatItem: function(row,i,max) {
						var obj =eval("(" + row + ")");//转换成js对象
						return obj.text;
					},
					formatResult: function(row) {
						var obj =eval("(" + row + ")");
						return obj.text;
					}
				});
				
				//选择后处理方法
				$("#m_producer").result(function(event, data, formatted){ 
					var obj = eval("(" + data + ")"); //转换成js对象 
					$("#m_producer").val(obj.text);
				});
				
			});
		
			function save(isDraft){
				if(saving){
					return false;
				}
				saving = true;
				
				//基准图谱类型
				var altType = getCheckboxVal("atlType");
				if(isNull(altType) || altType.length < 1){
					errorMsg("系统提示：请选择试验类型");
					saving = false;
					return false;
				}
				
				//型式试验
				if(validChoose(altType, 3) || validChoose(altType, 4)){
					if(!isRequire("atlItem", "系统提示：选择型式试验时，测试项目必填")){ saving = false; return false; }
				}
				
				// 抽样原因
				if(!isRequire("origin", "系统提示：样件来源必选")){ saving = false; return false; }
				if(!isRequire("reason", "系统提示：抽样原因必选")){ saving = false; return false; }
				if(!isRequire("source", "系统提示：费用出处必选")){ saving = false; return false; }
				
				// 零件试验 
				if(validChoose(altType, 1) || validChoose(altType, 3)){
					// 整车信息
					if(!isRequire("v_code", "系统提示：选择零件试验时，车型代码必选")){ saving = false; return false; }
					if(!isRequire("v_proAddr", "系统提示：选择零件试验时，整车生产基地必选")){ saving = false; return false; }
					
					// 零部件信息
					if(!isRequire("p_name", "系统提示：选择零件试验时，零件名称必填")){ saving = false; return false; }
					if(!isRequire("p_producer", "系统提示：选择零件试验时，零件供应商必填")){ saving = false; return false; }
					if(!isRequire("p_producerCode", "系统提示：选择零件试验时，零件供应商代码必填")){ saving = false; return false; }
					if(!isRequire("p_proTime", "系统提示：选择零件试验时，样件生产日期必填")){ saving = false; return false; }
					
					var pNum = $("#p_num").textbox("getValue");
					if(!isNull(pNum) && isNaN(pNum)){
						saving = false;
						errorMsg("系统提示：样件数量必须为整数");
						$("#p_num").next('span').find('input').focus();
						$("#p_num").textbox("setValue", "");
						return false;
					}
				}
				
				// 材料试验
				if(validChoose(altType, 2) || validChoose(altType, 4)){
					// 原材料信息
					if(!isRequire("m_matName", "系统提示：选择材料试验时，材料名称必填")){ saving = false; return false; }
					if(!isRequire("m_matNo", "系统提示：选择材料试验时，材料牌号必填")){ saving = false; return false; }
					if(!isRequire("m_producer", "系统提示：选择材料试验时，材料供应商必填")){ saving = false; return false; }
					if(!isRequire("m_proNo", "系统提示：选择材料试验时，材料批号必填")){ saving = false; return false; }
					
					var mNum = $("#m_num").textbox("getValue");
					if(!isNull(mNum) && isNaN(mNum)){
						saving = false;
						errorMsg("系统提示：样品数量必须为整数");
						$("#m_num").next('span').find('input').focus();
						$("#m_num").textbox("setValue", "");
						return false;
					}
				}
				
				// 权限信息
				var examineAccountId = $("#examineAccountId").val();
				if(isNull(examineAccountId)){
					errorMsg("系统提示：请选择审核人员");
					saving = false;
					return false;
				}
				
				var trainsmitAccountId = $("#trainsmitAccountId").val();
				if(isNull(trainsmitAccountId)){
					errorMsg("系统提示：请选择下达人员");
					saving = false;
					return false;
				}
				
				var approveAccountId = $("#approveAccountId").val();
				if(isNull(approveAccountId)){
					errorMsg("系统提示：请选择审批人员");
					saving = false;
					return false;
				}
				
				$("#draft").val(isDraft);
				
				$('#uploadForm').ajaxSubmit({
					url: "${ctx}/tpt/save",
					dataType : 'json',
					success:function(data){
						if(data.success){
							tipMsg(data.msg, function(){
								window.location.reload();
							});
						}else{
							saving = false; 
							errorMsg(data.msg);
						}
					}
				});
			}
			
			/**
			  * 判断是否必填
			  * id: 属性ID
			  * emsg: 错误信息
			*/
			function isRequire(id, emsg){
				var val = $("#" + id).val();
				if(isNull(val)){
					errorMsg(emsg);
					$("#" + id).next('span').find('input').focus();
					return false;
				}
				return true;
			}
		
			function vehicleInfo() {
				$('#vehicleDialog').dialog({
					title : '整车信息',
					width : 1000,
					height : 520,
					closed : false,
					cache : false,
					href : "${ctx}/vehicle/list",
					modal : true
				});
				$('#vehicleDialog').window('center');
				
				// 移去滚动条
				window.parent.parent.scrollY(510);
			}
			
			function materialInfo() {
				$('#materialDialog').dialog({
					title : '原材料信息',
					width : 1000,
					height : 520,
					closed : false,
					cache : false,
					href : "${ctx}/material/list",
					modal : true
				});
				$('#materialDialog').window('center');
				
				// 移去滚动条
				window.parent.parent.scrollY(510);
			}
			
			
			function partsInfo() {
				$('#partsDialog').dialog({
					title : '零部件信息',
					width : 1000,
					height : 550,
					closed : false,
					cache : false,
					href : "${ctx}/parts/list",
					modal : true
				});
				$('#partsDialog').window('center');
				
				// 移去滚动条
				window.parent.parent.scrollY(510);
			}
			
			// 新增整车信息
			function addVehicle(){
				$("#v_code").combobox("select", '');
				$("#v_proAddr").combobox("select", "");
				$("#v_proTime").datebox('setValue', "");
				$("#v_remark").textbox("setValue", "");
				$("#v_id").val("");
			}
			
			// 新增零部件信息
			function addParts(){
				$("#p_code").textbox("setValue", "");
				$("#p_name").textbox("setValue", "");
				$("#p_proTime").datebox('setValue', "");
				$("#p_place").textbox("setValue", "");
				$("#p_proNo").textbox("setValue", "");
				$("#p_remark").textbox("setValue", "");
				$("#p_producer").val(""); 
				$("#p_producerCode").textbox('setValue', ""); 
				$("#p_num").textbox('setValue', ""); 
				$("#p_id").val("");
			}
			
			// 新增原材料信息
			function addMaterial(){
				$("#m_matName").textbox("setValue", "");
				$("#m_proNo").textbox("setValue", "");
				$("#m_producer").val("");
				$("#m_matNo").textbox("setValue", "");
				$("#m_matColor").textbox("setValue", "");
				$("#m_remark").textbox("setValue", "");
				$("#m_num").textbox("clear");
			}
			
			function clearValue(type){
				$("#" + type + "AccountName").val("");
				$("#" + type + "AccountId").val("");
			}
			
			
			function chooseUser(type){
				$('#userDialog').dialog({
					title : '用户信息',
					width : 1100,
					height : 550,
					closed : false,
					cache : false,
					top: 100,
					href : "${ctx}/tpt/userList?type=" + type,
					modal : true
				});
				
				// 移去滚动条
				window.parent.parent.scrollY(430);
			}
		</script>
	
</body>

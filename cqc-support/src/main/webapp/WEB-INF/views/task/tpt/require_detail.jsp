<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<form method="POST" enctype="multipart/form-data" id="uploadForm">
		<input type="hidden" id="t_id" name="t_id" value="${facadeBean.id }">
		<input type="hidden" id="taskType" name="taskType" value="${taskType }">
		<input type="hidden" id="v_id" name="v_id" value="${facadeBean.info.vehicle.id}">
		<input type="hidden" id="p_id" name="p_id" value="${facadeBean.info.parts.id }">
		<input type="hidden" id="m_id" name="m_id" value="${facadeBean.info.material.id }">
		<input type="hidden" id="draft" name="draft" value="${facadeBean.draft }">
		<input type="hidden" id="applicat_id" name="applicat_id" value="${facadeBean.applicat.id }">
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
							<span class="title-span"><span class="req-span">*</span>申请人：</span> 
							<input id="applicatName" name="applicatName" class="easyui-textbox" value="${facadeBean.applicat.name }" style="width:150px;">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>科室：</span> 
							<input id="applicatDepart" name="applicatDepart" class="easyui-textbox" value="${facadeBean.applicat.depart }" style="width:150px;">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>机构/单位：</span> 
							<input id="applicatOrg" name="applicatOrg" style="width: 168px;"/>
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>联系方式：</span> 
							<input id="applicatContact" name="applicatContact" class="easyui-textbox" value="${facadeBean.applicat.contact }"  style="width:150px;">
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span">备注：</span> 
							<input id="applicatRemark" name="applicatRemark" class="easyui-textbox" value="${facadeBean.applicat.remark }"  style="width:150px;">
						</td>
					</tr>
				</table>
			</div>
			
			
			<!-- 基准图谱类型 -->
			<c:if test="${taskType == 1}">
				<div style="margin-top:20px;">
					<div class="title">基准图谱类型</div>
					<table class="info">
						<tr>
							<td>
								<span class="title-span"><span class="req-span">*</span>类型：</span> 
								 <select id="atlType" name="atlType" style="width:160px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
								 	<option value="">请选择</option>
								 	<option value="1" <c:if test="${facadeBean.atlType == 1 }">selected="selected"</c:if>>零件基准图谱</option>
								 	<option value="2" <c:if test="${facadeBean.atlType == 2 }">selected="selected"</c:if>>材料基准图谱</option>
								 </select>
							</td>
							<td>
								<span class="title-span">备注：</span> 
								<input id="atlRemark" name="atlRemark" class="easyui-textbox" value="${facadeBean.atlRemark }" style="width:150px;">
							</td>
						</tr>
					</table>
				</div>
			</c:if>
			<!-- 第三方试验委托 -->
			<c:if test="${taskType == 4}">
				<div style="margin-top:20px;">
					<div class="title">试验类型</div>
					<table class="info">
						<tr>
							<td>
								<span class="title-span"><span class="req-span">*</span>试验类型：</span> 
								<select id="atlType" name="atlType" style="width:160px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
									<option value="">请选择</option>
									<option value="1" <c:if test="${facadeBean.atlType == 1 }">selected="selected"</c:if>>零件图谱试验</option>
									<option value="2" <c:if test="${facadeBean.atlType == 2 }">selected="selected"</c:if>>材料图谱试验</option>
									<option value="4" <c:if test="${facadeBean.atlType == 4 }">selected="selected"</c:if>>零件型式试验</option>
									<option value="3" <c:if test="${facadeBean.atlType == 3 }">selected="selected"</c:if>>材料型式试验</option>
								</select>
							</td>
							<td>
								<span class="title-span"><span class="req-span">*</span>测试项目：</span> 
								<input id="atlItem" name="atlItem" class="easyui-textbox" value="${facadeBean.atlItem }" style="width:150px;">
							</td>
							<td>
								<span class="title-span">备注：</span> 
								<input id="atlRemark" name="atlRemark" class="easyui-textbox" value="${facadeBean.atlRemark }" style="width:150px;">
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
								<span class="title-span">其他原因描述：</span> 
								<input id="otherRemark" name="otherRemark" class="easyui-textbox" value="${facadeBean.reason.otherRemark }" style="width:150px;">	
							</td>
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
						</tr>
						<tr>
							<td>
								<span class="title-span">备注：</span> 
								<input id="reasonRemark" name="reasonRemark" class="easyui-textbox" value="${facadeBean.reason.remark }" style="width:150px;">	
							</td>
						</tr>
					</table>
				</div>
			</c:if>
			
		
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
						<span class="title-span"><span class="req-span">*</span>供应商代码：</span> 
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
						<span class="title-span">生产场地：</span> 
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
	
		 <div style="text-align:center;margin-top:35px;" class="data-row">
			<a href="javascript:void(0);"  onclick="save(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>&nbsp;&nbsp;
			<a href="javascript:void(0);"  onclick="save(1)" class="easyui-linkbutton" data-options="iconCls:'icon-large-smartart'">暂存</a>
			<span id="exception_error" class="error-message"></span>
		</div>
	</form>
	
	<div id="vehicleDialog"></div>
	<div id="materialDialog"></div>
	<div id="partsDialog"></div>
	
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
		</style>
		
		<script type="text/javascript">
			// 是否提交中
			var saving = false;
			
			$(function(){
				
				var taskType = "${taskType}";
				
				if(taskType == 1){
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
				}
				
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
				
				// 申请人科室
				$('#applicatOrg').combotree({
					url: '${ctx}/org/getTreeByType?type=2',
					multiple: false,
					animate: true,
					onBeforeSelect: function(node){
					   if(isNull(node.children)){
							return true;
					   }else{
						   return false;
					   }
				   }
				});
				
				// 设置值
				$('#applicatOrg').combotree('setValue', "${facadeBean.applicat.orgId}");
			});
		
			function save(isDraft){
				if(saving){
					return false;
				}
				saving = true;
				
				// 申请人信息
				if(!isRequire("applicatName", "申请人必填")){ saving = false; return false; }
				if(!isRequire("applicatDepart", "申请人科室必填")){ saving = false; return false; }
				if(!isRequire("applicatOrg", "申请人机构/单位必选")){ saving = false; return false; }
				if(!isRequire("applicatContact", "申请人联系方式必填")){ saving = false; return false; }
				
				//基准图谱类型
				if("${taskType == 1}"){
					if(!isRequire("atlType", "基准图谱类型必选")){ saving = false; return false; }
				} else if("${taskType == 4}"){
					// 试验类型
					if(!isRequire("atlType", "试验必选")){ saving = false; return false; }
					
					var atlType = $("#atlType").combobox('getValue');
					if(atlType == 3 || atlType == 4){
						if(!isRequire("atlItem", "测试项目必填")){ saving = false; return false; }
					}
					
					// 抽样原因
					if(!isRequire("origin", "样件来源必选")){ saving = false; return false; }
					if(!isRequire("reason", "抽样原因必选")){ saving = false; return false; }
					if(!isRequire("source", "费用出处必选")){ saving = false; return false; }
				}
				
				
				// 整车信息
				if(!isRequire("v_code", "车型代码必选")){ saving = false; return false; }
				if(!isRequire("v_proAddr", "整车生产基地必选")){ saving = false; return false; }
				
				// 零部件信息
				var taskType = "${taskType}";
				if(taskType == 1){
					if(!isRequire("p_name", "零件名称必填")){ saving = false; return false; }
					if(!isRequire("p_producer", "零件供应商必填")){ saving = false; return false; }
					if(!isRequire("p_producerCode", "零件供应商代码必填")){ saving = false; return false; }
					if(!isRequire("p_proTime", "样件生产日期必填")){ saving = false; return false; }
					
					var pNum = $("#p_num").textbox("getValue");
					if(!isNull(pNum) && isNaN(pNum)){
						saving = false;
						errorMsg("系统提示：提交失败，样件数量必须为整数");
						$("#p_num").next('span').find('input').focus();
						$("#p_num").textbox("setValue", "");
						return false;
					}
				}
				
				// 原材料信息
				if(!isRequire("m_matName", "材料名称必填")){ saving = false; return false; }
				if(!isRequire("m_matNo", "材料牌号必填")){ saving = false; return false; }
				if(!isRequire("m_producer", "材料供应商必填")){ saving = false; return false; }
				if(!isRequire("m_proNo", "材料批号必填")){ saving = false; return false; }
				
				var mNum = $("#m_num").textbox("getValue");
				if(!isNull(mNum) && isNaN(mNum)){
					saving = false;
					errorMsg("系统提示：提交失败，样品数量必须为整数");
					$("#m_num").next('span').find('input').focus();
					$("#m_num").textbox("setValue", "");
					return false;
				}
				
				$("#draft").val(isDraft);
				
				$('#uploadForm').ajaxSubmit({
					url: "${ctx}/ots/save",
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
		</script>
	
</body>

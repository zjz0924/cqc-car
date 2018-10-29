<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<form method="POST" id="uploadForm">
		<input type="hidden" id="t_id" name="t_id" value="${facadeBean.id }">
		<input type="hidden" id="v_id" name="v_id" value="${facadeBean.standInfo.vehicle.id}">
		<input type="hidden" id="p_id" name="p_id" value="${facadeBean.standInfo.parts.id }">
		<input type="hidden" id="m_id" name="m_id" value="${facadeBean.standInfo.material.id }">
		<input type="hidden" id="i_id" name="i_id">
		<input type="hidden" id="taskType" name="taskType" value="${taskType }">
		<input type="hidden" id="reason_id" name="reason_id" value="${facadeBean.reason.id }">
		
		<div style="margin-left: 10px;margin-top:20px;">
			
			<c:if test="${not empty facadeBean.id && facadeBean.state == 2}">
				<div style="margin-bottom: 20px;margin-left: 10px;">
					当前状态： <span style="color:red; font-weight:bold;">审批不通过</span>
				       	    <div style="border: 1px dashed #C9C9C9;width: 97%;margin-top: 10px;">
				       	    	<c:forEach items="${recordList}" var="vo" varStatus="vst">
				       	    		<div style="margin-top:5px; margin-bottom: 5px;margin-left: 5px;">
				       	    			第&nbsp;<span style="font-weight:bold;">${vst.index + 1}</span>&nbsp;次审核&nbsp;&nbsp;&nbsp;&nbsp;<fmt:formatDate value='${vo.createTime}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>&nbsp;&nbsp;&nbsp;&nbsp;审核意见：<span style="font-weight:bold;">${vo.remark}</span>
				       	    		</div>
				       	    	</c:forEach> 
				       	    </div>
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
			
			<!-- 试验类型 -->
			<div style="margin-top:20px;">
				<div class="title">试验类型</div>
				<table class="info">
					<tr>
						<td>
							<input type="checkbox" id="partAtl" name="atlType" value="1">零件图谱&nbsp;&nbsp;&nbsp;&nbsp;
						</td>
						<td>
							<span class="title-span" style="width:150px">零件图谱委托实验室：</span> 
							<input id="partsAtl_org" name="partsAtl_org" style="width: 280px;"/>
						</td>
						<td>
							<span class="title-span" style="width: 120px;"><span class="req-span">*</span>期望完成时间：</span> 
							<input id="expectDate" name="expectDate" type="text" class="easyui-datebox" data-options="editable:false " value="<fmt:formatDate value='${facadeBean.expectDate }' type="date" pattern="yyyy-MM-dd"/>" style="width:200px;">
						</td>
					</tr>
					<tr>
						<td>
							<input type="checkbox" id="materialAtl" name="atlType" value="2">材料图谱
						</td>
						<td>
							<span class="title-span" style="width:150px">材料图谱委托实验室：</span> 
							<input id="matAtl_org" name="matAtl_org" style="width: 280px;"/>
						</td>
						<td>
							<span class="title-span" style="width: 120px;">备注：</span> 
							<input id="atlRemark" name="atlRemark" class="easyui-textbox" value="${facadeBean.atlRemark }" style="width:200px;">	
						</td>
					</tr>
				</table>
			</div>
			
			<!-- 抽样原因 -->
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
			
		
			<div style="margin-top: 15px; margin-bottom: 15px;">
				<div class="title">选择基准</div>
				<div style="margin-left: 10px;">
					<span class="title-span">任务号：</span><input type="text" id="qCode" name="qCode" class="easyui-textbox">&nbsp;
					<a href="javascript:void(0)" onclick="taskInfo()" title="选择"><i class="icon icon-tip"></i>选择</a>&nbsp;&nbsp;
				    <a href="javascript:void(0)" onclick="doQuery()" title="检索"><i class="icon icon-search"></i>查询</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					
					<span class="title-span">选择基准图谱：</span><input id="standard" name="standard" style="width: 370px">
				</div>
			</div>
		
			<div class="title">整车信息&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="vehicleInfo()" title="妫€绱¢"><i class="icon icon-search"></i></a>
			</div>
			
			<table class="info">
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>车型代码：</span> 
						<input id="v_code" style="width:160px;" class="easyui-textbox" disabled value="${facadeBean.info.vehicle.code }">
					</td>
					<td>
						<span class="title-span"><span class="req-span">*</span>生产基地：</span> 
						<input id="v_proAddr" style="width:160px;" class="easyui-textbox" disabled value="${facadeBean.info.vehicle.proAddr }" >
					</td>
					<td>
						<span class="title-span">生产日期：</span> 
						<input id="v_proTime" type="text" class="easyui-datebox" data-options="editable:false " value="<fmt:formatDate value='${facadeBean.info.vehicle.proTime }' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>" disabled style="width:150px;">
					</td>
					<td>
						<span class="title-span">&nbsp;备注：</span> 
						<input id="v_remark" name="v_remark" class="easyui-textbox" value="${facadeBean.info.vehicle.remark }" style="width:150px;">	
					</td>
				</tr>
			</table>
		</div>
	
		<div style="margin-left: 10px;margin-top:20px;">
			<div class="title">零件信息&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="partsInfo()"><i class="icon icon-search"></i></a>
			</div>
			
			<table class="info">
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>零件名称：</span> 
						<input id="p_name" class="easyui-textbox" value="${facadeBean.info.parts.name }" disabled style="width:150px;">
					</td>
					<td>
						<span class="title-span">零件图号：</span> 
						<input id="p_code" class="easyui-textbox" value="${facadeBean.info.parts.code }" disabled style="width:150px;">
					</td>
					<td>
						<span class="title-span"><span class="req-span">*</span>供应商：</span> 
						<input id="p_producer" type="text" value="${facadeBean.info.parts.producer }" disabled class="inputAutocomple" style="width:150px;opacity: 0.6;background-color: rgb(235, 235, 228);">
					</td>
					<td>
						<span class="title-span span-long"><span class="req-span">*</span>供应商代码：</span> 
						<input id="p_producerCode" class="easyui-textbox" value="${facadeBean.info.parts.producerCode }" disabled style="width:150px;">
					</td>
				</tr>
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>生产日期：</span> 
						<input id="p_proTime" name="p_proTime" type="text" class="easyui-datebox" data-options="editable:false" value="<fmt:formatDate value='${facadeBean.info.parts.proTime }' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>" style="width:150px;">
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
						<span class="title-span span-long">生产场地：</span> 
						<input id="p_place" name="p_place" class="easyui-textbox" value="${facadeBean.info.parts.place }" style="width:150px;">
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
			<div class="title">原材料信息&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="materialInfo()"><i class="icon icon-search"></i></a>
			</div>
			
			<table class="info">
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>材料名称：</span> 
						<input id="m_matName" class="easyui-textbox" value="${facadeBean.info.material.matName }" disabled style="width:150px;">
					</td>
					<td>
						<span class="title-span"><span class="req-span">*</span>材料牌号：</span> 
						<input id="m_matNo" class="easyui-textbox" value="${facadeBean.info.material.matNo }" disabled style="width:150px;">
					</td>
					<td>
						<span class="title-span"><span class="req-span">*</span>供应商：</span> 
						<input id="m_producer" type="text"  value="${facadeBean.info.material.producer }" disabled class="inputAutocomple" style="opacity: 0.6;background-color: rgb(235, 235, 228);">
					</td>
					<td>
						<span class="title-span"><span class="req-span">*</span>材料颜色：</span> 
						<input id="m_matColor" class="easyui-textbox" value="${facadeBean.info.material.matColor }" disabled style="width:150px;">
					</td>
				</tr>
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>样品批号：</span> 
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
				<span class="permissionSpan">审批人员：</span>
				<input id="approveAccountName" class="inputxt" readonly="readonly" value="${approveAccount.nickName }">
				<input id="approveAccountId" name="approveAccountId" class="inputxt" type="hidden" value="${approveAccount.id}">
				
				<a onclick="chooseUser('approve')" href="javascript:void(0)" class="easyui-linkbutton l-btn l-btn-plain" icon="icon-search">选择</a>
				<a onclick="clearValue('approve')" href="javascript:void(0)" class="easyui-linkbutton l-btn l-btn-plain" icon="icon-redo">清空</a>
			</div>
		</div>

		 <div style="text-align:center;margin-top:35px;" class="data-row">
			<a href="javascript:void(0);"  onclick="save()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">提交</a>
			<span id="exception_error" class="error-message"></span>
		</div>
	</form>
	
	<div id="vehicleDialog"></div>
	<div id="materialDialog"></div>
	<div id="partsDialog"></div>
	<div id="taskDialog" style="overflow-y:hidden;"></div>
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
	        
	        .red-font{
			   color:red;
			   font-weight: bold;
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
			
			.span-long{
				width: 100px;
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
			var standardUrl = '${ctx}/ppap/standard';
			// 是否提交中
			var saving = false;
			
			$(function(){
				// 零件图谱委托实验室
				$('#partsAtl_org').combotree({
					url: '${ctx}/org/getTreeByType?type=3',
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
				$('#partsAtl_org').combotree('setValue', "${facadeBean.partsAtlId}");
				
				
				// 材料图谱委托实验室
				$('#matAtl_org').combotree({
					url: '${ctx}/org/getTreeByType?type=3',
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
				$('#matAtl_org').combotree('setValue', "${facadeBean.matAtlId}");
				
				
				// 基准
				$("#standard").combobox({
					url : standardUrl,
					valueField : 'id',
					textField : 'text',
					formatter : formatItem,
					onLoadSuccess:function() {
						var data= $(this).combobox("getData");
						if (data.length > 0) {
		                	if(!isNull("${facadeBean.standIid}")){
		                		$(this).combobox('select', "${facadeBean.standIid}");
		                	}else{
		                		$(this).combobox('select', data[0].id);
		                	}
		                }else{
		                	$(this).combobox('select', '');
		                }
					}
				});

				// 编辑的时候
				var iId = "${facadeBean.standIid}";
				if(!isNull(iId)){
					$('#standard').combobox('reload', standardUrl + "?v_id=" + $("#v_id").val() + "&p_id=" +  $("#p_id").val() + "&m_id=" + $("#m_id").val());
				}
				
				// 图谱类型
				if(!isNull("${partAtl}")){
					$("#partAtl").prop("checked",true);
				}
				if(!isNull("${materialAtl}")){
					$("#materialAtl").prop("checked",true);
				}
			});

			function save() {
				if(saving){
					return false;
				}
				saving = true;
				
				//试验类型
				var altType = getCheckboxVal("atlType");
				if(isNull(altType) || altType.length < 1){
					errorMsg("系统提示：请选择试验类型");
					saving = false;
					return false;
				}
				
				if(validChoose(altType, 1)){
					if(isNull($('#partsAtl_org').combotree('getValue'))){
						errorMsg("系统提示：请选择零件图谱委托实验室");
						$("#partsAtl_org").next('span').find('input').focus();
						saving = false;
						return false;
					}
				}else {
					if(isNull($('#matAtl_org').combotree('getValue'))){
						errorMsg("系统提示：请选择材料图谱委托实验室");
						$("#matAtl_org").next('span').find('input').focus();
						saving = false;
						return false;
					}
				}
				
				if(!isRequire("expectDate", "系统提示：期望完成时间必选")){ saving = false; return false; }
				
				// 抽样原因
				if(!isRequire("origin", "系统提示：样件来源必选")){ saving = false; return false; }
				if(!isRequire("reason", "系统提示：抽样原因必选")){ saving = false; return false; }
				if(!isRequire("source", "系统提示：费用出处必选")){ saving = false; return false; }
				
				if(validChoose(altType, 1)){
					if(!isRequire("p_proTime", "系统提示：样件生产日期必填")){ saving = false; return false; }
					
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
				if(!isRequire("m_proNo", "系统提示：材料批号必填")){ saving = false; return false; }
				
				var mNum = $("#m_num").textbox("getValue");
				if(!isNull(mNum) && isNaN(mNum)){
					saving = false;
					errorMsg("系统提示：提交失败，样品数量必须为整数");
					$("#m_num").next('span').find('input').focus();
					$("#m_num").textbox("setValue", "");
					return false;
				}
				
				var iId = $("#standard").combobox("getValue");
				if(isNull(iId)){
					errorMsg("系统提示：请选择基准任务");
					saving = false;
					return false;
				}
				$("#i_id").val(iId);
				
				// 权限信息
				var approveAccountId = $("#approveAccountId").val(); 
				if(isNull(approveAccountId)){
					errorMsg("系统提示：请选择审批人员");
					saving = false;
					return false;
				}
				
				$('#uploadForm').ajaxSubmit({
					url: "${ctx}/ppap/transmit",
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
					},
					error: function(data){
						console.log(data);
					}
				});
			}

			function vehicleInfo() {
				$('#vehicleDialog').dialog({
					title : '整车信息',
					width : 1000,
					height : 520,
					closed : false,
					cache : false,
					href : "${ctx}/vehicle/list",
					modal : true,
					onClose: function(){
						standardChange();
					}
				});
			}

			function materialInfo() {
				$('#materialDialog').dialog({
					title : '原材料信息',
					width : 1000,
					height : 520,
					closed : false,
					cache : false,
					href : "${ctx}/material/list",
					modal : true,
					onClose: function(){
						standardChange();
					}
				});
				$('#materialDialog').window('center');
			}

			function partsInfo() {
				$('#partsDialog').dialog({
					title : '零部件信息',
					width : 1000,
					height : 550,
					closed : false,
					cache : false,
					href : "${ctx}/parts/list",
					modal : true,
					onClose: function(){
						standardChange();
					}
				});
				$('#partsDialog').window('center');
			}
			
			
			function taskInfo() {
				$('#taskDialog').dialog({
					title : '任务信息',
					width : 1100,
					height : 600,
					closed : false,
					cache : false,
					href : "${ctx}/ppap/taskList",
					modal : true,
					top:100,
					onClose: function(){
						standardChange();
					}
				});
				
				// 移去滚动条
				window.parent.scrollY(450);
			}

			function standardChange() { 
				var v_id = $("#v_id").val();
				var p_id = $("#p_id").val();
				var m_id = $("#m_id").val();  
				
				if(!isNull(v_id) || !isNull(p_id) || !isNull(m_id)){
				    $('#standard').combobox('reload', standardUrl + "?v_id=" + $("#v_id").val() + "&p_id=" +  $("#p_id").val() + "&m_id=" + $("#m_id").val());
				}
			}

			// 格式化基准下拉框
			function formatItem(row) {
				var s = '<span style="font-weight:bold;color:black;">' + row.text + '</span><br/>' + '<span style="color:black;">任务号：'
						+ row.taskCode + '&nbsp;&nbsp;&nbsp;创建时间：' + row.date + '</span>';
				return s;
			}
			
			function doQuery(){
				var qCode = $("#qCode").textbox("getValue");
				if(isNull(qCode)){
					errorMsg("请输入任务号或选择任务号");
					return false;
				}
				
				$.ajax({
					url: "${ctx}/ppap/queryTask",
					data: {
						qCode: qCode
					},
					success: function(data){
						if(data.success){
							var vehicle = eval('(' + data.data.vehicle  + ')');;
							var parts = eval('(' + data.data.parts + ')');;
							var material = eval('(' + data.data.material + ')');;
							
							// 整车信息
							$("#v_code").textbox("setValue", vehicle.code);
							$("#v_proTime").datebox('setValue',formatDate(vehicle.proTime));
							$("#v_proAddr").textbox("setValue", vehicle.proAddr);
							$("#v_remark").textbox("setValue", vehicle.remark);
							$("#v_id").val(vehicle.id);
							
							// 零部件信息
							$("#p_name").textbox("setValue", parts.name);
							$("#p_code").textbox("setValue", parts.code);
							$("#p_producer").val(parts.producer);
							$("#p_producerCode").textbox("setValue", parts.producerCode);
							$("#p_proTime").datebox("setValue", formatDate(parts.proTime));
							$("#p_num").textbox("setValue", parts.num);
							$("#p_proNo").textbox("setValue", parts.proNo);
							$("#p_place").textbox("setValue", parts.place);
							$("#p_remark").textbox("setValue", parts.remark);	
							$("#p_id").val(parts.id);
							
							// 原材料信息
							$("#m_matName").textbox("setValue", material.matName);
							$("#m_proNo").textbox("setValue", material.proNo);
							$("#m_producer").val(material.producer);
							$("#m_matNo").textbox("setValue", material.matNo);
							$("#m_matColor").textbox("setValue", material.matColor);
							$("#m_remark").textbox("setValue", material.remark);
							$("#m_num").textbox("setValue", material.num);
							$("#m_id").val(material.id);
							
							standardChange();
						}else{
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
					href : "${ctx}/ppap/userList?type=" + type,
					modal : true
				});
				
				// 移去滚动条
				window.parent.parent.scrollY(430);
			}
		</script>
	
</body>

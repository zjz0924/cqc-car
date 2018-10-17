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
	
		<c:if test="${taskType == 1}">
			<div style="margin-left: 10px;margin-top:20px;">
				<div class="title">零部件信息&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="partsInfo()"><i class="icon icon-search"></i></a>&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="addParts()" title="清空"><i class="icon icon-edit"></i></a>
				</div>
				
				<table class="info">
					<tr>
						<td>
							<span class="title-span">零件号：</span> 
							<input id="p_code" name="p_code" class="easyui-textbox" value="${facadeBean.info.parts.code }" style="width:150px;">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>零件名：</span> 
							<input id="p_name" name="p_name" class="easyui-textbox" value="${facadeBean.info.parts.name }" style="width:150px;">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>供应商：</span> 
							<input id="p_producer" name="p_producer" type="text" value="${facadeBean.info.parts.producer }" class="inputAutocomple" >
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>供应商代码：</span> 
							<input id="p_producerCode" name="p_producerCode" type="text" value="${facadeBean.info.parts.producerCode }" class="inputAutocomple" >
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span">生产批号：</span> 
							<input id="p_proNo" name="p_proNo" class="easyui-textbox" value="${facadeBean.info.parts.proNo }"  style="width:150px;">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>生产日期：</span> 
							<input id="p_proTime" name="p_proTime" type="text" class="easyui-datebox" data-options="editable:false" value="<fmt:formatDate value='${facadeBean.info.parts.proTime }' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>"  style="width:150px;">
						</td>
						<td>
							<span class="title-span">生产场地：</span> 
							<input id="p_place" name="p_place" class="easyui-textbox" value="${facadeBean.info.parts.place }"  style="width:150px;">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>关键零件：</span> 
							<select id="p_isKey" name="p_isKey" style="width:160px;" class="easyui-combobox" data-options="panelHeight: 'auto', onChange: function(n, o){isKeyChange()}">
								<option value="0" <c:if test="${facadeBean.info.parts.isKey == 0 }">selected="selected"</c:if>>否</option>
								<option value="1" <c:if test="${facadeBean.info.parts.isKey == 1 }">selected="selected"</c:if>>是</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span"><span class="req-span" id="keyCode_req" style="display:none;">*</span>零件型号：</span> 
							<input id="p_keyCode" name="p_keyCode" class="easyui-textbox" value="${facadeBean.info.parts.keyCode }" style="width:150px;">
						</td>
						<td>
							<span class="title-span">联系人：</span> 
							<input id="p_contacts" name="p_contacts" class="easyui-textbox" value="${facadeBean.info.parts.contacts }" style="width:150px;">
						</td>
						<td>
							<span class="title-span">联系电话：</span> 
							<input id="p_phone" name="p_phone" class="easyui-textbox" value="${facadeBean.info.parts.phone }"  style="width:150px;">
						</td>
						<td>
							<span class="title-span">&nbsp;备注：</span> 
							<input id="p_remark" name="p_remark" class="easyui-textbox" value="${facadeBean.info.parts.remark }" style="width:150px;">	
						</td>
					</tr>
				</table>
			</div>
		</c:if>
	
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
						<span class="title-span"><span class="req-span">*</span>生产批号：</span> 
						<input id="m_proNo" name="m_proNo" class="easyui-textbox" value="${facadeBean.info.material.proNo }" style="width:150px;">
					</td>
					<td>
						<span class="title-span"><span class="req-span">*</span>生产商：</span> 
						<input id="m_producer" name="m_producer" type="text"  value="${facadeBean.info.material.producer }" class="inputAutocomple">
					</td>
					<td>
						<span class="title-span"><span class="req-span">*</span>材料牌号：</span> 
						<input id="m_matNo" name="m_matNo" class="easyui-textbox" value="${facadeBean.info.material.matNo }" style="width:150px;">
					</td>
				</tr>
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>材料颜色：</span> 
						<input id="m_matColor" name="m_matColor" class="easyui-textbox" value="${facadeBean.info.material.matColor }" style="width:150px;">
					</td>
					
					<td>
						<span class="title-span">联系人：</span> 
						<input id="m_contacts" name="m_contacts" class="easyui-textbox" value="${facadeBean.info.material.contacts }" style="width:150px;">	
					</td>
					
					<td>
						<span class="title-span">联系电话：</span> 
						<input id="m_phone" name="m_phone" class="easyui-textbox" value="${facadeBean.info.material.phone }" style="width:150px;">	
					</td>
					
					<td>
						<span class="title-span">备注：</span> 
						<input id="m_remark" name="m_remark" class="easyui-textbox" value="${facadeBean.info.material.remark }" style="width:150px;">	
					</td>
				</tr>
				
				<tr>
					<td>
						<span class="title-span">成分表：</span> 
						<input id="m_pic" name="m_pic" class="easyui-filebox" style="width:150px" data-options="buttonText: '选择'">
					</td>
					
					<c:if test="${ not empty facadeBean.info.material.pic}">
						<td>
							<span class="title-span">成分表：</span>
							<span>
								<a target="_blank" href="${resUrl}/${facadeBean.info.material.pic}">${fn:substringAfter(facadeBean.info.material.pic, "/")}</a>
							</span> 
						</td>
					</c:if>
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
					animate: true
				});
				
				// 只能选择子节点
				var mOrgTree = $('#applicatOrg').combotree('tree');	
				mOrgTree.tree({
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
				if(!isRequire("atlType", "基准图谱类型必选")){ saving = false; return false; }
				
				// 整车信息
				if(!isRequire("v_code", "车型代码必选")){ saving = false; return false; }
				//if(!isRequire("v_proTime", "整车生产日期必填")){ saving = false; return false; }
				if(!isRequire("v_proAddr", "整车生产基地必选")){ saving = false; return false; }
				
				// 零部件信息
				var taskType = "${taskType}";
				if(taskType == 1){
					//if(!isRequire("p_code", "零件号必填")){ saving = false; return false; }
					if(!isRequire("p_name", "零部件名称必填")){ saving = false; return false; }
					//if(!isRequire("p_orgId", "零部件生产商必填")){ saving = false; return false; }
					if(!isRequire("p_producer", "零部件生产商必填")){ saving = false; return false; }
					if(!isRequire("p_producerCode", "零部件生产商代码必填")){ saving = false; return false; }
					if(!isRequire("p_proTime", "零部件生产日期必填")){ saving = false; return false; }
					//if(!isRequire("p_place", "零部件生产场地必填")){ saving = false; return false; }
					//if(!isRequire("p_proNo", "零部件生产批号必填")){ saving = false; return false; }
					var isKey = $("#p_isKey").val();
					if(isKey == 1){
						if(!isRequire("p_keyCode", "零件型号必填")){ saving = false; return false; }
					}
					//if(!isRequire("p_contacts", "零部件联系人必填")){ saving = false; return false; }
					//if(!isRequire("p_phone", "零部件联系电话必填")){ saving = false; return false; }
					
					var p_phone = $("#p_phone").val();
					if (!isNull(p_phone)) {
						if (!(/^[1][3,4,5,7,8][0-9]{9}$/.test(p_phone))) {
							errorMsg("零部件联系电话格式不正确");
							$("#p_phone").next('span').find('input').focus();
							saving = false; 
							return false;
						}
					}
				}
				
				// 原材料信息
				if(!isRequire("m_matName", "原材料名称必填")){ saving = false; return false; }
				if(!isRequire("m_proNo", "原材料生产批号必填")){ saving = false; return false; }
				//if(!isRequire("m_orgId", "材料生产商必填")){ saving = false; return false; }
				if(!isRequire("m_producer", "材料生产商必填")){ saving = false; return false; }
				if(!isRequire("m_matNo", "原材料材料牌号必填")){ saving = false; return false; }
				if(!isRequire("m_matColor", "原材料材料颜色必填")){ saving = false; return false; }
				
				//if(!isRequire("m_contacts", "原材料联系人必填")){ saving = false; return false; }
				//if(!isRequire("m_phone", "原材料联系电话必填")){ saving = false; return false; }
				
				var m_phone = $("#m_phone").val();
				if (!isNull(m_phone)) {
					if (!(/^[1][3,4,5,7,8][0-9]{9}$/.test(m_phone))) {
						errorMsg("原材料联系电话格式不正确");
						$("#m_phone").next('span').find('input').focus();
						saving = false; 
						return false;
					}
				}
				
				$("#draft").val(isDraft);
				
				$('#uploadForm').ajaxSubmit({
					url: "${ctx}/ots/save",
					dataType : 'text',
					success:function(msg){
						var data = eval('(' + msg + ')');
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
				$("#v_code").textbox("setValue", "");
				$("#v_type").textbox("setValue", "");
				$("#v_proTime").datebox('setValue', "");
				$("#v_proAddr").textbox("setValue", "");
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
				$("#p_keyCode").textbox("setValue", "");
				$("#p_phone").textbox("setValue", "");
				$("#p_contacts").textbox("setValue", "");
				$("#p_isKey").combobox('select', 0);
				$("#p_producer").textbox('setValue', ""); 
				$("#p_id").val("");
			}
			
			// 新增原材料信息
			function addMaterial(){
				$("#m_matName").textbox("setValue", "");
				$("#m_proNo").textbox("setValue", "");
				$("#m_producer").val("");
				$("#m_matNo").textbox("setValue", "");
				$("#m_matColor").textbox("setValue", "");
				$("#m_contacts").textbox("setValue", "");
				$("#m_phone").textbox("setValue", "");
				$("#m_remark").textbox("setValue", "");
				$("#m_pic").filebox("clear");
			}
			
			function isKeyChange(){
				var isKey = $("#p_isKey").combobox('getValue');
				
				if(isKey == 0){
					$("#keyCode_req").hide();
				}else{
					$("#keyCode_req").show();
				}
			}
		</script>
	
</body>

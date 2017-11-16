<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<form method="POST" enctype="multipart/form-data" id="uploadForm">
		<input type="hidden" id="t_id" name="t_id" value="${facadeBean.id }">
		<input type="hidden" id="v_id" name="v_id" value="${facadeBean.info.vehicle.id}">
		<input type="hidden" id="p_id" name="p_id" value="${facadeBean.info.parts.id }">
		<input type="hidden" id="m_id" name="m_id" value="${facadeBean.info.material.id }">
	
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
		
			<div class="title">整车信息&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="vehicleInfo()" title="检索"><i class="icon icon-search"></i></a>
			</div>
			
			<table class="info">
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>代码：</span> 
						<input id="v_code" name="v_code" class="easyui-textbox" value="${facadeBean.info.vehicle.code }" disabled style="width:150px;">
					</td>
					<td>
						<span class="title-span"><span class="req-span">*</span>车型：</span> 
						<input id="v_type" name="v_type" class="easyui-textbox" value="${facadeBean.info.vehicle.type }" disabled style="width:150px;">
					</td>
					<td>
						<span class="title-span"><span class="req-span">*</span>生产日期：</span> 
						<input id="v_proTime" name="v_proTime" type="text" class="easyui-datebox" data-options="editable:false " value="<fmt:formatDate value='${facadeBean.info.vehicle.proTime }' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>" disabled style="width:150px;">
					</td>
					<td>
						<span class="title-span"><span class="req-span">*</span>生产地址：</span> 
						<input id="v_proAddr" name="v_proAddr" class="easyui-textbox" value="${facadeBean.info.vehicle.proAddr }" disabled style="width:150px;">
					</td>
				</tr>
				<tr>
					<td>
						<span class="title-span">&nbsp;备注：</span> 
						<input id="v_remark" name="v_remark" class="easyui-textbox" value="${facadeBean.info.vehicle.remark }" disabled style="width:150px;">	
					</td>
				</tr>
			</table>
		</div>
	
		<div style="margin-left: 10px;margin-top:20px;">
			<div class="title">零部件信息&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="partsInfo()"><i class="icon icon-search"></i></a>
			</div>
			
			<table class="info">
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>零件号：</span> 
						<input id="p_code" name="p_code" class="easyui-textbox" value="${facadeBean.info.parts.code }" disabled style="width:150px;">
					</td>
					<td>
						<span class="title-span"><span class="req-span">*</span>名称：</span> 
						<input id="p_name" name="p_name" class="easyui-textbox" value="${facadeBean.info.parts.name }" disabled style="width:150px;">
					</td>
					<td>
						<span class="title-span"><span class="req-span">*</span>生产商：</span> 
						<input id="p_orgName" name="p_orgName" class="easyui-textbox" value="${facadeBean.info.parts.org.name}" disabled style="width:150px;">
					</td>
					<td>
						<span class="title-span"><span class="req-span">*</span>生产批号：</span> 
						<input id="p_proNo" name="p_proNo" class="easyui-textbox" value="${facadeBean.info.parts.proNo }" disabled style="width:150px;">
					</td>
				</tr>
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>生产日期：</span> 
						<input id="p_proTime" name="p_proTime" type="text" class="easyui-datebox" data-options="editable:false" value="<fmt:formatDate value='${facadeBean.info.parts.proTime }' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>" disabled style="width:150px;">
					</td>
					<td>
						<span class="title-span"><span class="req-span">*</span>生产场地：</span> 
						<input id="p_place" name="p_place" class="easyui-textbox" value="${facadeBean.info.parts.place }" disabled style="width:150px;">
					</td>
					<td>
						<span class="title-span"><span class="req-span">*</span>关键零件：</span> 
						<select id="p_isKey" name="p_isKey" style="width:150px;" class="easyui-combobox" data-options="panelHeight: 'auto'" disabled>
							<option value="0" <c:if test="${facadeBean.info.parts.isKey == 0 }">selected="selected"</c:if>>否</option>
							<option value="1" <c:if test="${facadeBean.info.parts.isKey == 1 }">selected="selected"</c:if>>是</option>
						</select>
					</td>
					<td>
						<span class="title-span">零件型号：</span> 
						<input id="p_keyCode" name="p_keyCode" class="easyui-textbox" value="${facadeBean.info.parts.keyCode }" disabled style="width:150px;">
					</td>
				</tr>
				<tr>
					<td>
						<span class="title-span">&nbsp;备注：</span> 
						<input id="p_remark" name="p_remark" class="easyui-textbox" value="${facadeBean.info.parts.remark }" disabled style="width:150px;">	
					</td>
				</tr>
			</table>
		</div>
	
		<div style="margin-left: 10px;margin-top:20px;">
			<div class="title">原材料信息
				<a href="javascript:void(0)" onclick="materialInfo()"><i class="icon icon-search"></i></a>
			</div>
			
			<table class="info">
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>材料名称：</span> 
						<input id="m_matName" name="m_matName" class="easyui-textbox" value="${facadeBean.info.material.matName }" disabled style="width:150px;">
					</td>
					<td>
						<span class="title-span"><span class="req-span">*</span>生产批号：</span> 
						<input id="m_proNo" name="m_proNo" class="easyui-textbox" value="${facadeBean.info.material.proNo }" disabled style="width:150px;">
					</td>
					<td>
						<span class="title-span"><span class="req-span">*</span>生产商：</span> 
						<input id="m_orgName" name="m_orgName" class="easyui-textbox" value="${facadeBean.info.material.org.name}" disabled style="width:150px;">
					</td>
					<td>
						<span class="title-span"><span class="req-span">*</span>材料牌号：</span> 
						<input id="m_matNo" name="m_matNo" class="easyui-textbox" value="${facadeBean.info.material.matNo }" disabled style="width:150px;">
					</td>
				</tr>
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>材料颜色：</span> 
						<input id="m_matColor" name="m_matColor" class="easyui-textbox" value="${facadeBean.info.material.matColor }" disabled style="width:150px;">
					</td>
					<td>
						<span class="title-span"><span class="req-span">*</span>成分表：</span> 
						<span id="m_pic_span" <c:if test="${empty facadeBean.info.material.pic}">style="display:none;"</c:if>>	
							<a id="m_pic_a" target="_blank" href="${resUrl}/${facadeBean.info.material.pic}">${fn:substringAfter(facadeBean.info.material.pic, "/")}</a>
						</span>
						
					</td>
					
					<td>
						<span class="title-span">备注：</span> 
						<input id="m_remark" name="m_remark" class="easyui-textbox" value="${facadeBean.info.material.remark }" disabled style="width:150px;">	
					</td>
				</tr>
			</table>
		</div>

		<div style="margin-left: 10px; margin-top: 20px;">
			<div class="title">选择基准</div>
			<div style="margin-left: 20px;"><input id="standard" name="standard" style="width: 370px"></div>
		</div>

		<div style="margin-left: 10px;margin-top:20px;">
			<div class="title">下达实验室</div>
			<div>
				<span class="title-span" style="width: 120px">零部件图谱试验：</span>
				<input id="partsAtlId" name="partsAtlId">
			</div>
		
			<div style="margin-top:5px;">
				<span class="title-span" style="width: 120px">原材料图谱试验： </span>
				<input id="matAtlId" name="matAtlId">
			</div>
			
			<%-- <c:if test="${empty facadeBean.partsPatId}">
				<div style="margin-top:5px;">
					<span class="title-span" style="width: 120px">零部件型式试验： </span>
					<input id="partsPatId" name="partsPatId">
				</div>
			</c:if>
			
			<c:if test="${empty facadeBean.matPatId}">
				<div style="margin-top:5px;">
					<span class="title-span" style="width: 120px">原材料型式试验： </span>
					<input id="matPatId" name="matPatId">
				</div>
			</c:if> --%>
		</div>
	
		 <div style="text-align:center;margin-top:35px;" class="data-row">
			<a href="javascript:void(0);"  onclick="save()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">提交</a>
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
		</style>
		
		<script type="text/javascript">
			var standardUrl = '${ctx}/ppap/standard';
			// 是否提交中
			var saving = false;
			
			$(function(){
				// 基准选择
				$("#standard").combobox({
					url : standardUrl,
					valueField : 'id',
					textField : 'text',
					formatter : formatItem,
					onLoadSuccess:function(){ //默认选中第一条数据
				        var data= $(this).combobox("getData");
					    //默认选中第一个
		                if (data.length > 0) {
		                	if(!isNull("${facadeBean.iId}")){
		                		$(this).combobox('select', "${facadeBean.iId}");
		                	}else{
		                		$(this).combobox('select', data[0].id);
		                	}
		                }else{
		                	$(this).combobox('select', '');
		                }
					}
				});

				// 编辑的时候
				var iId = "${facadeBean.iId}";
				if(!isNull(iId)){
					$('#standard').combobox('reload', standardUrl + "?v_id=" + $("#v_id").val() + "&p_id=" +  $("#p_id").val() + "&m_id=" + $("#m_id").val());
				}
				
				
				// 零部件图谱
				$('#partsAtlId').combotree({
					url : '${ctx}/org/getTreeByType?type=3',
					multiple : false,
					animate : true,
					width : '250px'
				});

				// 只有最底层才能选择
				var partsAtlIdTree = $('#partsAtlId').combotree('tree');
				partsAtlIdTree.tree({
					onBeforeSelect : function(node) {
						if (isNull(node.children)) {
							return true;
						} else {
							return false;
						}
					}
				});

				// 原材料图谱
				$('#matAtlId').combotree({
					url : '${ctx}/org/getTreeByType?type=3',
					multiple : false,
					animate : true,
					width : '250px'
				});

				// 只有最底层才能选择
				var matAtlIdTree = $('#matAtlId').combotree('tree');
				matAtlIdTree.tree({
					onBeforeSelect : function(node) {
						if (isNull(node.children)) {
							return true;
						} else {
							return false;
						}
					}
				});

				// 默认选中CQC实验室
				$("#partsAtlId").combotree("setValue", "20");
				$("#matAtlId").combotree("setValue", "20");
			});

			function save() {
				if(saving){
					return false;
				}
				saving = true;
				
				var t_id = $("#t_id").val();
				var v_id = $("#v_id").val();
				var p_id = $("#p_id").val();
				var m_id = $("#m_id").val();

				if (isNull(v_id)) {
					errorMsg("请选择整车信息");
					saving = false;
					return false;
				}

				if (isNull(p_id)) {
					errorMsg("请选择零部件信息");
					saving = false;
					return false;
				}

				if (isNull(m_id)) {
					errorMsg("请选择原材料信息");
					saving = false;
					return false;
				}
				
				var iId = $("#standard").combobox("getValue");
				if(isNull(iId)){
					errorMsg("请选择基准");
					saving = false;
					return false;
				}

				var partsAtlId_val = $("#partsAtlId").combotree("getValue");
				var matAtlId_val = $("#matAtlId").combotree("getValue");

				$.ajax({
					url : "${ctx}/ppap/transmit",
					data : {
						"t_id" : t_id,
						"i_id" : iId,
						"partsAtlId" : partsAtlId_val,
						"matAtlId" : matAtlId_val,
						"taskType": "${taskType}"
					},
					success : function(data) {
						saving = false;
						if (data.success) {
							tipMsg(data.msg, function() {
								window.location.reload();
							});
						} else {
							errorMsg(data.msg);
						}
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

			function standardChange() { 
				var v_id = $("#v_id").val();
				var p_id = $("#p_id").val();
				var m_id = $("#m_id").val();  
				
				if(!isNull(v_id) && !isNull(p_id) && !isNull(m_id)){
				    $('#standard').combobox('reload', standardUrl + "?v_id=" + $("#v_id").val() + "&p_id=" +  $("#p_id").val() + "&m_id=" + $("#m_id").val());
				}
			}

			// 格式化基准下拉框
			function formatItem(row) {
				var s = '<span style="font-weight:bold">' + row.text + '</span><br/>' + '<span style="color:#888">任务号：'
						+ row.taskCode + '&nbsp;&nbsp;&nbsp;创建时间：' + row.date + '</span>';
				return s;
			}
		</script>
	
</body>

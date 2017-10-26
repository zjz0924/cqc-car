<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<html>
	<head>
		<meta charset="utf-8">
		<title>SGMW</title>
		<%@include file="../../common/source.jsp"%>
		<script src="${ctx}/resources/js/jquery.form.js"></script>
		
		<style type="text/css">
			.title-span{
				display: inline-block;
				width: 95px;
				padding-right: 15px;
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
			$(function(){
				$('#p_orgId').combotree({
					url: '${ctx}/org/getTreeByType?type=2',
					multiple: false,
					animate: true,
					width: '163px'
				});
				
				// 只有最底层才能选择
				var pOrgTree = $('#p_orgId').combotree('tree');	
				pOrgTree.tree({
				   onBeforeSelect: function(node){
					   if(isNull(node.children)){
							return true;
					   }else{
						   return false;
					   }
				   }
				});
				
				$('#m_orgId').combotree({
					url: '${ctx}/org/getTreeByType?type=2',
					multiple: false,
					animate: true,
					width: '163px'
				});
				
				// 只有最底层才能选择
				var mOrgTree = $('#m_orgId').combotree('tree');	
				mOrgTree.tree({
				   onBeforeSelect: function(node){
					   if(isNull(node.children)){
							return true;
					   }else{
						   return false;
					   }
				   }
				});
			});
		
			function save(){
				// 整车信息
				if(!isRequire("v_code", "整车代码必填")){ return false; }
				if(!isRequire("v_type", "车型必填")){ return false; }
				if(!isRequire("v_proTime", "整车生产日期必填")){ return false; }
				if(!isRequire("v_proAddr", "整车生产地址必填")){ return false; }
				
				// 零部件信息
				if(!isRequire("p_code", "零部号必填")){ return false; }
				if(!isRequire("p_name", "零部件名称必填")){ return false; }
				if(!isRequire("p_orgId", "零部件生产商必填")){ return false; }
				if(!isRequire("p_proTime", "零部件生产日期必填")){ return false; }
				if(!isRequire("p_place", "零部件生产场地必填")){ return false; }
				if(!isRequire("p_proNo", "零部件生产批号必填")){ return false; }
				var isKey = $("#p_isKey").val();
				if(isKey == 1){
					if(!isRequire("p_keyCode", "零件型号必填")){ return false; }
				}
				
				
				// 原材料信息
				if(!isRequire("m_matName", "原材料名称必填")){ return false; }
				if(!isRequire("m_proNo", "原材料生产批号必填")){ return false; }
				if(!isRequire("m_matProducer", "材料生产商必填")){ return false; }
				if(!isRequire("m_producerAdd", "原材料生产商地址必填")){ return false; }
				if(!isRequire("m_matNo", "原材料材料牌号必填")){ return false; }
				if(!isRequire("m_matColor", "原材料材料颜色必填")){ return false; }
				
				var fileDir = $("#m_pic").filebox("getValue");
				if (!isNull(fileDir)) {
					var suffix = fileDir.substr(fileDir.lastIndexOf("."));
					if (".jpg" != suffix && ".png" != suffix && ".jpeg" != suffix && ".gif" != suffix) {
						errMsg("请选择图片格式文件导入！");
						$("#m_pic").focus();
						return false;
					}
				}
				
				$('#uploadForm').ajaxSubmit({
					url: "${ctx}/ots/save?time=" + new Date(),
					dataType : 'text',
					success:function(msg){
						var data = eval('(' + msg + ')');
						if(data.success){
							tipMsg(data.msg, function(){
								window.location.reload();
							});
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
			}
			
			// 新增整车信息
			function addVehicle(){
				$('#v_code').textbox('enable'); 
				$('#v_type').textbox('enable'); 
				$('#v_proTime').datebox('enable');
				$('#v_proAddr').textbox('enable'); 
				$('#v_remark').textbox('enable'); 
				
				$("#v_code").textbox("setValue", "");
				$("#v_type").textbox("setValue", "");
				$("#v_proTime").datebox('setValue', "");
				$("#v_proAddr").textbox("setValue", "");
				$("#v_remark").textbox("setValue", "");
				$("#v_id").val("");
			}
			
			// 新增整车信息
			function addParts(){
				$('#p_code').textbox('enable'); 
				$('#p_name').textbox('enable'); 
				$('#p_proTime').datebox('enable');
				$('#p_place').textbox('enable'); 
				$('#p_proNo').textbox('enable'); 
				$('#p_remark').textbox('enable'); 
				$('#p_keyCode').textbox('enable'); 
				$("#p_isKey").combobox('enable');
				$("#p_orgId").combotree('enable'); 
				
				$("#p_code").textbox("setValue", "");
				$("#p_name").textbox("setValue", "");
				$("#p_proTime").datebox('setValue', "");
				$("#p_place").textbox("setValue", "");
				$("#p_proNo").textbox("setValue", "");
				$("#p_remark").textbox("setValue", "");
				$("#p_keyCode").textbox("setValue", "");
				$("#p_isKey").combobox('select', 0);
				$("#p_orgId").combotree("setValue","");
				$("#p_id").val("");
			}
		</script>
	</head>
	
	<body>
		<form method="POST" enctype="multipart/form-data" id="uploadForm">
			<div style="margin-left: 10px;margin-top:20px;">
				<div class="title">整车信息&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="vehicleInfo()" title="检索"><i class="icon icon-search"></i></a>&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="addVehicle()" title="新增"><i class="icon icon-edit"></i></a>
				</div>
				<input type="hidden" id="v_id" name="v_id">
				<table class="info">
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>代码：</span> 
							<input id="v_code" name="v_code" class="easyui-textbox">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>车型：</span> 
							<input id="v_type" name="v_type" class="easyui-textbox">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>生产日期：</span> 
							<input id="v_proTime" name="v_proTime" type="text" class="easyui-datebox" data-options="editable:false ">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>生产地址：</span> 
							<input id="v_proAddr" name="v_proAddr" class="easyui-textbox">
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span">&nbsp;备注：</span> 
							<input id="v_remark" name="v_remark" class="easyui-textbox">	
						</td>
					</tr>
				</table>
			</div>
		
			<div style="margin-left: 10px;margin-top:20px;">
				<div class="title">零部件信息&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="partsInfo()"><i class="icon icon-search"></i></a>&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="addParts()" title="新增"><i class="icon icon-edit"></i></a>
				</div>
				<input type="hidden" id="p_id" name="p_id">
				<table class="info">
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>零件号：</span> 
							<input id="p_code" name="p_code" class="easyui-textbox">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>名称：</span> 
							<input id="p_name" name="p_name" class="easyui-textbox">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>生产商：</span> 
							<input id="p_orgId" name="p_orgId">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>生产批号：</span> 
							<input id="p_proNo" name="p_proNo" class="easyui-textbox">
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>生产日期：</span> 
							<input id="p_proTime" name="p_proTime" type="text" class="easyui-datebox" data-options="editable:false">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>生产场地：</span> 
							<input id="p_place" name="p_place" class="easyui-textbox">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>关键零件：</span> 
							<select id="p_isKey" name="p_isKey" style="width:163px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
								<option value="0">否</option>
								<option value="1">是</option>
							</select>
						</td>
						<td>
							<span class="title-span">零件型号：</span> 
							<input id="p_keyCode" name="p_keyCode" class="easyui-textbox">
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span">&nbsp;备注：</span> 
							<input id="p_remark" name="p_remark" class="easyui-textbox">	
						</td>
					</tr>
				</table>
			</div>
		
			<div style="margin-left: 10px;margin-top:20px;">
				<div class="title">原材料信息
					<!--  &nbsp;&nbsp;<a href="javascript:void(0)" onclick="materialInfo()"><i class="icon icon-search"></i></a> -->
				</div>
				
				<table class="info">
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>材料名称：</span> 
							<input id="m_matName" name="m_matName" class="easyui-textbox">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>生产批号：</span> 
							<input id="m_proNo" name="m_proNo" class="easyui-textbox">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>材料生产商：</span> 
							<input id="m_orgId" name="m_orgId">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>材料牌号：</span> 
							<input id="m_matNo" name="m_matNo" class="easyui-textbox">
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>材料颜色：</span> 
							<input id="m_matColor" name="m_matColor" class="easyui-textbox">
						</td>
						<td>
							<span class="title-span">材料成分表：</span> 
							<input id="m_pic" name="m_pic" class="easyui-filebox" style="width:171px" data-options="buttonText: '选择'">
						</td>
						<td>
							<span class="title-span">备注：</span> 
							<input id="m_remark" name="m_remark" class="easyui-textbox">	
						</td>
					</tr>
				</table>
			</div>
		
			 <div style="text-align:center;margin-top:35px;" class="data-row">
				<a href="javascript:void(0);"  onclick="save()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
				<span id="exception_error" class="error-message"></span>
			</div>
		</form>
		
		<div id="vehicleDialog"></div>
		<div id="materialDialog"></div>
		<div id="partsDialog"></div>
	</body>
</html>
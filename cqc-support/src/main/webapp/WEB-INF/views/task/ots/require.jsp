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
			function save(){
				// 整车信息
				if(!isRequire("v_code", "整车代码必填")){ return false; }
				if(!isRequire("v_type", "车型必填")){ return false; }
				if(!isRequire("v_proTime", "整车生产日期必填")){ return false; }
				if(!isRequire("v_proAddr", "整车生产地址必填")){ return false; }
				
				// 零部件信息
				if(!isRequire("p_code", "零部件代码必填")){ return false; }
				if(!isRequire("p_name", "零部件名称必填")){ return false; }
				if(!isRequire("p_producer", "零部件生产商必填")){ return false; }
				if(!isRequire("p_proTime", "零部件生产日期必填")){ return false; }
				if(!isRequire("p_place", "零部件生产场地必填")){ return false; }
				if(!isRequire("p_proNo", "零部件生产批号必填")){ return false; }
				if(!isRequire("p_technology", "零部件生产工艺必填")){ return false; }
				if(!isRequire("p_matName", "零部件材料名称必填")){ return false; }
				if(!isRequire("p_matNo", "零部件材料牌号必填")){ return false; }
				if(!isRequire("p_matColor", "零部件材料颜色必填")){ return false; }
				if(!isRequire("p_matProducer", "零部件生产商必填")){ return false; }
				
				var fileDir = $("#p_pic").filebox("getValue");
				if (!isNull(fileDir)) {
					var suffix = fileDir.substr(fileDir.lastIndexOf("."));
					if (".jpg" != suffix && ".png" != suffix && ".jpeg" != suffix && ".gif" != suffix) {
						errMsg("请选择图片格式文件导入！");
						$("#p_pic").focus();
						return false;
					}
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
		</script>
	</head>
	
	<body>
		<form method="POST" enctype="multipart/form-data" id="uploadForm">
			<div style="margin-left: 10px;margin-top:20px;">
				<div class="title">检索整车信息&nbsp;&nbsp;<a href="javascript:void(0)" onclick="vehicleInfo()"><i class="icon icon-search"></i></a></div>
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
				<div class="title">检索零部件信息&nbsp;&nbsp;<a href="javascript:void(0)" onclick="partsInfo()"><i class="icon icon-search"></i></a></div>
				<table class="info">
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>代码：</span> 
							<input id="p_code" name="p_code" class="easyui-textbox">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>名称：</span> 
							<input id="p_name" name="p_name" class="easyui-textbox">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>生产商：</span> 
							<input id="p_producer" name="p_producer" class="easyui-textbox">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>生产日期：</span> 
							<input id="p_proTime" name="p_proTime" type="text" class="easyui-datebox" data-options="editable:false">
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>生产场地：</span> 
							<input id="p_place" name="p_place" class="easyui-textbox">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>生产批号：</span> 
							<input id="p_proNo" name="p_proNo" class="easyui-textbox">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>生产工艺：</span> 
							<input id="p_technology" name="p_technology" class="easyui-textbox">
						</td>
						<td>	
							<span class="title-span">图片：</span> 
							<input id="p_pic" name="p_pic" class="easyui-filebox" style="width:171px" data-options="buttonText: '选择'">
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>材料名称：</span> 
							<input id="p_matName" name="p_matName" class="easyui-textbox">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>材料牌号：</span> 
							<input id="p_matNo" name="p_matNo" class="easyui-textbox">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>材料颜色：</span> 
							<input id="p_matColor" name="p_matColor" class="easyui-textbox">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>材料生产商：</span> 
							<input id="p_matProducer" name="p_matProducer" class="easyui-textbox">
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
				<div class="title">检索原材料信息&nbsp;&nbsp;<a href="javascript:void(0)" onclick="materialInfo()"><i class="icon icon-search"></i></a></div>
				
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
							<input id="m_matProducer" name="m_matProducer" class="easyui-textbox">
						</td>
						<td>
							<span class="title-span"><span class="req-span">*</span>生产商地址：</span> 
							<input id="m_producerAdd" name="m_producerAdd" class="easyui-textbox">
						</td>
					</tr>
					<tr>
						<td>
							<span class="title-span"><span class="req-span">*</span>材料牌号：</span> 
							<input id="m_matNo" name="m_matNo" class="easyui-textbox">
						</td>
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
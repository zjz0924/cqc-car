<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<form method="POST" enctype="multipart/form-data" id="dataForm">
	
	<input type="hidden" id="t_id" name="t_id" value="${facadeBean.id }">
	<input type="hidden" id="taskType" name="taskType" value="${taskType }">
	<input type="hidden" id="v_id" name="v_id" value="${facadeBean.info.vehicle.id}">
	<input type="hidden" id="p_id" name="p_id" value="${facadeBean.info.parts.id }">
	<input type="hidden" id="m_id" name="m_id" value="${facadeBean.info.material.id }">
	<input type="hidden" id="result" name="result">
	<input type="hidden" id="examine_remark" name="examine_remark">
	<input type="hidden" id="applicat_id" name="applicat_id" value="${facadeBean.applicat.id }">
	
	<!-- 申请人信息 -->
	<div style="margin-top:20px;">
		<div class="title">申请人信息</div>
		<table class="info">
			<tr>
				<td>
					<span class="title-span"><span class="req-span">*</span>申请人：</span> 
					<input class="easyui-textbox" value="${facadeBean.applicat.nickName}" disabled style="width:150px;">
				</td>
				<td>
					<span class="title-span"><span class="req-span">*</span>科室：</span> 
					<input class="easyui-textbox" value="${facadeBean.applicat.department }" disabled style="width:150px;">
				</td>
				<td>
					<span class="title-span"><span class="req-span">*</span>机构/单位：</span> 
					<input class="easyui-textbox" value="${facadeBean.applicat.org.name }" disabled style="width:150px;">
				</td>
				<td>
					<span class="title-span"><span class="req-span">*</span>联系方式：</span> 
					<input class="easyui-textbox" value="${facadeBean.applicat.mobile }" disabled  style="width:150px;">
				</td>
			</tr>
			<tr>
				<td>
					<span class="title-span">备注：</span> 
					<input class="easyui-textbox" disabled value="${facadeBean.applicat.remark }"  style="width:150px;">
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
					<span class="title-span"><span class="req-span">*</span>类型：</span> 
					<input type="checkbox" id="partAtl" name="atlType" value="1">零件基准图谱&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox" id="materialAtl" name="atlType" value="2">材料基准图谱
				</td>
				<td>
					<span class="title-span">备注：</span> 
					<input id="atlRemark" name="atlRemark" class="easyui-textbox" value="${facadeBean.atlRemark }" style="width:150px;">
				</td>
			</tr>
		</table>
	</div>
	
	<!-- 整车信息 -->
	<div style="margin-left: 10px;margin-top:20px;">
		<div class="title">整车信息</div>
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
		<div class="title">零部件信息</div>
		
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
		<div class="title">原材料信息</div>
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
	</form>
	
	<div style="text-align:center;margin-top:25px;margin-bottom: 15px;" class="data-row">
		<a href="javascript:void(0);"  onclick="examine(${facadeBean.id}, 1, '')" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">通过</a>&nbsp;&nbsp;
		<a href="javascript:void(0);"  onclick="notPass()" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">不通过</a>
	</div>

	<div id="dlg" class="easyui-dialog" title="审核不通过" style="width: 400px; height: 200px; padding: 10px" closed="true" data-options="modal:true">
		<input id="remark" class="easyui-textbox" label="不通过原因：" labelPosition="top" multiline="true" style="width: 350px;height: 100px;"/>
		
		<div align=center style="margin-top: 15px;">
			<a href="javascript:void(0);"  onclick="doSubmit()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">提交</a>&nbsp;&nbsp;
			<a href="javascript:void(0);"  onclick="doCancel()" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
			
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
			
		.title {
			margin-left: 10px;
			margin-bottom: 8px;
			font-size: 14px;
			color: #1874CD;
    		font-weight: bold;
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
		
		.title-td {
			width:13%;
			padding-left: 5px;
			font-weight: bold;
		}
		
		.value-td{
			width:32%;
			padding-left: 5px;
		}
		
		.single-row{
			background: #F0F0F0;
		}
		
		.couple-row{
			background: #f5f5f5;
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
			// 图谱类型
			if(!isNull("${partAtl}")){
				$("#partAtl").prop("checked",true);
			}
			if(!isNull("${materialAtl}")){
				$("#materialAtl").prop("checked",true);
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
	
		function examine(id, result, remark){
			if(saving){
				return false;
			}
			saving = true;
			
			$("#result").val(result);
			$("#examine_remark").val(remark);
			
			//基准图谱类型
			var altType = getCheckboxVal("atlType");
			if(isNull(altType) || altType.length < 1){
				errorMsg("请选择基准图谱类型");
				saving = false;
				return false;
			}
			
			if(validChoose(altType, 1)){
				// 整车信息
				if(!isRequire("v_code", "车型代码必选")){ saving = false; return false; }
				if(!isRequire("v_proAddr", "整车生产基地必选")){ saving = false; return false; }
				
				// 零部件信息
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
			
			$('#dataForm').ajaxSubmit({
				url: "${ctx}/ots/examine",
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
		
		function notPass(){
			$("#remark").textbox("setValue", "");
			$("#dlg").dialog("open");
			
			// 移去滚动条
			window.parent.parent.scrollY(480);
		}
		
		function doSubmit(){
			var remark = $("#remark").textbox("getValue");
			if(isNull(remark)){
				errorMsg("请输入原因");
				$("#remark").next('span').find('input').focus();
				return false;
			}
			
			examine("${facadeBean.id}", 2, remark);
			$("#dlg").dialog("close");
		}
		
		function doCancel(){
			$("#dlg").dialog("close");
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
	</script>	
	
</body>

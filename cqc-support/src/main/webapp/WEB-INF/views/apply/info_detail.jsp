<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<form method="POST" id="uploadForm">
		<input type="hidden" id="t_id" name="t_id" value="${facadeBean.id }">
	
		<div style="margin-left: 10px;margin-top:20px;">
			
			<div class="title">整车信息</div>
			<table class="info">
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>车型代码：</span>
						<span class="val" title="${facadeBean.info.vehicle.code }">${facadeBean.info.vehicle.code }</span>
					</td>
					<td class="input-td">
						<select id="v_code" name="v_code" style="width:180px;" class="easyui-combobox" data-options="panelHeight: '200px'">
							<option value="">请选择</option>
							<c:forEach items="${carCodeList}" var="vo">
								<option value="${vo.code}">${vo.code}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<span class="title-span">生产日期：</span>
						<span class="val" title="<fmt:formatDate value='${facadeBean.info.vehicle.proTime }' type="date" pattern="yyyy-MM-dd"/>"><fmt:formatDate value='${facadeBean.info.vehicle.proTime }' type="date" pattern="yyyy-MM-dd"/></span>
					</td>
					<td class="input-td">
						<input id="v_proTime" name="v_proTime" type="text" class="easyui-datebox" data-options="editable:false" />
					</td>
				</tr>

				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>生产基地：</span>
						<span class="val" title="${facadeBean.info.vehicle.proAddr }">${facadeBean.info.vehicle.proAddr }</span>
					</td>
					<td class="input-td">
						<select id="v_proAddr" name="v_proAddr" style="width:180px;" class="easyui-combobox" data-options="panelHeight: 'auto'">
							<option value="">请选择</option>
							<c:forEach items="${addressList}" var="vo">
								<option value="${vo.name}">${vo.name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<span class="title-span">&nbsp;备注：</span> 
						<span class="val" title="${facadeBean.info.vehicle.remark }">${facadeBean.info.vehicle.remark }</span>
					</td>
					<td class="input-td">
						<input id="v_remark" name="v_remark" class="easyui-textbox" />
					</td>
				</tr>
			</table>
		</div>
	
		<div style="margin-left: 10px;margin-top:20px;">
			<div class="title">零部件信息</div>
			
			<table class="info">
				<tr>
					<td>
						<span class="title-span">零件名称：</span>
						<span class="val" title="${facadeBean.info.parts.name}">${facadeBean.info.parts.name}</span>
					</td>
					<td class="input-td">
						<input id="p_name" name="p_name" class="easyui-textbox" />
					</td>
					
				</tr>
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>零件图号：</span> 
						<span class="val" title="${facadeBean.info.parts.code}">${facadeBean.info.parts.code}</span>
					</td>
					<td class="input-td">
						<input id="p_code" name="p_code" class="easyui-textbox" />
					</td>
				</tr>
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>供应商：</span> 
						<span class="val" title="${facadeBean.info.parts.producer}">${facadeBean.info.parts.producer}</span>
					</td>
					<td class="input-td">
						<input id="p_producer" name="p_producer" type="text" class="inputAutocomple" >
					</td>
				</tr>
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>供应商代码：</span> 
						<span class="val" title="${facadeBean.info.parts.producerCode}">${facadeBean.info.parts.producerCode}</span>
					</td>
					<td class="input-td">
						<input id="p_producerCode" name="p_producerCode" class="easyui-textbox">
					</td>
				</tr>
				<tr>
					<td>
						<span class="title-span">样件批号：</span> 
						<span class="val" title="${facadeBean.info.parts.proNo }">${facadeBean.info.parts.proNo }</span>
					</td>
					<td class="input-td">
						<input id="p_proNo" name="p_proNo" class="easyui-textbox" />
					</td>
				</tr>
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>生产日期：</span> 
						<span class="val" title="<fmt:formatDate value='${facadeBean.info.parts.proTime }' type="date" pattern="yyyy-MM-dd"/>"><fmt:formatDate value='${facadeBean.info.parts.proTime }' type="date" pattern="yyyy-MM-dd"/></span>
					</td>
					<td class="input-td">
						<input id="p_proTime" name="p_proTime" type="text" class="easyui-datebox" data-options="editable:false" />
					</td>
				</tr>
				<tr>
					<td>
						<span class="title-span">生产场地：</span> 
						<span class="val" title="${facadeBean.info.parts.place }">${facadeBean.info.parts.place }</span>
					</td>
					<td class="input-td">
						<input id="p_place" name="p_place" class="easyui-textbox" />
					</td>
				</tr>
				<tr>
					<td>
						<span class="title-span">样件数量：</span> 
						<span class="val" title="${facadeBean.info.parts.num }">${facadeBean.info.parts.num }</span>
					</td>
					<td class="input-td">
						<input id="p_num" name="p_num" class="easyui-textbox" />
					</td>
				</tr>
				<tr>
					<td>
						<span class="title-span">&nbsp;备注：</span> 
						<span class="val" title="${facadeBean.info.parts.remark }">${facadeBean.info.parts.remark }</span>
					</td>
					<td class="input-td">
						<input id="p_remark" name="p_remark" class="easyui-textbox">	
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
						<span class="val" title="${facadeBean.info.material.matName }">${facadeBean.info.material.matName }</span>
					</td>
					<td class="input-td">
						<input id="m_matName" name="m_matName" class="easyui-textbox">
					</td>
				</tr>
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>材料牌号：</span> 
						<span class="val" title="${facadeBean.info.material.matNo }">${facadeBean.info.material.matNo }</span>
					</td>
					<td class="input-td">
						<input id="m_matNo" name="m_matNo" class="easyui-textbox">
					</td>
				</tr>
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>供应商：</span> 
						<span class="val" title="${facadeBean.info.material.producer }">${facadeBean.info.material.producer }</span>
					</td>
					<td class="input-td">
						<input id="m_producer" name="m_producer" type="text"  class="inputAutocomple">
					</td>
				</tr>
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>材料颜色：</span> 
						<span class="val" title="${facadeBean.info.material.matColor }">${facadeBean.info.material.matColor }</span>
					</td>
					<td class="input-td">
						<input id="m_matColor" name="m_matColor" class="easyui-textbox">
					</td>
				</tr>
				<tr>
					<td>
						<span class="title-span"><span class="req-span">*</span>材料批号：</span> 
						<span class="val" title="${facadeBean.info.material.proNo }">${facadeBean.info.material.proNo }</span>
					</td>
					<td class="input-td">
						<input id="m_proNo" name="m_proNo" class="easyui-textbox">
					</td>
				</tr>
				<tr>
					<td>
						<span class="title-span">样品数量：</span> 
						<span class="val" title="${facadeBean.info.material.num }">${facadeBean.info.material.num }</span>
					</td>
					<td class="input-td">
						<input id="m_num" name="m_num" class="easyui-textbox">
					</td>
				</tr>
				<tr>	
					<td>
						<span class="title-span">备注：</span> 
						<span class="val" title="${facadeBean.info.material.remark }">${facadeBean.info.material.remark }</span>	
					</td>
					<td class="input-td">
						<input id="m_remark" name="m_remark" class="easyui-textbox">
					</td>
				</tr>
			</table>
		</div>
	
		 <div style="text-align:center;margin-top:35px;" class="data-row">
			<div id="exception_error" class="error-message"></div>
			<a href="javascript:void(0);"  onclick="save()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
			<a href="javascript:void(0);"  onclick="doCancel()" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</form>
	
	<div id="vehicleDialog"></div>
	<div id="materialDialog"></div>
	<div id="partsDialog"></div>
	
		<style type="text/css">
			.title-span{
				display: inline-block;
				width: 85px;
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
	        
	        .val{
	        	border: 1px solid #D3D3D3;
			    display: inline-block;
			    width: 180px;
			    border-radius: 5px 5px 5px 5px;
			    margin: 0px;
			    padding-top: 0px;
			    padding-bottom: 0px;
			    line-height: 22px;
			    padding-left: 5px;
			    opacity: 0.6;
			    background-color: rgb(235, 235, 228);
			}
			
			input{
				width: 180px;
			}
			
			.input-td{
				padding-left: 50px;
				padding-right: 20px;
			}
			
			.error-message{
				color:red;
				text-align:center;
				margin-bottom: 15px;
				font-weight:bold;
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
		
			function save(){
				if(saving){
					return false;
				}
				saving = true;
				$("#exception_error").html("");
				
				var pNum = $("#p_num").textbox("getValue");
				if(!isNull(pNum) && isNaN(pNum)){
					saving = false;
					$("#p_num").next('span').find('input').focus();
					$("#p_num").textbox("setValue", "");
					$("#exception_error").html("提交失败，样件数量必须为整数");
					return false;
				}else{
					$("#exception_error").html("");
				}
				
				var mNum = $("#m_num").textbox("getValue");
				if(!isNull(mNum) && isNaN(mNum)){
					saving = false;
					$("#m_num").next('span').find('input').focus();
					$("#m_num").textbox("setValue", "");
					$("#exception_error").html("提交失败，样品数量必须为整数");
					return false;
				}else{
					$("#exception_error").html("");
				}
				
				$('#uploadForm').ajaxSubmit({
					url: "${ctx}/apply/applyInfoSave",
					dataType : 'json',
					success:function(data){
						saving = false;
						
						if(data.success){
							closeDialog(data.msg, "infoDetailDialog");
						}else{
							$("#exception_error").html(data.msg);
						}
					}
				});
			}

			function doCancel(){
				$("#infoDetailDialog").dialog("close");
			}
			
		</script>
	
</body>

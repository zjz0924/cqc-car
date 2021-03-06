<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<div style="margin-left: 10px;margin-top:20px;">
		<div class="title">车型信息</div>
		<div style="width: 98%;">
			<table class="info">
				<tr class="single-row">
					<td class="title-td">代码：</td>
					<td class="value-td">${facadeBean.info.vehicle.code}</td>
				</tr>
				<tr class="couple-row">
					<td class="title-td">生产日期：</td>
					<td class="value-td"><fmt:formatDate value='${facadeBean.info.vehicle.proTime}' type="date" pattern="yyyy-MM-dd"/></td>
					<td class="title-td">生产基地：</td>
					<td class="value-td">${facadeBean.info.vehicle.proAddr}</td>
				</tr>
				<tr class="single-row">
					<td class="title-td">备注：</td>
					<td class="value-td" colspan="3">${facadeBean.info.vehicle.remark}</td>
				</tr>
			</table>
		</div>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		
		<div class="title">零件信息</div>
		<div style="width: 98%;">
			<table class="info">
				<tr class="single-row">
					<td class="title-td">代码：</td>
					<td class="value-td">${facadeBean.info.parts.code}</td>
					<td class="title-td">名称：</td>
					<td class="value-td">${facadeBean.info.parts.name}</td>
				</tr>
				<tr class="couple-row">
					<td class="title-td">生产商：</td>
					<td class="value-td">${facadeBean.info.parts.org.name}</td>
					<td class="title-td">生产批号：</td>
					<td class="value-td">${facadeBean.info.parts.proNo}</td>
				</tr>
				<tr class="single-row">
					<td class="title-td">生产日期：</td>
					<td class="value-td"><fmt:formatDate value='${facadeBean.info.parts.proTime}' type="date" pattern="yyyy-MM-dd"/></td>
					<td class="title-td">生产地址：</td>
					<td class="value-td">${facadeBean.info.parts.place}</td>
				</tr>
				<tr class="couple-row">
					<td class="title-td">关键零件：</td>
					<td class="value-td">
						<c:choose>
							<c:when test="${facadeBean.info.parts.isKey == 0}">
								否
							</c:when>
							<c:otherwise>
								是
							</c:otherwise>
						</c:choose>
					</td>
					<td class="title-td">零件型号</td>
					<td class="value-td">
						${facadeBean.info.parts.keyCode}
					</td>
				</tr>
				
				<tr class="single-row">
					<td class="title-td">联系人：</td>
					<td class="value-td">${facadeBean.info.parts.contacts}</td>
					
					<td class="title-td">联系电话：</td>
					<td class="value-td">${facadeBean.info.parts.phone}</td>
				</tr>
				
				<tr class="couple-row">
					<td class="title-td">备注：</td>
					<td class="value-td" colspan="3">${facadeBean.info.parts.remark}</td>
				</tr>
			</table>
		</div>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		
		<div class="title">材料信息</div>
		<div style="width: 98%;">
			<table class="info">
				<tr class="single-row">
					<td class="title-td">材料名称：</td>
					<td class="value-td">${facadeBean.info.material.matName}</td>
					<td class="title-td">生产批号：</td>
					<td class="value-td">${facadeBean.info.material.proNo}</td>
				</tr>
				
				<tr class="couple-row">
					<td class="title-td">生产商：</td>
					<td class="value-td">${facadeBean.info.material.org.name}</td>
					<td class="title-td">生产商地址：</td>
					<td class="value-td">${facadeBean.info.material.org.addr}</td>
				</tr>
				
				<tr class="single-row">
					<td class="title-td">材料牌号：</td>
					<td class="value-td">${facadeBean.info.material.matNo}</td>
					<td class="title-td">材料颜色：</td>
					<td class="value-td">${facadeBean.info.material.matColor}</td>
				</tr>
				
				<tr class="couple-row">
					<td class="title-td">联系人：</td>
					<td class="value-td">${facadeBean.info.material.contacts}</td>
					
					<td class="title-td">联系电话：</td>
					<td class="value-td">${facadeBean.info.material.phone}</td>
				</tr>
				
				<tr class="single-row">
					<td class="title-td">材料成分表：</td>
					<td class="value-td">
						<c:if test="${not empty facadeBean.info.material.pic}">
							<a target="_blank" href="${resUrl}/${facadeBean.info.material.pic}">
								<img src="${resUrl}/${facadeBean.info.material.pic}" style="width: 100px;height: 50px;"></img>
							</a>
						</c:if>
					</td>
					<td class="title-td">备注：</td>
					<td class="value-td">${facadeBean.info.material.remark}</td>
				</tr>
			</table>
		</div>
		
		<c:if test="${not empty labReqList}">
			<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
			<div class="title">试验说明</div>
			<div style="margin-bottom: 20px;">
				<table class="info">
					<tr class="single-row">
						<td class="title-td">试验名称</td>
						<td class="title-td">任务号</td>
						<td class="title-td">实验要求</td>
						<td class="title-td">商定完成时间</td>
					</tr>
					
					<c:forEach items="${labReqList}" var="vo">
						<tr>
							<td>
								<c:choose>
									<c:when test="${vo.type eq 1}">零件图谱试验</c:when>
									<c:when test="${vo.type eq 2}">材料图谱试验</c:when>
									<c:when test="${vo.type eq 3}">零件型式试验</c:when>
									<c:when test="${vo.type eq 4}">材料型式试验</c:when>
								</c:choose>
							</td>
							<td>${vo.code}</td>
							<td style="word-break : break-all;line-height: 20px;">${vo.remark }</td>
							<td><fmt:formatDate value='${vo.time}' type="date" pattern="yyyy-MM-dd"/></td>
						</tr>
					</c:forEach>
				</table>
			</div>	
		</c:if>
		
		<!-- PPAP/SOP 对比结果接收 -->
		<c:if test="${facadeBean.type == 2 or facadeBean.type == 3}">
			<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
			<div class="title">对比结果</div>
			
			<div style="margin-left: 15px;">
				<div class="title" style="margin-top:15px;">零件图谱对比（基准-抽样）</div>
					<c:forEach items="${pAtlasResult}" var="m">
						<div style="margin-bottom: 10px;">
							<c:choose>
								<c:when test="${m.key == 1}">
									<div class="title1">红外光分析图谱</div>
								</c:when>
								<c:when test="${m.key == 2}">
									<div class="title1">差热分析图谱</div>
								</c:when>
								<c:when test="${m.key == 4}">
									<div class="title1">样品照片图谱</div>
								</c:when>
								<c:otherwise>
									<div class="title1">热重分析图谱</div>
								</c:otherwise>
							</c:choose>
							
							<table>
								<tr>
									<td style="padding-left: 15px;">
										<c:if test="${not empty m.value.standard_pic }">
											<a href="${resUrl}/${m.value.standard_pic}" target= _blank><img src="${resUrl}/${m.value.standard_pic}" style="width: 400px;height: 250px;"></a>
										</c:if>
										<c:if test="${empty m.value.standard_pic }">
											<span class="img-span">基准图谱为空</span>
										</c:if>
									</td>
									<td style="padding-left: 35px;">
										<c:if test="${not empty m.value.sampling_pic }">
											<a href="${resUrl}/${m.value.sampling_pic}" target= _blank><img src="${resUrl}/${m.value.sampling_pic}" style="width: 400px;height: 250px;"></a>
										</c:if>
										<c:if test="${empty m.value.sampling_pic }">
											<span class="img-span">抽样图谱为空</span>
										</c:if>
									</td>
								</tr>
							</table>
						</div>
					</c:forEach>
					
					<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
					
					<div class="title" style="margin-top:15px;">材料图谱对比（基准-抽样）</div>
					<c:forEach items="${mAtlasResult}" var="m">
						<div style="margin-bottom: 10px;">
							<c:choose>
								<c:when test="${m.key == 1}">
									<div class="title1">红外光分析图谱</div>
								</c:when>
								<c:when test="${m.key == 2}">
									<div class="title1">差热分析图谱</div>
								</c:when>
								<c:when test="${m.key == 4}">
									<div class="title1">样品照片图谱</div>
								</c:when>
								<c:otherwise>
									<div class="title1">热重分析图谱</div>
								</c:otherwise>
							</c:choose>
							
							<table>
								<tr>
									<td style="padding-left: 15px;">
										<c:if test="${not empty m.value.standard_pic }">
											<a href="${resUrl}/${m.value.standard_pic}" target= _blank><img src="${resUrl}/${m.value.standard_pic}" style="width: 400px;height: 250px;"></a>
										</c:if>
										<c:if test="${empty m.value.standard_pic }">
											<span class="img-span">基准图谱为空</span>
										</c:if>
									</td>
									<td style="padding-left: 35px;">
										<c:if test="${not empty m.value.sampling_pic }">
											<a href="${resUrl}/${m.value.sampling_pic}" target= _blank><img src="${resUrl}/${m.value.sampling_pic}" style="width: 400px;height: 250px;"></a>
										</c:if>
										<c:if test="${empty m.value.sampling_pic }">
											<span class="img-span">抽样图谱为空</span>
										</c:if>
									</td>
								</tr>
							</table>
						</div>
				   </c:forEach>
			  </div>

			<div style="border: 0.5px dashed #C9C9C9; width: 98%; margin-top: 15px; margin-bottom: 15px;"></div>
			<div class="title">结论</div>
			<div>
				<table style="width: 98%; font-size: 14px;">
					<tr style="background: #F0F0F0; height: 30px; font-weight: bold; text-align: center;">
						<td>类型</td>
						<td>样品照片</td>
						<td>红外光分析</td>
						<td>差热分析</td>
						<td>热重分析</td>
						<td>结论</td>
					</tr>
					
					<c:forEach items="${compareResult}" var="m">
						<tr>
							<td style="font-weight:bold;">${m.key}</td>
							<c:forEach items="${m.value}" var="vo" varStatus="vst">
								<td align="center">
									<div style="margin-top:5px;">
										<label><input name="${m.key}_radio_${vst.index}" type="radio" value="1" <c:if test="${vo.state == 1}">checked</c:if> disabled/>一致</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<label><input name="${m.key}_radio_${vst.index}" type="radio" value="2" <c:if test="${vo.state == 2}">checked</c:if> disabled/>不一致 </label> 
									</div>
									<div style="margin-top:5px;">
										<textarea rows="3" cols="25" disabled>${vo.remark}</textarea>
									</div>
								</td>
							</c:forEach>
						</tr>
					</c:forEach>
				</table>
			</div>
			
			<div style="border: 0.5px dashed #C9C9C9; width: 98%; margin-top: 15px; margin-bottom: 15px;"></div>
			<div class="title">不合格原因：</div>
			<div style="margin-left:10px;color:red;">${ facadeBean.remark }</div>
			
			<div style="margin-top:15px;font-weight:bold;color:red;" align="center" id="errorMsg"></div>
			<div align="center" style="margin-top:10px;margin-bottom: 20px;">
				<a id="saveBtn1" href="javascript:void(0);"  onclick="doSubmit(1)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">第二次抽样</a>
				<a href="javascript:void(0);"  onclick="notpass()" class="easyui-linkbutton" data-options="iconCls:'icon-no'">中止任务</a>
			</div>	

			
			<div id="dlg" class="easyui-dialog" title="结果接收" style="width: 400px; height: 250px; padding: 10px" closed="true" data-options="modal:true">
				
				<div>
					<input id="remark" class="easyui-textbox" label="中止原因：" labelPosition="top" multiline="true" style="width: 350px;height: 100px;"/><br>
					<span id="remark_error" style="color:red;"></span>
				</div>
				
				<div>
					<span id="result_error" style="color:red;"></span>
				</div>
				
				<div align=center style="margin-top: 15px;">
					<a id="saveBtn2" href="javascript:void(0);"  onclick="doSubmit(2)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">提交</a>&nbsp;&nbsp;
					<a href="javascript:void(0);"  onclick="doCancel()" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
				</div>
			</div>

		</c:if>
		
	</div>
			
	<script type="text/javascript">
		// 是否提交中
		var saving = false;
	
		function doSubmit(result){
			if(saving){
				return false;
			}
			saving = true;
			
			var remark = "";
			
			if(result == 2){
				$('#saveBtn2').linkbutton('disable');
				
				remark = $("#remark").val();
				
				if(isNull(remark)){
					$("#remark_error").html("请填写原因");
					$('#saveBtn2').linkbutton('enable');
					saving = false;
					return false;
				}else{
					$("#remark_error").html("");
				}
			}else{
				$('#saveBtn1').linkbutton('disable');
			}
			
			$.ajax({
				url: "${ctx}/ppap/confirmResult",
				data: {
					"taskId": "${facadeBean.id}",
					"result": result,
					"remark": remark
				},
				success: function(data){
					saving = false;
					if(data.success){
						if(result == 2){
							doCancel();
						}
						closeDialog(data.msg);
					}else{
						if(result == 1){
							$("#errorMsg").html(data.msg);
							$('#saveBtn1').linkbutton('enable');
						}else{
							$("#result_error").html(data.msg);
							$('#saveBtn2').linkbutton('enable');
						}
					}
				}
			});
		}
		
		function notpass(testType){
			$("#remark").textbox("setValue", "");
			$("#dlg").dialog("open");
		}
		
		function doCancel(){
			$("#dlg").dialog("close");
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
		
		.title1 {
			margin-left: 10px;
			margin-bottom: 8px;
			font-size: 14px;
			color: red;
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
			border-collapse:collapse;
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
		
		.img-span{
			width: 400px;
			height: 250px;
			display:inline-block;
			border:0.5px dashed #C9C9C9;
			text-align:center;
			line-height:250px;
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
		
	</style>
	
</body>

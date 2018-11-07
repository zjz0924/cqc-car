<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<div style="margin-left: 20px; margin-top: 10px;">
		<a id="showBtn" href="javascript:void(0);" onclick="expand()" style="color:red;">展开</a>
		<a id="hideBtn" href="javascript:void(0);" onclick="expand()" style="display: none; color: red;">收起</a>
	</div>
	
	<div style="margin-left: 10px;margin-top:20px;">
		<div class="title">任务详情</div>
		<div style="width: 98%;display:none;" id="taskDiv">
			<table class="info">
				<tr class="single-row">
					<td class="title-td">任务号：</td>
					<td class="value-td">${facadeBean.task.code}</td>
					<td class="title-td">任务类型：</td>
					<td class="value-td">
						<c:if test="${facadeBean.task.type == 1}">基准图谱建立</c:if>
						<c:if test="${facadeBean.task.type == 2}">图谱试验抽查-开发阶段</c:if>
						<c:if test="${facadeBean.task.type == 3}">图谱试验抽查-量产阶段</c:if>
						<c:if test="${facadeBean.task.type == 4}">第三方委托</c:if>
					</td>
				</tr>
				<tr class="couple-row">
					<td class="title-td">录入时间：</td>
					<td class="value-td"><fmt:formatDate value='${facadeBean.task.createTime}' type="date" pattern="yyyy-MM-dd"/></td>
					<td class="title-td">完成时间：</td>
					<td class="value-td"><fmt:formatDate value='${facadeBean.task.confirmTime}' type="date" pattern="yyyy-MM-dd"/></td>
				</tr>
				<tr class="single-row">
					<td class="title-td">状态：</td>
					<td class="value-td">
						<c:if test="${facadeBean.task.type == 1 or facadeBean.task.type == 4}">
							<c:if test="${facadeBean.task.state == 1}">审核中</c:if>
							<c:if test="${facadeBean.task.state == 2}">审核不通过</c:if>
							<c:if test="${facadeBean.task.state == 3}">试验中</c:if>
							<c:if test="${facadeBean.task.state == 4}">完成</c:if>
							<c:if test="${facadeBean.task.state == 5}">申请修改</c:if>
							<c:if test="${facadeBean.task.state == 6}">申请不通过</c:if>
						</c:if>
						
						<c:if test="${facadeBean.task.type == 2 or facadeBean.task.type == 3}">
							<c:if test="${facadeBean.task.state == 1}">审批中</c:if>
							<c:if test="${facadeBean.task.state == 2}">审批不通过</c:if>
							<c:if test="${facadeBean.task.state == 3}">结果上传中</c:if>
							<c:if test="${facadeBean.task.state == 4}">结果比对中</c:if>
							<c:if test="${facadeBean.task.state == 5}">结果发送中</c:if>
							<c:if test="${facadeBean.task.state == 6}">结果确认中</c:if>
							<c:if test="${facadeBean.task.state == 7}">完成</c:if>
							<c:if test="${facadeBean.task.state == 8}">申请修改</c:if>
							<c:if test="${facadeBean.task.state == 9}">申请不通过</c:if>
							<c:if test="${facadeBean.task.state == 10}">等待是否二次抽样</c:if>
							<c:if test="${facadeBean.task.state == 11}">中止任务</c:if>
						</c:if>
					</td>
					<td class="title-td">备注：</td>
					<td class="value-td"><c:if test="${facadeBean.task.state == 6 or facadeBean.task.state == 11}">${facadeBean.task.remark}</c:if></td>
				</tr>
				<tr class="couple-row">
					<td class="title-td">结果：</td>
					<td class="value-td">
						<c:if test="${(facadeBean.task.type == 1 or facadeBean.task.type == 4) and facadeBean.task.state == 4}">
							<c:if test="${facadeBean.task.failNum == 0}">合格</c:if>
							<c:if test="${facadeBean.task.failNum == 1}">一次不合格</c:if>
							<c:if test="${facadeBean.task.failNum == 2}">二次不合格</c:if>
						</c:if>
						<c:if test="${(facadeBean.task.type == 2 or facadeBean.task.type == 3) and facadeBean.task.state == 7}">
							<c:if test="${facadeBean.task.failNum == 0}">合格</c:if>
							<c:if test="${facadeBean.task.failNum == 1}">一次不合格</c:if>
							<c:if test="${facadeBean.task.failNum == 2}">二次不合格</c:if>
						</c:if>
					</td>
					<td class="title-td">原因：</td>
					<td class="value-td">
						<c:if test="${facadeBean.task.failNum >= 0}">
							${facadeBean.task.remark}
						</c:if>
					</td>
				</tr>
			</table>
		</div>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		
		<div class="title">申请人信息</div>
		<div style="width: 98%;display:none;" id="applicatDiv">
			<table class="info">
				<tr class="single-row">
					<td class="title-td">申请人：</td>
					<td class="value-td">${facadeBean.task.applicat.nickName}</td>
					<td class="title-td">科室：</td>
					<td class="value-td">${facadeBean.task.applicat.department}</td>
				</tr>
				<tr class="single-row">
					<td class="title-td">机构/单位：</td>
					<td class="value-td">${facadeBean.task.applicat.org.name}</td>
					<td class="title-td">联系方式：</td>
					<td class="value-td">${facadeBean.task.applicat.mobile}</td>
				</tr>
				<tr class="couple-row">
					<td class="title-td">备注：</td>
					<td class="value-td" colspan="3">${facadeBean.task.applicat.remark}</td>
				</tr>
			</table>
		</div>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		
		<div class="title">抽样原因</div>
		<div style="width: 98%;display:none;" id="reasonDiv">
			<table class="info">
				<tr class="single-row">
					<td class="title-td">样件来源：</td>
					<td class="value-td">${facadeBean.task.reason.origin }</td>
					<td class="title-td">抽样原因：</td>
					<td class="value-td">${facadeBean.task.reason.reason}</td>
				</tr>
				<tr class="single-row">
					<td class="title-td">其他原因描述：</td>
					<td class="value-td">${facadeBean.task.reason.otherRemark }</td>
					<td class="title-td">费用出处：</td>
					<td class="value-td">${facadeBean.task.reason.source}</td>
				</tr>
				<tr class="single-row">
					<td class="title-td">备注：</td>
					<td class="value-td">${facadeBean.task.reason.remark }</td>
				</tr>
			</table>
		</div>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		
		<div class="title">车型信息</div>
		<div style="width: 98%;display: none;" id="vehicleDiv">
			<table class="info">
				<tr class="single-row">
					<td class="title-td">代码：</td>
					<td class="value-td">${facadeBean.task.info.vehicle.code}</td>
					<td class="title-td">生产基地：</td>
					<td class="value-td">${facadeBean.task.info.vehicle.proAddr}</td>
				</tr>
				<tr class="couple-row">
					<td class="title-td">生产日期：</td>
					<td class="value-td"><fmt:formatDate value='${facadeBean.task.info.vehicle.proTime}' type="date" pattern="yyyy-MM-dd"/></td>
					<td class="title-td">备注：</td>
					<td class="value-td">${facadeBean.task.info.vehicle.remark}</td>
				</tr>
			</table>
		</div>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		
		<div class="title">零件信息</div>
		<div style="width: 98%; display: none;" id="partsDiv">
			<table class="info">
				<tr class="single-row">
					<td class="title-td">零件名称：</td>
					<td class="value-td">${facadeBean.task.info.parts.name}</td>
					<td class="title-td">零件图号：</td>
					<td class="value-td">${facadeBean.task.info.parts.code}</td>
				</tr>
				<tr class="couple-row">
					<td class="title-td">供应商：</td>
					<td class="value-td">${facadeBean.task.info.parts.producer}</td>
					<td class="title-td">供应商代码：</td>
					<td class="value-td">${facadeBean.task.info.parts.producerCode}</td>
				</tr>
				<tr class="single-row">
					<td class="title-td">生产日期：</td>
					<td class="value-td"><fmt:formatDate value='${facadeBean.task.info.parts.proTime}' type="date" pattern="yyyy-MM-dd"/></td>
					<td class="title-td">样件数量：</td>
					<td class="value-td">${facadeBean.task.info.parts.num}</td>
				</tr>
				<tr class="single-row">
					<td class="title-td">样件批号：</td>
					<td class="value-td">${facadeBean.task.info.parts.proNo}</td>
					<td class="title-td">生产场地：</td>
					<td class="value-td">${facadeBean.task.info.parts.place}</td>
				</tr>
				<tr class="couple-row">
					<td class="title-td">备注：</td>
					<td class="value-td" colspan="3">${facadeBean.task.info.parts.remark}</td>
				</tr>
			</table>
		</div>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		
		<div class="title">材料信息</div>
		<div style="width: 98%;display: none;" id="materialDiv">
			<table class="info">
				<tr class="single-row">
					<td class="title-td">材料名称：</td>
					<td class="value-td">${facadeBean.task.info.material.matName}</td>
					<td class="title-td">材料牌号：</td>
					<td class="value-td">${facadeBean.task.info.material.matNo}</td>
				
				</tr>
				
				<tr class="couple-row">
					<td class="title-td">供应商：</td>
					<td class="value-td">${facadeBean.task.info.material.producer}</td>
					<td class="title-td">材料颜色：</td>
					<td class="value-td">${facadeBean.task.info.material.matColor}</td>
				</tr>
				
				<tr class="single-row">
					<td class="title-td">材料批号：</td>
					<td class="value-td">${facadeBean.task.info.material.proNo}</td>
					<td class="title-td">样品数量：</td>
					<td class="value-td">${facadeBean.task.info.material.num}</td>
				</tr>
				
				<tr class="single-row">
					<td class="title-td">备注：</td>
					<td class="value-td" colspan="3">${facadeBean.task.info.material.remark}</td>
				</tr>
			</table>
		</div>
		
		<c:if test="${not empty labReqList}">
			<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
			<div class="title">试验说明</div>
			<div style="margin-bottom: 20px;">
				<table class="info">
					<tr class="single-row">
						<td class="title-td">试验编号</td>
						<td class="title-td">试验名称</td>
						<td class="title-td">任务号</td>
						<td class="title-td">实验要求</td>
						<td class="title-td">商定完成时间</td>
					</tr>
					
					<c:forEach items="${labReqList}" var="vo">
						<c:if test="${(facadeBean.labType eq 1 and vo.type eq 1) or (facadeBean.labType eq 3 and vo.type eq 2) }">
							<tr>
								<td>
									<c:choose>
										<c:when test="${vo.type eq 1}">${facadeBean.task.partsAtlCode}</c:when>
										<c:when test="${vo.type eq 2}">${facadeBean.task.matAtlCode}</c:when>
										<c:when test="${vo.type eq 3}">${facadeBean.task.partsPatCode}</c:when>
										<c:when test="${vo.type eq 4}">${facadeBean.task.matPatCode}</c:when>
									</c:choose>
								</td>
								<td>
									<c:choose>
										<c:when test="${vo.type eq 1}">零部件图谱试验</c:when>
										<c:when test="${vo.type eq 2}">原材料图谱试验</c:when>
										<c:when test="${vo.type eq 3}">零部件型式试验</c:when>
										<c:when test="${vo.type eq 4}">原材料型式试验</c:when>
									</c:choose>
								</td>
								<td>${vo.code}</td>
								<td style="word-break : break-all;line-height: 20px;">${vo.remark }</td>
								<td><fmt:formatDate value='${vo.time}' type="date" pattern="yyyy-MM-dd"/></td>
							</tr>
						</c:if>
					</c:forEach>
				</table>
			</div>	
		</c:if>
		
		<div style="border: 0.5px dashed #C9C9C9;width:98%;margin-top:15px;margin-bottom: 15px;"></div>
		<div class="title" style="margin-top:15px;">结果确认</div>
		<div style="margin-left: 10px; margin-bottom: 15px;">
			<c:choose>
				<c:when test="${facadeBean.task.type == 1}">
					基准图谱建立
				</c:when>
				<c:when test="${facadeBean.task.type == 2}">
					图谱试验抽查-开发阶段
				</c:when>
				<c:when test="${facadeBean.task.type == 3}">
					图谱试验抽查-量产阶段
				</c:when>
				<c:otherwise>
					第三方委托
				</c:otherwise>
			</c:choose>
			
			<c:choose>
				<c:when test="${facadeBean.labType == 1}">
					-- 零部件图谱实验
				</c:when>
				<c:when test="${facadeBean.labType == 2}">
					-- 零部件型式实验
				</c:when>
				<c:when test="${facadeBean.labType == 3}">
					-- 原材料图谱实验
				</c:when>
				<c:otherwise>
					-- 原材料型式实验
				</c:otherwise>
			</c:choose>
			
			&nbsp;&nbsp;&nbsp;&nbsp;第 <span style="color:red;font-weight:bold;">${facadeBean.times}</span> 次实验，结果确认：<c:if test="${ facadeBean.labResult == 1}"><span style="color:green;font-weight:bold;">合格</span></c:if><c:if test="${ facadeBean.labResult == 2}"><span style="color:red;font-weight:bold;">不合格</span></c:if>
		</div>
		
		<c:choose>
			<c:when test="${type == 1}">
				<div class="title" style="margin-top: 30px;">收费清单&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);"  onclick="addItem()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a></div>
				<div>
					<table class="info" id="expItemTable" style="width: 80%;">
						<tr>
							<td style="background: #F0F0F0;font-weight:bold;">序号</td>
							<td style="background: #F0F0F0;font-weight:bold;"><span class="req-span">*</span>试验项目</td>
							<td style="background: #F0F0F0;font-weight:bold;"><span class="req-span">*</span>参考标准</td>
							<td style="background: #F0F0F0;font-weight:bold;"><span class="req-span">*</span>单价（元）</td>
							<td style="background: #F0F0F0;font-weight:bold;"><span class="req-span">*</span>数量</td>
							<td style="background: #F0F0F0;font-weight:bold;">总价（元）</td>
							<td style="background: #F0F0F0;font-weight:bold;">备注</td>
							<td style="background: #F0F0F0;font-weight:bold;">操作</td>
						</tr>
						
						<c:forEach var="i" begin="1" end="1" varStatus="status">
							<tr num="${status.index}">
								<td style="background: #f5f5f5;padding-left:5px;">${status.index}</td>
								<td class="value-td1">
									<input id="project_${status.index}" name="project_${status.index}" class="easyui-textbox"/>
									<span id="project_${status.index}_error" class="req-span"></span>
								</td>
								<td class="value-td1">
									<input id="standard_${status.index}" name="standard_${status.index}" class="easyui-textbox"/>
									<span id="standard_${status.index}_error" class="req-span"></span>
								</td>
								<td class="value-td1">
									<input id="price_${status.index}" name="price_${status.index}" onchange="priceChange(${status.index})" class="easyui-numberbox" style="width: 100px;" data-options="min:0,precision:2"/>
									<span id="price_${status.index}_error" class="req-span"></span>
								</td>
								<td class="value-td1">
									<input id="num_${status.index}" name="num_${status.index}" onchange="priceChange(${status.index})" class="easyui-numberbox" style="width: 100px;" data-options="min:0,precision:0"/>
									<span id="num_${status.index}_error" class="req-span"></span>
								</td>
								<td class="value-td1">
									<input id="total_${status.index}" name="total_${status.index}" disabled class="easyui-numberbox" style="width: 100px;" data-options="min:0,precision:0"/>
								</td>
								<td class="value-td1">
									<input id="remark_${status.index}" name="remark_${status.index}" class="easyui-textbox"/>
									<span id="remark_${status.index}_error" class="req-span"></span>
								</td>
								<td style="background: #f5f5f5;padding-left:5px;">
									<a href="javascript:void(0);"  onclick="deleteItem(${status.index})"><i class="icon icon-cancel"></i></a>
								</td>
							</tr>
						</c:forEach>
					</table>
					
					<div style="margin-top: 10px;margin-left: 5px;font-weight:bold;">
						<span>总费用：</span><span style="color: red;font-weight:bold;font-size: 15px;" id="totalVal">0</span> &nbsp;元
					</div>
				</div>
			
				<!-- 待发送 -->
				<div style="margin-top: 25px;">
					<div class="title">发送机构</div>
					<div style="margin-left: 10px;">
						<input id="org" name="org"/>
						<span id="org_error" style="color:red;margin-left: 20px;"></span>
					</div>
				</div>
				
				<div id="tips" style="color:red;font-weight:bold;margin-bottom: 10px;" align="center"></div>
				<div id="saveBtn" align=center style="margin-top: 15px;margin-bottom: 30px;">
					<a href="javascript:void(0);"  onclick="save()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">发送</a>&nbsp;&nbsp;
					<a href="javascript:void(0);"  onclick="doCancel()" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
				</div>
				
			</c:when>
			<c:otherwise>
				<!-- 已发送 -->
				<div class="title" style="margin-top:15px;">费用详情</div>
				
				<div style="margin-bottom: 50px;">
					<table class="info">
						<tr>
							<td class="title-td">序号</td>
							<td class="title-td">试验项目</td>
							<td class="title-td">参考标准</td>
							<td class="title-td">单价</td>
							<td class="title-td">数量</td>
							<td class="title-td">总价</td>
							<td class="title-td">备注</td>
						</tr>
						
						<c:forEach items="${itemList}" var="vo" varStatus="vst">
							<tr>
								<td class="value-td1">${vst.index + 1 }</td>
								<td class="value-td1">${vo.project }</td>
								<td class="value-td1">${vo.standard }</td>
								<td class="value-td1">${vo.price }</td>
								<td class="value-td1">${vo.num }</td>
								<td class="value-td1">${vo.total }</td>
								<td class="value-td1">${vo.remark }</td>
							</tr>
						</c:forEach>
					</table>
					
					<div style="margin-top: 10px;margin-left: 5px;font-weight:bold;">
						<span>总费用：</span><span style="color: red;font-weight:bold;font-size: 15px;">${itemPrice}</span> &nbsp;元
					</div>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
			
	<script type="text/javascript">
		var sum = 0;
		
		$(function(){
			if("${type == 1}"){
				$('#org').combotree({
					url: '${ctx}/org/tree',
					multiple: true,
					animate: true,
					width: '350px',
					panelHeight: '150px',
					checkbox: function(node){
					   if(isNull(node.children)){
							return true;
					   }else{
						   return false;
					   }
				   }
				});
				
				
				$("#num_1").numberbox({
				    "onChange": function(){
				    	priceChange(1);
				    }
				});
				
				$("#price_1").numberbox({
				    "onChange": function(){
				    	priceChange(1);
				    }
				});
				
			}
		});
		
		function expand(){
			$("#vehicleDiv").toggle();
			$("#partsDiv").toggle();
			$("#materialDiv").toggle();
			$("#showBtn").toggle();
			$("#hideBtn").toggle();
			$("#taskInfoDiv").toggle();
			$("#taskDiv").toggle();
			$("#applicatDiv").toggle();
			$("#reasonDiv").toggle();
		}
		
		function save(){
			$("#saveBtn").hide();
			
			var dataArray = [];
			var flag = true;
			var date = new Date();
			
			var expItemTable = $("#expItemTable").length;
			if(expItemTable > 0){
				if($("tr[num]").length < 1){
					$("#tips").html("请添加试验项目");
					$("#tips").html("");
					$("#saveBtn").show();
					return false;
				}
				$("#result_error").html("");
			}
			
			$("tr[num]").each(function(){
				var num = $(this).attr("num");
				
				// 实验项目
				var project = $("#project_" + num).textbox("getValue");
				if(isNull(project)){
					$("#project_"+ num +"_error").html("必填");
					flag = false;
					return false;
				}else{
					$("#project_"+ num +"_error").html("");
				}
				
				// 参考标准
				var standard = $("#standard_" + num).textbox("getValue");
				if(isNull(standard)){
					$("#standard_"+ num +"_error").html("必填");
					flag = false;
					return false;
				}else{
					$("#standard_"+ num +"_error").html("");
				}
				
				// 单价
				var price = $("#price_" + num).numberbox("getValue");
				if(isNull(price)){
					$("#price_"+ num +"_error").html("必填");
					flag = false;
					return false;
				}else{
					$("#price_"+ num +"_error").html("");
				}
				
				// 数量
				var num_val = $("#num_" + num).numberbox("getValue");
				if(isNull(num_val)){
					$("#num_"+ num +"_error").html("必填");
					flag = false;
					return false;
				}else{
					$("#num_"+ num +"_error").html("");
				}
				var remark = $("#remark_" + num).textbox("getValue");
				
				var obj = new Object();
				obj.aId = "${currentAccount.id}"
				obj.project = project;
				obj.standard = standard;
				obj.cId = "${facadeBean.id}";
				obj.price = price;
				obj.num = num_val;
				obj.total = price * num_val;
				obj.remark = remark
				obj.createTime = date;
				dataArray.push(obj);
			});
			
			if(flag == false){
				$("#saveBtn").show();
				return false;
			}
			
			var orgs = $("#org").combotree("getValues");
			if(isNull(orgs)){
				$("#org_error").html("请选择要发送的机构");
				$("#saveBtn").show();
				return false;
			}
			$("#org_error").html("");
			
			$("#tips").html("正在发送中，请稍等");
			$.ajax({
				url: "${ctx}/cost/costSend",
				data: {
					"costId": "${facadeBean.id}",
					"result": JSON.stringify(dataArray),
					"orgs": orgs.toString()
				},
				success: function(data){
					if(data.success){
						$("#tips").html(data.msg);
						$("#tips").css("color", "green");
						
						tipMsg(data.msg, function(){
							window.location.reload();
						});
					}else{
						$("#saveBtn").show();
						$("#tips").html(data.msg);
					}
				}
			})
		}
		
		/**
		 *  添加项目
		 */
		function addItem(){
			$("#tips").html("");
			
			var num;
			for(var i = 1; i >= 1 ; i++){
				var len = $("tr[num="+ i + "]").length;
				if(len < 1){
					num = i;
					break;
				}
			}
			
			var str = "<tr num='"+ num + "'>"
					+	 "<td style='background: #f5f5f5;padding-left:5px;'>"+ num +"</td>"
					+	 "<td class='value-td1'>"
					+		"<input id='project_"+ num +"' name='project_"+ num +"' class='easyui-textbox'/>"
					+		"<span id='project_"+ num +"_error' class='req-span'></span>"
					+	 "</td>"
					+	 "<td class='value-td1'>"
					+		"<input id='standard_"+ num +"' name='standard_"+ num +"' class='easyui-textbox'/>"
					+		"<span id='standard_"+ num +"_error' class='req-span'></span>"
					+	 "</td>"
					+	 "<td class='value-td1'>"
					+		"<input id='price_"+ num +"' name='price__"+ num +"' class='easyui-numberbox' style='width: 100px;' data-options='min:0,precision:2'/>"
					+		"<span id='price_"+ num +"_error' class='req-span'></span>"
					+	 "</td>"
					+	 "<td class='value-td1'>"
					+		"<input id='num_"+ num +"' name='num_"+ num +"' class='easyui-numberbox' style='width: 100px;' data-options='min:0,precision:0'/>"
					+		"<span id='num_"+ num +"_error' class='req-span'></span>"
					+	 "</td>"
					+	 "<td class='value-td1'>"
					+		"<input id='total_"+ num +"' name='total_"+ num +"' class='easyui-numberbox' disabled style='width: 100px;' data-options='min:0,precision:0'/>"
					+	 "</td>"
					+	 "<td class='value-td1'>"
					+		"<input id='remark_"+ num +"' name='remark_"+ num +"' class='easyui-textbox'/>"
					+		"<span id='remark_"+ num +"_error' class='req-span'></span>"
					+	 "</td>"
					+	 "<td style='background: #f5f5f5;padding-left:5px;'>"
					+	    "<a href='javascript:void(0);'  onclick='deleteItem("+num+")'><i class='icon icon-cancel'></i></a>"
					+	 "</td>"
					+"</tr>";
			
			$("#expItemTable").append(str);
			
			// 渲染输入框
			$.parser.parse($("#project_"+ num).parent());
			$.parser.parse($("#standard_"+ num).parent());
			$.parser.parse($("#price_"+ num).parent());
			$.parser.parse($("#num_"+ num).parent());
			$.parser.parse($("#total_"+ num).parent());
			$.parser.parse($("#remark_"+ num).parent());
			
			$("#num_" + num).numberbox({
			    "onChange": function(){
			    	priceChange(num);
			    }
			});
			
			$("#price_" + num).numberbox({
			    "onChange": function(){
			    	priceChange(num);
			    }
			});
			
		}
		
		function deleteItem(num){
			var sumVal = $("#total_" + num).numberbox("getValue");
			if(!isNull(sumVal)){
				sum -= sumVal;
				$("#totalVal").html(sum);
			}
			
			$("tr[num='"+ num + "']").remove();
		}
		
		function priceChange(num){
			var numVal = $("#num_" + num).numberbox("getValue");
			var price = $("#price_" + num).numberbox("getValue");
			var sumVal = $("#total_" + num).numberbox("getValue");
			
			if(!isNull(numVal) && !isNull(price)){
				var sm = numVal * price;
				$("#total_" + num).numberbox("setValue", sm);
				sum += sm;
			}else{
				$("#total_" + num).numberbox("setValue", "");
				
				if(!isNull(sumVal)){
					sum -= sumVal;
				}
			}
			
			$("#totalVal").html(sum);
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
		
		.icon{
			width:16px;
			height: 16px;
			display: inline-block;
		}
		
		.img-span{
			width: 400px;
			height: 250px;
			display:inline-block;
			border:0.5px dashed #C9C9C9;
			text-align:center;
			line-height:250px;
		}
		
		.img-span1{
			width: 100px;
			height: 50px;
			display:inline-block;
			border:0.5px dashed #C9C9C9;
			text-align:center;
			line-height:50px;
		}
		
		.single-row{
			background: #F0F0F0;
		}
		
		.couple-row{
			background: #f5f5f5;
		}
		
		.table-title{
			padding-left: 5px;
			font-weight: bold;
		}
		
		.remark-span{
			font-weight: bold;
		}
	</style>
	
</body>

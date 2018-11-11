<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<div style="margin-left:10px;margin-top: 15px;">
		<table class="table table-border table-bordered table-bg">
			<tr style="background-color: #f5fafe;height: 40px;font-size: 16px;">
				<th colspan="2">
					<span>任务情况</span>
					<c:if test="${not empty backlogPermission}">
						<span style="float:right;font-size: 12px;margin-right: 10px;">
							<a href="${ctx}/backlog/list" style="color: green;">详情</a>
						</span>
					</c:if>
				</th>
			</tr>
			
			<tbody>
				<tr id="examineNumDiv" style="display: none;">
					<td class="left-td"><span class="row-style2">待审核</span></td>
					<td class="right-td"><span class="row-content" id="examineNum1"></span></td>
				</tr>
				
				<tr id="approveNumDiv" style="display: none;">
					<td class="left-td"><span class="row-style2">待审批</span></td>
					<td class="right-td"><span class="row-content" id="approveNum1"></span></td>
				</tr>
				
				<tr id="uploadNumDiv" style="display: none;background-color: #f5fafe;font-weight: bold; font-size: 12px;">
					<td colspan="2"><span style="font-weight: bold; font-size: 12px;">待上传结果</span></td>
				</tr>
				
				<tr id="patternUploadNumDiv" style="display: none;">
					<td class="left-td"><span class="row-style2">&nbsp;- 型式结果</span></td>
					<td class="right-td"><span class="row-content" id="patternUploadNum1"></span></td>
				</tr>
				
				<tr id="atlasUploadNumDiv" style="display: none;">
					<td class="left-td"><span class="row-style2">&nbsp;- 图谱结果</span></td>
					<td class="right-td"><span class="row-content" id="atlasUploadNum1"></span></td>
				</tr>
				
				<tr id="compareNumDiv" style="display: none;">
					<td class="left-td"><span class="row-style2">待比对</span></td>
					<td class="right-td"><span class="row-content" id="compareNum1"></span></td>
				</tr>
				
				<tr id="confirmNumDiv" style="display: none;background-color: #f5fafe;">
					<td colspan="2"><span style="font-weight: bold; font-size: 12px;">待结果接收</span></td>
				</tr>
				
				<tr id="waitConfirmNumDiv" style="display: none;">
					<td class="left-td"><span class="row-style2">&nbsp;- 待上传</span></td>
					<td class="right-td"><span class="row-content" id="waitConfirmNum1"></span></td>
				</tr>
				
				<tr id="finishConfirmNumDiv" style="display: none;">
					<td class="left-td"><span class="row-style2">&nbsp;- 已上传</span></td>
					<td class="right-td"><span class="row-content" id="finishConfirmNum1"></span></td>
				</tr>
			</tbody>
		</table>
	
	</div>
	
	<script src="${ctx}/resources/js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="${ctx}/resources/js/jquery-easyui-1.5.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${ctx}/resources/js/jquery-easyui-1.5.3/locale/easyui-lang-zh_CN.js"></script>
	
	<script type="text/javascript">
		$(function(){
			$.ajax({
				url : "${ctx}/getTaskNum",
				success : function(data) {
					
					// 审核数
					var examineNum = data.data[0];
					if(examineNum != -1){
						$("#examineNum1").html(examineNum);
						$("#examineNumDiv").show();
					}
					
					// 审批数
					var approveNum = data.data[1];
					if(approveNum != -1){
						$("#approveNum1").html(approveNum);
						$("#approveNumDiv").show();
					}
					
					// 上传结果
					var patternUploadNum = data.data[2];
					var atlasUploadNum = data.data[3];
					if(patternUploadNum != -1 || atlasUploadNum != -1){
						$("#uploadNumDiv").show();
						
						if(patternUploadNum != -1){
							$("#patternUploadNum1").html(patternUploadNum);
							$("#patternUploadNumDiv").show();
						}
						
						if(atlasUploadNum != -1){
							$("#atlasUploadNum1").html(atlasUploadNum);
							$("#atlasUploadNumDiv").show();
						}
					}
					
					// 待对比数
					var compareNum = data.data[4];
					if(compareNum != -1){
						$("#compareNum1").html(compareNum);
						$("#compareNumDiv").show();
					}
					
					// 结果接收
					var waitConfirmNum = data.data[5];
					var finishConfirmNum = data.data[6];
					
					if(waitConfirmNum != -1 || finishConfirmNum != -1){
						$("#confirmNumDiv").show();
						
						if(waitConfirmNum != -1){
							$("#waitConfirmNum1").html(waitConfirmNum);
							$("#waitConfirmNumDiv").show();
						}
						
						if(finishConfirmNum != -1){
							$("#finishConfirmNum1").html(finishConfirmNum);
							$("#finishConfirmNumDiv").show();
						}
					}
					
				}
			});
		});
	</script>
	
	<style type="text/css">
		
		table {
		    width: 98%;
		    empty-cells: show;
		    background-color: transparent;
		    border-collapse: collapse;
		    border-spacing: 0;
		}
		
		.table-bordered tr{
			line-height: 30px;
		}
		
		.table-bordered th, .table-bordered td {
		    border-left: 1px solid #ddd;
		    border-right: 1px solid #ddd;
		    padding-left: 10px;
		}
		
		.table-border th, .table-border td{
		    border-bottom: 1px solid #ddd;
		    border-top: 1px solid #ddd;
		}
	
		.left-td{
			width: 40px;
		}
		
		.right-td{
			text-align: center;
		}
	
	</style>
</body>

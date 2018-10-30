<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<div style="margin-left:20px;margin-top: 15px;">
		<div class="title-style1" style="margin-bottom: 10px;">任务情况：</div>
		<div class="row-style1"><span class="row-style2">待审核</span><span class="row-content" id="examineNum1"></span>  个</div>
		<div class="row-style1"><span class="row-style2">待审批</span><span class="row-content" id="approveNum1"></span>  个</div>
		
		<div class="row-style1"><span class="row-style2">待上传结果</span></div>
		<div class="row-style1"><span class="row-style2">&nbsp;- 型式结果</span><span class="row-content" id="patternUploadNum1"></span>  个</div>
		<div class="row-style1"><span class="row-style2">&nbsp;- 图谱结果</span><span class="row-content" id="atlasUploadNum1"></span>  个</div>
		
		<div class="row-style1"><span class="row-style2">待比对</span><span class="row-content" id="compareNum1"></span>  个</div>
		
		<div class="row-style1"><span class="row-style2">待结果确认</span></div>
		<div class="row-style1"><span class="row-style2">&nbsp;- 待上传</span><span class="row-content" id="waitConfirmNum1"></span>  个</div>
		<div class="row-style1"><span class="row-style2">&nbsp;- 已上传</span><span class="row-content" id="finishConfirmNum1"></span>  个</div>
		
		<div class="title-style1" style="margin-top: 15px;">消息提醒：</div>
		<div style="margin-top:10px;font-size:14px;">您还有 <span style="font-weight:bold;color:red;">${unread}</span> 条消息未读，请及时阅读。</div>
	</div>
	
	<script src="${ctx}/resources/js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript">
		$(function(){
			$.ajax({
				url : "${ctx}/getTaskNum",
				success : function(data) {
					$("#examineNum1").html(data.data[0]);
					$("#approveNum1").html(data.data[1]);
					$("#patternUploadNum1").html(data.data[2]);
					$("#atlasUploadNum1").html(data.data[3]);
					$("#compareNum1").html(data.data[4]);
					$("#waitConfirmNum1").html(data.data[5]);
					$("#finishConfirmNum1").html(data.data[6]);
				}
			});
		});
	</script>
</body>

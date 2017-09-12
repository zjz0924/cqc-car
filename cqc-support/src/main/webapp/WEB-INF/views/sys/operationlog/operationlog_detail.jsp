<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>
<%@include file="/page/NavPageBar.jsp"%>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@include file="../../common/source.jsp"%>
	
	<script type="text/javascript">
	
	</script>
	
	<style type="text/css">
		.data-row{
			line-height: 30px;
		}
		
		.data-title{
			display:inline-block;
			width: 120px;
		}
		
		.table thead > tr > th, .table tbody > tr > th, .table tfoot > tr > th, .table thead > tr > td, .table tbody > tr > td, .table tfoot > tr > td {
			padding: 5px;
			text-align:left;
			font-weight: normal;
			font-size: 14px;
		}
	</style>
</head>

<body>

	<div class="row">
		<div class="col-lg-12">
			<ol class="breadcrumb">
				<li>系统管理</li>
				<li><a href="${ctx}/operationlog/list">日志管理</a></li>
				<li>日志信息</li>
			</ol>
		</div>
	</div>

	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2>
						<span class="break"></span><strong>日志信息</strong>
					</h2>
				</div>

				<div class="panel-body" style="padding-top:10px;padding-left:30px;">

					<div style="margin-left:10px;">
						<div class="data-row">
							<span class="data-title">类型：</span>
							<span class="data-content">${opeartionLog.type}</span>
						</div>
						
						<div class="data-row">
							<span class="data-title">操作：</span>
							<span class="data-content">${opeartionLog.operation}</span>
						</div>
						
						<div class="data-row">
							<span class="data-title">用户：</span>
							<span class="data-content">${opeartionLog.userName}</span>
						</div>
						
						<div class="data-row">
							<span class="data-title">Client IP：</span>
							<span class="data-content">${opeartionLog.clientIp}</span>
						</div>
						
						<div class="data-row">
							<span class="data-title">User Agent：</span>
							<span class="data-content">${opeartionLog.userAgent}</span>
						</div>
						
						<div class="data-row">
							<span class="data-title">时间：</span>
							<span class="data-content"><fmt:formatDate value='${opeartionLog.time}' type="date" pattern="yyyy-MM-dd HH:mm:ss" /></span>
						</div>
					</div>	
					
					<div style="margin-top:10px;">
						<div style="font-weight:bold;">Detail Information</div>
						
						<c:if test="${not empty dataList}">
							<table class="table table-bordered table-striped table-condensed table-hover" style="width: 70%;">
								<thead>
									<tr>
										<th>Field</th>
										<th>Value</th>
										
										<c:if test="${operation == 'Update'}">
											<th>Old Value</th>
										</c:if>
									</tr>
								</thead>
								
								<c:forEach items="${dataList}" var="vo" > 
									<tr>
										<td>${vo.name}</td>
										<c:choose>
											<c:when test="${operation == 'Update'}">
												<td>${vo.newValue}</td>
												<td>${vo.oldValue}</td>
											</c:when>
											<c:when test="${operation == 'Create'}">
												<td>${vo.newValue}</td>
											</c:when>
											<c:otherwise>
												<td>${vo.oldValue}</td>
											</c:otherwise>
										</c:choose>
									</tr>
								</c:forEach> 
							</table>
						</c:if>
					</div>

				</div>
			</div>
		</div>
		<!--/col-->
	</div>
	<!--/row-->

</body>
</html>
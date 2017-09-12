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
		function goTo(url){
			window.location.href = "${ctx}/operationlog/" + url;
		}
	</script>
	
	<style type="text/css">
		.detail{
			word-break: break-all;
		    text-overflow: ellipsis;
		    display: -webkit-box; /** 将对象作为伸缩盒子模型显示 **/
		    -webkit-box-orient: vertical; /** 设置或检索伸缩盒对象的子元素的排列方式 **/
		    -webkit-line-clamp: 3; /** 显示的行数 **/
		    overflow: hidden; 
		}
	</style>
</head>

<body>

	<div class="row">
		<div class="col-lg-12">
			<ol class="breadcrumb">
				<li>系统管理</li>
				<li><a href="${ctx}/operationlog/list">日志管理</a></li>
			</ol>
		</div>
	</div>

	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2><span class="break"></span><strong>日志管理</strong></h2>
				</div>

				<div class="panel-body">
					<form id="queryForm" name="queryForm" action="${ctx}/operationlog/list" method="post">
						<table class="queryTable">
							<tr>
								<td class="labelTd">用户名</td>
								<td class="contentTd">
									<input type="text" id="userName" name="userName" class="form-control input-sm" value="${userName}">
								</td>
								
								<td class="labelTd">Detail</td>
								<td class="contentTd">
									<input type="text" id="detail" name="detail" class="form-control input-sm" value="${detail}">
								</td>
								
								<td class="labelTd">类型</td>
								<td class="contentTd">
									<select id="type" name="type" class="form-control">
										<option value="">全部</option>
										<c:forEach items="${typeList}"  var="vo">
			                            	<option value="${vo}" <c:if test="${type == vo}">selected=selected</c:if>>${vo}</option>
			                            </c:forEach>
		                        	</select>
		                        </td>
		                        
								<td class="labelTd">操作</td>
								<td class="contentTd">
									<select id="operation" name="operation" class="form-control">
										<option value="">全部</option>
										<option value="Create" <c:if test="${operation == 'Create'}">selected=selected</c:if>>Create</option>
										<option value="Update" <c:if test="${operation == 'Update'}">selected=selected</c:if>>Update</option>
										<option value="Delete" <c:if test="${operation == 'Delete'}">selected=selected</c:if>>Delete</option>
										<option value="Login" <c:if test="${operation == 'Login'}">selected=selected</c:if>>Login</option>
										<option value="Logout" <c:if test="${operation == 'Logout'}">selected=selected</c:if>>Logout</option>
		                        	</select>
		                        </td>						
							</tr>
							
							<tr>
								<td class="labelTd">时间</td>
								<td colspan="3">
									<input type="text" id="startTimeFrom" name="startTimeFrom" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'startTimeTo\')}'})" class="form-control input-sm" value="${startTimeFrom}" style="width:20%;display:inline-block"/> - 
									<input type="text" id="startTimeTo" name="startTimeTo" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startTimeFrom\')}'})" class="form-control input-sm" value="${startTimeTo}" style="width:20%;display:inline-block"/>
								</td>
								
								<td class="text-right" colspan="4" style="padding-right:20px;">
									<button onclick="doSubmit()" type="button" class="btn btn-primary"><i class="fa fa-search"></i>查询</button>
							   		<button onclick="doCancel()" type="button" class="btn btn-danger"><i class="fa fa-ban"></i>取消</button>
								</td>
							</tr>
						</table>

						<div style="padding-top: 15px;">
							<table class="table table-bordered table-striped table-condensed table-hover">
								<thead>
									<tr>
										<th class="text_size_14">序号</th>
										<th class="text_size_14">用户名</th>
										<th class="text_size_14">类型</th>
										<th class="text_size_14">操作</th>
										<th class="text_size_14">Client IP</th>
										<th class="text_size_14">Detail</th>
										<th class="text_size_14">时间</th>
									</tr>
								</thead>

								<tbody>
									<c:forEach items="${dataList}" var="vo" varStatus="vst">
										<tr onclick="goTo('detail?id=${vo.id}')">
											<td class="text-center text_size_14" style="width:6%;">${vst.index + 1}</td>
											<td class="text-center text_size_14" style="width:8%;">${vo.userName}</td>
											<td class="text-center text_size_14" style="width:8%;">${vo.type}</td>
											<td class="text-center text_size_14" style="width:8%;">${vo.operation}</td>
											<td class="text-center text_size_14" style="width:10%;">${vo.clientIp}</td>
											<td class="text_size_14"><div class="detail">${vo.detail}</div></td>
											<td class="text-center text_size_14" style="width:10%;">
												<fmt:formatDate value='${vo.time}' type="date" pattern="yyyy-MM-dd hh:mm:ss" />
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>

						<c:if test="${not empty dataList}">
							<pagination:pagebar startRow="${dataList.getStartRow()}" id="queryForm" pageSize="${dataList.getPageSize()}" totalSize="${dataList.getTotal()}" showbar="true" showdetail="true" />
						</c:if>
					</form>
				</div>
			</div>
		</div>
		<!--/col-->
	</div>
	<!--/row-->
</body>
</html>
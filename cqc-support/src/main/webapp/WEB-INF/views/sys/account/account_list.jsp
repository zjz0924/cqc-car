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
			window.location.href = "${ctx}/account/" + url;
		}
	</script>
</head>

<body>

	<div class="row">
		<div class="col-lg-12">
			<ol class="breadcrumb">
				<li>系统管理</li>
				<li><a href="${ctx}/account/list">用户管理</a></li>
			</ol>
		</div>
	</div>

	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2><span class="break"></span><strong>用户管理</strong></h2>
					
					<span style="float:right;padding-top:5px;">
						<button type="button" class="btn btn-primary btn-xs" onclick="goTo('detail')">添加</button>
					</span>
				</div>

				<div class="panel-body">
					<form id="queryForm" name="queryForm" action="${ctx}/account/list" method="post">
						<table class="queryTable">
							<tr>
								<td class="labelTd">用户名</td>
								<td class="contentTd">
									<input type="text" id="userName" name="userName" class="form-control input-sm" value="${userName}">
								</td>
								
								<td class="labelTd">昵称</td>
								<td class="contentTd">
									<input type="text" id="nickName" name="nickName" class="form-control input-sm" value="${nickName}">
								</td>
								
								<td class="labelTd">状态</td>
								<td class="contentTd">
									<select id="lock" name="lock" class="form-control">
										<option value="">全部</option>
			                            <option value="N" <c:if test="${lock == 'N'}">selected=selected</c:if>>正常</option>
			                            <option value="Y" <c:if test="${lock == 'Y'}">selected=selected</c:if>>锁定</option>
		                        	</select>
		                        </td>
		                        
								<td class="labelTd">手机号码</td>
								<td class="contentTd">
									<input type="text" id="mobile" name="mobile" class="form-control input-sm" value="${mobile}">
								</td>							
							</tr>
							
							<tr>
								<td class="labelTd">创建时间</td>
								<td colspan="3">
									<input type="text" id="startCreateTime" name="startCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endCreateTime\')}'})" class="form-control input-sm" value="${startCreateTime}" style="width:20%;display:inline-block"/> - 
									<input type="text" id="endCreateTime" name="endCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startCreateTime\')}'})" class="form-control input-sm" value="${endCreateTime}" style="width:20%;display:inline-block"/>
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
										<th class="text_size_14">昵称</th>
										<th class="text_size_14">手机</th>
										<th class="text_size_14">角色</th>
										<th class="text_size_14">状态</th>
										<th class="text_size_14">创建时间</th>
										<th class="text_size_14">操作</th>
									</tr>
								</thead>

								<tbody>
									<c:forEach items="${dataList}" var="vo" varStatus="vst">
										<tr>
											<td class="text-center text_size_14" style="width:8%;">${vst.index + 1}</td>
											<td class="text-center text_size_14" style="width:10%;">${vo.userName}</td>
											<td class="text-center text_size_14" style="width:10%;">${vo.nickName}</td>
											<td class="text-center text_size_14" style="width:12%;">${vo.mobile}</td>
											<td class="text-center text_size_14" style="width:8%;">${vo.role.name}</td>
											<td class="text-center text_size_14" style="width:8%;">
												<c:choose>
													<c:when test="${vo.lock == 'N'}">
														<span class="label label-success">正常</span>
													</c:when>
													<c:otherwise>
														<span class="label label-danger">锁定</span>
													</c:otherwise>
												</c:choose>
											</td>
											<td class="text-center text_size_14" style="width:16%;">
												<fmt:formatDate value='${vo.createTime}' type="date" pattern="yyyy-MM-dd hh:mm:ss" />
											</td>
											<td>
												<button btnType="readBtn" type="button" class="btn btn-default btn_padding" onclick="goTo('detail?id=${vo.id}&mode=readonly')">查看</button>&nbsp;
												<button btnType="editBtn" type="button" class="btn btn-success btn_padding" onclick="goTo('detail?id=${vo.id}')">编辑</button>&nbsp;
												<button btnType="editBtn" type="button" class="btn btn-danger btn_padding" onclick="confirm('是否确定删除该记录？','delete?id=${vo.id}')">删除</button> &nbsp;
												
												<c:choose>
													<c:when test="${vo.lock == 'N'}">
														<button btnType="editBtn" type="button" class="btn btn-warning btn_padding" onclick="confirm('是否确认锁定用户？','lock?id=${vo.id}&lock=Y')">锁定</button>&nbsp;
													</c:when>
													<c:otherwise>
														
														<button btnType="editBtn" type="button" class="btn btn-info btn_padding" onclick="confirm('是否确认解锁用户？','lock?id=${vo.id}&lock=N')">解锁</button>&nbsp;
													</c:otherwise>
												</c:choose>

												<button btnType="editBtn" type="button" class="btn btn-primary btn_padding" onclick="confirm('是否确认重置密码？','resetPwd?id=${vo.id}')">重置密码</button>
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
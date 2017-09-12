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
		$(function(){
			var resultCode = "${resultCode}";
			if(resultCode != null && resultCode != '' && resultCode != undefined){
				var resultMsg = "${resultMsg}";
				// 设置按钮不可点
				$("#saveBtn").attr("class", "btn btn-primary disabled");
				
				if(resultCode == "01" || resultCode == "03"){ 
					window.location.href = "${ctx}/account/list";
				}else{
					// 设置按钮可点
					$("#saveBtn").attr("class", "btn btn-primary");
				}
			}
			
			var mode = "${mode}";
			if(mode == "readonly"){
				$(":input").attr("disabled","true");
			}
			
			//自适应高度
			window.parent.adapter(document.body.scrollHeight + 10);
		});
	
		function checkData(){
			if(isNull("${facadeBean.id}")){
				if(!isRequired("userName", "用户名必填")) return false;
				if(!isRequired("password", "密码必填")) return false;
				if(!isRequired("repeatPassword", "确认密码必填")) return false;
				
				if($("#password").val() != $("#repeatPassword").val()){
					alert("两次密码不一致");
					return false;
				}
			}
			
			if(!isRequired("nickName", "昵称不能为空")) return false;
		}
	</script>
</head>

<body>

	<div class="row">
		<div class="col-lg-12">
			<ol class="breadcrumb">
				<li>系统管理</li>
				<li><a href="${ctx}/account/list">用户管理</a></li>
				<li>用户信息</li>
			</ol>
		</div>
	</div>

	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2>
						<span class="break"></span><strong>用户信息</strong>
					</h2>
				</div>

				<div class="panel-body" style="padding-top:30px;padding-left:30px;">
					<form action="${ctx}/account/save" method="post" onsubmit="return checkData();">
						<input type="hidden" id="id" name="id" value="${facadeBean.id}"/>
						
						<div class="form-group height_30">
		                    <label class="col-md-2 control-label"><span class="asterisk">*</span>用户名</label>
		                    <div class="col-md-3">
		                    	<c:choose>
		                    		<c:when test="${empty facadeBean.id}">
		                    			<input type="text" id="userName" name="userName" class="form-control" value="${facadeBean.userName}">
		                    		</c:when>
			                    	<c:otherwise>
			                    		<p class="form-control-static">${facadeBean.userName}</p>
			                    	</c:otherwise>
		                    	</c:choose>
		                    </div>
		                </div>
		                
		                <c:if test="${empty facadeBean.id }"> 
			                <div class="form-group height_30">
			                    <label class="col-md-2 control-label"><span class="asterisk">*</span>密码</label>
			                    <div class="col-md-3">
			                    	<input type="password" id="password" name="password" class="form-control">
			                    </div>
			                </div>
			                
			                <div class="form-group height_30">
			                    <label class="col-md-2 control-label"><span class="asterisk">*</span>确认密码</label>
			                    <div class="col-md-3">
			                    	<input type="password" id="repeatPassword" name="repeatPassword" class="form-control">
			                    </div>
			                </div>
		                </c:if>
		                
		                <div class="form-group height_30">
		                    <label class="col-md-2 control-label"><span class="asterisk">*</span>昵称</label>
		                    <div class="col-md-3">
		                        <input type="text" id="nickName" name="nickName" class="form-control" value="${facadeBean.nickName}">
		                    </div>
		                </div>
		                
		                <div class="form-group height_30">
		                    <label class="col-md-2 control-label">手机</label>
		                    <div class="col-md-3">
		                        <input type="text" id="mobile" name="mobile" class="form-control" value="${facadeBean.mobile}">
		                    </div>
		                </div>
		                
		                <div class="form-group height_30">
		                    <label class="col-md-2 control-label">角色</label>
		                    <div class="col-md-3">
		                        <select class="form-control" id="roleId" name="roleId">
		                        	<c:forEach items="${roleList}" var="vo"> 
		                        		<option value="${vo.id}"  <c:if test="${vo.id == facadeBean.roleId}">selected="selected"</c:if>>${vo.name}</option>
		                        	</c:forEach>
	                   			</select>
		                    </div>
		                </div>
		                
		                 <c:if test="${not empty facadeBean.id }"> 
			                <div class="form-group height_30">
			                    <label class="col-md-2 control-label">状态</label>
			                    <div class="col-md-3 height_30" style="padding-top: 5px;">
			                        <c:choose>
										<c:when test="${facadeBean.lock == 'N'}">
											<span class="label label-success">正常</span>
										</c:when>
										<c:otherwise>
											<span class="label label-danger">锁定</span>
										</c:otherwise>
									</c:choose>
			                    </div>
			                </div>
				        
					        <div class="form-group height_30">
			                    <label class="col-md-2 control-label">创建时间</label>
			                    <div class="col-md-3">
			                        <p class="form-control-static">
			                        	<fmt:formatDate value='${facadeBean.createTime}' type="date" pattern="yyyy-MM-dd hh:mm:ss" />
			                        </p>
			                    </div>
			                </div>        
						</c:if>
						
						<c:if test="${mode != 'readonly'}">
							 <div class="form-group height_30 text-center">
								<button id="saveBtn" type="submit" class="btn btn-primary">保存</button>
								<button type="button" class="btn btn-danger" onclick="window.location.reload();">取消</button>
							</div>
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
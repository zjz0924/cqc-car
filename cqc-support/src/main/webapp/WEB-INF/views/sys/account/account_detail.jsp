<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<input type="hidden" id="id" name="id" value="${facadeBean.id}"/>
	
	<div style="margin-top:15px;margin-left:20px;">
		<div class="data-row">
			<span class="title-span"><span class="req-span">*</span>用户名：</span> 
			<input id="userName" name="userName" value="${facadeBean.userName}" <c:if test="${not empty facadeBean.id}">disabled</c:if> class="easyui-textbox">
			<span id="userName_error" class="error-message"></span>
		</div>
		
		<c:if test="${empty facadeBean.id }"> 
            <div class="data-row">
				<span class="title-span"><span class="req-span">*</span>密码：</span> 
				<input id="password" name="password" class="easyui-passwordbox">
				<span id="password_error" class="error-message"></span>
			</div>
			
			<div class="data-row">
				<span class="title-span"><span class="req-span">*</span>确认密码：</span> 
				<input id="repeatPassword" name="repeatPassword" class="easyui-passwordbox">
				<span id="repeatPassword_error" class="error-message"></span>
			</div>
        </c:if>
		
		<div class="data-row">
			<span class="title-span"><span class="req-span">*</span>姓名：</span> 
			<input id="nickName" name="nickName" class="easyui-textbox" value="${facadeBean.nickName}">
			<span id="nickName_error" class="error-message"></span>
		</div>
		
		<div class="data-row">
			<span class="title-span"><span class="req-span">*</span>角色：</span> 
			<input id="role" name="role">
			<span id="role_error" class="error-message"></span>
		</div>
		
		<div class="data-row">
			<span class="title-span"><span class="req-span">*</span>机构：</span> 
			<input id="org" name="org">
			<span id="org_error" class="error-message"></span>
		</div>
		
		<div class="data-row">
			<span class="title-span">手机：</span> 
			<input id="mobile" name="mobile" class="easyui-textbox" value="${facadeBean.mobile}" data-options="validType:'phone'">
		</div>
		
		<div class="data-row">
			<span class="title-span">邮箱：</span> 
			<input id="email" name="email" class="easyui-textbox" value="${facadeBean.email}" data-options="validType:'email'">
		</div>
		
		<c:if test="${not empty facadeBean.id }"> 
              <div class="data-row">
                  <span class="title-span">状态</span>
                   <c:choose>
						<c:when test="${facadeBean.lock == 'N'}">
							<span class="label label-success">正常</span>
						</c:when>
						<c:otherwise>
							<span class="label label-danger">锁定</span>
						</c:otherwise>
					</c:choose>
              </div>
              
              <div class="data-row">
                  <span class="title-span">创建时间：</span>
       			  <span><fmt:formatDate value='${facadeBean.createTime}' type="date" pattern="yyyy-MM-dd hh:mm:ss" /></span>
       		  </div>
		 </c:if>
		 
		 <div style="text-align:center;margin-top:5px;" class="data-row">
			<a href="javascript:void(0);"  onclick="save()" class="easyui-linkbutton" >保存</a>
			<span id="exception_error" class="error-message"></span>
		</div>
	</div>
	
	<script type="text/javascript">
		$(function(){
			$('#role').combotree({
				url: '${ctx}/role/tree',
				multiple: true,
				animate: true,	
				checkbox: function(node){
					console.info("sdf");
					if(node.id.indexOf("r") != -1){
						return true;
					}
                }
			});
			
			$('#org').combotree({
				url: '${ctx}/org/tree'
			});
			
			var roleVal = "${roleVal}";  
		 	if(!isNull(roleVal)){
		 		var roleJson = eval('(' + roleVal + ')');
		 		$('#role').combotree('setValues', roleJson);
		 	}
		 	
		 	var orgId = "${orgId}"; 
		 	if(!isNull(orgId)){
				$('#org').combotree('setValue', {id: orgId, text: '${orgName}'});
			}
		});
	
		function save(){
			var userName = $("#userName").textbox("getValue");
			
			if(isNull(userName)){
				err("userName_error", "用户名必填");
				return false;
			}else{
				err("userName_error", "");
			}
			
			var accountId = $("#id").val();
			if(isNull(accountId)){
				var password = $("#password").val();
				var repeatPassword = $("#repeatPassword").val();
				
				if(isNull(password)){
					err("password_error", "密码必填");
					return false;
				}else{
					err("password_error", "");
				}
				
				if(isNull(repeatPassword)){
					err("repeatPassword_error", "确认密码必填");
					return false;
				}else{
					err("repeatPassword_error", "");
				}
				
				if(password != repeatPassword){
					err("password_error", "两次密码不一致");
					return false;
				}else{
					err("repeatPassword_error", "");
				}
			}
			
			var nickName = $("#nickName").val();
			if(isNull(nickName)){
				err("nickName_error", "姓名必填");
				return false;
			}else{
				err("nickName_error", "");
			}
			
			var roleId = "";
			var roleVals = $("#role").combotree('getValues');
			if(roleVals.length > 0){
				for(var i = 0; i < roleVals.length; i++){
					var id = roleVals[i];
					id = id.split("_")[1];
					
					if(i != roleVals.length - 1){
						roleId += id + ",";
					}else{
						roleId += id;
					}
				}
			}
			if(isNull(roleId)){
				err("role_error", "请选择角色");
				return false;
			}else{
				err("role_error", "");
			}
			
			var orgId = "";
			var orgTree = $('#org').combotree('tree');	
			var selecteNode = orgTree.tree('getSelected');
			if(!isNull(selecteNode)){
				orgId = selecteNode.id;
			}
			if(isNull(orgId)){
				err("org_error", "请选择机构");
				return false;
			}else{
				err("org_error", "");
			}
			
			var mobile = $("#mobile").textbox("getValue");
			var email = $("#email").textbox("getValue");
			
			$.ajax({
				url: "${ctx}/account/save?time=" + new Date(),
				data: {
					userName: userName,
					password: password,
					nickName: nickName,
					roleId: roleId,
					orgId: orgId,
					mobile: mobile,
					email: email,
					id: accountId
				},
				success:function(data){
					if(data.success){
						window.parent.closeDialog(data.msg);
					}else{
						if(data.data == "userName"){
							err("userName_error", data.msg);
						}else{
							err("exception_error", data.msg);
						}
					}
				}
			});
		}
		
		function err(id, message){
            $("#" + id).html(message);
        }
	</script>
	
	<style type="text/css">
		.data-row{
			height: 35px;
		}
	
		.title-span{
			font-weight: bold;
			display: inline-block;
			width: 80px;
		}
		
        .error-message{
            margin: 4px 0 0 5px;
            padding: 0;
            color: red;
        }
        
        .req-span{
        	font-weight: bold;
        	color: red;
        }
	</style>
	
</body>

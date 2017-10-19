<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<form method="POST" enctype="multipart/form-data" id="accountForm">
		<input type="hidden" id="id" name="id" value="${facadeBean.id}"/>
		<input type="hidden" id="roleId" name="roleId"/>
		<input type="hidden" id="orgId" name="orgId"/>
 		
		<div style="margin-top:15px;margin-left:20px;">
			<div class="data-row">
				<div class="data-cell-left">
					<span class="title-span"><span class="req-span">*</span>用户名：</span> 
					<input id="userName" name="userName" value="${facadeBean.userName}" <c:if test="${not empty facadeBean.id}">disabled</c:if> class="easyui-textbox">
					<span id="userName_error" class="error-message"></span>
				</div>
				
				<div class="data-cell-right">
					<span class="title-span"><span class="req-span">*</span>姓名：</span> 
					<input id="nickName" name="nickName" class="easyui-textbox" value="${facadeBean.nickName}">
					<span id="nickName_error" class="error-message"></span>
				</div>
			</div>
			
			<c:if test="${empty facadeBean.id }"> 
	            <div class="data-row">
	            	<div class="data-cell-left">
						<span class="title-span"><span class="req-span">*</span>密码：</span> 
						<input id="password" name="password" class="easyui-passwordbox">
						<span id="password_error" class="error-message"></span>
					</div>
				
					<div class="data-cell-right">
						<span class="title-span"><span class="req-span">*</span>确认密码：</span> 
						<input id="repeatPassword" name="repeatPassword" class="easyui-passwordbox">
						<span id="repeatPassword_error" class="error-message"></span>
					</div>
				</div>
	        </c:if>
			
			<div class="data-row">
				<div class="data-cell-left">
					<span class="title-span"><span class="req-span">*</span>角色：</span> 
					<input id="role" name="role">
					<span id="role_error" class="error-message"></span>
				</div>
				<div class="data-cell-right">
					<span class="title-span"><span class="req-span">*</span>机构：</span> 
					<input id="org" name="org">
					<span id="org_error" class="error-message"></span>
				</div>
			</div>
			
			<div class="data-row">
				<div class="data-cell-left">
					<span class="title-span">手机：</span> 
					<input id="mobile" name="mobile" class="easyui-textbox" value="${facadeBean.mobile}" data-options="validType:'phone'">
				</div>
				<div class="data-cell-right">
					<span class="title-span">邮箱：</span> 
					<input id="email" name="email" class="easyui-textbox" value="${facadeBean.email}" data-options="validType:'email'">
				</div>
			</div>
			
			<c:if test="${not empty facadeBean.id }"> 
	              <div class="data-row">
		              	<div class="data-cell-left">
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
						<div class="data-cell-right">
							<span class="title-span">创建时间：</span>
	       			  		<span><fmt:formatDate value='${facadeBean.createTime}' type="date" pattern="yyyy-MM-dd hh:mm:ss" /></span>
						</div>
	              </div>
			 </c:if>
			
			<div class="data-row">
				<span class="title-span">备注：</span> 
				<input id="remark" name="remark" class="easyui-textbox" multiline="true" value="${facadeBean.remark }" style="height:50px">		
			</div>
			
			<div class="data-row" style="margin-top:30px;">
				<span class="title-span">签名来源：</span> 
				<select id="signType" class="easyui-combobox" name="signType" data-options="panelHeight:'auto'" style="width:171px;">
				    <option value="1" <c:if test="${facadeBean.signType == 1}">selected="selected"</c:if>>登录用户姓名</option>
				    <option value="2" <c:if test="${facadeBean.signType == 2}">selected="selected"</c:if>>使用图片签名</option>
				</select>
			</div>
			
			<div class="data-row" style="margin-top:5px;">
				<span class="title-span">签名图片：</span> 
				<input id="pic" name="pic" class="easyui-filebox" style="width:171px" data-options="buttonText: '选择'">
				<span id="pic_error" class="error-message"></span>
			</div>
			 
			<c:if test="${not empty facadeBean.pic}">
				<div style="margin-top:5px;margin-left: 83px;margin-bottom: 10px;">
					<a href="${resUrl}/${facadeBean.pic}" target="_blank">
						<img src="${resUrl}/${facadeBean.pic}" style="width: 100px; height: 50px;"></img>
					</a>
				</div>
			</c:if>
			 
			 <div style="text-align:center;margin-top:5px;" class="data-row">
				<a href="javascript:void(0);"  onclick="saveAccount()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
				<span id="exception_error" class="error-message"></span>
			</div>
		</form>
	</div>
	
	<script type="text/javascript">
		$(function(){
			$('#role').combotree({
				url: '${ctx}/role/tree',
				multiple: false,
				animate: true	
			});
			
			// 只有角色才能选择
			var t = $('#role').combotree('tree');	
			t.tree({
			   onBeforeSelect: function(node){
				   if(node.id.indexOf("r") != -1){
						return true;
				   }else{
					   return false;
				   }
			   }
			});
			
			$('#org').combotree({
				url: '${ctx}/org/tree'
			});
			
			// 只能选择最底层机构
			var orgTree = $('#org').combotree('tree');	
			orgTree.tree({
			   onBeforeSelect: function(node){
				   if(isNull(node.children)){
						return true;
				   }else{
					   return false;
				   }
			   }
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
	
		function saveAccount(){
			var userName = $("#userName").textbox("getValue");
			
			if(!isRequire("userName", "用户名必填")){ return false; }
			
			var accountId = $("#id").val();
			if(isNull(accountId)){
				var password = $("#password").val();
				var repeatPassword = $("#repeatPassword").val();
				
				if(!isRequire("password", "密码必填")){ return false; }
				if(!isRequire("repeatPassword", "确认密码必填")){ return false; }
				
				if(password != repeatPassword){
					errAccount("password_error", "两次密码不一致");
					return false;
				}else{
					errAccount("repeatPassword_error", "");
				}
			}
			
			if(!isRequire("nickName", "姓名必填")){ return false; }
			
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
				errAccount("role_error", "请选择角色");
				return false;
			}else{
				errAccount("role_error", "");
			}
			$("#roleId").val(roleId);
			
			var orgId = "";
			var orgTree = $('#org').combotree('tree');	
			var selecteNode = orgTree.tree('getSelected');
			if(!isNull(selecteNode)){
				orgId = selecteNode.id;
			}
			if(isNull(orgId)){
				errAccount("org_error", "请选择机构");
				return false;
			}else{
				errAccount("org_error", "");
			}
			$("#orgId").val(orgId);
			
			var signType = $("#signType").val();
			if(signType == 2){
				var fileDir = $("#pic").filebox("getValue");
				if (!isNull(fileDir)) {
					var suffix = fileDir.substr(fileDir.lastIndexOf("."));
					if (".jpg" != suffix && ".png" != suffix && ".jpeg" != suffix && ".gif" != suffix) {
						$("#pic_error").html("请选择图片格式文件导入！");
						return false;
					}
				}else{
					var pic = '${facadeBean.pic}';
					if(isNull(pic)){
						$("#pic_error").html("请选择要上传的签名图片");
						return false;
					}
				}
			}else{
				$("#pic_error").html("");
			}
			
			$('#accountForm').ajaxSubmit({
				url: "${ctx}/account/save?time=" + new Date(),
				dataType : 'text',
				success:function(msg){
					var data = eval('(' + msg + ')');
					if(data.success){
						closeAccountDialog(data.msg);
					}else{
						if(data.data == "userName"){
							errAccount("userName_error", data.msg);
						}else{
							errAccount("exception_error", data.msg);
						}
					}
				}
			});
		}
		
		function errAccount(id, message){
            $("#" + id).html(message);
        }
		
		/**
		  * 判断是否必填
		  * id: 属性ID
		  * emsg: 错误信息
		*/
		function isRequire(id, emsg){
			var val = $("#" + id).val();
			if(isNull(val)){
				errAccount(id + "_error", emsg);
				return false;
			}else{
				errAccount(id + "_error", "");
				return true;
			}
		}
	</script>
	
	<style type="text/css">
		.data-row{
			height: 35px;
		}
		
		.data-cell-left{
			display: inline-block;
			width: 50%;
		}
		
		.data-cell-right{
			display: inline-block;
			width: 45%;
		}
	
		.title-span{
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

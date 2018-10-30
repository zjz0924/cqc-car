<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@include file="/page/taglibs.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Cache-Control" content="no-cache">
	<meta http-equiv="Expires" content="0">
	<title>登录</title>
	<link href="${ctx}/resources/css/login/form.css" rel="stylesheet" type="text/css" />
	<script src="${ctx}/resources/js/jquery-2.1.1.min.js"></script>
</head>

<body>
	<div class="login_box">
		<div class="login_l_img"><img src="${ctx}/resources/img/login/login-img.png" /></div>
		<div class="login">
			<div class="login_logo"><img src="${ctx}/resources/img/login/login_logo.png" /></div>
			<div class="login_name">
				<p>材料数据库登录认证</p>
			</div>
			
			<form id="loginForm" action="${ctx}/login" method="post">
				<input name="username" id="username" type="text" placeholder="账号"> 
				<input name="password" type="password" id="password" placeholder="密码"/>
				<input name="vcode" id="vcode" type="text" maxLength="4" style="width: 190px;" placeholder="验证码"/>
				<span>
            		<img src="${ctx}/verifycode" id="verifyimg" title="看不清？点击刷新！" style="width:80px;height:25px;margin-left: 15px;"/>
            	</span>
			
				<input value="登录" style="width: 100%;" type="button" onclick="doSubmit()">
				
				<div style="margin-top: 15px;text-align: center;">
					<span id="error_message" style="color:#d25; font-weight:bold;">${error}</span>
				</div>
			</form>
		</div>
	</div>
	
	<script type="text/javascript">
		$(function(){
			$("#verifyimg").click(function(){
				refreshVerify("verifyimg");
			});
			
			/**有父窗口则在父窗口打开*/  
	        if(self!=top){top.location=self.location;}  
		});
		
		document.onkeydown = function(event){
			var e = event || window.event || arguments.callee.caller.arguments[0];
			if(e && e.keyCode == 13){ // enter 键
				doSubmit();
			}
		}; 
		
		function checkVerify(verify) {
			var ret = false;
			$.ajax({
		        type: "GET",
		        cache: false,
		        url: "${ctx}/checkverify",
		        async: false,
		        data: "vcode="+verify,
		        success: function(msg) {
		        	ret = msg;
		        }
		    });
			
			return ret;
		}
		
		function refreshVerify(id){
			var imgurl = "${ctx}/verifycode?rnd="+new Date().getTime();
			$("#"+id).attr("src", imgurl);
		}

		function doSubmit(){
			var username = $("#username").val();
			var password = $("#password").val();
			var verifyCode = $("#vcode").val();
		
			if (username == null || username == "" || username == undefined){
				$("#error_message").html("请输入账号");
				$("#username").focus();
				return false;
			}else{
				$("#error_message").html("");
			}					
			
			if (password == null || password == "" || password == undefined){
				$("#error_message").html("请输入密码");
				$("#password").focus();
				return false;
			}
			
			if (verifyCode == null || verifyCode == "" || verifyCode == undefined){
				$("#error_message").html("请输入验证码");
				$("#vcode").focus();
				return false;
			}else {
				if (checkVerify(verifyCode) != true) {
		    		$("#error_message").html("验证码输入错误，看不清？点击图片换一个");
		    		$("#vcode").focus();
		    		
		    		//刷新验证码
		    		refreshVerify("verifyimg");
		    		return false;
				}else{
					$("#error_message").html("");
				}
			}
			
			$('#loginForm').submit();
		}
	</script>
	
</body>
</html>

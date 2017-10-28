<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@include file="/page/taglibs.jsp" %>

<!DOCTYPE html>
<html>
	<head>
    	<meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <title>后台管理系统</title>	
		
		<link href='${ctx}/resources/css/cssreset.css' rel="stylesheet" type="text/css" />
		
	    <style type="text/css">
	    	body{ background:#152652 url(${ctx}/resources/img/login/bg_31.png) repeat-x top;}

			.wrap{ width:955px; height:567px; margin:0 auto; background:url(${ctx}/resources/img/login/bg_321.jpg) no-repeat center; margin-top:79px; position:relative;}
			.wrap table{ position:absolute; top:203px; left:408px;}
			.wrap table td input{ border:1px solid #a5b7ca; outline:none; padding-left:5px; width: 140px; line-height: 19px;}
			.wrap table td{ height:24px; padding:5px; line-height:24px; vertical-align:middle;}
			.wrap table td span{ border:1px solid #126AEF; float:right; margin-left:5px; height:22px;}
			.wrap table td.btn input{ width:57px; height:20px; text-align:center; line-height:20px; background:url(${ctx}/resources/img/login/bg_33.png) no-repeat; cursor:pointer; color:#fff; margin-right:15px;border:none;}
	    </style>
	</head>
</head>

<body>

	<div class="wrap ">
		<form id="loginForm" action="${ctx}/login" method="post" class="form-horizontal login" >
		    <table>
		        <tr>
		            <td>用户名</td>
		            <td><input id="username" name="username" type="text"/></td>
		        </tr>
		        <tr>
		            <td>密码</td>
		            <td><input type="password" id="password" name="password"></input></td>
		        </tr>
		        <tr>
		            <td>验证码</td>
		            <td>
		            	<input name="vcode" id="vcode" type="text" maxLength="4"/>
		            	<span>
		            		<img src="${ctx}/verifycode" id="verifyimg" title="看不清？点击刷新！" style="width:50px;height:20px;"/>
		            	</span>
		            </td>
		        </tr>
		        <tr>
		            <td></td>
		            <td class="btn">
		            	<input type="button" name="" value="登录" onclick="doSubmit()"/>
		            	<input name="" type="button"  value="重置" onclick="reset()"/>
		            </td>
		        </tr>
		    </table>
	    </form>
	    <div style="color:#d25; font-weight:bold;margin-left: 300px;padding-top: 346px;" id="error_message">
	    	<c:choose>
		    	<c:when test="${not empty error }">
		    		${error}
		    	</c:when>
		    	<c:otherwise>
		    		您还没有登录，请先登录。
		    	</c:otherwise>
	    	</c:choose>
	    </div>
	</div>
		
	<script src="${ctx}/resources/js/jquery-2.1.1.min.js"></script>

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
		
			if (username.length == 0){
				$("#error_message").html("请输入账号");
				$("#username").focus();
				return false;
			}else{
				$("#error_message").html("");
			}					
			
			if (password.length == 0){
				$("#error_message").html("请输入密码");
				$("#password").focus();
				return false;
			}
			
			if (verifyCode.length == 0){
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
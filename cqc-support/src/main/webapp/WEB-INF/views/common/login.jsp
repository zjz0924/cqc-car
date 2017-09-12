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
		
        <!--[if lt IE 9]>
		<link href="http://fonts.useso.com/css?family=Open+Sans:400" rel="stylesheet" type="text/css" />
		<link href="http://fonts.useso.com/css?family=Open+Sans:700" rel="stylesheet" type="text/css" />
		<link href="http://fonts.useso.com/css?family=Droid+Sans:400" rel="stylesheet" type="text/css" />
		<link href="http://fonts.useso.com/css?family=Droid+Sans:700" rel="stylesheet" type="text/css" />
		<![endif]-->

	    <!-- Css files -->
	    <link href="${ctx}/resources/frame/css/bootstrap.min.css" rel="stylesheet">		
		<link href="${ctx}/resources/frame/css/jquery.mmenu.css" rel="stylesheet">		
		<link href="${ctx}/resources/frame/css/font-awesome.min.css" rel="stylesheet">
		<link href="${ctx}/resources/frame/plugins/jquery-ui/css/jquery-ui-1.10.4.min.css" rel="stylesheet">			    
	    <link href="${ctx}/resources/frame/css/style.min.css" rel="stylesheet">
		<link href="${ctx}/resources/frame/css/add-ons.min.css" rel="stylesheet">

	    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	    <!--[if lt IE 9]>
			<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
			<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	    <![endif]-->
	</head>
</head>

<body>
	<div class="container-fluid content">
		<div class="row">
			<div id="content" class="col-sm-12 full">
				<div class="row">
					<div class="login-box">
						<div class="header" style="font-size: 20px;letter-spacing: .15em;font-weight: 700;">
							后台管理系统
						</div>
					
						<form id="loginForm" action="${ctx}/login" method="post" class="form-horizontal login" >
							<fieldset class="col-sm-12">
								<div class="form-group">
									<div class="controls row">
										<div class="input-group col-sm-12">	
											<input type="text" class="form-control" id="username" name="username" placeholder="账号" autofocus="true"/>
											<span class="input-group-addon"><i class="fa fa-user"></i></span>
										</div>	
									</div>
								</div>
							
								<div class="form-group">
									<div class="controls row">
										<div class="input-group col-sm-12">	
											<input type="password" class="form-control" id="password" name="password" placeholder="密码"/>
											<span class="input-group-addon"><i class="fa fa-key"></i></span>
										</div>	
									</div>
								</div>
								
								<div class="form-group">
									<div class="controls row">
										<div class="input-group col-sm-12">	
											<input name="vcode" id="vcode" class="form-control" maxLength="4" placeholder="验证码"  style="width:68%;vertical-align:middle;display:inline-block"/> 
											<img src="${ctx}/verifycode" id="verifyimg" title="看不清？点击刷新！" style="cursor: pointer;vertical-align:middle;margin-left:20px;margin-top:5px;"/>
										</div>
									</div>
								</div>
								

								<div class="confirm" style="text-align:center;color:red;font-weight:bold;" id="error_message">
									${error}
								</div>	

								<div class="row">
									<button type="button" id="login" class="btn btn-lg btn-primary col-xs-12">登录</button>
								</div>
							</fieldset>	
						</form>
						
						<div class="clearfix"></div>				
					</div>
				</div><!--/row-->
			</div>	
		</div><!--/row-->		
	</div><!--/container-->
		
	<script src="${ctx}/resources/js/jquery-2.1.1.min.js"></script>

	<script type="text/javascript">
		$(function(){
			$("#login").click(function(){
				doSubmit();
			});
			
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
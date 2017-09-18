<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp" %>

<!DOCTYPE html>
<html lang="en">
	<head>
    	<meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <title>Wow</title>		
		
	    <%@include file="../common/source.jsp"%>
		<script src="${ctx}/resources/js/jquery-2.1.1.min.js"></script>
		<script src="${ctx}/resources/frame/js/core.min.js"></script>
		<script src="${ctx}/resources/frame/js/bootstrap.min.js"></script>
		
		<script type="text/javascript">
			$(function(){
				$("#modular").load(function() {
					$(this).height(0); //用于每次刷新时控制IFRAME高度初始化   
					var height = $(this).contents().height() + 10;
					$(this).height(height);
				});
				
				// 自动打开第一个菜单 
				autoOpen();
			});
		
			function openFrame(src) {
				var frame = document.getElementById("modular");
				frame.src = "${ctx}/" + src;
			}
			
			function adapter(height) {
				$("#modular").height(height < 650 ? 650 : height);
			}
			
			function changepwd(){
				art.dialog.open('${ctx}/account/changePwd',{
					id: "changepwdDialog",
			    	padding: 0,
					width: 500,
					height: 300,
					resize: true,
					lock: true
				});
			}
			
			// 自动点开第一个
			function autoOpen(){
				// 自动点开第一个
				$(".nav-sidebar li:first a").trigger("click");
				
				var subItem = $(".nav-sidebar li:first").children("ul").find("li:first a");
				if(subItem.length > 0){
					subItem.trigger("click");
				}
			}
		</script>
	</head>
</head>

<body>
	<!-- start: Header -->
	<div class="navbar" role="navigation">
		<div class="navbar-header" id="navbar-header-title">
			<span class="navbar-header-title">后台管理系统</span>
		</div>
	
		<div class="container-fluid">
			<ul class="nav navbar-nav navbar-actions navbar-left">
				<li class="visible-md visible-lg"><a href="javascript:void(0)" id="main-menu-toggle"><i class="fa fa-th-large"></i></a></li>
				<li class="visible-xs visible-sm"><a href="javascript:void(0)" id="sidebar-menu"><i class="fa fa-navicon"></i></a></li>			
			</ul>
			
	        <ul class="nav navbar-nav navbar-right">
				<li class="dropdown visible-md visible-lg">
	        		<a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-weight: 600">${currentAccount.userName}</a>
	        		<ul class="dropdown-menu">
						<li class="dropdown-menu-header">
							<strong>账号管理</strong>
						</li>						
						<li><a href="javascript:void(0)" onclick="openFrame('account/detail?id=${currentAccount.id}&mode=readonly')"><i class="fa fa-user"></i> 个人信息</a></li>
						<li><a href="javascript:void(0)" onclick="changepwd()"><i class="fa fa-wrench"></i> 修改密码</a></li>
	        		</ul>
	      		</li>
				<li><a href="${ctx}/loginout"><i class="fa fa-power-off"></i></a></li>
			</ul>
		</div>
		
	</div>
	<!-- end: Header -->
	
	<div class="container-fluid content">
		<div class="row">
			<!-- start: Main Menu -->
			<div class="sidebar ">
				<div class="sidebar-collapse">
					<div class="sidebar-menu">
						<ul class="nav nav-sidebar">
							<c:forEach items="${menuList}" var="vo">
								<c:choose>
									<c:when test="${fn:length(vo.subList) > 0}">
										<li>
											<a href="javascript:void(0)"><i class="${vo.logo}"></i><span class="text">${vo.name}</span> <span class="fa fa-angle-down pull-right"></span></a>
											<ul class="nav sub">	
												<c:forEach items="${vo.subList}" var="subVo">
													<li><a href="javascript:void(0)" onclick="openFrame('${subVo.url}')"><i class="${subVo.logo}"></i><span class="text">${subVo.name}</span></a></li>
												</c:forEach>								
											</ul>
										</li>
									</c:when>
									<c:otherwise>
										<li><a href="javascript:void(0)" onclick="openFrame('${vo.url}')"><i class="${vo.logo}"></i><span class="text">${vo.name}</span></a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</ul>
					</div>					
				</div>
			</div>
			<!-- end: Main Menu -->
		
		<!-- start: Content -->
		<div class="main">
			<iframe id="modular" name="modular" width="100%" frameborder=0 height="100%" src="" marginheight="0" marginwidth="0"  scrolling="no">
		</div>
		<!-- end: Content -->
		
	</div><!--/container-->
	
	<div class="clearfix"></div>
	
</body>
</html>
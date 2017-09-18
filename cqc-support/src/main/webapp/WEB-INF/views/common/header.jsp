<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<link href="${ctx}/resources/css/style.css" rel="stylesheet">
	<link href="${ctx}/resources/css/index3.css" rel="stylesheet">
	<link href="${ctx}/resources/css/responsive-menu.css" rel="stylesheet">
	<link href="${ctx}/resources/css/menu.css" rel="stylesheet">
	<link href="${ctx}/resources/css/cssreset.css" rel="stylesheet">
	<script src="${ctx}/resources/js/responsive-menu.js"></script>
	
	<script type="text/javascript">
	    $(function(){
	    	$("li[_t_nav='GYSTXJS']").addClass('nojuris');
	    	var menu = $('.rm-nav').rMenu({
	            minWidth: '400px'
	        });
	    })
    </script>
	
	<style type="text/css">
		.rm-nav {
		    letter-spacing: 1px;
		}
		
		.rm-toggle.rm-button {
		    margin-top: 25px;
		}
		
		.rm-css-animate.rm-menu-expanded {
		    max-height: none;
		    display: block;
		}
		
		.rm-nav li a,
		.rm-top-menu a {
		    /* padding: .75rem 1rem; */
		    font-size: .9em;
		    line-height: 1.5rem;
		    text-transform: uppercase;
		}
		.rm-layout-expanded .rm-nav > ul > li > a,
		.rm-layout-expanded .rm-top-menu > .rm-menu-item > a {
		    font-size: 15px;height: 49px;line-height: 16px;
		    padding-top: 24px;
		}
	</style>
</head>

<body>
	<div class="header">
		<div class="header_in" style="font-family: 微软雅黑">
			<a href="#"><img src='${ctx}/resources/img/logo.png' class="logo" /></a>
			<hr />
			<h2>上汽通用五菱材料管理平台</h2>
			<div class="ri">
				<p>
					<a href='/smsh/xtszTab/tabs1-3'><span><img src='../../resources/img/icon_11.png' /></span>${currentAccount.nickName }，晚上好</a>&nbsp;&nbsp;
					<a href="#" class="loginOut"><img src='../../resources/img/icon_04.png' />退出</a> 
				</p>
			</div>
			
			<div class="nav">
				<nav class="rm-nav rm-nojs rm-darken">
					<ul>
						<li class='base'><a class='base_a' style='' href='/smsh'>首页</a>
						</li>
						<li class="nojuris base" _t_nav="BM"><a href="#"
							class="base_a">我的部门</a></li>
						<li class="nojuris base" _t_nav="GYSTXJS"><a href="#"
							class="base_a">供应商体系</a></li>
						<li class='base' _t_nav="YWGL"><a href="/smsh/bpm/tabs1-3"
							class="base_a">业务管理</a>
							<ul>
								<li class='hasitemli'><a href="#">APQP</a>
									<ul>
										<li class='subli'><a href="#">项目管理</a></li>
										<li class='subli'><a href="#">供应商评审</a></li>
										<li class='subli'><a href="#">供应商质量开发</a></li>
									</ul></li>
								<li class='hasitemli'><a href="/smsh/bpm/tabs1-3">供应商质量保障</a>
									<ul>
										<li class='subli'><a href="/smsh/bpm/tabs1-3">现场质量问题</a>
										</li>
										<li class='subli'><a href="/smsh/bpm/tabs2-1">问题解决</a></li>
										<li class='subli'><a href="#">质量保障</a></li>
										<li class='subli'><a href="#">IPTV管理</a></li>
									</ul></li>
								<li class='subli'><a href="#">供应商实验室管理</a></li>
								<li class='hasitemli'><a href="#">供应商质量成本管理</a>
									<ul>
										<li class='subli'><a href="#">售后三包索赔管理</a></li>
										<li class='subli'><a href="#">特殊索赔管理</a></li>
									</ul></li>
							</ul></li>
						<li class='base' _t_nav="WDYW"><a
							href="/smsh/jbpm/taskpersonal" class="base_a">我的业务</a>
							<ul>
								<li class='hasitemli'><a href="#">个人工作任务跟踪</a>
									<ul>
										<li class='subli'><a href="#">新增个人工作计划</a></li>
										<li class='subli'><a href="#">个人工作计划一览</a></li>
										<li class='subli'><a href="#">新增个人工作总结</a></li>
										<li class='subli'><a href="#">个人工作总结一览</a></li>
									</ul></li>
								<li class='subli'><a href="/smsh/jbpm/taskpersonal">我的待办事项</a>
								</li>
								<li class='hasitemli'><a href="#">所管供应商质量表现</a>
									<ul>
										<li class='subli'><a href="#">供应商表现一览</a></li>
										<li class='subli'><a href="#">供应商质量分析</a></li>
										<li class='subli'><a href="#">供应商质量改进</a></li>
									</ul></li>
							</ul></li>
						<li class="nojuris base" _t_nav="GYSJXGL"><a href="#"
							class="base_a" style='padding-top: 17px; height: 56px;'>供应商<br>绩效管理
						</a></li>
						<li class="nojuris base" _t_nav="GYSNLGL"><a href="#"
							class="base_a" style='padding-top: 17px; height: 56px;'>供应商<br>能力管理
						</a></li>
						<li class="nojuris base" _t_nav="GYSPXGL"><a href="#"
							class="base_a" style='padding-top: 17px; height: 56px;'>供应商<br>培训管理
						</a></li>
						<li class="nojuris base" _t_nav="ZSFX"><a href="#"
							class="base_a">知识分享</a></li>
						<li class="nojuris base" _t_nav="FXGL"><a href="#"
							class="base_a" style='padding-top: 17px; height: 56px;'>供应商<br>风险管理
						</a></li>
						<li class='base' _t_nav="XTGL"><a
							href="/smsh/xtszTab/tabs1-1" class="base_a ed">系统管理</a>
							<ul>
								<li class='hasitemli rm-last'><a
									href="/smsh/xtszTab/tabs1-1">系统设置</a>
									<ul>
										<li class='subli'><a href="/smsh/xtszTab/tabs1-2">个人审批设置</a>
										</li>
										<li class='subli'><a href="/smsh/xtszTab/tabs1-3">密码修改</a>
										</li>
										<li class='subli'><a href="/smsh/xtszTab/tabs1-5">供应商用户信息</a>
										</li>
									</ul>
								</li>
							</ul>
						</li>
					</ul>
				</nav>

			</div>
		</div>
	</div>
</body>
</html>
<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>SGMW</title>

		<script src="${ctx}/resources/js/jquery-2.1.1.min.js"></script>
		<script src="${ctx}/resources/js/slides.js"></script>
	</head>

	<body style="margin:0px;">
		<%@include file="../common/header.jsp"%>
		
		<!--banner开始-->
		<div class="banner">
		    <div class="banner_in" id="container">
		        <div id="example">
		            <div id="slides">
		                <div class="slides_container">
		                    <div><a href="#"><img src="../../resources/img/gundong/banner_04.png" /></a></div>
		                    <div><a href="#"><img src="../../resources/img/gundong/banner_05.png" /></a></div>
		                    <div><a href="#"><img src="../../resources/img/gundong/banner_06.png" /></a></div>
		                    <div><a href="#"><img src="../../resources/img/gundong/banner_07.png" /></a></div>
		                </div>
		                <a href="#" class="prev"><img src="../../resources/img/arrow-prev.png" alt="Arrow Prev"></a>
		                <a href="#" class="next"><img src="../../resources/img/arrow-next.png" alt="Arrow Next"></a>
		            </div>
		        </div>
		    </div>
		</div>
		<!--banner结束-->
		
		<div class="main">
			<div style="background-color:white;margin-left: 20px;margin-right:20px;margin-top: 20px;height:650px;">
				<div style="padding-top:30px;padding-left:15px;font-size: 20px;">欢迎使用上汽通用五菱材料管理平台</div>
				
				<div style="margin-left:15px;margin-top: 25px;">
					<div style="font-weight:bold;color: #1874CD;font-size:16px;">温馨提示：</div>
					<div style="margin-top:10px;font-size:14px;">您还有 <span style="font-weight:bold;color:red;">${unread}</span> 条消息未读，请及时阅读。</div>
				</div>
			</div>
		</div>
		
		<!-- footer -->
		<%@include file="../common/footer.jsp"%>
	</body>
</html>
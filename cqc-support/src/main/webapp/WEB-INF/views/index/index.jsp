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
		
		<style type="text/css">
			.title-sytle{
				display:inline-block;
				width: 80px;
				text-align: right;
				padding-right: 10px;
			}
			
			.title-style1{
				font-weight:bold;
				color: #1874CD;
				font-size:16px;
			}
			
			.row-style{
				height: 35px;
			}
			
			.row-style1{
				height: 25px;
			}
			
			.row-style2{
				display:inline-block;
				width: 150px;
				font-size:14px;
			}
			
			.row-content{
				font-size:14px;
				font-weight:bold;
				color:red;
			}
		</style>
		
		<script type="text/javascript">
			$(function() {
				
				if("${showBacklog}" == 1){
					backlog();
				}
			});
			
			function backlog(){
				$('#backlogDialog').dialog({
					title : '待办信息',
					width : 600,
					height : 380,
					closed : false,
					cache : false,
					href : "${ctx}/backlog/detail",
					modal : true
				});
				
				$(".window-mask").css("height", "");
			}
			
		</script>
	</head>

	<body style="margin:0px;">
		<%@include file="../common/header.jsp"%>
		
		<!--banner开始-->
		<div class="banner">
		    <div class="banner_in" id="container">
		        <div id="example">
		            <div id="slides">
		                <div class="slides_container">
		                    <div><a href="#"><img src="${ctx}/resources/img/gundong/banner_04.png" /></a></div>
		                    <div><a href="#"><img src="${ctx}/resources/img/gundong/banner_05.png" /></a></div>
		                    <div><a href="#"><img src="${ctx}/resources/img/gundong/banner_06.png" /></a></div>
		                    <div><a href="#"><img src="${ctx}/resources/img/gundong/banner_07.png" /></a></div>
		                </div>
		                <a href="#" class="prev"><img src="${ctx}/resources/img/arrow-prev.png" alt="Arrow Prev"></a>
		                <a href="#" class="next"><img src="${ctx}/resources/img/arrow-next.png" alt="Arrow Next"></a>
		            </div>
		        </div>
		    </div>
		</div>
		<!--banner结束-->
		
		<div id="backlogDialog" style="overflow-y:hidden!important;"></div>
		
		<!-- footer -->
		<%@include file="../common/footer.jsp"%>
	</body>
</html>
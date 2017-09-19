<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>SGMW</title>
		<%@include file="../common/source.jsp"%>
		
		<script type="text/javascript">
	        
	        $(function(){
	        	
				$("#tt").tabs({
					onSelect : function(title, index) {
						// 刷新 
						//点击 日志管理时会有error信息
						$('#tt').tabs('getTab', index).panel('refresh');
	
						//可能会造成textbox 赋值失败
						/* if ($('#tt').tabs('exists', title)) {
							var currTab = $('#tt').tabs('getTab', title);
							iframe = $(currTab.panel('options').content);
							content = '<iframe scrolling="auto" frameborder="0"  src="' + iframe.attr('src') + '" style="width:100%;height:100%;"></iframe>';
							$('#tt').tabs('update', {
								tab : currTab,
								options : {
									content : content
								}
							});
						} */
					}
				});

				// 选中tab
				$("#tt").tabs('select', parseInt("${choose}"));

				$(".tabs").css("height", "36px");
				$(".tabs-inner").css("height", "35px");
				$(".tabs-inner").css("line-height", "35px");
			});
		</script>
		
	</head>
	
	<body>
		<%@include file="../common/header.jsp"%>
		
		<!--banner-->
		<div class="inbanner XTGL"></div>
		
		<div style="width: auto;height: auto; min-height: 650px; background: #e6e6e6; font-size: 14px;margin-left: 5%;margin-right: 5%;margin-top:20px;margin-bottom: 20px;">
			<div id="tt" class="easyui-tabs" style="width:100%;height:auto;" data-options="plain: true,pill: true, justified: true, narrow: false">
		        <c:if test="${not empty menu.subList}">
		        	<c:forEach items="${menu.subList}" var="vo">
						<div title="${vo.name}" data-options="href:'${ctx}/${vo.url}',closed:true"></div>	        	
		        	</c:forEach>
		        </c:if>
		    </div>
		</div>
		
		<!-- footer -->
		<%@include file="../common/footer.jsp"%>
	</body>
</html>
<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>SGMW</title>
		<link href="${ctx}/resources/css/style.css" rel="stylesheet">
		<link href="${ctx}/resources/css/cssreset.css" rel="stylesheet">
		<script src="${ctx}/resources/js/jquery-2.1.1.min.js"></script>
		
		<link rel="stylesheet" type="text/css" href="${ctx}/resources/js/jquery-easyui-1.5.3/themes/material/easyui.css">
		<link rel="stylesheet" type="text/css" href="${ctx}/resources/js/jquery-easyui-1.5.3/themes/icon.css">
		<script type="text/javascript" src="${ctx}/resources/js/jquery-easyui-1.5.3/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/jquery-easyui-1.5.3/locale/easyui-lang-zh_CN.js"></script>
		
		 <script type="text/javascript">
	        function setTabs(){
	            $('#tt').tabs({
	                plain: $('#plain').is(':checked'),
	                narrow: $('#narrow').is(':checked'),
	                pill: $('#pill').is(':checked'),
	                justified: $('#justified').is(':checked')
	            })
	        }
	    </script>
		
	</head>
	
	<body>
		<%@include file="../common/header.jsp"%>
		
		<!--banner-->
		<div class="inbanner XTGL"></div>
		
		<div style="width: 100%;height: auto; min-height: 650px; background: #e6e6e6; font-size: 14px;">
			<div id="tt" class="easyui-tabs" style="width:100%;height:250px">
		        <div title="About" style="padding:10px">
		            <p style="font-size:14px">jQuery EasyUI framework helps you build your web pages easily.</p>
		            <ul>
		                <li>easyui is a collection of user-interface plugin based on jQuery.</li>
		                <li>easyui provides essential functionality for building modem, interactive, javascript applications.</li>
		                <li>using easyui you don't need to write many javascript code, you usually defines user-interface by writing some HTML markup.</li>
		                <li>complete framework for HTML5 web page.</li>
		                <li>easyui save your time and scales while developing your products.</li>
		                <li>easyui is very easy but powerful.</li>
		            </ul>
		        </div>
		        <div title="My Documents" style="padding:10px">
		            <ul class="easyui-tree" data-options="url:'tree_data1.json',method:'get',animate:true"></ul>
		        </div>
		        <div title="Help" data-options="iconCls:'icon-help',closable:true" style="padding:10px">
		            This is the help content.
		        </div>
		    </div>
		</div>
		
		<!-- footer -->
		<%@include file="../common/footer.jsp"%>
	</body>
</html>
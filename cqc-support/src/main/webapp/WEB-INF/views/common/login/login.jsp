<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@include file="/page/taglibs.jsp"%>

<!DOCTYPE html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>材料数据库登陆认证</title>

	<link href="${ctx}/resources/css/login/login.css" rel="stylesheet" media="all" />

	<!--[if IE]>
	    <style type="text/css">
	        li.remove_frame a {
	            padding-top: 5px;
	            background-position: 0px -3px;
	        }
	    </style>
    <![endif]-->

	<script src="${ctx}/resources/js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript">
        $(document).ready(function () {
            function fixHeight() {
                $("#iframe").attr("height", $(window).height() + 54 + "px");
            }
            $(window).resize(function () {
                fixHeight();
            }).resize();
        });
    </script>
</head>

<body id="by">
	<div id="iframe-wrap">
		<iframe id="iframe" src="${ctx}/form?error=${error}" frameborder="0" width="100%"></iframe>
	</div>
</body>
</html>

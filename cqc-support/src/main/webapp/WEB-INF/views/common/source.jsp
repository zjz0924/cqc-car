<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<link href="${ctx}/resources/frame/css/bootstrap.min.css" rel="stylesheet">
<link href="${ctx}/resources/frame/css/font-awesome.min.css" rel="stylesheet">
<link href="${ctx}/resources/frame/css/style.min.css" rel="stylesheet">
<link href="${ctx}/resources/frame/css/add-ons.min.css" rel="stylesheet">
<link href="${ctx}/resources/frame/css/climacons-font.css" rel="stylesheet">

<script src="${ctx}/resources/js/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/tools.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.7/artDialog.source.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.7/jquery.artDialog.source.js?skin=idialog"></script>
<script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.7/plugins/iframeTools.source.js"></script>


<script type="text/javascript">
	$(function(){
		var permission = "${permission}";
	
		if(permission != "" && permission != null){
			if(permission == "2"){   
				$(":button[btnType='readBtn']").show();
				$(":button[btnType='editBtn']").show();
			}else if(permission == "1"){
				$(":button[btnType='editBtn']").show();
			}
		}
	});
</script>
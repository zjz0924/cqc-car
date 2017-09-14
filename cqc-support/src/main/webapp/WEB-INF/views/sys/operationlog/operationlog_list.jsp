<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>
<%@include file="/page/NavPageBar.jsp"%>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@include file="../../common/source.jsp"%>
	
	<link rel="stylesheet" type="text/css" href="${ctx}/resources/js/jquery-easyui-1.5.3/themes/material/easyui.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/js/jquery-easyui-1.5.3/themes/icon.css">
	<script type="text/javascript" src="${ctx}/resources/js/jquery-easyui-1.5.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${ctx}/resources/js/jquery-easyui-1.5.3/locale/easyui-lang-zh_CN.js"></script>
    
	<script type="text/javascript">
		function goTo(url){
			window.location.href = "${ctx}/operationlog/" + url;
		}

		var url = "${ctx}/operationlog/getLogList?time=" + new Date();
		var datagrid = "dg";
		$(function(){
			 $("#" + datagrid).datagrid({
		        url : url,
		        singleSelect : true, /*是否选中一行*/
		        width:'auto', 
		        pagination : true,  /*是否显示下面的分页菜单*/
		        border:false,
		        rownumbers: true,
		        columns : [ [  {
		            field : 'id', 
		            hidden: 'true'
		        }, {
		            field : 'userName',
		            title : '用户名',
		            width : '160',
		            align : 'center'
		        }, {
		            field : 'type',
		            title : '类型',
		            width : '80',
		            align : 'center'
		        }, {
		            field : 'operation',
		            title : '操作',
		            width : '80',
		            align : 'center'
		        }, {
		            field : 'clientIp',
		            title : '访问IP',
		            width : '100',
		            align : 'center'
		        }, {
		            field : 'detail',
		            title : '详情',
		            width : '450',
		            align : 'center',
		            formatter: formatCellTooltip
		        }, {
		            field : 'time',
		            title : '时间',
		            width : '140',
		            align : 'center',
		            formatter: DateTimeFormatter
		        }
		        ]],
		        onClickRow:function(rowIndex,rowData){
		        	goTo('detail?id='+ rowData.id);
		       	}
		    });
			
			// 分页信息
			$('#' + datagrid).datagrid('getPager').pagination({  
                pageSize: "${defaultPageSize}",  
                pageNumber: 1,  
                displayMsg: '当前显示 {from} - {to} 条记录    共  {total} 条记录',
                onSelectPage: function (pageNumber, pageSize) {//分页触发  
                	var data = {
                        'userName' : $("#userName").val(),
                        'type' : $("#type").val(),
                        'startTimeFrom' : $("#startTimeFrom").val(),
                        'startTimeTo' : $("#startTimeTo").val(),
                        'operation' : $("#operation").val(),
                        'pageNum' : pageNumber,
                        'pageSize' : pageSize
                    }
                	getData(datagrid, url, data);
            	} 
			});
			
			adjustHeight();
		});
		
		function doSearch(){
			var data = {
                'userName' : $("#userName").val(),
                'type' : $("#type").val(),
                'startTimeFrom' : $("#startTimeFrom").val(),
                'startTimeTo' : $("#startTimeTo").val(),
                'operation' : $("#operation").val()
            }
			getData(datagrid, url, data);
		}
		
		function doClear(){
			$("#userName").textbox('setValue', "");
			$("#operation").combobox('select', "");  
			$("#type").combobox('select', "");
			$("#startTimeFrom").val('');
			$("#startTimeTo").val('');
			getData(datagrid, url, {});
		}
		
		
	</script>
</head>

<body>

	<div class="row">
		<div class="col-lg-12">
			<ol class="breadcrumb">
				<li>系统管理</li>
				<li><a href="${ctx}/operationlog/list">日志管理</a></li>
			</ol>
		</div>
	</div>

	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2><span class="break"></span><strong>日志管理</strong></h2>
				</div>

				<div class="panel-body">
					<div style="margin-top: 15px; padding-left: 20px; margin-bottom: 30px;">
						<input id="userName" name="userName" class="easyui-textbox"  label="用户名:" labelPosition="left" style="width: 200px;"> &nbsp;&nbsp;&nbsp;
						
						<select id="type" name="type" class="easyui-combobox" label="类型" labelPosition="left" style="width: 200px;" data-options="panelHeight:'auto'"> 
							<option value="">全部</option>
							<c:forEach items="${typeList}" var="vo">
-                               <option value="${vo}">${vo}</option>
-                           </c:forEach>
						</select> &nbsp;&nbsp;&nbsp;
						
						<select id="operation" name="operation" class="easyui-combobox" data-options="panelHeight:'auto'" label="操作" labelPosition="left" style="width: 200px;margin-right:20px;" >
							<option value="">全部</option>
							<c:forEach items="${operationList}" var="vo">
                               <option value="${vo}">${vo}</option>
                            </c:forEach>
						</select>&nbsp;&nbsp;&nbsp;
		
						 <input type="text" id="startTimeFrom" name="startTimeFrom" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'startTimeTo\')}'})" class="textbox" style="line-height: 23px;width:120px;display:inline-block"/> -
-                        <input type="text" id="startTimeTo" name="startTimeTo" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startTimeFrom\')}'})" class="textbox" style="line-height: 23px;width:120px;display:inline-block"/>
						
						<p style="margin-right: 20px;">
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px;" onclick="doSearch()">查询</a>
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px;" onclick="doClear()">清空</a>
						</p>
					</div>

					<div style="margin-top:30px;">
						<table id="dg" style="height:500px;width:auto"></table>
					</div>
					
				</div>
			</div>
		</div>
		<!--/col-->
	</div>
	<!--/row-->
</body>
</html>
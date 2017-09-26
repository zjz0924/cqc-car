<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<div style="margin-top: 15px; padding-left: 20px; margin-bottom: 10px;">
		类型：<input id="q_name" name="q_name" class="easyui-textbox" style="width: 150px;">
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px;" onclick="doSearch()">查询</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" style="width:80px;" onclick="doClear()">清空</a>
	</div>
			
	<div style="margin-top:10px;">
		<table id="dictionaryTable" style="height:auto;width:auto"></table>
	</div>
	
	<div id="dictionaryDialog"></div>
	
	<script src="${ctx}/resources/js/jquery.form.js"></script>
	<script type="text/javascript">
		var url = "${ctx}/dictionary/getList?time=" + new Date();
		var detailUrl = "${ctx}/dictionary/detail";
		var datagrid = "dictionaryTable";
		
		var toolbar = [{
            text:'新增',
            iconCls:'icon-add',
            handler: function(){
            	info(detailUrl);	
            }
        }, '-',  {
            text:'编辑',
            iconCls:'icon-edit',
            handler: function(){
            	var row = $("#" + datagrid).datagrid('getSelected');
            	if(isNull(row)){
            		errorMsg("请选择一条记录进行操作!");
            		return;
            	}
            	
            	info(detailUrl + "?id=" + row.id);	
            }
        }, '-',  {
			text : '删除',
			iconCls : 'icon-delete',
			handler : function() {
				var row = $("#" + datagrid).datagrid('getSelected');
            	if(isNull(row)){
            		errorMsg("请选择一条记录进行操作!");
            		return;
            	}
            	
            	 $.messager.confirm('系统提示', "此操作将删除该用户密码，您确定要继续吗？", function(r){
                     if (r){
                         $.ajax({
                         	url: "${ctx}/dictionary/delete",
                         	data: {
                         		id: row.id,
                         	},
                         	success: function(data){
                         		if(data.success){
                         			tipMsg(data.msg, function(){
                						$('#' + datagrid).datagrid('reload');
                					});
                 				}else{
                 					errorMsg(data.msg);
                 				}
                         	}
                         });
                     }
                 });
			}
		}];
		
		
		$(function(){
			 $("#" + datagrid).datagrid({
		        url : url,
		      //  checkOnSelect: true,
		        singleSelect : true, /*是否选中一行*/
		        height: '600px',
		        width:'auto', 
		        pagination : true,  /*是否显示下面的分页菜单*/
		        border:false,
		        rownumbers: true,
		        toolbar : toolbar,
		        title: "字典信息",
		        idField: 'id',
		        columns : [ [  /* {
		        	field: 'ck',
		        	checkbox: true
		        }, */{
		            field : 'id', 
		            hidden: 'true'
		        }, {
		            field : 'name',
		            title : '类型',
		            width : '200',
		            align : 'center',
		            formatter: formatCellTooltip
		        }, {
		            field : 'val',
		            title : '值',
		            width : '200',
		            align : 'center',
		            formatter: formatCellTooltip
		        }, {
		            field : 'desc',
		            title : '描述',
		            width : '500',
		            align : 'center',
		            formatter: formatCellTooltip
		        }
		        ] ],
				onDblClickRow : function(rowIndex, rowData) {
					info(detailUrl + "?id=" + rowData.id);
				}
			});

			// 分页信息
			$('#' + datagrid).datagrid('getPager').pagination({
				pageSize : "${defaultPageSize}",
				pageNumber : 1,
				displayMsg : '当前显示 {from} - {to} 条记录    共  {total} 条记录',
				onSelectPage : function(pageNumber, pageSize) {//分页触发  
					var data = {
						'name' : $("#q_name").textbox("getValue"), 
						'pageNum' : pageNumber,
						'pageSize' : pageSize
					}
					getData(datagrid, url, data);
				}
			});

		});

		function doSearch() {
			var data = {
				'name' : $("#q_name").textbox("getValue"), 
			}
			getData(datagrid, url, data);
		}

		function doClear() {
			$("#q_name").textbox('clear');
			getData(datagrid, url, {});
		}

		function info(url) {
			$('#dictionaryDialog').dialog({
				title : '字典信息',
				width : 400,
				height : 250,
				closed : false,
				cache : false,
				href : url,
				modal : true
			});
			$('#dictionaryDialog').window('center');
		}
		
		// 关掉对话时回调
		function closeDialog(msg) {
			$('#dictionaryDialog').dialog('close');
			tipMsg(msg, function(){
				$('#' + datagrid).datagrid('reload');
			});
		}
	</script>
	
	
	<style style="text/css">
		.datagrid-btable tr {
			height: 30px;
		}
		
		.datagrid-header {
			background: linear-gradient(to bottom, #BFDEFF 0, #F2F2F2 100%)
		}
		
		.datagrid-header-row {
			font-weight: bold;
			height: 50px
		}
		
		.datagrid-row-over, .datagrid-header td.datagrid-header-over {
		    background: #e6e6e6;
		    color: #00438a;
		    cursor: default;
		}
		
		.lock-unlock {
			display: inline-block;
		    width: 16px;
		    height: 16px;
		    margin-right: 3px;
		}
	</style>
	
</body>

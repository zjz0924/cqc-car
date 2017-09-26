<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

<body>
	<div style="margin-top: 15px; padding-left: 20px; margin-bottom: 10px;">
		<div>
			用户名：<input id="q_account" name="q_account" class="easyui-textbox" style="width: 150px;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			姓名：<input id="q_nickName" name="q_nickName" class="easyui-textbox" style="width: 150px;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		
			状态: <select id="q_lock" name="q_lock"  class="easyui-combobox" style="width: 150px;" data-options="panelHeight:'auto'">
			   <option value="">全部</option>
	           <option value="N" <c:if test="${lock == 'N'}">selected=selected</c:if>>正常</option>
	           <option value="Y" <c:if test="${lock == 'Y'}">selected=selected</c:if>>锁定</option>
	      	</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	      	
	      	机构：<input id="q_org" name="q_org"  class="easyui-combotree" data-options="url:'${ctx}/org/tree'" style="width: 150px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	      	
	      	手机号码：<input id="q_mobile" name="q_mobile" class="easyui-textbox" style="width: 150px;">
		</div>
	
		<div style="margin-top:15px;">
			创建时间：<input type="text" id="q_startCreateTime" name="q_startCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'q_endCreateTime\')}'})" class="textbox" style="line-height: 23px;width:150px;display:inline-block"/> - 
			   	   <input type="text" id="q_endCreateTime" name="q_endCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'q_startCreateTime\')}'})" class="textbox"  style="line-height: 23px;width:150px;display:inline-block;margin-right:60px;"/>
	
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px;" onclick="doSearch()">查询</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" style="width:80px;" onclick="doClear()">清空</a>
		</div>
	</div>
			
	<div style="margin-top:10px;">
		<table id="accountTable" style="height:auto;width:auto"></table>
	</div>
	
	<div id="accountDialog"></div>
	
	<!-- Excel 导入 -->
	<div id="excelDialog" class="easyui-dialog" title="用户导入" style="width: 300px; height: 200px; padding: 10px;" data-options="modal: true" closed="true">
		<form method="POST" enctype="multipart/form-data" id="uploadForm">
			<div>
				请选择要导入的文件（<span style="color: red;">只支持 Excel</span>）：
			</div>
			
			<div style="margin-top: 10px;">
				<input class="easyui-filebox" id="upfile" name="upfile" style="width: 90%" data-options="buttonText: '选择文件'">
				<p id="fileInfo" style="color:red;margin-top:5px;"></p>
			</div>
			
			<div style="margin-top: 15px;">
				<a href="javascript:void(0);" class="easyui-linkbutton" style="width: 90%" onclick="importExcel()">上传</a>
			</div>
			
			<div id="result" style="margin-top:5px;"></div>
		</form>
	</div>
	
	<script src="${ctx}/resources/js/jquery.form.js"></script>
	<script type="text/javascript">
		var url = "${ctx}/account/getList?time=" + new Date();
		var detailUrl = "${ctx}/account/detail";
		var datagrid = "accountTable";
		
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
			text : '重置密码',
			iconCls : 'icon-key',
			handler : function() {
				var row = $("#" + datagrid).datagrid('getSelected');
            	if(isNull(row)){
            		errorMsg("请选择一条记录进行操作!");
            		return;
            	}
            	
            	 $.messager.confirm('系统提示', "此操作将重置该用户密码，您确定要继续吗？", function(r){
                     if (r){
                         $.ajax({
                         	url: "${ctx}/account/resetPwd",
                         	data: {
                         		id: row.id,
                         	},
                         	success: function(data){
                         		if(data.success){
                 					tipMsg(data.msg);
                 				}else{
                 					errorMsg(data.msg);
                 				}
                         	}
                         });
                     }
                 });
            	
			}
		}, '-',  {
			text : '导入',
			iconCls : 'icon-import',
			handler : function() {
				$('#excelDialog').dialog('open');
				$('#excelDialog').window('center');
			}
		}, '-',  {
			text : '导出',
			iconCls : 'icon-export',
			handler : function() {
				window.location.href = "${ctx}/account/exportUser";
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
                         	url: "${ctx}/account/delete",
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
		        width:'auto', 
		        pagination : true,  /*是否显示下面的分页菜单*/
		        border:false,
		        rownumbers: true,
		        toolbar : toolbar,
		        title: "用户信息",
		        idField: 'id',
		        columns : [ [  /* {
		        	field: 'ck',
		        	checkbox: true
		        }, */{
		            field : 'id', 
		            hidden: 'true'
		        }, {
		            field : 'userName',
		            title : '用户名',
		            width : '120',
		            align : 'center',
		            formatter: formatCellTooltip
		        }, {
		            field : 'nickName',
		            title : '姓名',
		            width : '120',
		            align : 'center',
		            formatter: formatCellTooltip
		        }, {
		            field : 'mobile',
		            title : '手机号码',
		            width : '120',
		            align : 'center',
		            formatter: formatCellTooltip
		        }, {
		            field : 'org',
		            title : '机构名称',
		            width : '160',
		            align : 'center',
		            formatter: function(val){
		            	if(val){
		            		return "<span title='" + val.name + "'>" + val.name + "</span>";
		            	}
		            }
		        }, {
		            field : 'roleList',
		            title : '角色',
		            width : '180',
		            align : 'center',
		            formatter: function(val){
						if (val) {
							var data = "";
							for (var i = 0; i < val.length; i++) {
								var obj = val[i];
								if (i != val.length - 1) {
									data += obj.name + ",";
								} else {
									data += obj.name;
								}
							}
							return "<span title='" + data + "'>" + data + "</span>";
						}
					}
				}, {
					field : 'email',
					title : '邮箱',
					width : '140',
					align : 'center',
					formatter : formatCellTooltip
				}, {
					field : 'lock',
					title : '操作',
					width : '120',
					align : 'center',
					formatter : function(val, row){
						if(!isNull(val) && val == 'Y'){
							return '<a class="editlock l-btn l-btn-small l-btn-plain" href="javascript:void(0);" onclick="lockOrUnlock(' + row.id + ', \'N\')"><span class="icon-timg lock-unlock">&nbsp;</span><span style="color:red;font-weight:bold;" title="解锁">解锁 </span></a>';
						}else{
							return '<a class="editlock l-btn l-btn-small l-btn-plain" href="javascript:void(0);"  onclick="lockOrUnlock(' + row.id + ', \'Y\')"><span class="icon-lock1 lock-unlock">&nbsp;</span><span title="锁定">锁定</span></a>';
						}
					}
				}, {
					field : 'createTime',
					title : '创建时间',
					width : '150',
					align : 'center',
					formatter : DateTimeFormatter
				} ] ],
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
						'userName' : $("#q_account").textbox("getValue"), 
						'nickName' : $("#q_nickName").textbox("getValue"),
						'startCreateTime' : $("#q_startCreateTime").val(),
						'endCreateTime' : $("#q_endCreateTime").val(),
						'mobile': $("#q_startTimeTo").textbox("getValue"),
						'lock': $("#q_lock").val(),
						'orgId': $("#q_org").combotree("getValue"),
						'pageNum' : pageNumber,
						'pageSize' : pageSize
					}
					getData(datagrid, url, data);
				}
			});

		});

		function doSearch() {
			var data = {
				'userName' : $("#q_account").textbox("getValue"), 
				'nickName' : $("#q_nickName").textbox("getValue"),
				'startCreateTime' : $("#q_startCreateTime").val(),
				'endCreateTime' : $("#q_endCreateTime").val(),
				'mobile': $("#q_mobile").textbox("getValue"),
				'lock': $("#q_lock").val(),
				'orgId': $("#q_org").combotree("getValue")
			}
			getData(datagrid, url, data);
		}

		function doClear() {
			$("#q_account").textbox('clear');
			$("#q_nickName").textbox('clear');
			$("#q_mobile").textbox('clear');
			$("#q_lock").combobox('select', "");
			$("#q_startCreateTime").val('');
			$("#q_endCreateTime").val('');
			$("#q_org").combotree("setValue","");
			
			getData(datagrid, url, {});
		}

		function info(url) {
			$('#accountDialog').dialog({
				title : '用户信息',
				width : 450,
				height : 400,
				closed : false,
				cache : false,
				href : url,
				modal : true
			});
			$('#accountDialog').window('center');
		}
		
		function lockOrUnlock(id, type){
			var message = "此操作将解锁该用户，您确定要继续吗？";
			if(type == "Y"){
				message = "此操作将锁定该用户，您确定要继续吗？";
			}
			
			 $.messager.confirm('系统提示', message, function(r){
                if (r){
                    $.ajax({
                    	url: "${ctx}/account/lock",
                    	data: {
                    		id: id,
                    		lock: type
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
		
		// 关掉对话时回调
		function closeDialog(msg) {
			$('#accountDialog').dialog('close');
			tipMsg(msg, function(){
				$('#' + datagrid).datagrid('reload');
			});
		}
		
		function importExcel() {
			$("#result").html("");
			
			var fileDir = $("#upfile").filebox("getValue");
			var suffix = fileDir.substr(fileDir.lastIndexOf("."));
			if ("" == fileDir) {
				$("#fileInfo").html("请选择要导入的Excel文件");
				return false;
			}
			if (".xls" != suffix && ".xlsx" != suffix) {
				$("#fileInfo").html("请选择Excel格式的文件导入！");
				return false;
			}
			
			$("#fileInfo").html("");

			$('#uploadForm').ajaxSubmit({
				url : '${ctx}/account/importUser',
				dataType : 'text',
				success : function(msg) {
					var data = eval('(' + msg + ')');
					$("#upfile").filebox("clear");
					$("#result").html(data.msg);
					$('#' + datagrid).datagrid('reload');
				}
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

<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp"%>

	<body>
		<div style="margin-top: 15px; padding-left: 20px; margin-bottom: 10px;font-size:12px;">
			<div>
				<span class="title_span" style="width: 80px;">用户名：</span>
				<input id="q_parent_account" name="q_parent_account" class="easyui-textbox" style="width: 175px;">
				
				<span class="title_span">手机号码：</span>
				<input id="q_parent_mobile" name="q_parent_mobile" class="easyui-textbox" style="width: 130px;">
				
				<span class="title_span" >姓名：</span>
				<input id="q_parent_nickName" name="q_parent_nickName" class="easyui-textbox" style="width: 130px;">
			
		      	
		      	<span class="title_span">机构：</span>
		      	<input id="q_parent_org" name="q_parent_org"  class="easyui-combotree" data-options="url:'${ctx}/org/tree'" style="width: 230px;">
		      	
			</div>
		
			<div style="margin-top:10px;">
				<span class="title_span" style="width: 80px;">状态：</span> 
				<select id="q_parent_lock" name="q_parent_lock"  class="easyui-combobox" style="width: 175px;" data-options="panelHeight:'auto'">
				   <option value="">全部</option>
		           <option value="N" <c:if test="${lock == 'N'}">selected=selected</c:if>>正常</option>
		           <option value="Y" <c:if test="${lock == 'Y'}">selected=selected</c:if>>锁定</option>
		      	</select>
		      	
		      	<span class="title_span">是否收费：</span> 
				<select id="q_parent_isCharge" name="q_parent_isCharge"  class="easyui-combobox" style="width: 130px;" data-options="panelHeight:'auto'">
				   <option value="">全部</option>
		           <option value="0">否</option>
		           <option value="1">是</option>
		      	</select>
		      	
		      	<span class="title_span">科室：</span> 	
				<select id="q_parent_department" name="q_parent_department"  class="easyui-combobox" style="width: 130px;" data-options="panelHeight:'200px'">
		      		<option value="">全部</option>
		      		<c:forEach items="${departmentList}" var="vo">
		      			<option value="${vo.name}">${vo.name}</option>
		      		</c:forEach>
		      	</select>
				
		      	<span class="title_span">角色： </span>
		      	<input id="q_parent_role" name="q_parent_role" style="width: 230px;">
			</div>
			
			<div style="margin-top:10px;">
				<span class="title_span" style="width: 80px;">上级用户名：</span>
				<input id="q_parent_parentUserName" name="q_parent_parentUserName" class="easyui-textbox" style="width: 175px;">
				
				<span class="title_span">创建时间：</span>
				<input type="text" id="q_parent_startCreateTime" name="q_parent_startCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'q_parent_endCreateTime\')}'})" class="textbox" style="line-height: 23px;width:80px;display:inline-block"/> - 
				<input type="text" id="q_parent_endCreateTime" name="q_parent_endCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'q_parent_startCreateTime\')}'})" class="textbox"  style="line-height: 23px;width:80px;display:inline-block;"/>&nbsp;&nbsp;
			
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px;" onclick="doParentSearch()">查询</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" style="width:80px;" onclick="doParentClear()">清空</a>
			</div>
		</div>
				
		<div style="margin-top:10px;">
			<table id="parentTable" style="height:auto;width:auto"></table>
		</div>
		
		<script type="text/javascript">
			var parentDataUrl = "${ctx}/account/getList";
			var parentDatagrid = "parentTable";
			
			var toolbar = [{
	           text:'选择',
	           iconCls:'icon-add',
	           handler: function(){
	        	    var row = $('#' + parentDatagrid).datagrid('getSelected');
	        	    doChoose(row);
	           }
	        }];
			
			$(function(){
				 $("#" + parentDatagrid).datagrid({
			        url : parentDataUrl,
			      //  checkOnSelect: true,
			        singleSelect : true, /*是否选中一行*/
			        width:'auto', 
			        toolbar: toolbar,
			        pagination : true,  /*是否显示下面的分页菜单*/
			        border:false,
			        rownumbers: true,
			        height: '400px',
			        title: "用户信息",
			        idField: 'id',
			        frozenColumns:[[ {
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
				            width : '130',
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
				            field : 'parent',
				            title : '上级用户名',
				            width : '160',
				            align : 'center',
				            formatter: function(val){
				            	if(val){
				            		return "<span title='" + val.userName + "'>" + val.userName + "</span>";
				            	}
				            }
				        }
			        ]],
			        columns : [ [{
			            field : 'department',
			            title : '科室',
			            width : '120',
			            align : 'center',
			            sortable: true,
			            formatter: formatCellTooltip
			        }, {
			            field : 'role',
			            title : '角色',
			            width : '140',
			            align : 'center',
			            formatter: function(val){
			            	if(val){
			            		return "<span title='" + val.name + "'>" + val.name + "</span>";
			            	}
						}
					}, {
			            field : 'mobile',
			            title : '手机号码',
			            width : '100',
			            align : 'center',
			            formatter: formatCellTooltip
			        }, {
						field : 'email',
						title : '邮箱',
						width : '140',
						align : 'center',
						formatter : formatCellTooltip
					}, {
						field : 'isCharge',
						title : '是否收费',
						width : '80',
						align : 'center',
						formatter : function(val){
							var str = "是";
							if(isNull(val) || val == 0){
								str = "否";
							}
							return "<span title='" + str + "'>" + str + "</span>";
						}
					}, {
						field : 'createTime',
						title : '创建时间',
						width : '150',
						align : 'center',
						formatter : DateTimeFormatter
					} ] ],
					onDblClickRow: function(index,row){
						doChoose(row);
					}
				});
		
				// 分页信息
				$('#' + parentDatagrid).datagrid('getPager').pagination({
					pageSize : "${defaultPageSize}",
					pageNumber : 1,
					displayMsg : '当前显示 {from} - {to} 条记录    共  {total} 条记录',
					onSelectPage : function(pageNumber, pageSize) {//分页触发  
						var data = {
							'userName' : $("#q_parent_account").textbox("getValue"), 
							'nickName' : $("#q_parent_nickName").textbox("getValue"),
							'startCreateTime' : $("#q_parent_startCreateTime").val(),
							'endCreateTime' : $("#q_parent_endCreateTime").val(),
							'mobile': $("#q_parent_mobile").textbox("getValue"),
							'lock': $("#q_parent_lock").val(),
							'isCharge': $("#q_parent_isCharge").val(),
							'orgId': $("#q_parent_org").combotree("getValue"),
							'roleId': $("#q_parent_role").combotree("getValue"),
							'department': $("#q_parent_department").combobox("getValue"),
							'parentUserName': $("#q_parent_parentUserName").textbox("getValue"),
							'pageNum' : pageNumber,
							'pageSize' : pageSize
						}
						getData(parentDatagrid, parentDataUrl, data);
					}
				});
				
				
				$('#q_parent_role').combotree({
					url: '${ctx}/role/tree',
					multiple: false,
					animate: true,
					onBeforeSelect: function(node){
					   if(node.id.indexOf("r") != -1){
							return true;
					   }else{
						   return false;
					   }
				    }
				});
			});
		
			function doParentSearch() {
				var data = {
					'userName' : $("#q_parent_account").textbox("getValue"), 
					'nickName' : $("#q_parent_nickName").textbox("getValue"),
					'startCreateTime' : $("#q_parent_startCreateTime").val(),
					'endCreateTime' : $("#q_parent_endCreateTime").val(),
					'mobile': $("#q_parent_mobile").textbox("getValue"),
					'lock': $("#q_parent_lock").val(),
					'isCharge': $("#q_parent_isCharge").val(),
					'orgId': $("#q_parent_org").combotree("getValue"),
					'roleId': $("#q_parent_role").combotree("getValue"),
					'department': $("#q_parent_department").combobox("getValue"),
					'parentUserName': $("#q_parent_parentUserName").textbox("getValue")
				}
				getData(parentDatagrid, parentDataUrl, data);
			}
		
			function doParentClear() {
				$("#q_parent_account").textbox('clear');
				$("#q_parent_nickName").textbox('clear');
				$("#q_parent_mobile").textbox('clear');
				$("#q_parent_lock").combobox('select', "");
				$("#q_parent_isCharge").combobox('select', "");
				$("#q_parent_startCreateTime").val('');
				$("#q_parent_endCreateTime").val('');
				$("#q_parent_org").combotree("setValue","");
				$("#q_parent_role").combotree("setValue","");
				$("#q_parent_department").combobox("select", "");
				$("#q_parent_parentUserName").textbox("setValue", "")
				getData(parentDatagrid, parentDataUrl, {});
			}
			
			function doChoose(row){
				if(!isNull(row)){
					if(row.userName == "${currentUserName}"){
						errorMsg("错误提示：不能选择自己作为上级");
						return false;
					}else{
						var p1 = row.parent;
						if(!isNull(p1)){
							var p2 = p1.parent;
							if(!isNull(p2)){
								var p3 = p2.parent;
								
								if(!isNull(p3.parent)){
									errorMsg("错误提示：当前选择的用户上级已经超过3级，请重新选择");
									return false;
								}
							}
						}
						
						$("#pName").textbox("setValue", row.nickName);
						$("#pId").val(row.id);
						   
						$("#parentDialog").dialog("close");
					}
				}else{
					errorMsg("请选择用户");
					return false;
				}
			}
		</script>
		
		
		<style style="text/css">
			.title_span{
				display: inline-block;
				width: 70px;
				text-align: right;
			}
		</style>
	</body>
</html>

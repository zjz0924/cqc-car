/**
 *  工具类
 */


/**
 *  判断是否为空
 */
function isNull(data){
	if(data == null || data == "" || data == "undefined"){
		return true;
	}else{
		return false;
	}
}


/**
 * 判断是否为正整数
 */ 
function isPositiveNum(num){
	if(num == 0){
		return true;
	}
	
	var re = /^[0-9]*[1-9][0-9]*$/; 
	return re.test(num) 
}


/**
 * 判断是否为正整数, 则提示
 * @param field  字段ID
 * @param type   提示的字段名称
 * @returns {Boolean}
 */
function isPositive(field, type){
	if (!isPositiveNum($("#"+field).val())) {
		errorMsg("系统提示：提交失败，" + type + "为正整数");
		$("#" + field).focus();
		return false;
	}
	return true;
}


/**
 * 判断字段是否必填
 * @param field  字段ID
 * @param type   提示的字段名称
 * @returns {Boolean}
 */
function isRequired(field, type) {
	var data = $("#" + field).val();

	if (data == null || data == "" || data == "undefined") {
		errorMsg("系统提示：提交失败，" + type + "为必填");
		$("#" + field).focus();
		return false;
	}
	return true;
}


/**
 * 是否为数字
 * @param field
 * @param type
 * @returns {Boolean}
 */
function isDouble(field, type) {
	var data = $("#" + field).val();

	if (isNaN($("#"+ field).val())) {
		errorMsg("系统提示：提交失败，" + type + "为数字");
		$("#" + field).focus();
		return false;
	}
	return true;
}


/**
 * 判断两个密码是否相等
 * @param val1
 * @param val2
 * @returns {Boolean}
 */
function isEqual(val1, val2) {
	var data1 = $("#" + val1).val();
	var data2 = $("#" + val2).val();

	if (data1 != data2) {
		errorMsg("系统提示：提交失败，两次输入密码不一致");
		$("#" + val1).focus();
		$("#" + val1).val("");
		$("#" + val2).val("");
		return false;
	}
	return true;
}


/**
 *  检查金额输入
 */
function checkMoney(id){
	var money = $("#"+ id).val();
	if(isNull(money)){
		errorMsg("请输入金额");
		$("#"+ id).focus();
		return false;
	}
	if(isNaN(money)){
		errorMsg("请输入数字");
		$("#"+ id).focus();
		$("#"+ id).val('');
		return false;
	}
	return true;
}

/**
 * 检查手机号码 
 * @param mobile
 */
function checkMobile(mobile){
	if (!(/^1[3|4|5|7|8]\d{9}$/.test(mobile))) {
		return false;
	}
	return true;
}


/**
 * 	格式化数字 （少于10的在前面加上0）
 */ 
function formatNum(val){
	if(parseInt(val) < 10){
		val = "0" + val;
    }
	return val;
}

/**
 * 格式化日期
 * @param date  整型 
 */
function formatDate(time){
	if(isNull(time)){
		return "";
	}else{
		var date = new Date(time * 1000);
		var str = date.getFullYear() + "-" + formatNum(date.getMonth()+1) + "-" + formatNum(date.getDate()) + " " + formatNum((date.getHours())) + ":" + formatNum(date.getMinutes()) + ":" + formatNum(date.getSeconds());
		return str; 
	}
}


/**
 * 成功提示信息
 * @param msg       信息
 * @param callback  回调函数
 * @param time      窗口关闭时间
 */
function tipMsg(msg, callback, time){
	var time = 2;
	if(!isNull(time)){
		time = time;
	}
	art.dialog.tips(msg, time, "succeed", callback);
}


/**
 * 错误提示信息
 * @param msg       信息
 * @param callback  回调函数
 * @param time      窗口关闭时间
 */
function errorMsg(msg, callback, time){
	var time = 2;
	if(!isNull(time)){
		time = time;
	}
	art.dialog.tips(msg, time, "error", callback);
}


/**
 * 清空查询框
 */
function doCancel(){
	$(":input").val("");
	doSubmit();
}

/**
 * 提交表单
 */
function doSubmit(){
	$("#queryForm").submit();
}


/**
 * 页面跳转
 * @param url
 */
function goTo(url){
	window.location.href = url;
}


/**
 * 确认对话框
 * @param tips 要提示的信息
 * @param url  提交的url
 */
function confirm(tips, url){
	art.dialog.confirm(tips, function () {
		$.ajax({
			url: url + "&time=" + new Date(),
			success: function(data){
				var suc = data.success;
				
				if(suc){
					tipMsg(data.msg, function(){
						window.location.reload();
					});
				}else{
					errorMsg(data.msg);
				}
			}
		});
	});
}


/**
 * 检查 email 格式
 */
function checkEmail(email) {
	var re = /^(?:\w+\.?)*\w+@(?:\w+\.)*\w+$/;
	if (!re.test(email)) {
		return false;
	}
	return true;
}










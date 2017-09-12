package cn.wow.support.utils;

public class Contants {

	//操作提示信息
	public final static String SAVE_SUCCESS_MSG = "系统提示：数据添加成功";
	public final static String SAVE_FAIL_MSG = "系统提示：数据添加失败";
	public final static String EDIT_SUCCESS_MSG = "系统提示：数据修改成功";
	public final static String EDIT_FAIL_MSG = "系统提示：数据修改失败";
	public final static String EXCEPTION_MSG = "系统提示：系统异常，请重试";
	public final static String DELETE_FAIL_MSG = "系统提示：数据删除失败";
	public final static String DELETE_SUCCESS_MSG = "系统提示：数据删除成功";
	
	//提示类型
	public final static Integer SUC_ADD = 1;    //添加成功
	public final static Integer FAIL_ADD = 2;   //添加失败
	public final static Integer SUC_EDIT = 3;    //编辑成功
	public final static Integer FAIL_EDIT = 4;   //编辑失败
	public final static Integer SUC_DELETE = 5;    //删除成功
	public final static Integer FAIL_DELETE = 6;   //删除失败
	public final static Integer EXCEP = 6;   //删除失败
	
	/** 添加/编辑 返回编码  **/
	public final static String SAVE_SUCCESS = "01";
	public final static String SAVE_FAIL = "02";
	public final static String EDIT_SUCCESS = "03";
	public final static String EDIT_FAIL = "04";
	public final static String EXCEPTION = "05";
	
	// 验证码
	public static final String VERIFYCODE = "verifyCode";
	
	public static final String CURRENT_ACCOUNT = "currentAccount";
	public static final String CURRNET_PERMISSION = "currentPermission";
	
	
	// Controller 别名
	public static final String ACCOUNT = "account_manager";
	public static final String ROLE = "role_manager";
	public static final String OPERATIONLOG = "log_manager";
}

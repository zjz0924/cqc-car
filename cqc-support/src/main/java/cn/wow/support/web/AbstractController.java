package cn.wow.support.web;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import cn.wow.common.domain.RolePermission;
import cn.wow.common.utils.AjaxVO;
import cn.wow.support.utils.Contants;

/**
 * 共享控制器
 * 
 * @author zhenjunzhuo 2017-1-5
 */
public class AbstractController {

	// 照片上传根路径
	@Value("${img.root.url}")
	private String rootPath;

	// 照片资源路径
	@Value("${res.url.root}")
	protected String resUrl;

	/**
	 * 返回响应结果
	 * 
	 * @param vo
	 *            返回对象
	 * @param msg
	 *            提示信息
	 * @param flag
	 *            结果
	 */
	public void getResponse(AjaxVO vo, int type) {
		String information = null;
		boolean flag = true;

		switch (type) {
		case 1: // 添加成功
			information = Contants.SAVE_SUCCESS_MSG;
			flag = true;
			break;
		case 2: // 添加失败
			information = Contants.SAVE_FAIL_MSG;
			flag = false;
			break;
		case 3: // 修改成功
			information = Contants.EDIT_SUCCESS_MSG;
			flag = true;
			break;
		case 4: // 修改失败
			information = Contants.EDIT_FAIL_MSG;
			flag = false;
			break;
		case 5: // 删除成功
			information = Contants.DELETE_SUCCESS_MSG;
			flag = true;
			break;
		case 6: // 删除失败
			information = Contants.DELETE_FAIL_MSG;
			flag = false;
			break;
		case 7: // 异常
			information = Contants.EXCEPTION_MSG;
			flag = false;
			break;
		}

		vo.setSuccess(flag);
		vo.setMsg(information);
	}

	/**
	 * 返回响应结果
	 * 
	 * @param vo
	 *            返回对象
	 * @param msg
	 *            提示信息
	 * @param flag
	 *            结果
	 */
	public void getResponse(AjaxVO vo, boolean flag, String msg) {
		vo.setSuccess(flag);
		vo.setMsg(msg);
	}

	/**
	 * 普通照片上传
	 */
	public String uploadImg(MultipartFile multipartFile, String path) throws Exception {
		if (multipartFile != null && multipartFile.getSize() > 0) {
			// 原始文件名
			String sourceName = multipartFile.getOriginalFilename();
			String newName = System.currentTimeMillis() + sourceName.substring(sourceName.indexOf("."));
			// 文件上传路径
			String uploadPath = rootPath + "/" + path;

			File uploadPathFile = new File(uploadPath);
			if (!uploadPathFile.exists()) {
				uploadPathFile.mkdirs();
			}

			File srcFile = new File(uploadPath + newName);
			multipartFile.transferTo(srcFile);

			return path + newName;
		}

		return null;
	}

	/**
	 * ckeditor 文件上传（图片上传/超链接文件上传）
	 */
	@RequestMapping(value = "uploadEditorFile")
	public void uploadFile(@RequestParam("upload") MultipartFile multipartFile, HttpServletRequest request,
			HttpServletResponse response) {
		response.setContentType("text/html;charset=UTF-8");
		response.setHeader("X-Frame-Options", "SAMEORIGIN");
		String CKEditorFuncNum = request.getParameter("CKEditorFuncNum");
		// 类型
		String type = request.getParameter("type");

		try {
			PrintWriter out = null;

			String fileName = multipartFile.getOriginalFilename();
			String uploadContentType = multipartFile.getContentType();

			/*
			 * String expandedName =""; if
			 * (uploadContentType.equals("image/pjpeg")||
			 * uploadContentType.equals("image/jpeg")) { //
			 * IE6上传jpg图片的headimageContentType是image/pjpeg，
			 * 而IE9以及火狐上传的jpg图片是image/jpeg expandedName = ".jpg"; } else if
			 * (uploadContentType.equals("image/png") ||
			 * uploadContentType.equals("image/x-png")) { //
			 * IE6上传的png图片的headimageContentType是"image/x-png" expandedName =
			 * ".png"; } else if (uploadContentType.equals("image/gif")) {
			 * expandedName = ".gif"; } else if
			 * (uploadContentType.equals("image/bmp")) { expandedName = ".bmp";
			 * } else { out.println("<script type=\"text/javascript\">");
			 * out.println("window.parent.CKEDITOR.tools.callFunction(" +
			 * CKEditorFuncNum + ",''," +
			 * "'文件格式不正确（必须为.jpg/.gif/.bmp/.png文件）');");
			 * out.println("</script>"); return ; }
			 * 
			 * // 限制文件大小 if (multipartFile.getSize() > 600 * 1024) {
			 * out.println("<script type=\"text/javascript\">");
			 * out.println("window.parent.CKEDITOR.tools.callFunction(" +
			 * CKEditorFuncNum + ",''," + "'文件大小不得大于600k');");
			 * out.println("</script>"); return; }
			 */

			// 文件名称（图片会重命名，其它文件不重命名）
			String newName = null;
			// 文件类型
			String fileType = null;
			if (uploadContentType.startsWith("image")) {
				newName = System.currentTimeMillis() + fileName.substring(fileName.indexOf("."));
				fileType = "image";
			} else {
				newName = fileName;
				fileType = "doc";
			}

			// 上传路径
			String uploadPath = rootPath + "editor/" + type + "/" + fileType + "/";
			// 下载路径
			String downloadPath = resUrl + "editor/" + type + "/" + fileType + "/";

			File f = new File(uploadPath);
			if (!f.exists()) {
				f.mkdirs();
			}
			multipartFile.transferTo(new File(uploadPath + newName));

			out = response.getWriter();
			out.println("<script type=\"text/javascript\">window.parent.CKEDITOR.tools.callFunction(" + CKEditorFuncNum
					+ ", '" + downloadPath + newName + "','')</script>");
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 获取当前用户名称
	 */
	public String getCurrentUserName() {
		return (String) SecurityUtils.getSubject().getPrincipal();
	}
	
	/**
	 * 获取当前页面的权限
	 */
	public String getPermission(HttpServletRequest request, String moduleName) {
		RolePermission rolePermission = (RolePermission) request.getSession().getAttribute(Contants.CURRNET_PERMISSION);
		String permission = "0";

		if (rolePermission != null && StringUtils.isNotBlank(rolePermission.getPermission())) {
			String[] array = rolePermission.getPermission().split(",");

			for (String str : array) {
				String[] vals = str.split("-");
				if (moduleName.equals(vals[0])) {
					permission = vals[1];
					break;
				}
			}
		}
		return permission;
	}
}


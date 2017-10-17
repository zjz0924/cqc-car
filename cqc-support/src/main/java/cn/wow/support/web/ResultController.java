package cn.wow.support.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.Page;

import cn.wow.common.domain.Account;
import cn.wow.common.domain.AtlasResult;
import cn.wow.common.domain.Menu;
import cn.wow.common.domain.Task;
import cn.wow.common.service.AtlasResultService;
import cn.wow.common.service.InfoService;
import cn.wow.common.service.MenuService;
import cn.wow.common.service.TaskService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.Contants;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.utils.taskState.StandardTaskEnum;

/**
 * 结果控制器
 * 
 * @author zhenjunzhuo 2017-10-17
 */
@Controller
@RequestMapping(value = "result")
public class ResultController extends AbstractController {

	Logger logger = LoggerFactory.getLogger(ResultController.class);

	// 结果上传列表
	private final static String UPLOAD_DEFAULT_PAGE_SIZE = "10";
	// 任务记录列表
	private final static String RECORD_DEFAULT_PAGE_SIZE = "10";
		
	// 图谱图片上传路径
	@Value("${result.atlas.url}")
	protected String atlasUrl;
	
	@Autowired
	private MenuService menuService;
	@Autowired
	private TaskService taskService;
	@Autowired
	private InfoService infoService;
	@Autowired
	private AtlasResultService atlasResultService;
	
	
	/**
	 * 结果上传列表
	 */
	@RequestMapping(value = "/uploadList")
	public String uploadList(HttpServletRequest request, HttpServletResponse response, Model model, int type) {
		Menu menu = null;
		
		if(type == 1){
			menu = menuService.selectByAlias("patternUpload");
		}else{
			menu = menuService.selectByAlias("atlasUpload");
		}
		
		model.addAttribute("defaultPageSize", UPLOAD_DEFAULT_PAGE_SIZE);
		model.addAttribute("recordPageSize", RECORD_DEFAULT_PAGE_SIZE);
		model.addAttribute("menuName", menu.getName());
		model.addAttribute("type", type);
		return "result/upload_list";
	}

	/**
	 * 列表数据
	 */
	@ResponseBody
	@RequestMapping(value = "/uploadListData")
	public Map<String, Object> uploadListData(HttpServletRequest request, Model model, String code, String orgId,
			String startCreateTime, String endCreateTime, String nickName, int type) {
		Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
		
		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", UPLOAD_DEFAULT_PAGE_SIZE);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "t.create_time desc");
		map.put("state", StandardTaskEnum.UPLOADING.getState());
		
		// 超级管理员具有所有的权限
		if(account.getRole() == null || !Contants.SUPER_ROLE_CODE.equals(account.getRole().getCode())){
			if(type == 1){  //型式结果
				map.put("patternLab", account.getOrgId() == null ? -1: account.getOrgId());
			}else{   // 图谱结果
				map.put("atlasLab", account.getOrgId() == null ? -1: account.getOrgId());
			}
		}
		
		if(type == 1){
			map.put("patternResult", 0);
		}else{
			map.put("atlasResult", 0);
		}

		if (StringUtils.isNotBlank(code)) {
			map.put("code", code);
		}
		if (StringUtils.isNotBlank(startCreateTime)) {
			map.put("startCreateTime", startCreateTime);
		}
		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime);
		}
		if (StringUtils.isNotBlank(nickName)) {
			map.put("nickName", nickName);
		}
		if (StringUtils.isNotBlank(orgId)) {
			map.put("orgId", orgId);
		}

		List<Task> dataList = taskService.selectAllList(map);

		// 分页
		Page<Task> pageList = (Page<Task>) dataList;

		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("total", pageList.getTotal());
		dataMap.put("rows", pageList.getResult());

		return dataMap;
	}

	/**
	 * 详情列表
	 */
	@RequestMapping(value = "/uploadDetail")
	public String uploadDetail(HttpServletRequest request, HttpServletResponse response, Model model, Long id, int type) {
		if (id != null) {
			Task task = taskService.selectOne(id);

			model.addAttribute("facadeBean", task);
		}

		model.addAttribute("resUrl", resUrl);
		model.addAttribute("type", type);
		return "result/upload_detail";
	}

	/**
	 * 审批结果
	 * 
	 * @param taskId  任务ID
	 * @param tgLab   热重分析描述
	 * @param infLab  红外光分析描述
	 * @param dtLab   差热扫描描述
	 */
	@ResponseBody
	@RequestMapping(value = "/atlasUpload")
	public AjaxVO atlasUpload(HttpServletRequest request, Model model, Long taskId, String tgLab, String infLab,
			String dtLab, @RequestParam(value = "tgLab_pic", required = false) MultipartFile tgfile,
			@RequestParam(value = "infLab_pic", required = false) MultipartFile infile,
			@RequestParam(value = "dtLab_pic", required = false) MultipartFile dtfile) {
		AjaxVO vo = new AjaxVO();
		String pic = null;
		
		try {
			Date date = new Date();
			// 热重分析
			AtlasResult tg = new AtlasResult();
			if (tgfile != null && !tgfile.isEmpty()) {
				pic = uploadImg(tgfile, atlasUrl + taskId + "/3/", false);
				tg.setPic(pic);
			}
			tg.setRemark(tgLab);
			tg.setType(3);
			tg.settId(taskId);
			tg.setCreateTime(date);
			
			// 红外光分析
			AtlasResult inf = new AtlasResult();
			if (infile != null && !infile.isEmpty()) {
				pic = uploadImg(infile, atlasUrl + taskId + "/1/", false);
				inf.setPic(pic);
			}
			inf.setRemark(infLab);
			inf.setType(1);
			inf.settId(taskId);
			inf.setCreateTime(date);
			
			// 差热扫描
			AtlasResult dt = new AtlasResult();
			if (dtfile != null && !dtfile.isEmpty()) {
				pic = uploadImg(dtfile, atlasUrl + taskId + "/2/", false);
				dt.setPic(pic);
			}
			dt.setRemark(dtLab);
			dt.setType(2);
			dt.settId(taskId);
			dt.setCreateTime(date);			
			
			List<AtlasResult> dataList = new ArrayList<AtlasResult>();
			dataList.add(tg);
			dataList.add(inf);
			dataList.add(dt);
			
			Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
			atlasResultService.upload(account, dataList, taskId, date);
		} catch (Exception ex) {
			logger.error("图谱上传失败", ex);

			vo.setSuccess(false);
			vo.setMsg("操作失败，系统异常，请重试");
			return vo;
		}

		vo.setSuccess(true);
		vo.setMsg("操作成功");
		return vo;
	}

}

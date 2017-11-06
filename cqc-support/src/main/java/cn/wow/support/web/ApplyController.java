package cn.wow.support.web;

import java.text.ParseException;
import java.text.SimpleDateFormat;
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

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.Page;

import cn.wow.common.domain.Account;
import cn.wow.common.domain.AtlasResult;
import cn.wow.common.domain.Material;
import cn.wow.common.domain.Menu;
import cn.wow.common.domain.Parts;
import cn.wow.common.domain.PfResult;
import cn.wow.common.domain.Task;
import cn.wow.common.domain.Vehicle;
import cn.wow.common.service.AtlasResultService;
import cn.wow.common.service.InfoService;
import cn.wow.common.service.MaterialService;
import cn.wow.common.service.MenuService;
import cn.wow.common.service.PartsService;
import cn.wow.common.service.PfResultService;
import cn.wow.common.service.TaskService;
import cn.wow.common.service.VehicleService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.Contants;
import cn.wow.common.utils.pagination.PageMap;


/**
 * 申请管理
 * @author zhenjunzhuo
 * 2017-11-05
 */
@Controller
@RequestMapping(value = "apply")
public class ApplyController extends AbstractController {
	
	Logger logger = LoggerFactory.getLogger(ApplyController.class);

	private final static String DEFAULT_PAGE_SIZE = "10";
	
	@Autowired
	private TaskService taskService;
	@Autowired
	private MenuService menuService;
	@Autowired
	private VehicleService vehicleService;
	@Autowired
	private PartsService partsService;
	@Autowired
	private MaterialService materialService;
	@Autowired
	private InfoService infoService;
	@Autowired
	private AtlasResultService atlasResultService;
	@Autowired
	private PfResultService pfResultService;
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	// 原材料图片上传路径
	@Value("${info.material.url}")
	protected String materialUrl;
	
	// 图谱图片上传路径
	@Value("${result.atlas.url}")
	protected String atlasUrl;
	
	
	/**
	 * 任务列表
	 */
	@RequestMapping(value = "/taskList")
	public String taskList(HttpServletRequest request, HttpServletResponse response, Model model) {

		Menu menu = menuService.selectByAlias("updateApply");

		model.addAttribute("menuName", menu.getName());
		model.addAttribute("defaultPageSize", DEFAULT_PAGE_SIZE);
		return "apply/task_list";
	}

	
	/**
	 * 列表数据
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/taskListData")
	public Map<String, Object> taskListData(HttpServletRequest request, Model model, String startCreateTime, String endCreateTime, Integer state) {
		Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
		
		// 设置默认记录数
		String pageSize = request.getParameter("pageSize");
		if (!StringUtils.isNotBlank(pageSize)) {
			request.setAttribute("pageSize", DEFAULT_PAGE_SIZE);
		}

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "t.create_time desc");
		
		if (StringUtils.isNotBlank(startCreateTime)) {
			map.put("startCreateTime", startCreateTime);
		}
		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime);
		}
		
		// 非超级管理员，只能看到分配到自己实验室的任务
		if (!Contants.SUPER_ROLE_CODE.equals(account.getRole().getCode())) {
			map.put("accomplishTask_lab", account.getOrgId());
		}
		
		map.put("accomplishTask", true);
		List<Task> dataList = taskService.selectAllList(map);

		// 分页
		Page<Task> pageList = (Page<Task>) dataList;

		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("total", pageList.getTotal());
		dataMap.put("rows", pageList.getResult());

		return dataMap;
	}
	

	/**
	 * 信息详情
	 */
	@RequestMapping(value = "/infoDetail")
	public String infoDetail(HttpServletRequest request, HttpServletResponse response, Model model, Long id) {
		if(id != null){
			Task task = taskService.selectOne(id);
			
			model.addAttribute("facadeBean", task);
		}
		model.addAttribute("resUrl", resUrl);
		return "apply/info_detail";
	}
	
	/**
	 * 实验结果详情
	 */
	@RequestMapping(value = "/labDetail")
	public String labDetail(HttpServletRequest request, HttpServletResponse response, Model model, Long id) {
		if(id != null){
			Task task = taskService.selectOne(id);
			
			// 零部件-性能结果（只取最后一次实验）
			Map<String, Object> pfMap = new HashMap<String, Object>();
			pfMap.put("tId", id);
			pfMap.put("expNo", pfResultService.getExpNoByCatagory(id, 1));
			pfMap.put("catagory", 1);
			List<PfResult> pPfResult = pfResultService.selectAllList(pfMap);

			// 原材料-性能结果（只取最后一次实验结果）
			Map<String, Object> mPfMap = new HashMap<String, Object>();
			mPfMap.put("tId", id);
			mPfMap.put("expNo", pfResultService.getExpNoByCatagory(id, 2));
			mPfMap.put("catagory", 2);
			List<PfResult> mPfResult = pfResultService.selectAllList(mPfMap);
			
			// 零部件-图谱结果（只取最后一次实验）
			Map<String, Object> pAtMap = new HashMap<String, Object>();
			pAtMap.put("tId", id);
			pAtMap.put("expNo", atlasResultService.getExpNoByCatagory(id, 1));
			pAtMap.put("catagory", 1);
			List<AtlasResult> pAtlasResult = atlasResultService.selectAllList(pAtMap);
			
			// 原材料-图谱结果（只取最后一次实验）
			Map<String, Object> mAtMap = new HashMap<String, Object>();
			mAtMap.put("tId", id);
			mAtMap.put("catagory", 2);
			mAtMap.put("expNo", atlasResultService.getExpNoByCatagory(id, 2));
			List<AtlasResult> mAtlasResult = atlasResultService.selectAllList(mAtMap);

			// 零部件-性能结果
			model.addAttribute("pPfResult", pPfResult);
			// 原材料-性能结果
			model.addAttribute("mPfResult", mPfResult);
			// 零部件-图谱结果
			model.addAttribute("pAtlasResult", pAtlasResult);
			// 原材料-图谱结果
			model.addAttribute("mAtlasResult", mAtlasResult);
			
			model.addAttribute("facadeBean", task);
		}
		
		model.addAttribute("superRoleCole", Contants.SUPER_ROLE_CODE);
		model.addAttribute("resUrl", resUrl);
		return "apply/lab_detail";
	}
	
	
	/**
	 * 申请列表
	 */
	@RequestMapping(value = "/applyList")
	public String applyList(HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("defaultPageSize", DEFAULT_PAGE_SIZE);
		return "apply/apply_list";
	}
	
	
	/**
	 * 信息修改申请保存
	 */
	@ResponseBody
	@RequestMapping(value = "/applyInfoSave")
	public AjaxVO applyInfoSave(HttpServletRequest request, Model model, String v_code, String v_type,
			String v_proTime, String v_proAddr, String v_remark, String p_code, String p_name, String p_proTime,
			String p_place, String p_proNo, String p_keyCode, Integer p_isKey, Long p_orgId, String p_remark,
			String m_matName, String m_matColor, String m_proNo, Long m_orgId, String m_matNo, String m_remark,
			@RequestParam(value = "m_pic", required = false) MultipartFile mfile, Long t_id) {

		AjaxVO vo = new AjaxVO();

		try {
			Date date = new Date();
			Task task = taskService.selectOne(t_id);
			
			// 整车信息
			Vehicle vehicle = null;
			if (isUpdateVehicleInfo(v_code, v_type, v_proTime, v_proAddr, v_remark)) {
				vehicle = vehicleService.selectOne(task.getInfo().getvId());
				if (StringUtils.isNotBlank(v_code)) {
					Vehicle dbVehicle = vehicleService.selectByCode(vehicle.getCode());
					if (dbVehicle != null && dbVehicle.getId().longValue() != vehicle.getId().longValue()) {
						vo.setSuccess(false);
						vo.setMsg("整车代码已存在");
						return vo;
					}
					
					vehicle.setCode(v_code);
				}
				assembleVehicleInfo(vehicle, v_type, v_proTime, v_proAddr, v_remark, date);
			}
			
			// 零部件信息
			Parts parts = partsService.selectOne(task.getInfo().getpId());
			if (isUpdatePartsInfo(parts, p_code, p_name, p_proTime, p_place, p_proNo, p_keyCode, p_isKey, p_orgId, p_remark)) {
				if (StringUtils.isNotBlank(p_code)) {
					Parts dbParts = partsService.selectByCode(p_code);
					if (dbParts != null && dbParts.getId().longValue() != parts.getId().longValue()) {
						vo.setSuccess(false);
						vo.setMsg("零部件号已存在");
						return vo;
					}
				}
				assemblePartsInfo(parts, p_name, p_proTime, p_place, p_proNo, p_keyCode, p_isKey, p_orgId, p_remark, date);
			}else{
				parts = null;
			}
			
			// 原材料信息
			Material material = null;
			if(isUpdateMetailInfo(m_matName, m_matColor, m_proNo, m_orgId, m_matNo, m_remark, mfile)){
				material = materialService.selectOne(task.getInfo().getmId());
				assembleMaterialInfo(material, m_matName, m_matColor, m_proNo, m_orgId, m_matNo, m_remark, mfile, date);
			}
			
			if (vehicle == null && parts == null && material == null) {
				vo.setSuccess(false);
				vo.setMsg("请输入要修改的信息");
				return vo;
			}
			
			Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
			infoService.applyInfo(account, task, vehicle, parts, material);
		} catch (Exception ex) {
			ex.printStackTrace();
			logger.error("修改申请失败", ex);

			vo.setSuccess(false);
			vo.setMsg("保存失败，系统异常");
			return vo;
		}

		vo.setSuccess(true);
		vo.setMsg("保存成功");
		return vo;
	}
	
	
	/**
	 * 试验结果修改申请保存
	 * @param taskId  任务ID
	 * @param p_tgLab   零部件热重分析描述
	 * @param p_infLab  零部件红外光分析描述
	 * @param p_dtLab   零部件差热扫描描述
	 * @param m_tgLab   原材料热重分析描述
	 * @param m_infLab  原材料红外光分析描述
	 * @param m_dtLab   原材料差热扫描描述
	 */
	@ResponseBody
	@RequestMapping(value = "/labInfoSave")
	public AjaxVO labInfoSave(HttpServletRequest request, Model model, Long taskId, 
			String p_tgLab, String p_infLab, String p_dtLab, String m_tgLab, String m_infLab, String m_dtLab, 
			@RequestParam(value = "p_tgLab_pic", required = false) MultipartFile p_tgfile,
			@RequestParam(value = "p_infLab_pic", required = false) MultipartFile p_infile,
			@RequestParam(value = "p_dtLab_pic", required = false) MultipartFile p_dtfile,
			@RequestParam(value = "m_tgLab_pic", required = false) MultipartFile m_tgfile,
			@RequestParam(value = "m_infLab_pic", required = false) MultipartFile m_infile,
			@RequestParam(value = "m_dtLab_pic", required = false) MultipartFile m_dtfile, String result){
		
		AjaxVO vo = new AjaxVO();

		try {
			// 型式结果
			ObjectMapper mapper = new ObjectMapper();
			List<PfResult> pfResultList = mapper.readValue(result, new TypeReference<List<PfResult>>() {});

			// 组装图谱信息
			List<AtlasResult> atlResultList = assembleAtlasInfo(taskId, p_tgLab, p_infLab, p_dtLab, m_tgLab, m_infLab, m_dtLab, p_tgfile, p_infile, p_dtfile, m_tgfile, m_infile, m_dtfile);
			
			Account account = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
			infoService.applyResult(account, taskId, pfResultList, atlResultList);
			
		} catch (Exception ex) {
			logger.error("试验结果修改申请保存失败", ex);

			vo.setSuccess(false);
			vo.setMsg("操作失败，系统异常，请重试");
			return vo;
		}
		
		vo.setSuccess(true);
		vo.setMsg("保存成功");
		return vo;
	}
	
	
	/**
	 * 是否更新整车信息
	 */
	boolean isUpdateVehicleInfo(String v_code, String v_type, String v_proTime, String v_proAddr, String v_remark) {
		if (StringUtils.isBlank(v_code) && StringUtils.isBlank(v_type) && StringUtils.isBlank(v_proTime)
				&& StringUtils.isBlank(v_proAddr) && StringUtils.isBlank(v_remark)) {
			return false;
		} else {
			return true;
		}
	}
	
	/**
	 * 是否更新零部件信息
	 */
	boolean isUpdatePartsInfo(Parts parts, String p_code, String p_name, String p_proTime, String p_place,
			String p_proNo, String p_keyCode, Integer p_isKey, Long p_orgId, String p_remark) {

		if (StringUtils.isBlank(p_code) && StringUtils.isBlank(p_name) && StringUtils.isBlank(p_proTime)
				&& StringUtils.isBlank(p_place) && StringUtils.isBlank(p_proNo) && StringUtils.isBlank(p_keyCode)
				&& p_orgId == null && StringUtils.isBlank(p_remark)
				&& p_isKey.intValue() == parts.getIsKey().intValue()) {
			return false;
		} else {
			return true;
		}
	}
	
	/**
	 * 是否更新原材料信息
	 * @return
	 */
	boolean isUpdateMetailInfo(String m_matName, String m_matColor, String m_proNo, Long m_orgId, String m_matNo,
			String m_remark, MultipartFile mfile) {
		if (StringUtils.isBlank(m_matName) && StringUtils.isBlank(m_matColor) && StringUtils.isBlank(m_proNo)
				&& StringUtils.isBlank(m_matNo) && StringUtils.isBlank(m_matName) && StringUtils.isBlank(m_remark)
				&& m_orgId == null && mfile == null) {
			return false;
		} else {
			return true;
		}
	}
	
	
	/**
	 * 组装整车信息
	 */
	void assembleVehicleInfo(Vehicle vehicle, String v_type, String v_proTime, String v_proAddr, String v_remark, Date date) {
		if (StringUtils.isNotBlank(v_type)) {
			vehicle.setType(v_type);
		}

		if (StringUtils.isNotBlank(v_proTime)) {
			try {
				vehicle.setProTime(sdf.parse(v_proTime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}

		if (StringUtils.isNotBlank(v_proAddr)) {
			vehicle.setProAddr(v_proAddr);
		}

		if (StringUtils.isNotBlank(v_remark)) {
			vehicle.setRemark(v_remark);
		}

		vehicle.setCreateTime(date);
		vehicle.setId(null);
		vehicle.setState(0);
	}
	
	/**
	 * 组装零部件信息
	 */
	void assemblePartsInfo(Parts parts, String p_name, String p_proTime, String p_place, String p_proNo,
			String p_keyCode, Integer p_isKey, Long p_orgId, String p_remark, Date date) {

		if (StringUtils.isNotBlank(p_name)) {
			parts.setName(p_name);
		}

		if (StringUtils.isNotBlank(p_proTime)) {
			try {
				parts.setProTime(sdf.parse(p_proTime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}

		if (StringUtils.isNotBlank(p_place)) {
			parts.setPlace(p_place);
		}

		if (StringUtils.isNotBlank(p_proNo)) {
			parts.setProNo(p_proNo);
		}

		if (StringUtils.isNotBlank(p_keyCode)) {
			parts.setKeyCode(p_keyCode);
		}

		parts.setIsKey(p_isKey);

		if (p_orgId != null) {
			parts.setOrgId(p_orgId);
		}

		if (StringUtils.isNotBlank(p_remark)) {
			parts.setRemark(p_remark);
		}

		parts.setCreateTime(date);
		parts.setId(null);
		parts.setState(0);
	}
	
	/**
	 * 组装原材料信息
	 */
	void assembleMaterialInfo(Material material, String m_matName, String m_matColor, String m_proNo, Long m_orgId,
			String m_matNo, String m_remark, MultipartFile mfile, Date date) throws Exception {
		
		if (StringUtils.isNotBlank(m_matName)) {
			material.setMatName(m_matName);
		}

		if (StringUtils.isNotBlank(m_matColor)) {
			material.setMatColor(m_matColor);
		}

		if (StringUtils.isNotBlank(m_proNo)) {
			material.setProNo(m_proNo);
		}

		if (m_orgId != null) {
			material.setOrgId(m_orgId);
		}

		if (StringUtils.isNotBlank(m_matNo)) {
			material.setMatNo(m_matNo);
		}

		if (StringUtils.isNotBlank(m_remark)) {
			material.setRemark(m_remark);
		}

		if (mfile != null && !mfile.isEmpty()) {
			String pic = uploadImg(mfile, materialUrl, false);
			material.setPic(pic);
		}
		
		material.setId(null);
		material.setCreateTime(date);
		material.setState(0);
	}
	
	
	/**
	 * 组装图谱信息
	 */
	List<AtlasResult> assembleAtlasInfo(Long taskId, 
			String p_tgLab, String p_infLab, String p_dtLab, String m_tgLab, String m_infLab, String m_dtLab, 
			@RequestParam(value = "p_tgLab_pic", required = false) MultipartFile p_tgfile,
			@RequestParam(value = "p_infLab_pic", required = false) MultipartFile p_infile,
			@RequestParam(value = "p_dtLab_pic", required = false) MultipartFile p_dtfile,
			@RequestParam(value = "m_tgLab_pic", required = false) MultipartFile m_tgfile,
			@RequestParam(value = "m_infLab_pic", required = false) MultipartFile m_infile,
			@RequestParam(value = "m_dtLab_pic", required = false) MultipartFile m_dtfile) throws Exception{
		
		List<AtlasResult> dataList = new ArrayList<AtlasResult>();
		
		// 零部件-图谱结果（只取最后一次实验）
		Map<String, Object> pAtMap = new HashMap<String, Object>();
		pAtMap.put("tId", taskId);
		pAtMap.put("expNo", atlasResultService.getExpNoByCatagory(taskId, 1));
		pAtMap.put("catagory", 1);
		List<AtlasResult> pAtlasResult = atlasResultService.selectAllList(pAtMap);
		
		for (AtlasResult at : pAtlasResult) {
			if (at.getType() == 1) { // 红外光分析
				at.setRemark(p_infLab);
				if (p_infile != null && !p_infile.isEmpty()) {
					String pic = uploadImg(p_infile, atlasUrl + taskId + "apply/parts/inf/", false);
					at.setPic(pic);
				}
			} else if (at.getType() == 2) { // 差热分析
				at.setRemark(p_dtLab);
				if (p_dtfile != null && !p_dtfile.isEmpty()) {
					String pic = uploadImg(p_dtfile, atlasUrl + taskId + "/apply/parts/dt/", false);
					at.setPic(pic);
				}
			} else { // 热重分析
				at.setRemark(p_tgLab);
				if (p_tgfile != null && !p_tgfile.isEmpty()) {
					String pic = uploadImg(p_tgfile, atlasUrl + taskId + "apply/parts/tg/", false);
					at.setPic(pic);
				}
			}
		}
		
		// 原材料-图谱结果（只取最后一次实验）
		Map<String, Object> mAtMap = new HashMap<String, Object>();
		mAtMap.put("tId", taskId);
		mAtMap.put("catagory", 2);
		mAtMap.put("expNo", atlasResultService.getExpNoByCatagory(taskId, 2));
		List<AtlasResult> mAtlasResult = atlasResultService.selectAllList(mAtMap);
		
		for (AtlasResult at : mAtlasResult) {
			if (at.getType() == 1) { // 红外光分析
				at.setRemark(m_infLab);
				if (m_infile != null && !m_infile.isEmpty()) {
					String pic = uploadImg(m_infile, atlasUrl + taskId + "apply/material/inf/", false);
					at.setPic(pic);
				}
			} else if (at.getType() == 2) { // 差热分析
				at.setRemark(m_dtLab);
				if (m_dtfile != null && !m_dtfile.isEmpty()) {
					String pic = uploadImg(m_dtfile, atlasUrl + taskId + "/apply/material/dt/", false);
					at.setPic(pic);
				}
			} else { // 热重分析
				at.setRemark(m_tgLab);
				if (m_tgfile != null && !m_tgfile.isEmpty()) {
					String pic = uploadImg(m_tgfile, atlasUrl + taskId + "apply/material/tg/", false);
					at.setPic(pic);
				}
			}
		}
		
		if (pAtlasResult != null && pAtlasResult.size() > 0) {
			dataList.addAll(pAtlasResult);
		}
		
		if (mAtlasResult != null && mAtlasResult.size() > 0) {
			dataList.addAll(mAtlasResult);
		}
		return dataList;
	}
	
}

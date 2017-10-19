package cn.wow.common.service.impl;

import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.dao.QuotationDao;
import cn.wow.common.domain.Quotation;
import cn.wow.common.service.QuotationService;

@Service
@Transactional
public class QuotationServiceImpl implements QuotationService{

    private static Logger logger = LoggerFactory.getLogger(QuotationServiceImpl.class);

    @Autowired
    private QuotationDao quotationDao;

    public Quotation selectOne(Long id){
    	return quotationDao.selectOne(id);
    }

    public int save(String userName, Quotation quotation){
    	return quotationDao.insert(quotation);
    }

    public int update(String userName, Quotation quotation){
    	return quotationDao.update(quotation);
    }

    public int deleteByPrimaryKey(String userName, Quotation quotation){
    	return quotationDao.deleteByPrimaryKey(quotation.getId());
    }

    public List<Quotation> selectAllList(Map<String, Object> map){
    	PageHelperExt.startPage(map);
    	return quotationDao.selectAllList(map);
    }

}

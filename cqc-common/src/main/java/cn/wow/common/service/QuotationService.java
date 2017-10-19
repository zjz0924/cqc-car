package cn.wow.common.service;

import java.util.List;
import java.util.Map;
import cn.wow.common.domain.Quotation;

public interface QuotationService {
    public Quotation selectOne(Long id);

    public int save(String userName, Quotation quotation);

    public int update(String userName, Quotation quotation);

    public int deleteByPrimaryKey(String userName, Quotation quotation);

    public List<Quotation> selectAllList(Map<String, Object> map);

}

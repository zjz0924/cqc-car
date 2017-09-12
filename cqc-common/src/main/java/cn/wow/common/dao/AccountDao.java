package cn.wow.common.dao;

import cn.wow.common.domain.Account;

public interface AccountDao extends SqlDao{
    int deleteByPrimaryKey(Long id);
    
    Account selectByAccountName(String userName);
}
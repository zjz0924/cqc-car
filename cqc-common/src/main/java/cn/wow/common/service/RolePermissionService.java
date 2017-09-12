package cn.wow.common.service;

import cn.wow.common.domain.RolePermission;

public interface RolePermissionService {
    public RolePermission selectOne(Long id);

    public int save(RolePermission rolePermisson);

    public int update(RolePermission rolePermisson);

    public int deleteByPrimaryKey(Long id);

}

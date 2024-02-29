package com.maru.chaekmaru.admin.member;

import java.util.List;

public interface IAdminMemberDaoForMybatis {
	
	public boolean isAdminMember(String a_id);
	public int insertAdminAccount(AdminMemberDto adminMemberDto);
	public AdminMemberDto selectAdmin(AdminMemberDto adminMemberDto);	
	public int updateAdminForModify();
	public int deleteAdminAccount(int a_no);
	public List<AdminMemberDto> selectAllAdmins();
	public int updateAdminApproval(String a_id, int a_no);
}

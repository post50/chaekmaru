package com.maru.chaekmaru.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.maru.chaekmaru.config.Config;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class MemberService {

	@Autowired
	MemberDao memberDao;
	
	@Autowired
	PasswordEncoder passwordEncoder;	
	
	public int memberAccountConfirm(MemberDto memberDto) {
		log.info("--memberAccountConfirm--");
		
		boolean isMember = memberDao.isMember(memberDto.getM_id());
		
		if (!isMember) {
			memberDto.setM_pw(passwordEncoder.encode(memberDto.getM_pw()));
			int result = memberDao.insertMember(memberDto);
			
			switch (result) {
			case Config.DATABASE_COMMUNICATION_TROUBLE:
				log.info("DATABASE COMMUNICATION TROUBLE");
				break;

			case Config.INSERT_FAIL_AT_DATABASE:
				log.info("INSERT FAIL AT DATABASE");
				break;
				
			case Config.INSERT_SUCCESS_AT_DATABASE:
				log.info("INSERT SUCCESS AT DATABASE");
				break;

			}
			
			return result;
			
		} else {
			
			return Config.ID_ALREADY_EXIST;
			
		}
		
	}

	public MemberDto loginConfirm(MemberDto memberDto) {
	    log.info("--loginConfirm--");

	    MemberDto selectedMemberDtoById = memberDao.memberLoginConfirm(memberDto);
	    
	    if (selectedMemberDtoById != null && passwordEncoder.matches(memberDto.getM_pw(), selectedMemberDtoById.getM_pw())) {
		    log.info(selectedMemberDtoById.getM_id());
		    
	        return selectedMemberDtoById;
	    } else {
	        return null;
	    }
	}

	public MemberDto modifyConfirm(MemberDto memberDto) {

		log.info("modifyConfirm()");
		
		int result = memberDao.updateMemberForModify(memberDto);
		
		if (result > 0)
			return memberDao.getLatestMemberInfo(memberDto);
		else
			
		return null;
	}

}

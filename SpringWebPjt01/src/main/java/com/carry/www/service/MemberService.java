package com.carry.www.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.carry.www.dao.MemberDAO;
import com.carry.www.vo.MemberVO;

@Service
public class MemberService {
	
	@Autowired
	MemberDAO dao;
	
	@Autowired
	SqlSessionTemplate session;
	
	
	public int idCheck(String id) {

		return dao.idCheck(session, id);
		
	}
	
	public int emailCheck(String email) {
		
		return dao.emailCheck(session, email);
	}
	
	public int memberInsertOK(MemberVO vo) {
		
		return dao.memberInsert(session, vo);
		
	}

	public int login(MemberVO vo) {
		
		return dao.login(session, vo);
		
	}

	public MemberVO memberSelect(MemberVO vo) {

		return dao.memberSelect(session, vo);
		
	}

	public void memberUpdate(MemberVO vo) {
		
		dao.memberUpdate(session, vo);
		
	}

	public void memberDelete(MemberVO vo) {
		
		dao.memberDelete(session, vo);
		
	}
	
	public MemberVO selectEmail(String email) {
		
		return dao.selectEmail(session, email);
		
	}

	public void modifyUserPw(MemberVO vo) {
		
		dao.modifyUserPw(session, vo);
		
	}
	
	

	
}

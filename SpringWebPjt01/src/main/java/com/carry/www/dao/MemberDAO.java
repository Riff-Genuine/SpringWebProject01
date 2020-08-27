package com.carry.www.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.carry.www.vo.MemberVO;

@Repository
public class MemberDAO {
	
	public int idCheck(SqlSessionTemplate session, String id) {
		
		return session.selectOne("member.idCheck", id);
		
	}

	public int emailCheck(SqlSessionTemplate session, String email) {
		
		return session.selectOne("member.emailCheck", email);
	}
	
	public int memberInsert(SqlSessionTemplate session, MemberVO vo) {
		
		return session.insert("member.insert", vo);
		
	}

	public int login(SqlSessionTemplate session, MemberVO vo) {

		int result = session.selectOne("member.login", vo);
			
		return result;
	}

	public MemberVO memberSelect(SqlSessionTemplate session, MemberVO vo) {

		return session.selectOne("member.select", vo);
	}

	public void memberUpdate(SqlSessionTemplate session, MemberVO vo) {
		
		session.update("member.update", vo);
		
	}

	public void memberDelete(SqlSessionTemplate session, MemberVO vo) {

		session.delete("member.delete", vo);
		
	}
	
	public MemberVO selectEmail(SqlSessionTemplate session, String email) {
		
		return session.selectOne("member.selectEmail", email);
		
	}

	public void modifyUserPw(SqlSessionTemplate session, MemberVO vo) {

		session.update("member.modifyPw", vo);
		
	}

	

	
}

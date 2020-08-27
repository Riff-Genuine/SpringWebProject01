package com.carry.www.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.carry.www.vo.Criteria;
import com.carry.www.vo.MsgVO;

@Repository
public class MsgDAO {
	
	// 받은 메시지 개수 조회
	public int cntMsgTo(SqlSessionTemplate session, String id) {

		return session.selectOne("msg.cntMsgTo", id);
		
	}

	// 받은 메시지 조회
	public List<MsgVO> msgSelectTo(SqlSessionTemplate session, Criteria cri) {
		
		return session.selectList("msg.selectTo", cri);
				
	}
	
	// 보낸 메시지 개수 조회
	public int cntMsgFrom(SqlSessionTemplate session, String id) {
		
		return session.selectOne("msg.cntMsgFrom", id);
		
	}
	
	// 보낸 메시지 조히
	public List<MsgVO> msgSelectFrom(SqlSessionTemplate session, Criteria cri) {

		return session.selectList("msg.selectFrom", cri);
		
	}
	
	// 메시지 작성
	public void msgInsert(SqlSessionTemplate session, MsgVO vo) {

		session.insert("msg.insert", vo);
		
	}

	// 특정 메시지 조회
	public MsgVO msgSelectNo(SqlSessionTemplate session, int no) {

		return session.selectOne("msg.selectNo", no);
		
	}
	
	// 메시지 삭제
	public void msgDelete(SqlSessionTemplate session, int no) {
		
		session.delete("msg.delete", no);
		
	}

	

}

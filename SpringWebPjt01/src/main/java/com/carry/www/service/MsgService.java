package com.carry.www.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.carry.www.dao.MsgDAO;
import com.carry.www.vo.Criteria;
import com.carry.www.vo.MsgVO;

@Service
public class MsgService {
	
	@Autowired
	MsgDAO dao;
	
	@Autowired
	SqlSessionTemplate session;

	// 받은 메시지 개수 조회
	public int cntMsgTo(String id) {

		return dao.cntMsgTo(session, id);
		
	}
	
	// 받은 메시지 조회
	public List<MsgVO> msgSelectTo(Criteria cri) {

		return dao.msgSelectTo(session, cri);
		
	}
	
	// 보낸 메시지 개수 조회
	public int cntMsgFrom(String id) {
		
		return dao.cntMsgFrom(session, id);
		
	}
	
	// 보낸 메시지 조회
	public List<MsgVO> msgSelectFrom(Criteria cri) {

		return dao.msgSelectFrom(session, cri);
		
	}
	
	// 메시지 작성
	public void msgInsert(MsgVO vo) {
		
		dao.msgInsert(session, vo);
		
	}

	// 특정 메시지 조회
	public MsgVO msgSelectNo(int no) {
		
		return dao.msgSelectNo(session, no);
		
	}
	
	// 메시지 삭제
	public void msgDeleteOK(int no) {
		
		dao.msgDelete(session, no);
		
	}

	

	

}

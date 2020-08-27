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

	// ���� �޽��� ���� ��ȸ
	public int cntMsgTo(String id) {

		return dao.cntMsgTo(session, id);
		
	}
	
	// ���� �޽��� ��ȸ
	public List<MsgVO> msgSelectTo(Criteria cri) {

		return dao.msgSelectTo(session, cri);
		
	}
	
	// ���� �޽��� ���� ��ȸ
	public int cntMsgFrom(String id) {
		
		return dao.cntMsgFrom(session, id);
		
	}
	
	// ���� �޽��� ��ȸ
	public List<MsgVO> msgSelectFrom(Criteria cri) {

		return dao.msgSelectFrom(session, cri);
		
	}
	
	// �޽��� �ۼ�
	public void msgInsert(MsgVO vo) {
		
		dao.msgInsert(session, vo);
		
	}

	// Ư�� �޽��� ��ȸ
	public MsgVO msgSelectNo(int no) {
		
		return dao.msgSelectNo(session, no);
		
	}
	
	// �޽��� ����
	public void msgDeleteOK(int no) {
		
		dao.msgDelete(session, no);
		
	}

	

	

}

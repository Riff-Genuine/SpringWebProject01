package com.carry.www.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.carry.www.vo.Criteria;
import com.carry.www.vo.MsgVO;

@Repository
public class MsgDAO {
	
	// ���� �޽��� ���� ��ȸ
	public int cntMsgTo(SqlSessionTemplate session, String id) {

		return session.selectOne("msg.cntMsgTo", id);
		
	}

	// ���� �޽��� ��ȸ
	public List<MsgVO> msgSelectTo(SqlSessionTemplate session, Criteria cri) {
		
		return session.selectList("msg.selectTo", cri);
				
	}
	
	// ���� �޽��� ���� ��ȸ
	public int cntMsgFrom(SqlSessionTemplate session, String id) {
		
		return session.selectOne("msg.cntMsgFrom", id);
		
	}
	
	// ���� �޽��� ����
	public List<MsgVO> msgSelectFrom(SqlSessionTemplate session, Criteria cri) {

		return session.selectList("msg.selectFrom", cri);
		
	}
	
	// �޽��� �ۼ�
	public void msgInsert(SqlSessionTemplate session, MsgVO vo) {

		session.insert("msg.insert", vo);
		
	}

	// Ư�� �޽��� ��ȸ
	public MsgVO msgSelectNo(SqlSessionTemplate session, int no) {

		return session.selectOne("msg.selectNo", no);
		
	}
	
	// �޽��� ����
	public void msgDelete(SqlSessionTemplate session, int no) {
		
		session.delete("msg.delete", no);
		
	}

	

}

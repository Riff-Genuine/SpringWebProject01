package com.carry.www.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.carry.www.vo.Criteria;
import com.carry.www.vo.MemberVO;
import com.carry.www.vo.QnaVO;

@Repository
public class QnaDAO {

	public void qnaInsert(SqlSessionTemplate session, QnaVO vo) {

		session.insert("qna.insert", vo);
		
	}

	public List<QnaVO> qnaSelectList(SqlSessionTemplate session, Criteria cri) {
		
		return session.selectList("qna.list", cri);
		
	}

	public QnaVO qnaSelectVO(SqlSessionTemplate session, int no) {
		
		return session.selectOne("qna.vo", no);
		
	}

	public int cntUserQna(SqlSessionTemplate session, String id) {

		return session.selectOne("qna.cntUserQna", id);
		
	}

	public void qnaDelete(SqlSessionTemplate session, int no) {

		session.delete("qna.delete", no);
		
	}
	

}

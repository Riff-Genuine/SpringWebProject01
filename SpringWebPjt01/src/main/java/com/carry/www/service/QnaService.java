package com.carry.www.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.carry.www.dao.QnaDAO;
import com.carry.www.vo.Criteria;
import com.carry.www.vo.MemberVO;
import com.carry.www.vo.QnaVO;

@Service
public class QnaService {

	@Autowired
	QnaDAO dao;
	
	@Autowired
	SqlSessionTemplate session;
	
	public void qnaInsertOK(QnaVO vo) {

		dao.qnaInsert(session, vo);
		
	}

	public List<QnaVO> qnaSelectList(Criteria cri) {
		
		return dao.qnaSelectList(session, cri);
		
	}

	public QnaVO qnaSelectVO(int no) {
		
		return dao.qnaSelectVO(session, no);
		
	}

	public int cntUserQna(String id) {

		return dao.cntUserQna(session, id);
	}

	public void qnaDeleteOK(int no) {
		
		dao.qnaDelete(session, no);
		
	}

}

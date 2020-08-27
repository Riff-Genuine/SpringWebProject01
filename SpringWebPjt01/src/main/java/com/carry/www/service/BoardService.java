package com.carry.www.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.carry.www.config.FileConfig;
import com.carry.www.dao.BoardDAO;
import com.carry.www.vo.BoardVO;
import com.carry.www.vo.Criteria;
import com.carry.www.vo.FileVO;
import com.carry.www.vo.MemberVO;

@Service
public class BoardService {
	
	@Autowired
	BoardDAO dao;
	
	@Autowired
	FileConfig fileConfig;
	
	@Autowired
	SqlSessionTemplate session;

	public void boardInsertOK(BoardVO vo, Map<String, Object> map, HttpServletRequest request) throws Exception {
		
		dao.boardInsert(session, vo);
	
		List<Map<String, Object>> list = fileConfig.insertFileInfo(map, request);
		
		for(int i=0; i<list.size(); i++) {
			dao.fileInsert(session, list.get(i));
		}
		
	}
	
	public BoardVO boardSelectVO(String no) {
		
		return dao.boardSelectVO(session, no);
		
	}
	
	public void boardCnt(String no) {
		
		dao.boardCnt(session, no);
	}

	public void boardUpdateOK(BoardVO vo, Map<String, Object> map, HttpServletRequest request) throws IllegalStateException, IOException {

		dao.boardUpdate(session, vo);
		
		List<Map<String, Object>> list = fileConfig.updateFileInfo(map, request, vo);
		
		for(int i=0; i<list.size(); i++) {
			dao.fileInsert(session, list.get(i));
		}
		
	}

	// �Խñ� ����
	public void boardDeleteOK(int no) {

		dao.boardDelete(session, no);
		
	}
	
	// �Խñ� �� ����
	public int cntAllPost() {
		
		return dao.cntAllPost(session);
		
	}
	
	// ��ü �Խñ� ��ȸ
	public List<BoardVO> boardSelectAll(Criteria cri) {

		return dao.boardSelectAll(session, cri);
		
	}
	
	// �� �Խñ� �� ����
	public int cntUserPost(String id) {
			
		return dao.cntUserPost(session, id);
		
	}

	// �� �Խñ� ��ȸ
	public List<BoardVO> boardSelectList(Criteria cri) {

		return dao.boardSelectList(session, cri);
			
	}

	// �Խñۿ� ��ϵ� �̹��� ��ȸ
	public List<FileVO> fileSelectList(String no) {

		return dao.fileSelectList(session, no);
		
	}

	// ÷������ ����
	public void fileDelete(int no) {

		dao.fileDelete(session, no);
		
	}

	
}

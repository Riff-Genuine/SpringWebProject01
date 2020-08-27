package com.carry.www.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.carry.www.vo.BoardVO;
import com.carry.www.vo.Criteria;
import com.carry.www.vo.FileVO;
import com.carry.www.vo.MemberVO;

@Repository
public class BoardDAO {
	
	Map<String, Object> map;

	public void boardInsert(SqlSessionTemplate session, BoardVO vo) {
		
		session.insert("board.insert", vo);
		
	}


	public BoardVO boardSelectVO(SqlSessionTemplate session, String no) {
		
		return session.selectOne("board.vo", no);
		
	}
	
	public void boardCnt(SqlSessionTemplate session, String no) {

		session.update("board.views",no);
		
	}
	
	
	public int selectBoardNo(SqlSessionTemplate session) {
		
		return session.selectOne("board.selectBoardNo");
		
	}

	// ÷������ ����
	public void fileInsert(SqlSessionTemplate session, Map<String, Object> map) {

		session.insert("board.insertFile", map);
		
	}
	
	// �Խñ� �� ����
	public int cntAllPost(SqlSessionTemplate session) {

		return session.selectOne("board.cntAllPost");
		
	}
	
	// ��� �Խñ� ��ȸ
	public List<BoardVO> boardSelectAll(SqlSessionTemplate session, Criteria cri) {
		
		return session.selectList("board.allPost", cri);
		
	}
	
	// �� �Խñ� �� ����
	public int cntUserPost(SqlSessionTemplate session, String id) {

		return session.selectOne("board.cntUserPost", id);
	}

	// �� �Խñ� ��ȸ
	public List<BoardVO> boardSelectList(SqlSessionTemplate session, Criteria cri) {
		
		return session.selectList("board.list", cri);
		
	}

	// �Խñۿ� ��ϵ� �̹��� ��ȸ
	public List<FileVO> fileSelectList(SqlSessionTemplate session, String no) {
		
		return session.selectList("board.fileSelectList", no);
		
	}
	
	// �Խñ� ����
	public void boardUpdate(SqlSessionTemplate session, BoardVO vo) {

		session.update("board.update", vo);
			
	}
		
	// �Խñ� ����
	public void boardDelete(SqlSessionTemplate session, int no) {
	
		session.delete("board.delete", no);
			
	}

	// ÷������ ����
	public void fileDelete(SqlSessionTemplate session, int no) {

		session.delete("board.fileDelete", no);
		
	}
}

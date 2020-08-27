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

	// 첨부파일 저장
	public void fileInsert(SqlSessionTemplate session, Map<String, Object> map) {

		session.insert("board.insertFile", map);
		
	}
	
	// 게시글 총 개수
	public int cntAllPost(SqlSessionTemplate session) {

		return session.selectOne("board.cntAllPost");
		
	}
	
	// 모든 게시글 조회
	public List<BoardVO> boardSelectAll(SqlSessionTemplate session, Criteria cri) {
		
		return session.selectList("board.allPost", cri);
		
	}
	
	// 내 게시글 총 개수
	public int cntUserPost(SqlSessionTemplate session, String id) {

		return session.selectOne("board.cntUserPost", id);
	}

	// 내 게시글 조회
	public List<BoardVO> boardSelectList(SqlSessionTemplate session, Criteria cri) {
		
		return session.selectList("board.list", cri);
		
	}

	// 게시글에 등록된 이미지 조회
	public List<FileVO> fileSelectList(SqlSessionTemplate session, String no) {
		
		return session.selectList("board.fileSelectList", no);
		
	}
	
	// 게시글 수정
	public void boardUpdate(SqlSessionTemplate session, BoardVO vo) {

		session.update("board.update", vo);
			
	}
		
	// 게시글 삭제
	public void boardDelete(SqlSessionTemplate session, int no) {
	
		session.delete("board.delete", no);
			
	}

	// 첨부파일 삭제
	public void fileDelete(SqlSessionTemplate session, int no) {

		session.delete("board.fileDelete", no);
		
	}
}

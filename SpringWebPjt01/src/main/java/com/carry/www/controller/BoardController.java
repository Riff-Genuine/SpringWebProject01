package com.carry.www.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.carry.www.config.PageMaker;
import com.carry.www.service.BoardService;
import com.carry.www.service.QnaService;
import com.carry.www.vo.BoardVO;
import com.carry.www.vo.Criteria;
import com.carry.www.vo.FileVO;

@Controller
public class BoardController {
	
	PrintWriter out;
	
	@Autowired
	BoardService service;
	
	@Autowired
	QnaService qService;
	
	@RequestMapping("/")
	public String index(Model model, @ModelAttribute("cri") Criteria cri) {
		List<BoardVO> allPost = service.boardSelectAll(cri);
		model.addAttribute("allPost", allPost);
		
		PageMaker pmIndex = new PageMaker();
		pmIndex.setCri(cri);
		pmIndex.setTotalCount(service.cntAllPost());
		model.addAttribute("pmIndex", pmIndex);
		
		return "index";
	}
	
	// 특정 게시글 조회
	@RequestMapping("/boardView")
	public String boardView(@RequestParam("no") String no, Model model, HttpServletRequest request, HttpServletResponse response) {
		
		BoardVO postInfo = service.boardSelectVO(no);
		model.addAttribute("postInfo", postInfo);
		
		Cookie[] cookies = request.getCookies();
		
		Cookie cnt = null;
		
		if(cookies != null && cookies.length > 0) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cookie"+no)) {
					cnt = cookies[i];
				}
			}
		}
		
		if(cnt == null) {
			Cookie newCookie = new Cookie("cookie"+no, "|" + no + "|");
			response.addCookie(newCookie);
			
			service.boardCnt(no);
		}
		
		
		List<FileVO> fileInfo = service.fileSelectList(no);
		
		if(fileInfo != null) {
			model.addAttribute("fileInfo", fileInfo);
		}
		
		return "board/boardView";
		
	}
	
	// 게시글 작성 폼
	@RequestMapping("/boardInsert")
	public String boardInsert() {
		
		return "board/boardInsert";
		
	}
	
	// 게시글 작성 로직
	@RequestMapping(value="/boardInsertOK", method=RequestMethod.POST)
	public String boardInsertOK(BoardVO vo, Map<String, Object> map, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		service.boardInsertOK(vo, map, request);
		
		response.setContentType("text/html; charset=UTF-8");
		out = response.getWriter();
		out.println("<script>alert('등록되었습니다.');</script>");
		out.flush();
		
		return "index";
		
	}
	
	// 게시글 수정 폼
	@RequestMapping("/boardUpdate")
	public String boardUpdate(@RequestParam("no") String no, Model model) {
		
		BoardVO vo = service.boardSelectVO(no);
		model.addAttribute("vo", vo);
		
		List<FileVO> fileInfo = service.fileSelectList(no);
		
		if(fileInfo != null) {
			model.addAttribute("fileInfo", fileInfo);
		}
		
		return "board/boardUpdate";
	}
	
	// 게시글 수정 로직
	@RequestMapping(value="boardUpdateOK", method=RequestMethod.POST)
	public String boardUpdateOK(BoardVO vo, Map<String, Object> map, HttpServletRequest request, HttpServletResponse response) throws IllegalStateException, IOException {
		
		service.boardUpdateOK(vo, map, request);
		
		response.setContentType("text/html; charset=UTF-8");
		out = response.getWriter();
		out.println("<script>alert('수정되었습니다.');</script>");
		out.flush();
		
		return "index";
	}
	
	// 게시글 삭제 로직
	@RequestMapping(value="boardDeleteOK", method=RequestMethod.POST)
	@ResponseBody
	public int boardDeleteOK(String[] arr) throws Exception {
		
		int result = 0;
		
		for(int i=0; i<arr.length; i++) {
			int no = Integer.parseInt(arr[i]);
			service.boardDeleteOK(no);
			result = 1;
		}
		
		return result;
	}
	
	// 첨부파일 삭제 로직
	@RequestMapping(value="fileDeleteOK", method=RequestMethod.POST)
	@ResponseBody
	public int fileDeleteOK(int no) throws Exception {
		int result = 0;
		
		if(no != 0) {
			service.fileDelete(no);
			result = 1;
		}
		
		return result;
	}
	
}

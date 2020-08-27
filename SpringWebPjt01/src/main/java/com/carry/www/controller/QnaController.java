package com.carry.www.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.carry.www.config.PageMaker;
import com.carry.www.service.QnaService;
import com.carry.www.vo.Criteria;
import com.carry.www.vo.MemberVO;
import com.carry.www.vo.QnaVO;

@Controller
public class QnaController {
	
	PrintWriter out;
	
	@Autowired
	QnaService service;
	
	// 내 문의글 조회
	@RequestMapping("/qna")
	public String myQna(Model model, @ModelAttribute("cri") Criteria cri, HttpSession session, HttpServletRequest request) {
		session = request.getSession();
		MemberVO vo = (MemberVO)session.getAttribute("user");
		String id = vo.getId();
		cri.setId(id);
		
		List<QnaVO> myQna = service.qnaSelectList(cri);
		model.addAttribute("myQna", myQna);
		
		PageMaker pmQna = new PageMaker();
		pmQna.setCri(cri);
		pmQna.setTotalCount(service.cntUserQna(id));
		model.addAttribute("pmQna", pmQna);
		
		return "qna/qna";
	}
	
	// 문의글 작성 폼
	@RequestMapping("/qnaInsert")
	public String qnaInsert() {
		
		return "qna/qnaInsert";
		
	}
	
	// 문의글 작성 로직
	@RequestMapping(value="/qnaInsertOK", method=RequestMethod.POST)
	public String qnaInsertOK(QnaVO vo, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		service.qnaInsertOK(vo);
		
		response.setContentType("text/html; charset=UTF-8");
		out = response.getWriter();
		out.println("<script>alert('등록되었습니다.');</script>");
		out.flush();
		
		return "index";
		
	}
	
	// 문의글 뷰 폼
	@RequestMapping("/qnaView")
	public String qnaView(@RequestParam("no") int no, Model model) {
		
		QnaVO vo = service.qnaSelectVO(no);
		
		model.addAttribute("vo", vo);
		
		return "qna/qnaView";
	}
	
	// 문의글 삭제
	@RequestMapping(value="/qnaDeleteOK", method=RequestMethod.POST)
	@ResponseBody
	public int qnaDeleteOK(String[] arr) {
		int result = 0;
		
		for(int i=0; i<arr.length; i++) {
			int no = Integer.parseInt(arr[i]);
			service.qnaDeleteOK(no);
			result = 1;
		}
		
		return result;
	}
		
}

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
import com.carry.www.service.BoardService;
import com.carry.www.service.MemberService;
import com.carry.www.vo.BoardVO;
import com.carry.www.vo.Criteria;
import com.carry.www.vo.MemberVO;

@Controller
public class MemberController {
	
	PrintWriter out;
	
	@Autowired
	MemberService service;
	
	@Autowired
	BoardService bService;
	
	// 아이디 중복확인 로직
	@RequestMapping("/idCheck")
	@ResponseBody
	public int idCheck(@RequestParam("id") String id) {
		
		return service.idCheck(id);
		
	}
	
	// 이메일 중복확인 로직
	@RequestMapping("/emailCheck")
	@ResponseBody
	public int emailCheck(@RequestParam("email") String email) {
		
		return service.emailCheck(email);
		
	}
	
	// 회원가입 폼
	@RequestMapping("/memberInsert")
	public String memberInsert() {
		
		return "member/memberInsert";
		
	}
	
	// 회원가입 로직
	@RequestMapping(value="/memberInsertOK", method=RequestMethod.POST)
	public String memberInsertOK(MemberVO vo) {
		
		service.memberInsertOK(vo);
		
		return "member/login";
		
	}
	
	// 로그인 폼
	@RequestMapping("/login")
	public String login() {
		
		return "member/login";
		
	}
	
	// 로그인 로직
	@RequestMapping(value="/loginOK", method=RequestMethod.POST)
	public String loginOK(MemberVO vo, HttpSession session, HttpServletResponse response) throws IOException {
		
		int result = service.login(vo);
		String loc = null;
		
		if(result == 0) {
			response.setContentType("text/html; charset=UTF-8");
			out = response.getWriter();
			out.println("<script>alert('아이디와 비밀번호를 확인해주세요.');</script>");
			out.flush();
			loc = "member/login";
		} else {
			session.setAttribute("user", service.memberSelect(vo));
			loc = "index";
		}
		
		return loc;
				
	}
	
	// 로그아웃 로직
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		return "index";
	}
	
	// 마이페이지 폼
	@RequestMapping("/myPage")
	public String myPage(Model model, @ModelAttribute("cri") Criteria cri, HttpSession session, HttpServletRequest request) {
		
		session = request.getSession();
		MemberVO vo = (MemberVO)session.getAttribute("user");
		String id = vo.getId();
		cri.setId(id);
		
		List<BoardVO> myPost = bService.boardSelectList(cri);
		model.addAttribute("myPost", myPost);
		
		PageMaker pmPost = new PageMaker();
		pmPost.setCri(cri);
		pmPost.setTotalCount(bService.cntUserPost(id));
		model.addAttribute("pmPost", pmPost);
		
		return "member/myPage";
		
	}
	
	// 비밀번호 확인 폼
	@RequestMapping("/pwCheck")
	public String pwCheck() {
		
		return "member/pwCheck";
		
	}
	
	// 회원 탈퇴 로직
	@RequestMapping(value="/pwCheckOK", method=RequestMethod.POST)
	public String pwCheckOK(MemberVO vo, @RequestParam("keyword") String keyword, HttpServletResponse response, HttpSession session, Model model) throws IOException {
		response.setContentType("text/html; charset=UTF-8");
		out = response.getWriter();
		
		int result = service.login(vo);
		
		if(result == 0) {
			out.println("<script>alert('비밀번호를 확인해주세요.'); history.back();</script>");
		} else {
			if(keyword.equals("memberDelete")) {
				service.memberDelete(vo);
				out.println("<script>alert('이용해주셔서 감사합니다.');</script>");
				out.flush();
				session.invalidate();
			}
		}
		
		return "index";
	}
	
	// 회원정보 수정 폼
	@RequestMapping("/memberUpdate")
	public String memberUpdate() {
		
		return "member/memberUpdate";
		
	}
	
	// 회원정보 수정 로직
	@RequestMapping(value="/memberUpdateOK", method=RequestMethod.POST)
	public String memberUpdateOK(MemberVO vo) {
		
		service.memberUpdate(vo);
		
		return "index";
	}
	
	// 회원탈퇴 폼
	@RequestMapping("/memberDelete")
	public String memberDelete() {
		
		return "member/memberDelete";
		
	}
	
	// 아이디 찾기 폼
	@RequestMapping("/findID")
	public String findID() {
		
		return "member/findID";
		
	}
	
	// 비밀번호 찾기 폼
	@RequestMapping("/findPW")
	public String findPW() {
		return "member/findPW";
	}
}

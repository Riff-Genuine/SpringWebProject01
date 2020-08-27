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
	
	// ���̵� �ߺ�Ȯ�� ����
	@RequestMapping("/idCheck")
	@ResponseBody
	public int idCheck(@RequestParam("id") String id) {
		
		return service.idCheck(id);
		
	}
	
	// �̸��� �ߺ�Ȯ�� ����
	@RequestMapping("/emailCheck")
	@ResponseBody
	public int emailCheck(@RequestParam("email") String email) {
		
		return service.emailCheck(email);
		
	}
	
	// ȸ������ ��
	@RequestMapping("/memberInsert")
	public String memberInsert() {
		
		return "member/memberInsert";
		
	}
	
	// ȸ������ ����
	@RequestMapping(value="/memberInsertOK", method=RequestMethod.POST)
	public String memberInsertOK(MemberVO vo) {
		
		service.memberInsertOK(vo);
		
		return "member/login";
		
	}
	
	// �α��� ��
	@RequestMapping("/login")
	public String login() {
		
		return "member/login";
		
	}
	
	// �α��� ����
	@RequestMapping(value="/loginOK", method=RequestMethod.POST)
	public String loginOK(MemberVO vo, HttpSession session, HttpServletResponse response) throws IOException {
		
		int result = service.login(vo);
		String loc = null;
		
		if(result == 0) {
			response.setContentType("text/html; charset=UTF-8");
			out = response.getWriter();
			out.println("<script>alert('���̵�� ��й�ȣ�� Ȯ�����ּ���.');</script>");
			out.flush();
			loc = "member/login";
		} else {
			session.setAttribute("user", service.memberSelect(vo));
			loc = "index";
		}
		
		return loc;
				
	}
	
	// �α׾ƿ� ����
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		return "index";
	}
	
	// ���������� ��
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
	
	// ��й�ȣ Ȯ�� ��
	@RequestMapping("/pwCheck")
	public String pwCheck() {
		
		return "member/pwCheck";
		
	}
	
	// ȸ�� Ż�� ����
	@RequestMapping(value="/pwCheckOK", method=RequestMethod.POST)
	public String pwCheckOK(MemberVO vo, @RequestParam("keyword") String keyword, HttpServletResponse response, HttpSession session, Model model) throws IOException {
		response.setContentType("text/html; charset=UTF-8");
		out = response.getWriter();
		
		int result = service.login(vo);
		
		if(result == 0) {
			out.println("<script>alert('��й�ȣ�� Ȯ�����ּ���.'); history.back();</script>");
		} else {
			if(keyword.equals("memberDelete")) {
				service.memberDelete(vo);
				out.println("<script>alert('�̿����ּż� �����մϴ�.');</script>");
				out.flush();
				session.invalidate();
			}
		}
		
		return "index";
	}
	
	// ȸ������ ���� ��
	@RequestMapping("/memberUpdate")
	public String memberUpdate() {
		
		return "member/memberUpdate";
		
	}
	
	// ȸ������ ���� ����
	@RequestMapping(value="/memberUpdateOK", method=RequestMethod.POST)
	public String memberUpdateOK(MemberVO vo) {
		
		service.memberUpdate(vo);
		
		return "index";
	}
	
	// ȸ��Ż�� ��
	@RequestMapping("/memberDelete")
	public String memberDelete() {
		
		return "member/memberDelete";
		
	}
	
	// ���̵� ã�� ��
	@RequestMapping("/findID")
	public String findID() {
		
		return "member/findID";
		
	}
	
	// ��й�ȣ ã�� ��
	@RequestMapping("/findPW")
	public String findPW() {
		return "member/findPW";
	}
}

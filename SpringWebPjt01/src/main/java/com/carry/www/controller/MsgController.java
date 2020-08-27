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
import com.carry.www.service.MsgService;
import com.carry.www.vo.Criteria;
import com.carry.www.vo.MemberVO;
import com.carry.www.vo.MsgVO;

@Controller	
public class MsgController {
	
	@Autowired
	PageMaker pmMsg;
	
	@Autowired
	MsgService service;
	
	PrintWriter out;
	
	// ���� ������ ����¡
	@RequestMapping("/msg")
	public String msg(Model model, @ModelAttribute("cri") Criteria cri, HttpSession session, HttpServletRequest request) {
		session = request.getSession();
		MemberVO vo = (MemberVO)session.getAttribute("user");
		String id = vo.getId();
		cri.setId(id);
		
		// ���� �޽��� ��ȸ
		List<MsgVO> myMsg = service.msgSelectTo(cri);
		model.addAttribute("myMsg", myMsg);
		
		pmMsg.setCri(cri);
		pmMsg.setTotalCount(service.cntMsgTo(id));
		model.addAttribute("pmMsg", pmMsg);
		
		return "msg/msg";
	}
	
	// �޽��� ��
	@RequestMapping("/sendMsg")
	public String sendMsg() {
		
		return "msg/sendMsg";
		
	}
	
	// �޽��� �ۼ�
	@RequestMapping(value="/sendMsgOK", method=RequestMethod.POST)
	public void sendMsgOK(MsgVO vo, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		service.msgInsert(vo);
		
		response.setContentType("text/html; charset=UTF-8");
		out = response.getWriter();
		out.println("<script>alert('�߼��Ͽ����ϴ�.'); window.close();</script>");
		out.flush();
		
	}
	
	// Ư�� �޽��� ��ȸ
	@RequestMapping(value="/msgView")
	public String msgView(@RequestParam("no") int no, Model model) {
		
		MsgVO vo = service.msgSelectNo(no);
		model.addAttribute("vo", vo);
		
		return "msg/msgView";
		
	}
	
	// �޽��� ���� ����
	@RequestMapping(value="msgDeleteOK", method=RequestMethod.POST)
	@ResponseBody
	public int msgDeleteOK(String[] arr) {
		
		int result = 0;
		
		for(int i=0; i<arr.length; i++) {
			int no = Integer.parseInt(arr[i]);
			service.msgDeleteOK(no);
			result = 1;
		}
		
		return result;
	}
		
}

package com.carry.www.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.carry.www.service.MemberService;
import com.carry.www.vo.MemberVO;

@Controller
public class EmailController {
	
	int rndNum = 0;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	MemberService service;
	
	@RequestMapping("/sendCertiNum")
	@ResponseBody
	public void sendCertiNum(@RequestParam("email") String email, Model model) {
		rndNum = (int)(Math.random()*999999)+1;
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			
			helper.setFrom("seong9307@gmail.com");
			helper.setTo(email);
			helper.setSubject("[1 Day Helper]에서 발송한 메일입니다.");
			helper.setText("인증번호는 [ " + rndNum + " ] 입니다.");
			
			mailSender.send(message);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/certiNumCheck")
	@ResponseBody
	public int certiNumCheck(@RequestParam("certiNum") int certiNum) {
		int result = 0;
		
		if(certiNum != rndNum) {
			result = 1;
		}
		
		return result;
	}
	
	@RequestMapping("/sendUserID")
	@ResponseBody
	public void sendUserID(@RequestParam("email") String email) {
		
		MemberVO userInfo = service.selectEmail(email);
		
		String userID = userInfo.getId();
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			
			helper.setFrom("seong9307@gmail.com");
			helper.setTo(email);
			helper.setSubject("[1 Day Helper]에서 발송한 메일입니다.");
			helper.setText("가입하신 아이디는 [ " + userID + " ] 입니다.");
			
			mailSender.send(message);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/createNewPw")
	@ResponseBody
	public void createNewPw(@RequestParam("email") String email, MemberVO vo) {
		String newPw = rndStr();
		
		vo.setPw(newPw);
		vo.setEmail(email);
		
		service.modifyUserPw(vo);
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			
			helper.setFrom("seong9307@gmail.com");
			helper.setTo(email);
			helper.setSubject("[1 Day Helper]에서 발송한 메일입니다.");
			helper.setText("임시 비밀번호는 [ " + newPw + " ] 입니다.");
			
			mailSender.send(message);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public String rndStr() {
		Random rnd = new Random();
		StringBuffer sb = new StringBuffer();
		
		for(int i=0; i<10; i++) {
			if(rnd.nextBoolean()) {
				sb.append((char)((int)(rnd.nextInt(26))+65));
			} else {
				sb.append((rnd.nextInt(10)));
			}
		}
		
		return sb.toString();
	}
}

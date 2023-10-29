package com.example.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.model.LoginDAO;
import com.example.model.LoginTO;

@RestController
public class FindLoginController {

	@Autowired
	private JavaMailSender javaMailSender;

	@Autowired
	private LoginDAO ldao;

	// 아이디 찾기 페이지
	@RequestMapping("/findLogin.do")
	public ModelAndView login(HttpServletRequest request) {

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("login/findLogin");

		return modelAndView;
	}

	// 비밀번호 찾기 / 이메일로 인증번호 보내기
	@RequestMapping("/findPw.do")
	public String mail_ok(HttpServletRequest request) {

		// 받는사람
		String toEmail = request.getParameter("findemail1") + "@" + request.getParameter("findemail2");
		String subject = "인증번호입니다. -GOsaka 동까무라상";
		String code = "";

		for (int i = 0; i < 6; i++) {
			double num = Math.random();
			code += (int) (num * 10) + "";
		}

		String content = "본인확인에 필요한 인증번호입니다 : " + code;

		this.mailSender1(toEmail, subject, content);

		return code;
	}

	// 사용자의 등록된 아이디에 대한 이메일 얻기
	@RequestMapping("/correctInfo")
	public String correctInfo(HttpServletRequest request) {

		String email = ldao.correctInfo(request.getParameter("findId"));

		return email;
	}

	// 아이디 찾기 / 이메일로 아이디 전송
	@RequestMapping("/findId.do")
	public ModelAndView id_mail_ok(HttpServletRequest request) {

		LoginTO to = new LoginTO();
		to.setFemail(request.getParameter("id_findemail1"));
		to.setSemail(request.getParameter("id_findemail2"));

		// 받는사람
		String toEmail = request.getParameter("id_findemail1") + "@" + request.getParameter("id_findemail2");
		String subject = "아이디 정보 입니다. -GOsaka 동까무라상";
		String code = ldao.findId(to);

		String content = "요청하신 회원님의 아이디 입니다. : " + code;

		mailSender1(toEmail, subject, content);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("login/findId_ok");
		modelAndView.addObject("code", code);

		return modelAndView;
	}

	// 메일 받는사람에 대한 정보
	public void mailSender1(String toEmail, String subject, String content) {

		// 단순 텍스트 구성 메일 메시지 생성할 때 이용
		SimpleMailMessage simpleMailMessage = new SimpleMailMessage();

		// ~ 에게 보내겠다
		simpleMailMessage.setTo(toEmail);
		simpleMailMessage.setSubject(subject);
		simpleMailMessage.setText(content);
		simpleMailMessage.setSentDate(new Date()); // 날짜

		javaMailSender.send(simpleMailMessage);

		System.out.println("전송 완료");
	}

	// 비밀번호 변경 페이지
	@RequestMapping("/changePw.do")
	public ModelAndView changePw(HttpServletRequest request) {

		String h_findid = request.getParameter("h_findid");

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("login/changePw");
		modelAndView.addObject("h_findid", h_findid);
		return modelAndView;
	}

	// 비밀번호 변경 완료
	@RequestMapping("/changePw_ok.do")
	public ModelAndView changePw_ok(HttpServletRequest request) {

		LoginTO to = new LoginTO();

		to.setUserId(request.getParameter("h_findid"));
		to.setPassword(request.getParameter("newPw"));

		int flag = ldao.changePw(to);

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("login/changePw_ok");
		modelAndView.addObject("flag", flag);
		return modelAndView;
	}
}

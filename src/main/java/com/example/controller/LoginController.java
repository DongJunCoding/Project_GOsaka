package com.example.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.model.LoginDAO;
import com.example.model.LoginTO;

@RestController
public class LoginController {

	@Autowired
	private LoginDAO ldao;
	
	// 회원가입 OK !
	@RequestMapping("/signup.do")
	public ModelAndView signup_ok(HttpServletRequest request) {
		LoginTO signupTO = new LoginTO();

		signupTO.setUserId(request.getParameter("signid"));
		signupTO.setNickname(request.getParameter("signnick"));
		signupTO.setPassword(request.getParameter("signpw"));
		signupTO.setFemail(request.getParameter("signemail1"));
		signupTO.setSemail(request.getParameter("signemail2"));

		int flag = ldao.signup_ok(signupTO);

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("login/signup_ok");
		modelAndView.addObject("flag", flag);

		return modelAndView;
	}

	// 아이디 중복확인
	@RequestMapping("/id_check")
	public int dup_id_check(HttpServletRequest request) {
		String signid = request.getParameter("signid");

		int result = ldao.dup_id_chek(signid);

		return result;
	}

	// 닉네임 중복확인
	@RequestMapping("/nickname_check")
	public int dup_nickname_check(HttpServletRequest request) {
		String signnick = request.getParameter("signnick");

		int result = ldao.dup_nickname_chek(signnick);

		return result;
	}

	// 아이디 찾기 이메일 중복확인
	@RequestMapping("/email_check")
	public String email_check(HttpServletRequest request) {
		String femail = request.getParameter("femail");
		String semail = request.getParameter("semail");
		String result = ldao.dup_femail_check(femail, semail);

		return result;
	}

	// 로그인 페이지
	@RequestMapping("/login.do")
	public ModelAndView login(HttpServletRequest request) {

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("login/login");

		return modelAndView;
	}

	// 로그인 OK !
	@RequestMapping("/login_ok.do")
	public ModelAndView login_ok(HttpServletRequest request) {
		LoginTO loginTO = new LoginTO();
		loginTO.setUserId(request.getParameter("loginid"));
		loginTO.setPassword(request.getParameter("loginpw"));

		boolean flag = ldao.login(loginTO);

		LoginTO to = ldao.infoSession(loginTO);

		// flag가 true이면 로그인 정보를 제대로 가져온 것
		if (flag) {
			// 세션 생성
			HttpSession session = request.getSession();

			// 세션에 값 넣기
			session.setAttribute("loginId", loginTO.getUserId());
			session.setAttribute("nickname", to.getNickname());
			session.setAttribute("femail", to.getFemail());
			session.setAttribute("semail", to.getSemail());
			session.setAttribute("role", to.getRole());
			session.setMaxInactiveInterval(60 * 60);
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("login/login_ok");
		modelAndView.addObject("flag", flag);
		return modelAndView;
	}

	// 로그아웃
	@RequestMapping("/logout.do")
	public ModelAndView logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("login/logout_ok");
		return modelAndView;
	}
	
}

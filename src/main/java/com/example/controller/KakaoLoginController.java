package com.example.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.model.LoginDAO;
import com.example.model.LoginTO;
import com.example.service.KakaoService;

@RestController
public class KakaoLoginController {

	@Autowired
	private LoginDAO ldao;
	
	@Autowired
	private KakaoService ks;

	// 카카오로그인
	@RequestMapping("kakao/callback")
	public ModelAndView kakaoLogin(@RequestParam("code") String code, HttpServletRequest request) {
		
		// 인가코드를 통해 받아온 토큰 ks.getAccessToken(code)에서 받아옴
		String accessToken = ks.getAccessToken(code);
		
		LoginTO to = new LoginTO();
		HttpSession session = request.getSession();

		HashMap<String, Object> userInfo = ks.getUserInfo(accessToken);

		String kakaoEmail = (String)userInfo.get("email");
		int at = kakaoEmail.indexOf("@");
		
		to.setUserId((String)userInfo.get("id") + "(카카오)");
		to.setNickname((String)userInfo.get("nickname") + "(카카오)");
		to.setFemail(kakaoEmail.substring(0, at));
		to.setSemail(kakaoEmail.substring(at+1) + "(카카오)");
		
		int flag = ldao.kakaoLogin(to);
		
		LoginTO to2 = ldao.infoSession(to);
		
		if (flag == 0) {

			// 세션에 값 넣기
			session.setAttribute("accessToken", accessToken);
			session.setAttribute("loginId", to2.getUserId());
			session.setAttribute("nickname", to2.getNickname());
			session.setAttribute("femail", to2.getFemail());
			session.setAttribute("semail", to2.getSemail());
			session.setAttribute("role", to2.getRole());
			session.setMaxInactiveInterval(60 * 60);
		}
	
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("login/kakaoLogin_ok");
		modelAndView.addObject("flag", flag);
		return modelAndView;
	}	
	
	// 카카오 로그아웃
	@RequestMapping("kakao/logout")
	public ModelAndView kakaoLogout(HttpSession session) {

		ks.getLogout((String)session.getAttribute("accessToken"));

		session.invalidate();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("login/logout_ok");
		return modelAndView;
	}
}

package com.example.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.model.MyPageDAO;

@RestController
public class MyPageController {
	
	@Autowired
	private MyPageDAO mdao;

	// MyPage
	@RequestMapping("/myPage.do")
	public ModelAndView myPage(HttpServletRequest request) {

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("mypage/myPage");
		return modelAndView;
	}
	
	
	// MyPage 닉네임 수정
	@RequestMapping("/myPageModifyOK.do")
	public ModelAndView myPageModify(HttpServletRequest request) {
		String nickname = request.getParameter("mpNick");
		String userId = request.getParameter("mpId");
		
		int flag = mdao.mypageModify(nickname, userId);

		HttpSession session = request.getSession();
		session.invalidate();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("mypage/myPageModifyOk");
		modelAndView.addObject("flag", flag);
		return modelAndView;
		
	}
	
}

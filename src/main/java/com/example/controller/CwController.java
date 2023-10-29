package com.example.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.service.Fservice;
import com.example.service.Iservice;
import com.example.service.Sservice;

@RestController
public class CwController {
	
	@Resource(name = "OsakaCrawling")
	private Iservice osakaCrawling;

	@Resource(name = "ShoppingCrawling")
	private Sservice shoppingCrawling;
	
	@Resource(name = "FestivalCrawling")
	private Fservice festivalCrawling;
	
	/* 가이드 크롤링한 정보 */
	@RequestMapping("/cwling.do")
	public ModelAndView cwlingList(HttpServletRequest request) throws Exception {
		
		int res = festivalCrawling.getFestivalInfoFromWEB();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("crawling/crawling/cwling");
		modelAndView.addObject("res", String.valueOf(res));
		
		return modelAndView;
	}
	
	/* 쇼핑, 음식 크롤링한 정보(쇼핑 크롤링에서만 유동적 변환 해주면 됨.) */
	@RequestMapping("/cwling2.do")
	public ModelAndView cwlingList2(HttpServletRequest request) throws Exception {

		int res = shoppingCrawling.getShoppingInfoFromWEB();

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("crawling/cwling");
		modelAndView.addObject("res", String.valueOf(res));

		return modelAndView;
	}
	
	/* 축제 크롤링한 정보 */
	@RequestMapping("/cwling3.do")
	public ModelAndView cwlingList3(HttpServletRequest request) throws Exception {

		int res = festivalCrawling.getFestivalInfoFromWEB();

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("crawling/cwling");
		modelAndView.addObject("res", String.valueOf(res));

		return modelAndView;
	}
	
	
}

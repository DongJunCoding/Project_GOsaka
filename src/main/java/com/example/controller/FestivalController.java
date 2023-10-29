package com.example.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.model.FestivalDAO;
import com.example.model.FestivalTO;


@RestController
public class FestivalController {

	@Autowired
	private FestivalDAO fdao;

	// 오사카 축제 리스트 페이지
	@RequestMapping("/osakaFestivalList.do")
	public ModelAndView osakaFestivalList(HttpServletRequest request) {

		ArrayList<FestivalTO> festivalList = fdao.festivalList();

		ArrayList<FestivalTO> osakaFestivalList = new ArrayList<>();

		for (FestivalTO osakaFestivalTO : festivalList) {

			String category = osakaFestivalTO.getCategory();

			if (category.equals("osaka")) {

				osakaFestivalList.add(osakaFestivalTO);

			}
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("festival/osakaFestivalList");
		modelAndView.addObject("osakaFestivalList", osakaFestivalList);

		return modelAndView;

	}
	
	// 교토 축제 리스트 페이지
	@RequestMapping("/kyotoFestivalList.do")
	public ModelAndView kyotoFestivalList(HttpServletRequest request) {
		
		ArrayList<FestivalTO> festivalList = fdao.festivalList();
		
		ArrayList<FestivalTO> kyotoFestivalList = new ArrayList<>();
		
		for (FestivalTO kyotoFestivalTO : festivalList) {
			
			String category = kyotoFestivalTO.getCategory();
			
			if (category.equals("kyoto")) {
				
				kyotoFestivalList.add(kyotoFestivalTO);
				
			}
		}
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("festival/kyotoFestivalList");
		modelAndView.addObject("kyotoFestivalList", kyotoFestivalList);
		
		return modelAndView;
		
	}
	
	// 고베 축제 리스트 페이지
	@RequestMapping("/kobeFestivalList.do")
	public ModelAndView kobeFestivalList(HttpServletRequest request) {
		
		ArrayList<FestivalTO> festivalList = fdao.festivalList();
		
		ArrayList<FestivalTO> kobeFestivalList = new ArrayList<>();
		
		for (FestivalTO kobeFestivalTO : festivalList) {
			
			String category = kobeFestivalTO.getCategory();
			
			if (category.equals("kobe")) {
				
				kobeFestivalList.add(kobeFestivalTO);
				
			}
		}
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("festival/kobeFestivalList");
		modelAndView.addObject("kobeFestivalList", kobeFestivalList);
		
		return modelAndView;
		
	}
	
	// 나라 축제 리스트 페이지
	@RequestMapping("/naraFestivalList.do")
	public ModelAndView naraFestivalList(HttpServletRequest request) {
		
		ArrayList<FestivalTO> festivalList = fdao.festivalList();
		
		ArrayList<FestivalTO> naraFestivalList = new ArrayList<>();
		
		for (FestivalTO naraFestivalTO : festivalList) {
			
			String category = naraFestivalTO.getCategory();
			
			if (category.equals("nara")) {
				
				naraFestivalList.add(naraFestivalTO);
				
			}
		}
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("festival/naraFestivalList");
		modelAndView.addObject("naraFestivalList", naraFestivalList);
		
		return modelAndView;
		
	}
}

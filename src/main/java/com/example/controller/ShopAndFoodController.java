package com.example.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.model.PageListTO;
import com.example.model.RestaurantTO;
import com.example.model.ShopAndFoodDAO;
import com.example.model.ShoppingTO;

@RestController
public class ShopAndFoodController {

	@Autowired
	private ShopAndFoodDAO sdao;

	// 쇼핑 리스트 페이지 + 검색
	@RequestMapping("/shoppingList.do")
	public ModelAndView shoppingList(HttpServletRequest request) {

		PageListTO pageTO = new PageListTO();
		String cpageParam = request.getParameter("cpage");
		int cpage = 1; // 기본값 설정

		if (cpageParam != null && !cpageParam.isEmpty()) {
			cpage = Integer.parseInt(cpageParam);
		}
		int recordPerPage = pageTO.getRecordPerPage();
		int blockPerPage = pageTO.getBlockPerPage();

		ArrayList<ShoppingTO> shoppingList = sdao.shoppingList();

		String searchWord = request.getParameter("searchWord");

		// 전체 게시물 개수 가져옴
		pageTO.setTotalRecord(shoppingList.size());

		// 전체 게시물의 페이지 개수
		pageTO.setTotalPage((pageTO.getTotalRecord() - 1) / recordPerPage + 1);

		if (searchWord != null) {
			shoppingList = sdao.shoppingSearchList(searchWord);
	
			pageTO.setTotalRecord(shoppingList.size());
			pageTO.setTotalPage((pageTO.getTotalRecord() - 1) / recordPerPage + 1);

		}

		int skip = (cpage - 1) * recordPerPage;
		int endIndex = Math.min(skip + recordPerPage, shoppingList.size());

		ArrayList<ShoppingTO> pageList = new ArrayList<>(shoppingList.subList(skip, endIndex));
		pageTO.setShoppingPageList(pageList);

		pageTO.setStartBlock(cpage - (cpage - 1) % blockPerPage);
		pageTO.setEndBlock(cpage - (cpage - 1) % blockPerPage + blockPerPage - 1);

		if (pageTO.getEndBlock() >= pageTO.getTotalPage()) {
			pageTO.setEndBlock(pageTO.getTotalPage());
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("shopAndFood/shoppingList");
		modelAndView.addObject("shoppingList", shoppingList);
		modelAndView.addObject("pageTO", pageTO);

		return modelAndView;

	}

	// 쇼핑 view 페이지
	@RequestMapping("/shoppingView.do")
	public ModelAndView shoppingView(HttpServletRequest request) throws Exception {
		ShoppingTO to = new ShoppingTO();
		to.setShopId(request.getParameter("shopId"));

		to = sdao.shoppingView(to);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("shopAndFood/shoppingView");
		modelAndView.addObject("to", to);

		return modelAndView;
	}

	// 음식 리스트 페이지 + 검색
	@RequestMapping("/restaurantList.do")
	public ModelAndView foodList(HttpServletRequest request) {

		PageListTO pageTO = new PageListTO();
		String cpageParam = request.getParameter("cpage");
		int cpage = 1; // 기본값 설정

		if (cpageParam != null && !cpageParam.isEmpty()) {
			cpage = Integer.parseInt(cpageParam);
		}
		int recordPerPage = pageTO.getRecordPerPage();
		int blockPerPage = pageTO.getBlockPerPage();

		ArrayList<RestaurantTO> restaurantList = sdao.restaurantList();

		String searchWord = request.getParameter("searchWord");

		// 전체 게시물 개수 가져옴
		pageTO.setTotalRecord(restaurantList.size());

		// 전체 게시물의 페이지 개수
		pageTO.setTotalPage((pageTO.getTotalRecord() - 1) / recordPerPage + 1);

		if (searchWord != null) {
			restaurantList = sdao.restaurantSearchList(searchWord);
			
			pageTO.setTotalRecord(restaurantList.size());
			pageTO.setTotalPage((pageTO.getTotalRecord() - 1) / recordPerPage + 1);

		}

		int skip = (cpage - 1) * recordPerPage;
		int endIndex = Math.min(skip + recordPerPage, restaurantList.size());

		ArrayList<RestaurantTO> pageList = new ArrayList<>(restaurantList.subList(skip, endIndex));
		pageTO.setRestaurantPageList(pageList);

		pageTO.setStartBlock(cpage - (cpage - 1) % blockPerPage);
		pageTO.setEndBlock(cpage - (cpage - 1) % blockPerPage + blockPerPage - 1);

		if (pageTO.getEndBlock() >= pageTO.getTotalPage()) {
			pageTO.setEndBlock(pageTO.getTotalPage());
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("shopAndFood/restaurantList");
		modelAndView.addObject("restaurantList", restaurantList);
		modelAndView.addObject("pageTO", pageTO);

		return modelAndView;

	}

	// 음식 view 페이지
	@RequestMapping("/restaurantView.do")
	public ModelAndView restaurantView(HttpServletRequest request) throws Exception {
		RestaurantTO to = new RestaurantTO();
		to.setRestaurantId(request.getParameter("restaurantId"));

		to = sdao.restaurantView(to);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("shopAndFood/restaurantView");
		modelAndView.addObject("to", to);

		return modelAndView;
	}

	
}

package com.example.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.model.FestivalDAO;
import com.example.model.FestivalTO;
import com.example.model.OsakaAreaDAO;
import com.example.model.OsakaAreaTO;
import com.example.model.PageListTO;
import com.example.model.RestaurantTO;
import com.example.model.ShopAndFoodDAO;
import com.example.model.ShoppingTO;

@RestController
public class OsakaController {

	@Autowired
	private OsakaAreaDAO dao;
	
	@Autowired
	private ShopAndFoodDAO sdao;
	
	@Autowired
	private FestivalDAO fdao;
	
	@RequestMapping("/GOsakas.do")
	public ModelAndView GOsaka(HttpServletRequest request) {
		
		ArrayList<OsakaAreaTO> osakaList = dao.osakaList();
		ArrayList<ShoppingTO> shopList = sdao.shoppingList();
		ArrayList<RestaurantTO> resList = sdao.restaurantList();
		ArrayList<FestivalTO> fesList = fdao.festivalList();
	
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("main/index");
		modelAndView.addObject("osakaList", osakaList);
		modelAndView.addObject("shopList", shopList);
		modelAndView.addObject("resList", resList);
		modelAndView.addObject("fesList", fesList);
		return modelAndView;

	}

	// 관광가이드 오사카 리스트 페이지
	@RequestMapping("/osakaList.do")
	public ModelAndView osakaList(HttpServletRequest request) {
		
		PageListTO pageTO = new PageListTO();
		
		// url에 있는 cpage= 뒤에 오는 값을 받음
		String cpageParam = request.getParameter("cpage");
		
		int cpage = 1; // 기본값 설정

		// null체크와 빈문자열 isEmpty(공백)로 체크하는 것은 값을 넘겨받았을 때 두 가지의 문제가 보통 발생할 수 있어서 안정적으로 두 가지의 조건을 걸어준 것
		if (cpageParam != null && !cpageParam.isEmpty()) {
			cpage = Integer.parseInt(cpageParam);
		}
		
		int recordPerPage = pageTO.getRecordPerPage();
		int blockPerPage = pageTO.getBlockPerPage();

		ArrayList<OsakaAreaTO> japanList = dao.osakaList();

		ArrayList<OsakaAreaTO> osakaList = new ArrayList<>();

		String searchWord = request.getParameter("searchWord");

		for (OsakaAreaTO osakaTO : japanList) {

			String category = osakaTO.getCategory();

			if (category.equals("osaka")) {

				osakaList.add(osakaTO);

				// 전체 게시물 개수 가져옴
				pageTO.setTotalRecord(osakaList.size());

				// 전체 게시물의 페이지 개수
				pageTO.setTotalPage((pageTO.getTotalRecord() - 1) / recordPerPage + 1);
			}
		}

		if (searchWord != null) {
			osakaList = dao.searchList("osaka", searchWord);

			pageTO.setTotalRecord(osakaList.size());
			pageTO.setTotalPage((pageTO.getTotalRecord() - 1) / recordPerPage + 1);

		}

		int skip = (cpage - 1) * recordPerPage;
		int endIndex = Math.min(skip + recordPerPage, osakaList.size());

		ArrayList<OsakaAreaTO> pageList = new ArrayList<>(osakaList.subList(skip, endIndex));
		pageTO.setPageList(pageList);

		pageTO.setStartBlock(cpage - (cpage - 1) % blockPerPage);
		pageTO.setEndBlock(cpage - (cpage - 1) % blockPerPage + blockPerPage - 1);

		if (pageTO.getEndBlock() >= pageTO.getTotalPage()) {
			pageTO.setEndBlock(pageTO.getTotalPage());
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("guide/osakaList");
		modelAndView.addObject("osakaList", osakaList);
		modelAndView.addObject("pageTO", pageTO);

		return modelAndView;

	}

	// 관광가이드 교토 리스트 페이지
	@RequestMapping("/kyotoList.do")
	public ModelAndView kyotoList(HttpServletRequest request) {

		PageListTO pageTO = new PageListTO();
		String cpageParam = request.getParameter("cpage");
		int cpage = 1; // 기본값 설정

		if (cpageParam != null && !cpageParam.isEmpty()) {
			cpage = Integer.parseInt(cpageParam);
		}
		int recordPerPage = pageTO.getRecordPerPage();
		int blockPerPage = pageTO.getBlockPerPage();

		ArrayList<OsakaAreaTO> japanList = dao.osakaList();

		ArrayList<OsakaAreaTO> kyotoList = new ArrayList<>();

		String searchWord = request.getParameter("searchWord");

		for (OsakaAreaTO kyotoTO : japanList) {

			String category = kyotoTO.getCategory();

			if (category.equals("kyoto")) {
				kyotoList.add(kyotoTO);

				// 전체 게시물 개수 가져옴
				pageTO.setTotalRecord(kyotoList.size());

				// 전체 게시물의 페이지 개수
				pageTO.setTotalPage((pageTO.getTotalRecord() - 1) / recordPerPage + 1);
			}
		}

		if (searchWord != null) {
			kyotoList = dao.searchList("kyoto", searchWord);

			pageTO.setTotalRecord(kyotoList.size());
			pageTO.setTotalPage((pageTO.getTotalRecord() - 1) / recordPerPage + 1);

		}

		int skip = (cpage - 1) * recordPerPage;
		int endIndex = Math.min(skip + recordPerPage, kyotoList.size());

		ArrayList<OsakaAreaTO> pageList = new ArrayList<>(kyotoList.subList(skip, endIndex));
		pageTO.setPageList(pageList);

		pageTO.setStartBlock(cpage - (cpage - 1) % blockPerPage);
		pageTO.setEndBlock(cpage - (cpage - 1) % blockPerPage + blockPerPage - 1);

		if (pageTO.getEndBlock() >= pageTO.getTotalPage()) {
			pageTO.setEndBlock(pageTO.getTotalPage());
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("guide/kyotoList");
		modelAndView.addObject("kyotoList", kyotoList);
		modelAndView.addObject("pageTO", pageTO);

		return modelAndView;

	}

	// 관광가이드 고베 리스트 페이지
	@RequestMapping("/kobeList.do")
	public ModelAndView kobeList(HttpServletRequest request) {

		PageListTO pageTO = new PageListTO();
		String cpageParam = request.getParameter("cpage");
		int cpage = 1; // 기본값 설정

		if (cpageParam != null && !cpageParam.isEmpty()) {
			cpage = Integer.parseInt(cpageParam);
		}
		int recordPerPage = pageTO.getRecordPerPage();
		int blockPerPage = pageTO.getBlockPerPage();

		ArrayList<OsakaAreaTO> japanList = dao.osakaList();

		ArrayList<OsakaAreaTO> kobeList = new ArrayList<>();

		String searchWord = request.getParameter("searchWord");

		for (OsakaAreaTO kobeTO : japanList) {

			String category = kobeTO.getCategory();

			if (category.equals("kobe")) {
				kobeList.add(kobeTO);

				// 전체 게시물 개수 가져옴
				pageTO.setTotalRecord(kobeList.size());

				// 전체 게시물의 페이지 개수
				pageTO.setTotalPage((pageTO.getTotalRecord() - 1) / recordPerPage + 1);
			}
		}

		if (searchWord != null) {
			kobeList = dao.searchList("kobe", searchWord);

			pageTO.setTotalRecord(kobeList.size());
			pageTO.setTotalPage((pageTO.getTotalRecord() - 1) / recordPerPage + 1);

		}

		int skip = (cpage - 1) * recordPerPage;
		int endIndex = Math.min(skip + recordPerPage, kobeList.size());

		ArrayList<OsakaAreaTO> pageList = new ArrayList<>(kobeList.subList(skip, endIndex));
		pageTO.setPageList(pageList);

		pageTO.setStartBlock(cpage - (cpage - 1) % blockPerPage);
		pageTO.setEndBlock(cpage - (cpage - 1) % blockPerPage + blockPerPage - 1);

		if (pageTO.getEndBlock() >= pageTO.getTotalPage()) {
			pageTO.setEndBlock(pageTO.getTotalPage());
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("guide/kobeList");
		modelAndView.addObject("kobeList", kobeList);
		modelAndView.addObject("pageTO", pageTO);

		return modelAndView;

	}

	// 관광가이드 나라 리스트 페이지
	@RequestMapping("/naraList.do")
	public ModelAndView naraList(HttpServletRequest request) {

		PageListTO pageTO = new PageListTO();
		String cpageParam = request.getParameter("cpage");
		int cpage = 1; // 기본값 설정

		if (cpageParam != null && !cpageParam.isEmpty()) {
			cpage = Integer.parseInt(cpageParam);
		}
		int recordPerPage = pageTO.getRecordPerPage();
		int blockPerPage = pageTO.getBlockPerPage();

		ArrayList<OsakaAreaTO> japanList = dao.osakaList();

		ArrayList<OsakaAreaTO> naraList = new ArrayList<>();

		String searchWord = request.getParameter("searchWord");

		for (OsakaAreaTO naraTO : japanList) {

			String category = naraTO.getCategory();

			if (category.equals("nara")) {
				naraList.add(naraTO);

				// 전체 게시물 개수 가져옴
				pageTO.setTotalRecord(naraList.size());

				// 전체 게시물의 페이지 개수
				pageTO.setTotalPage((pageTO.getTotalRecord() - 1) / recordPerPage + 1);
			}
		}

		if (searchWord != null) {
			naraList = dao.searchList("nara", searchWord);

			pageTO.setTotalRecord(naraList.size());
			pageTO.setTotalPage((pageTO.getTotalRecord() - 1) / recordPerPage + 1);

		}

		int skip = (cpage - 1) * recordPerPage;
		int endIndex = Math.min(skip + recordPerPage, naraList.size());

		ArrayList<OsakaAreaTO> pageList = new ArrayList<>(naraList.subList(skip, endIndex));
		pageTO.setPageList(pageList);

		pageTO.setStartBlock(cpage - (cpage - 1) % blockPerPage);
		pageTO.setEndBlock(cpage - (cpage - 1) % blockPerPage + blockPerPage - 1);

		if (pageTO.getEndBlock() >= pageTO.getTotalPage()) {
			pageTO.setEndBlock(pageTO.getTotalPage());
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("guide/naraList");
		modelAndView.addObject("naraList", naraList);
		modelAndView.addObject("pageTO", pageTO);

		return modelAndView;

	}

	// 오사카 view 페이지
	@RequestMapping("/osakaView.do")
	public ModelAndView osakaView(HttpServletRequest request) throws Exception {
		OsakaAreaTO to = new OsakaAreaTO();
		to.setOsakaId(request.getParameter("osakaId"));

		to = dao.osakaView(to);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("guide/osakaView");
		modelAndView.addObject("to", to);

		return modelAndView;
	}

	// 교토 view 페이지
	@RequestMapping("/kyotoView.do")
	public ModelAndView kyotoView(HttpServletRequest request) throws Exception {
		OsakaAreaTO to = new OsakaAreaTO();
		to.setOsakaId(request.getParameter("osakaId"));

		to = dao.osakaView(to);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("guide/kyotoView");
		modelAndView.addObject("to", to);

		return modelAndView;
	}

	// 고베 view 페이지
	@RequestMapping("/kobeView.do")
	public ModelAndView kobeView(HttpServletRequest request) throws Exception {
		OsakaAreaTO to = new OsakaAreaTO();
		to.setOsakaId(request.getParameter("osakaId"));

		to = dao.osakaView(to);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("guide/kobeView");
		modelAndView.addObject("to", to);

		return modelAndView;
	}

	// 나라 view 페이지
	@RequestMapping("/naraView.do")
	public ModelAndView naraView(HttpServletRequest request) throws Exception {
		OsakaAreaTO to = new OsakaAreaTO();
		to.setOsakaId(request.getParameter("osakaId"));

		to = dao.osakaView(to);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("guide/naraView");
		modelAndView.addObject("to", to);

		return modelAndView;
	}
}

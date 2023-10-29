package com.example.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.model.AdminDAO;
import com.example.model.GuestBookTO;
import com.example.model.LoginTO;
import com.example.model.OsakaAreaDAO;
import com.example.model.OsakaAreaTO;
import com.example.model.QnaBoardDAO;
import com.example.model.QnaBoardTO;
import com.example.model.ReviewBoardDAO;
import com.example.model.ReviewBoardTO;
import com.example.model.TipBoardDAO;
import com.example.model.TipBoardTO;

@RestController
public class AdminController {

	@Autowired
	private TipBoardDAO bdao;

	@Autowired
	private ReviewBoardDAO rdao;

	@Autowired
	private QnaBoardDAO qdao;

	@Autowired
	private OsakaAreaDAO dao;

	@Autowired
	private AdminDAO adao;

	// 관리자페이지 메인
	@RequestMapping("/admin.do")
	public ModelAndView admin() {

		// 통계 그래프에 넣을 각 게시판 데이터 개수
		ArrayList<TipBoardTO> tipBoardList = bdao.tipBoardList();
		ArrayList<ReviewBoardTO> reviewBoardList = rdao.reviewBoardList();
		ArrayList<QnaBoardTO> qnaBoardList = qdao.qnaBoardList();

		// 각 게시판 게시글 개수
		int tipSize = tipBoardList.size();
		int revSize = reviewBoardList.size();
		int qnaSize = qnaBoardList.size();

		// 오사카, 교토, 고베, 나라 관광리스트 데이터 개수
		ArrayList<OsakaAreaTO> japanList = dao.osakaList();
		ArrayList<OsakaAreaTO> osakaList = new ArrayList<>();
		ArrayList<OsakaAreaTO> kyotoList = new ArrayList<>();
		ArrayList<OsakaAreaTO> kobeList = new ArrayList<>();
		ArrayList<OsakaAreaTO> naraList = new ArrayList<>();

		for (OsakaAreaTO osakaTO : japanList) {

			String category = osakaTO.getCategory();

			if (category.equals("osaka")) {
				osakaList.add(osakaTO);
			} else if (category.equals("kyoto")) {
				kyotoList.add(osakaTO);
			} else if (category.equals("kobe")) {
				kobeList.add(osakaTO);
			} else if (category.equals("nara")) {
				naraList.add(osakaTO);
			}
		}

		// 관광가이드 지역별 리스트 개수
		int osaka = osakaList.size();
		int kyoto = kyotoList.size();
		int kobe = kobeList.size();
		int nara = naraList.size();

		// 당일 회원가입한 유저, 당일 Q&A 리스트 3개 가져오기
		ArrayList<LoginTO> todayMember = adao.todaySignup();
		ArrayList<QnaBoardTO> todayQnaList = adao.todayQnaBoard();

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("admin/admin");
		modelAndView.addObject("tipSize", tipSize);
		modelAndView.addObject("revSize", revSize);
		modelAndView.addObject("qnaSize", qnaSize);
		modelAndView.addObject("osaka", osaka);
		modelAndView.addObject("kyoto", kyoto);
		modelAndView.addObject("kobe", kobe);
		modelAndView.addObject("nara", nara);
		modelAndView.addObject("todayMember", todayMember);
		modelAndView.addObject("todayQnaList", todayQnaList);
		modelAndView.addObject("qnaBoardList", qnaBoardList);
		return modelAndView;
	}

	// 관리자페이지 방명록
	@RequestMapping("/adminGuestBook.do")
	public ModelAndView adminGuestBook(HttpServletRequest request) {

		// 방명록 리스트
		ArrayList<GuestBookTO> list = adao.guestbookList();

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("admin/adminGuestBook");
		modelAndView.addObject("list", list);
		return modelAndView;
	}

	// 관리자페이지 방명록 쓰기
	@RequestMapping("/guestbookWriteOk.do")
	public ModelAndView adminProfile(HttpServletRequest request) {

		GuestBookTO to = new GuestBookTO();
		to.setGbwriter(request.getParameter("gbwriter"));
		to.setGbcontent(request.getParameter("gbcontent"));
		to.setEmot(request.getParameter("emot"));

		int flag = adao.guestbookWriteOk(to);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("admin/guestbookWriteOk");
		modelAndView.addObject("flag", flag);
		return modelAndView;
	}

	// 관리자페이지 방명록 글삭제
	@RequestMapping("/guestbookDeleteOk.do")
	public ModelAndView guestbookDelete(HttpServletRequest request) {

		int flag = adao.guestbookDelete(request.getParameter("gbId"));

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("admin/guestbookDeleteOk");
		modelAndView.addObject("flag", flag);
		return modelAndView;
	}

	// 관리자페이지 회원관리
	@RequestMapping("/adminMember.do")
	public ModelAndView adminMember() {
		
		ArrayList<LoginTO> totalUser = adao.totalUser();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("admin/adminMember");
		modelAndView.addObject("totalUser", totalUser);
		return modelAndView;
	}
	
	// 회원 블랙,블랙 해제 role 변경 / 회원 탈퇴 로직
	@RequestMapping("/changeRole.do")
	public ModelAndView changeRole(HttpServletRequest request) {
		
		String black = request.getParameter("blackList");
		String clear = request.getParameter("clear");
		String delete = request.getParameter("delete");
		
		int flag = 1;
		
		if(black != null) {
			LoginTO to = new LoginTO();
			to.setMemberId(request.getParameter("memberId"));
			to.setRole("BLACK");
			flag = adao.changeRole(to);
		} else if(clear != null) {
			LoginTO to = new LoginTO();
			to.setMemberId(request.getParameter("memberId"));
			to.setRole("NORMAL");
			flag = adao.changeRole(to);
		} else if(delete != null) {
			flag = adao.userDeleteOk(request.getParameter("memberId"));
		}
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("admin/changeRole");
		modelAndView.addObject("flag", flag);

		return modelAndView;
	}


}

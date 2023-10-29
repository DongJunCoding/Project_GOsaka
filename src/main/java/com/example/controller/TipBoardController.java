package com.example.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.model.CommentDAO;
import com.example.model.CommentTO;
import com.example.model.PageListTO;
import com.example.model.TipBoardDAO;
import com.example.model.TipBoardTO;

@RestController
public class TipBoardController {

	@Autowired
	private TipBoardDAO bdao;

	@Autowired
	private CommentDAO cdao;

	@Value("${spring.servlet.multipart.location}") // $기호를 사용하여 프로퍼티 값을 설정할 수 있음.
	private String uploadPath;

	// Tip 게시판 쓰기 작성 후 글쓰기 눌렀을 때 처리하는 로직
	@RequestMapping("/tipBoardWrite_ok.do")
	public ModelAndView tipBoard_Write(HttpServletRequest request,
			@RequestParam("upload") List<MultipartFile> uploads) {

		TipBoardTO tipTO = new TipBoardTO();
		List<String> imageNames = new ArrayList<>(); // 이미지 파일명을 저장하는 리스트
		int flag = 1;

		if (!uploads.get(0).isEmpty()) {
			for (MultipartFile upload : uploads) {

				String extension = upload.getOriginalFilename()
						.substring(upload.getOriginalFilename().lastIndexOf(".")); // . 이후의 확장자 이름
				String filename = upload.getOriginalFilename().substring(0,
						upload.getOriginalFilename().lastIndexOf(".")); // 0번째부터 . 위치번째까지의 이름부분
				String newfilename = filename + "-" + System.currentTimeMillis() + extension;
				try {
					upload.transferTo(new File(newfilename)); // 업로드된 파일을 서버의 파일 시스템에 저장하는 역할
					imageNames.add(newfilename); // 이미지 파일명을 리스트에 추가
				} catch (IllegalStateException e) {
					System.out.println("[에러] " + e.getMessage());
				} catch (IOException e) {
					System.out.println("[에러] " + e.getMessage());
				}

				tipTO.setTsubject(request.getParameter("tsubject"));
				tipTO.setTwriter(request.getParameter("twriter"));
				tipTO.setTcontent(request.getParameter("tcontent"));
				tipTO.setIp("000.000.000");
				tipTO.setImage(newfilename);

			}
		}

		// 이미지가 하나도 업로드되지 않은 경우
		if (imageNames.isEmpty()) {
			tipTO.setImage("dotonView.jpg");
		} else {
			// 이미지 파일명을 ,로 구분하여 하나의 문자열로 저장
			tipTO.setImage(String.join("▒", imageNames));
		}

		tipTO.setTsubject(request.getParameter("tsubject"));
		tipTO.setTwriter(request.getParameter("twriter"));
		tipTO.setTcontent(request.getParameter("tcontent"));
		tipTO.setIp("000.000.000");

		flag = bdao.tip_boardWrite(tipTO);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("tipBoard/tipBoardWrite_ok");
		modelAndView.addObject("flag", flag);
		return modelAndView;

	}

	// Tip 게시판 리스트
	@RequestMapping("/tipBoardList.do")
	public ModelAndView tipBoardList(HttpServletRequest request) {

		PageListTO pageTO = new PageListTO();
		String cpageParam = request.getParameter("cpage");
		int cpage = 1; // 기본값 설정

		if (cpageParam != null && !cpageParam.isEmpty()) {
			cpage = Integer.parseInt(cpageParam);
		}
		int recordPerPage = 10;
		int blockPerPage = pageTO.getBlockPerPage();

		ArrayList<TipBoardTO> tipBoardList = bdao.tipBoardList();

		String searchWord = request.getParameter("searchWord");
		String searchKey = request.getParameter("searchKey");

		// 전체 게시물 개수 가져옴
		pageTO.setTotalRecord(tipBoardList.size());

		// 전체 게시물의 페이지 개수
		pageTO.setTotalPage((pageTO.getTotalRecord() - 1) / recordPerPage + 1);

		if (searchWord != null) {
			tipBoardList = bdao.tipBoardSearchList(searchKey, searchWord);

			pageTO.setTotalRecord(tipBoardList.size());
			pageTO.setTotalPage((pageTO.getTotalRecord() - 1) / recordPerPage + 1);

		}

		int skip = (cpage - 1) * recordPerPage;
		int endIndex = Math.min(skip + recordPerPage, tipBoardList.size());

		ArrayList<TipBoardTO> pageList = new ArrayList<>(tipBoardList.subList(skip, endIndex));
		pageTO.setTipBoardPageList(pageList);

		pageTO.setStartBlock(cpage - (cpage - 1) % blockPerPage);
		pageTO.setEndBlock(cpage - (cpage - 1) % blockPerPage + blockPerPage - 1);

		if (pageTO.getEndBlock() >= pageTO.getTotalPage()) {
			pageTO.setEndBlock(pageTO.getTotalPage());
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("tipBoard/tipBoardList");
		modelAndView.addObject("tipBoardList", tipBoardList);
		modelAndView.addObject("pageTO", pageTO);

		return modelAndView;

	}

	// Tip 게시판 쓰기 뷰 페이지
	@RequestMapping("/tipBoardWrite.do")
	public ModelAndView tipBoardWrite(HttpServletRequest request) {

		String cpageParam = request.getParameter("cpage");
		int cpage = 1; // 기본값 설정

		if (cpageParam != null && !cpageParam.isEmpty()) {
			cpage = Integer.parseInt(cpageParam);
		}

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("tipBoard/tipBoardWrite");
		modelAndView.addObject("cpage", cpage);

		return modelAndView;
	}

	// Tip 게시판 뷰
	@RequestMapping("/tipBoardView.do")
	public ModelAndView tipBoardView(HttpServletRequest request) {

		String cpageParam = request.getParameter("cpage");
		int cpage = 1; // 기본값 설정

		if (cpageParam != null && !cpageParam.isEmpty()) {
			cpage = Integer.parseInt(cpageParam);
		}

		int tipId = Integer.parseInt(request.getParameter("tipId"));

		ArrayList<CommentTO> tip_commentList = cdao.tip_CommentList(tipId);

		TipBoardTO tipBoardView = new TipBoardTO();
		tipBoardView.setTipId(request.getParameter("tipId"));

		tipBoardView = bdao.tipBoardView(tipBoardView);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("tipBoard/tipBoardView");
		modelAndView.addObject("tipBoardView", tipBoardView);
		modelAndView.addObject("cpage", cpage);
		modelAndView.addObject("tip_commentList", tip_commentList);

		return modelAndView;
	}

	// Tip 게시판 게시글 삭제
	@RequestMapping("/tipBoardViewDelete_ok.do")
	public ModelAndView tipBoardViewDelete_ok(HttpServletRequest request) {

		TipBoardTO to = new TipBoardTO();
		to.setTipId(request.getParameter("tipId"));

		int flag = bdao.tipBoardViewDelete(to);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("tipBoard/tipBoardViewDelete_ok");
		modelAndView.addObject("flag", flag);
		return modelAndView;
	}

	// Tip 게시판 게시글 수정 페이지
	@RequestMapping("/tipBoardModify.do")
	public ModelAndView tipBoardModify(HttpServletRequest request) {

		String cpageParam = request.getParameter("cpage");
		int cpage = 1; // 기본값 설정

		if (cpageParam != null && !cpageParam.isEmpty()) {
			cpage = Integer.parseInt(cpageParam);
		}

		TipBoardTO to = new TipBoardTO();
		to.setTipId(request.getParameter("tipId"));

		to = bdao.tipBoardModify(to);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("tipBoard/tipBoardModify");
		modelAndView.addObject("cpage", cpage);
		modelAndView.addObject("to", to);
		return modelAndView;
	}

	// Tip 게시판 게시글 수정 로직
	@RequestMapping("/tipBoardModify_ok.do")
	public ModelAndView tipBoardModify_ok(HttpServletRequest request,
			@RequestParam("upload") List<MultipartFile> uploads) {

		TipBoardTO to = new TipBoardTO();

		to.setTipId(request.getParameter("tipId"));
		String tipId = to.getTipId();

		String[] oldFileNames = bdao.tipBoardImage(to).split("▒");

		List<String> imageNames = new ArrayList<>(); // 이미지 파일명을 저장하는 리스트
		int flag = 1;

		if (!uploads.get(0).isEmpty()) {
			for (MultipartFile upload : uploads) {

				String extension = upload.getOriginalFilename()
						.substring(upload.getOriginalFilename().lastIndexOf(".")); // . 이후의 확장자 이름
				String filename = upload.getOriginalFilename().substring(0,
						upload.getOriginalFilename().lastIndexOf(".")); // 0번째부터 . 위치번째까지의 이름부분
				String newfilename = filename + "-" + System.currentTimeMillis() + extension;
				try {
					upload.transferTo(new File(newfilename)); // 업로드된 파일을 서버의 파일 시스템에 저장하는 역할
					imageNames.add(newfilename); // 이미지 파일명을 리스트에 추가
				} catch (IllegalStateException e) {
					System.out.println("[에러] " + e.getMessage());
				} catch (IOException e) {
					System.out.println("[에러] " + e.getMessage());
				}

				to.setTsubject(request.getParameter("tsubject"));
				to.setTwriter(request.getParameter("twriter"));
				to.setTcontent(request.getParameter("tcontent"));
				to.setIp("000.000.000");
				to.setImage(newfilename);

			}
		}

		if (imageNames != null && oldFileNames != null) {
			for (String filename : oldFileNames) {
				if (!filename.equals("dotonView.jpg")) {
					File file = new File(uploadPath, filename);
					file.delete();
				}
			}

		}

		// 이미지가 하나도 업로드되지 않은 경우
		if (imageNames.isEmpty()) {
			to.setImage("dotonView.jpg");
		} else {
			// 이미지 파일명을 ,로 구분하여 하나의 문자열로 저장
			to.setImage(String.join("▒", imageNames));
		}

		to.setTsubject(request.getParameter("tsubject"));
		to.setTwriter(request.getParameter("twriter"));
		to.setTcontent(request.getParameter("tcontent"));
		to.setIp("000.000.000");

		flag = bdao.tipBoardModify_ok(to);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("tipBoard/tipBoardModify_ok");
		modelAndView.addObject("flag", flag);
		modelAndView.addObject("tipId", tipId);

		return modelAndView;
	}

	// Tip 게시판 댓글 쓰기
	@RequestMapping("/tip_CommentOk.do")
	public ModelAndView commentOk(HttpServletRequest request) {
		String cmId = request.getParameter("tipId");
		String cwriter = request.getParameter("cwriter");
		String ccontent = request.getParameter("ccontent");
		String cdate = request.getParameter("cdate");

		CommentTO commentTO = new CommentTO();
		commentTO.setPcmId(cmId);
		commentTO.setCwriter(cwriter);
		commentTO.setCcontent(ccontent);
		commentTO.setCdate(cdate);

		int flag = cdao.tip_CommentWriteOk(commentTO);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("tipBoard/tip_comment_ok");
		modelAndView.addObject("cmId", cmId);
		modelAndView.addObject("flag", flag);
		return modelAndView;
	}

	// Tip 게시판 댓글 삭제
	@RequestMapping("/tip_CommentDeleteOk.do")
	public ModelAndView commentDeleteOk(HttpServletRequest request) {

		CommentTO to = new CommentTO();

		to.setPcmId(request.getParameter("tipId"));
		to.setCmId(request.getParameter("cmId"));
		
		int flag = cdao.tip_commentDelete(to);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("tipBoard/tip_commentDelete_ok");
		modelAndView.addObject("flag", flag);
		return modelAndView;
	}

	// Tip 게시판 댓글 수정
	@RequestMapping("/tip_CommentModifyOk.do")
	public ModelAndView commentModifyOk(HttpServletRequest request) {

		CommentTO to = new CommentTO();

		to.setPcmId(request.getParameter("tipId"));
		to.setCmId(request.getParameter("cmId"));
		to.setCcontent(request.getParameter("modifyComment"));

		int flag = cdao.tip_commentModify(to);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("tipBoard/tip_commentModify_ok");
		modelAndView.addObject("flag", flag);
		return modelAndView;
	}

}

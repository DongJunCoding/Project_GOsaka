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
import com.example.model.ReviewBoardDAO;
import com.example.model.ReviewBoardTO;

@RestController
public class ReviewBoardController {

	@Autowired
	private ReviewBoardDAO rdao;

	@Autowired
	private CommentDAO cdao;

	@Value("${spring.servlet.multipart.location}") // $기호를 사용하여 프로퍼티 값을 설정할 수 있음.
	private String uploadPath;

	// Review 게시판 쓰기 뷰 페이지
	@RequestMapping("/reviewBoardWrite.do")
	public ModelAndView reviewBoardWrite(HttpServletRequest request) {

		String cpageParam = request.getParameter("cpage");
		int cpage = 1; // 기본값 설정

		if (cpageParam != null && !cpageParam.isEmpty()) {
			cpage = Integer.parseInt(cpageParam);
		}

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("reviewBoard/reviewBoardWrite");
		modelAndView.addObject("cpage", cpage);

		return modelAndView;
	}

	// Review 게시판 쓰기 작성 후 글쓰기 눌렀을 때 처리하는 로직
	@RequestMapping("/reviewBoardWrite_ok.do")
	public ModelAndView reviewBoard_Write(HttpServletRequest request,
			@RequestParam("upload") List<MultipartFile> uploads) {

		ReviewBoardTO reviewTO = new ReviewBoardTO();
		List<String> imageNames = new ArrayList<>(); // 이미지 파일명을 저장하는 리스트
		int flag = 1;

		// 이미지가 업로드 된 경우
		if (!uploads.get(0).isEmpty()) {
			for (MultipartFile upload : uploads) {

				// getOriginalFilename() : 파일명과 확장자까지 붙여서 문자열을 반환
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

				reviewTO.setCategory(request.getParameter("preface"));
				reviewTO.setRvsubject(request.getParameter("rvsubject"));
				reviewTO.setRvwriter(request.getParameter("rvwriter"));
				reviewTO.setRvcontent(request.getParameter("rvcontent"));
				reviewTO.setIp("000.000.000");
				reviewTO.setImage(String.join("▒", imageNames));
			}
		} else if (uploads.get(0).isEmpty()) {
			reviewTO.setImage("dotonView.jpg");
			reviewTO.setCategory(request.getParameter("preface"));
			reviewTO.setRvsubject(request.getParameter("rvsubject"));
			reviewTO.setRvwriter(request.getParameter("rvwriter"));
			reviewTO.setRvcontent(request.getParameter("rvcontent"));
			reviewTO.setIp("000.000.000");
		}

		flag = rdao.review_boardWrite(reviewTO);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("reviewBoard/reviewBoardWrite_ok");
		modelAndView.addObject("flag", flag);
		return modelAndView;

	}

	// Review 게시판 리스트
	@RequestMapping("/reviewBoardList.do")
	public ModelAndView reviewBoardList(HttpServletRequest request) {

		PageListTO pageTO = new PageListTO();
		String cpageParam = request.getParameter("cpage");
		int cpage = 1; // 기본값 설정

		if (cpageParam != null && !cpageParam.isEmpty()) {
			cpage = Integer.parseInt(cpageParam);
		}
		int recordPerPage = 10;
		int blockPerPage = pageTO.getBlockPerPage();

		ArrayList<ReviewBoardTO> reviewBoardList = rdao.reviewBoardList();

		String searchWord = request.getParameter("searchWord");

		String searchKey = request.getParameter("searchKey");

		// 전체 게시물 개수 가져옴
		pageTO.setTotalRecord(reviewBoardList.size());

		// 전체 게시물의 페이지 개수
		pageTO.setTotalPage((pageTO.getTotalRecord() - 1) / recordPerPage + 1);

		if (searchWord != null) {
			reviewBoardList = rdao.reviewBoardSearchList(searchKey, searchWord);

			pageTO.setTotalRecord(reviewBoardList.size());
			pageTO.setTotalPage((pageTO.getTotalRecord() - 1) / recordPerPage + 1);

		}

		int skip = (cpage - 1) * recordPerPage;
		int endIndex = Math.min(skip + recordPerPage, reviewBoardList.size());

		ArrayList<ReviewBoardTO> pageList = new ArrayList<>(reviewBoardList.subList(skip, endIndex));
		pageTO.setReviewBoardPageList(pageList);

		pageTO.setStartBlock(cpage - (cpage - 1) % blockPerPage);
		pageTO.setEndBlock(cpage - (cpage - 1) % blockPerPage + blockPerPage - 1);

		if (pageTO.getEndBlock() >= pageTO.getTotalPage()) {
			pageTO.setEndBlock(pageTO.getTotalPage());
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("reviewBoard/reviewBoardList");
		modelAndView.addObject("reviewBoardList", reviewBoardList);
		modelAndView.addObject("pageTO", pageTO);

		return modelAndView;

	}

	// Review 게시판 뷰
	@RequestMapping("/reviewBoardView.do")
	public ModelAndView reviewBoardView(HttpServletRequest request) {

		String cpageParam = request.getParameter("cpage");
		int cpage = 1; // 기본값 설정

		if (cpageParam != null && !cpageParam.isEmpty()) {
			cpage = Integer.parseInt(cpageParam);
		}

		int reviewId = Integer.parseInt(request.getParameter("reviewId"));

		ArrayList<CommentTO> review_commentList = cdao.review_CommentList(reviewId);

		ReviewBoardTO reviewBoardView = new ReviewBoardTO();
		reviewBoardView.setReviewId(request.getParameter("reviewId"));

		reviewBoardView = rdao.reviewBoardView(reviewBoardView);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("reviewBoard/reviewBoardView");
		modelAndView.addObject("reviewBoardView", reviewBoardView);
		modelAndView.addObject("cpage", cpage);
		modelAndView.addObject("review_commentList", review_commentList);

		return modelAndView;
	}

	// Tip 게시판 게시글 삭제
	@RequestMapping("/reviewBoardViewDelete_ok.do")
	public ModelAndView tipBoardViewDelete_ok(HttpServletRequest request) {

		ReviewBoardTO to = new ReviewBoardTO();
		to.setReviewId(request.getParameter("reviewId"));

		int flag = rdao.reviewBoardViewDelete(to);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("reviewBoard/reviewBoardViewDelete_ok");
		modelAndView.addObject("flag", flag);
		return modelAndView;
	}

	// Tip 게시판 게시글 수정 페이지
	@RequestMapping("/reviewBoardModify.do")
	public ModelAndView reviewBoardModify(HttpServletRequest request) {

		String cpageParam = request.getParameter("cpage");
		int cpage = 1; // 기본값 설정

		if (cpageParam != null && !cpageParam.isEmpty()) {
			cpage = Integer.parseInt(cpageParam);
		}

		ReviewBoardTO to = new ReviewBoardTO();
		to.setReviewId(request.getParameter("reviewId"));

		to = rdao.reviewBoardModify(to);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("reviewBoard/reviewBoardModify");
		modelAndView.addObject("cpage", cpage);
		modelAndView.addObject("to", to);
		return modelAndView;
	}

	// Tip 게시판 게시글 수정 로직
	@RequestMapping("/reviewBoardModify_ok.do")
	public ModelAndView reviewBoardModify_ok(HttpServletRequest request,
			@RequestParam("upload") List<MultipartFile> uploads) {

		ReviewBoardTO to = new ReviewBoardTO();

		to.setReviewId(request.getParameter("reviewId"));
		String reviewId = to.getReviewId();

		String[] oldFileNames = rdao.reviewBoardImage(to).split("▒");

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

				to.setCategory(request.getParameter("preface"));
				to.setRvsubject(request.getParameter("rvsubject"));
				to.setRvwriter(request.getParameter("rvwriter"));
				to.setRvcontent(request.getParameter("rvcontent"));
				to.setIp("000.000.000");
				to.setImage(String.join("▒", imageNames));

			}

		} else if (uploads.get(0).isEmpty()) {
			to.setImage("dotonView.jpg");
			to.setCategory(request.getParameter("preface"));
			to.setRvsubject(request.getParameter("rvsubject"));
			to.setRvwriter(request.getParameter("rvwriter"));
			to.setRvcontent(request.getParameter("rvcontent"));
			to.setIp("000.000.000");
		}

		if (imageNames != null && oldFileNames != null) {
			for (String filename : oldFileNames) {
				if (!filename.equals("dotonView.jpg")) {
					File file = new File(uploadPath, filename);
					file.delete();
				}
			}

		}

		flag = rdao.reviewBoardModify_ok(to);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("reviewBoard/reviewBoardModify_ok");
		modelAndView.addObject("flag", flag);
		modelAndView.addObject("reviewId", reviewId);

		return modelAndView;
	}

	// Review 게시판 댓글 쓰기
	@RequestMapping("/review_CommentOk.do")
	public ModelAndView commentOk(HttpServletRequest request) {
		String cmId = request.getParameter("reviewId");
		String cwriter = request.getParameter("cwriter");
		String ccontent = request.getParameter("ccontent");
		String cdate = request.getParameter("cdate");

		CommentTO commentTO = new CommentTO();
		commentTO.setPcmId(cmId);
		commentTO.setCwriter(cwriter);
		commentTO.setCcontent(ccontent);
		commentTO.setCdate(cdate);

		int flag = cdao.review_CommentWriteOk(commentTO);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("reviewBoard/review_comment_ok");
		modelAndView.addObject("cmId", cmId);
		modelAndView.addObject("flag", flag);
		return modelAndView;
	}

	// Review 게시판 댓글 삭제
	@RequestMapping("/review_CommentDeleteOk.do")
	public ModelAndView commentDeleteOk(HttpServletRequest request) {

		CommentTO to = new CommentTO();

		to.setPcmId(request.getParameter("reviewId"));
		to.setCmId(request.getParameter("cmId"));

		int flag = cdao.review_commentDelete(to);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("reviewBoard/review_commentDelete_ok");
		modelAndView.addObject("flag", flag);
		return modelAndView;
	}

	// Review 게시판 댓글 수정
	@RequestMapping("/review_CommentModifyOk.do")
	public ModelAndView commentModifyOk(HttpServletRequest request) {

		CommentTO to = new CommentTO();

		to.setPcmId(request.getParameter("reviewId"));
		to.setCmId(request.getParameter("cmId"));
		to.setCcontent(request.getParameter("modifyComment"));

		int flag = cdao.review_commentModify(to);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("reviewBoard/review_commentModify_ok");
		modelAndView.addObject("flag", flag);
		return modelAndView;
	}

}

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
import com.example.model.QnaBoardDAO;
import com.example.model.QnaBoardTO;

@RestController
public class QnaBoardController {

	@Autowired
	private QnaBoardDAO qdao;

	@Autowired
	private CommentDAO cdao;

	@Value("${spring.servlet.multipart.location}") // $기호를 사용하여 프로퍼티 값을 설정할 수 있음.
	private String uploadPath;

	// QNA 게시판 쓰기 작성 후 글쓰기 눌렀을 때 처리하는 로직
	@RequestMapping("/qnaBoardWrite_ok.do")
	public ModelAndView qnaBoard_Write(HttpServletRequest request,
			@RequestParam("upload") List<MultipartFile> uploads) {

		QnaBoardTO qnaTO = new QnaBoardTO();
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

				qnaTO.setQsubject(request.getParameter("qsubject"));
				qnaTO.setQwriter(request.getParameter("qwriter"));
				qnaTO.setQcontent(request.getParameter("qcontent"));
				qnaTO.setIp("000.000.000");
				qnaTO.setImage(newfilename);

			}
		}

		// 이미지가 하나도 업로드되지 않은 경우
		if (imageNames.isEmpty()) {
			qnaTO.setImage("dotonView.jpg");
		} else {
			// 이미지 파일명을 ,로 구분하여 하나의 문자열로 저장
			qnaTO.setImage(String.join("▒", imageNames));
		}

		qnaTO.setQsubject(request.getParameter("qsubject"));
		qnaTO.setQwriter(request.getParameter("qwriter"));
		qnaTO.setQcontent(request.getParameter("qcontent"));
		qnaTO.setIp("000.000.000");

		flag = qdao.qna_boardWrite(qnaTO);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("qnaBoard/qnaBoardWrite_ok");
		modelAndView.addObject("flag", flag);
		return modelAndView;

	}

	// QNA 게시판 리스트
	@RequestMapping("/qnaBoardList.do")
	public ModelAndView qnaBoardList(HttpServletRequest request) {

		PageListTO pageTO = new PageListTO();
		String cpageParam = request.getParameter("cpage");
		int cpage = 1; // 기본값 설정

		if (cpageParam != null && !cpageParam.isEmpty()) {
			cpage = Integer.parseInt(cpageParam);
		}
		int recordPerPage = 10;
		int blockPerPage = pageTO.getBlockPerPage();

		ArrayList<QnaBoardTO> qnaBoardList = qdao.qnaBoardList();

		String searchWord = request.getParameter("searchWord");
		String searchKey = request.getParameter("searchKey");

		// 전체 게시물 개수 가져옴
		pageTO.setTotalRecord(qnaBoardList.size());

		// 전체 게시물의 페이지 개수
		pageTO.setTotalPage((pageTO.getTotalRecord() - 1) / recordPerPage + 1);

		if (searchWord != null) {
			qnaBoardList = qdao.qnaBoardSearchList(searchKey, searchWord);

			pageTO.setTotalRecord(qnaBoardList.size());
			pageTO.setTotalPage((pageTO.getTotalRecord() - 1) / recordPerPage + 1);

		}

		int skip = (cpage - 1) * recordPerPage;
		int endIndex = Math.min(skip + recordPerPage, qnaBoardList.size());

		ArrayList<QnaBoardTO> pageList = new ArrayList<>(qnaBoardList.subList(skip, endIndex));
		pageTO.setQnaBoardPageList(pageList);

		pageTO.setStartBlock(cpage - (cpage - 1) % blockPerPage);
		pageTO.setEndBlock(cpage - (cpage - 1) % blockPerPage + blockPerPage - 1);

		if (pageTO.getEndBlock() >= pageTO.getTotalPage()) {
			pageTO.setEndBlock(pageTO.getTotalPage());
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("qnaBoard/qnaBoardList");
		modelAndView.addObject("qnaBoardList", qnaBoardList);
		modelAndView.addObject("pageTO", pageTO);

		return modelAndView;

	}

	// QNA 게시판 쓰기 뷰 페이지
	@RequestMapping("/qnaBoardWrite.do")
	public ModelAndView qnaBoardWrite(HttpServletRequest request) {

		String cpageParam = request.getParameter("cpage");
		int cpage = 1; // 기본값 설정

		if (cpageParam != null && !cpageParam.isEmpty()) {
			cpage = Integer.parseInt(cpageParam);
		}

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("qnaBoard/qnaBoardWrite");
		modelAndView.addObject("cpage", cpage);

		return modelAndView;
	}

	// QNA 게시판 뷰
	@RequestMapping("/qnaBoardView.do")
	public ModelAndView qnaBoardView(HttpServletRequest request) {

		String cpageParam = request.getParameter("cpage");
		int cpage = 1; // 기본값 설정

		if (cpageParam != null && !cpageParam.isEmpty()) {
			cpage = Integer.parseInt(cpageParam);
		}

		int qnaId = Integer.parseInt(request.getParameter("qnaId"));

		ArrayList<CommentTO> qna_commentList = cdao.qna_CommentList(qnaId);

		QnaBoardTO qnaBoardView = new QnaBoardTO();
		qnaBoardView.setQnaId(request.getParameter("qnaId"));

		qnaBoardView = qdao.qnaBoardView(qnaBoardView);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("qnaBoard/qnaBoardView");
		modelAndView.addObject("qnaBoardView", qnaBoardView);
		modelAndView.addObject("cpage", cpage);
		modelAndView.addObject("qna_commentList", qna_commentList);

		return modelAndView;
	}

	// QNA 게시판 게시글 삭제
	@RequestMapping("/qnaBoardViewDelete_ok.do")
	public ModelAndView qnaBoardViewDelete_ok(HttpServletRequest request) {

		QnaBoardTO to = new QnaBoardTO();
		to.setQnaId(request.getParameter("qnaId"));

		int flag = qdao.qnaBoardViewDelete(to);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("qnaBoard/qnaBoardViewDelete_ok");
		modelAndView.addObject("flag", flag);
		return modelAndView;
	}

	// QNA 게시판 게시글 수정 페이지
	@RequestMapping("/qnaBoardModify.do")
	public ModelAndView qnaBoardModify(HttpServletRequest request) {

		String cpageParam = request.getParameter("cpage");
		int cpage = 1; // 기본값 설정

		if (cpageParam != null && !cpageParam.isEmpty()) {
			cpage = Integer.parseInt(cpageParam);
		}

		QnaBoardTO to = new QnaBoardTO();
		to.setQnaId(request.getParameter("qnaId"));

		to = qdao.qnaBoardModify(to);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("qnaBoard/qnaBoardModify");
		modelAndView.addObject("cpage", cpage);
		modelAndView.addObject("to", to);
		return modelAndView;
	}

	// QNA 게시판 게시글 수정 로직
	@RequestMapping("/qnaBoardModify_ok.do")
	public ModelAndView qnaBoardModify_ok(HttpServletRequest request,
			@RequestParam("upload") List<MultipartFile> uploads) {

		QnaBoardTO to = new QnaBoardTO();

		to.setQnaId(request.getParameter("qnaId"));
		String qnaId = to.getQnaId();

		String[] oldFileNames = qdao.qnaBoardImage(to).split("▒");

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

				to.setQsubject(request.getParameter("qsubject"));
				to.setQwriter(request.getParameter("qwriter"));
				to.setQcontent(request.getParameter("qcontent"));
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

		to.setQsubject(request.getParameter("qsubject"));
		to.setQwriter(request.getParameter("qwriter"));
		to.setQcontent(request.getParameter("qcontent"));
		to.setIp("000.000.000");

		flag = qdao.qnaBoardModify_ok(to);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("qnaBoard/qnaBoardModify_ok");
		modelAndView.addObject("flag", flag);
		modelAndView.addObject("qnaId", qnaId);

		return modelAndView;
	}

	// 댓글 쓰기
	@RequestMapping("/qna_CommentOk.do")
	public ModelAndView commentOk(HttpServletRequest request) {
		String cmId = request.getParameter("qnaId");
		String cwriter = request.getParameter("cwriter");
		String ccontent = request.getParameter("ccontent");
		String cdate = request.getParameter("cdate");

		CommentTO commentTO = new CommentTO();
		commentTO.setPcmId(cmId);
		commentTO.setCwriter(cwriter);
		commentTO.setCcontent(ccontent);
		commentTO.setCdate(cdate);

		int flag = cdao.qna_CommentWriteOk(commentTO);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("qnaBoard/qna_comment_ok");
		modelAndView.addObject("cmId", cmId);
		modelAndView.addObject("flag", flag);
		return modelAndView;
	}

	// Qna 게시판 댓글 삭제
	@RequestMapping("/qna_CommentDeleteOk.do")
	public ModelAndView commentDeleteOk(HttpServletRequest request) {

		CommentTO to = new CommentTO();

		to.setPcmId(request.getParameter("qnaId"));
		to.setCmId(request.getParameter("cmId"));
	
		int flag = cdao.qna_commentDelete(to);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("qnaBoard/qna_commentDelete_ok");
		modelAndView.addObject("flag", flag);
		return modelAndView;
	}
	
	// Qna 게시판 댓글 수정
	@RequestMapping("/qna_CommentModifyOk.do")
	public ModelAndView commentModifyOk(HttpServletRequest request) {
		
		CommentTO to = new CommentTO();
		
		to.setPcmId(request.getParameter("qnaId"));
		to.setCmId(request.getParameter("cmId"));
		to.setCcontent(request.getParameter("modifyComment"));
		
		int flag = cdao.qna_commentModify(to);

		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("qnaBoard/qna_commentModify_ok");
		modelAndView.addObject("flag", flag);
		return modelAndView;
	}
	
	
	

}

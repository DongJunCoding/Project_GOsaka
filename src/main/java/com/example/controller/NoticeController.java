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

import com.example.model.NoticeDAO;
import com.example.model.NoticeTO;
import com.example.model.PageListTO;
import com.example.model.PassTicketTO;

@RestController
public class NoticeController {

	@Autowired
	private NoticeDAO ndao;
	
	
	@Value("${spring.servlet.multipart.location}") // $기호를 사용하여 프로퍼티 값을 설정할 수 있음.
	private String uploadPath;

	// 공지사항 게시판 쓰기 작성 후 글쓰기 눌렀을 때 처리하는 로직
	@RequestMapping("/noticeWrite_ok.do")
	public ModelAndView notice_Write(HttpServletRequest request,
			@RequestParam("upload") List<MultipartFile> uploads) {

		NoticeTO nTO = new NoticeTO();
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

				nTO.setNsubject(request.getParameter("nsubject"));
				nTO.setNwriter(request.getParameter("nwriter"));
				nTO.setNcontent(request.getParameter("ncontent"));
				nTO.setIp("000.000.000");
				nTO.setImage(newfilename);

			}
		}

		// 이미지가 하나도 업로드되지 않은 경우
		if (imageNames.isEmpty()) {
			nTO.setImage("dotonView.jpg");
		} else {
			// 이미지 파일명을 ,로 구분하여 하나의 문자열로 저장
			nTO.setImage(String.join("▒", imageNames));
		}

		nTO.setNsubject(request.getParameter("nsubject"));
		nTO.setNwriter(request.getParameter("nwriter"));
		nTO.setNcontent(request.getParameter("ncontent"));
		nTO.setIp("000.000.000");

		flag = ndao.noticeWrite(nTO);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("notice/noticeWrite_ok");
		modelAndView.addObject("flag", flag);
		return modelAndView;

	}

	// 공지사항 게시판 리스트
	@RequestMapping("/noticeList.do")
	public ModelAndView noticeList(HttpServletRequest request) {

		PageListTO pageTO = new PageListTO();
		String cpageParam = request.getParameter("cpage");
		int cpage = 1; // 기본값 설정

		if (cpageParam != null && !cpageParam.isEmpty()) {
			cpage = Integer.parseInt(cpageParam);
		}
		int recordPerPage = 10;
		int blockPerPage = pageTO.getBlockPerPage();

		ArrayList<NoticeTO> noticeList = ndao.noticeList();

		String searchWord = request.getParameter("searchWord");
		String searchKey = request.getParameter("searchKey");

		// 전체 게시물 개수 가져옴
		pageTO.setTotalRecord(noticeList.size());

		// 전체 게시물의 페이지 개수
		pageTO.setTotalPage((pageTO.getTotalRecord() - 1) / recordPerPage + 1);

		if (searchWord != null) {
			noticeList = ndao.noticeSearchList(searchKey, searchWord);

			pageTO.setTotalRecord(noticeList.size());
			pageTO.setTotalPage((pageTO.getTotalRecord() - 1) / recordPerPage + 1);

		}

		int skip = (cpage - 1) * recordPerPage;
		int endIndex = Math.min(skip + recordPerPage, noticeList.size());

		ArrayList<NoticeTO> pageList = new ArrayList<>(noticeList.subList(skip, endIndex));
		pageTO.setNoticePageList(pageList);

		pageTO.setStartBlock(cpage - (cpage - 1) % blockPerPage);
		pageTO.setEndBlock(cpage - (cpage - 1) % blockPerPage + blockPerPage - 1);

		if (pageTO.getEndBlock() >= pageTO.getTotalPage()) {
			pageTO.setEndBlock(pageTO.getTotalPage());
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("notice/noticeList");
		modelAndView.addObject("noticeList", noticeList);
		modelAndView.addObject("pageTO", pageTO);

		return modelAndView;

	}

	// 공지사항 게시판 쓰기 뷰 페이지
	@RequestMapping("/noticeWrite.do")
	public ModelAndView noticeWrite(HttpServletRequest request) {

		String cpageParam = request.getParameter("cpage");
		int cpage = 1; // 기본값 설정

		if (cpageParam != null && !cpageParam.isEmpty()) {
			cpage = Integer.parseInt(cpageParam);
		}

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("notice/noticeWrite");
		modelAndView.addObject("cpage", cpage);

		return modelAndView;
	}

	// 공지사항 게시판 뷰
	@RequestMapping("/noticeView.do")
	public ModelAndView noticeView(HttpServletRequest request) {

	
		String cpageParam = request.getParameter("cpage");
		int cpage = 1; // 기본값 설정

		if (cpageParam != null && !cpageParam.isEmpty()) {
			cpage = Integer.parseInt(cpageParam);
		}
			
		NoticeTO noticeView = new NoticeTO();
		noticeView.setNoticeId(request.getParameter("noticeId"));

		noticeView = ndao.noticeView(noticeView);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("notice/noticeView");
		modelAndView.addObject("noticeView", noticeView);
		modelAndView.addObject("cpage", cpage);

		return modelAndView;
	}

	// 공지사항 게시판 게시글 삭제
	@RequestMapping("/noticeViewDelete_ok.do")
	public ModelAndView noticeViewDelete_ok(HttpServletRequest request) {

		NoticeTO to = new NoticeTO();
		to.setNoticeId(request.getParameter("noticeId"));

		int flag = ndao.noticeViewDelete(to);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("notice/noticeViewDelete_ok");
		modelAndView.addObject("flag", flag);
		return modelAndView;
	}

	// 공지사항 게시판 게시글 수정 페이지
	@RequestMapping("/noticeModify.do")
	public ModelAndView noticeModify(HttpServletRequest request) {

		String cpageParam = request.getParameter("cpage");
		int cpage = 1; // 기본값 설정

		if (cpageParam != null && !cpageParam.isEmpty()) {
			cpage = Integer.parseInt(cpageParam);
		}

		NoticeTO to = new NoticeTO();
		to.setNoticeId(request.getParameter("noticeId"));

		to = ndao.noticeModify(to);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("notice/noticeModify");
		modelAndView.addObject("cpage", cpage);
		modelAndView.addObject("to", to);
		return modelAndView;
	}

	// 공지사항 게시판 게시글 수정 로직
	@RequestMapping("/noticeModify_ok.do")
	public ModelAndView noticeModify_ok(HttpServletRequest request,
			@RequestParam("upload") List<MultipartFile> uploads) {

		NoticeTO to = new NoticeTO();

		to.setNoticeId(request.getParameter("noticeId"));
		String noticeId = to.getNoticeId();

		String[] oldFileNames = ndao.noticeImage(to).split("▒");

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

				to.setNsubject(request.getParameter("nsubject"));
				to.setNwriter(request.getParameter("nwriter"));
				to.setNcontent(request.getParameter("ncontent"));
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

		to.setNsubject(request.getParameter("nsubject"));
		to.setNwriter(request.getParameter("nwriter"));
		to.setNcontent(request.getParameter("ncontent"));
		to.setIp("000.000.000");

		flag = ndao.noticeModify_ok(to);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("notice/noticeModify_ok");
		modelAndView.addObject("flag", flag);
		modelAndView.addObject("noticeId", noticeId);

		return modelAndView;
	}
	
	// 패스티켓 리스트 페이지
	@RequestMapping("/passticketList.do")
	public ModelAndView passticketList(HttpServletRequest request) {

		PageListTO pageTO = new PageListTO();

		// url에 있는 cpage= 뒤에 오는 값을 받음
		String cpageParam = request.getParameter("cpage");

		int cpage = 1; // 기본값 설정

		// null체크와 빈문자열 isEmpty(공백)로 체크하는 것은 값을 넘겨받았을 때 두 가지의 문제가 보통 발생할 수 있어서 안정적으로 두
		// 가지의 조건을 걸어준 것
		if (cpageParam != null && !cpageParam.isEmpty()) {
			cpage = Integer.parseInt(cpageParam);
		}

		int recordPerPage = pageTO.getRecordPerPage();
		int blockPerPage = pageTO.getBlockPerPage();

		ArrayList<PassTicketTO> passticketList = ndao.passticketList();

		String searchWord = request.getParameter("searchWord");

			// 전체 게시물 개수 가져옴
			pageTO.setTotalRecord(passticketList.size());

			// 전체 게시물의 페이지 개수
			pageTO.setTotalPage((pageTO.getTotalRecord() - 1) / recordPerPage + 1);
			

		if (searchWord != null) {
			passticketList = ndao.searchList(searchWord);

			pageTO.setTotalRecord(passticketList.size());
			pageTO.setTotalPage((pageTO.getTotalRecord() - 1) / recordPerPage + 1);

		}

		int skip = (cpage - 1) * recordPerPage;
		int endIndex = Math.min(skip + recordPerPage, passticketList.size());

		ArrayList<PassTicketTO> pageList = new ArrayList<>(passticketList.subList(skip, endIndex));
		pageTO.setPassticketPageList(pageList);

		pageTO.setStartBlock(cpage - (cpage - 1) % blockPerPage);
		pageTO.setEndBlock(cpage - (cpage - 1) % blockPerPage + blockPerPage - 1);

		if (pageTO.getEndBlock() >= pageTO.getTotalPage()) {
			pageTO.setEndBlock(pageTO.getTotalPage());
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("notice/passticketList");
		modelAndView.addObject("passticketList", passticketList);
		modelAndView.addObject("pageTO", pageTO);

		return modelAndView;

	}

}

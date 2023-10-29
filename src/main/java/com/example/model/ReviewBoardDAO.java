package com.example.model;

import java.io.File;
import java.util.ArrayList;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import com.example.config.ReviewBoardMapperInter;

@Repository
@MapperScan(basePackages = { "com.example.controller", "com.example.config", "com.example.model",
		"com.example.service" })
public class ReviewBoardDAO {

	@Autowired
	private ReviewBoardMapperInter mapper;

	// application.properties에 설정되어 있는 업로드 경로를 클래스에서 사용하려면 @Value 어노테이션을 이용하여 프로퍼티 값
	// 주입받아 사용.
	@Value("${spring.servlet.multipart.location}") // $기호를 사용하여 프로퍼티 값을 설정할 수 있음.
	private String uploadPath;

	// review 게시판 쓰기
	public int review_boardWrite(ReviewBoardTO to) {
		int result = mapper.boardWrite(to);
		int flag = 1;

		if (result == 1) {
			flag = 0;
		}

		return flag;
	}

	// review 게시판 리스트
	public ArrayList<ReviewBoardTO> reviewBoardList() {
		ArrayList<ReviewBoardTO> reviewBoardList = mapper.reviewBoardList();
		return reviewBoardList;
	}

	// review 게시판 검색
	public ArrayList<ReviewBoardTO> reviewBoardSearchList(String searchKey, String searchWord) {
		ArrayList<ReviewBoardTO> searchList = new ArrayList<>();

		if (searchKey.equals("rvsubject")) {
			searchList = mapper.subjectSearchList(searchWord);
		} else if (searchKey.equals("rvwriter")) {
			searchList = mapper.writerSearchList(searchWord);
		} else if (searchKey.equals("rvcontent")) {
			searchList = mapper.contentSearchList(searchWord);
		}

		return searchList;
	}

	// review 게시판 뷰
	public ReviewBoardTO reviewBoardView(ReviewBoardTO to) {

		mapper.reviewBoardViewHit(to);

		to = mapper.reviewBoardView(to);

		return to;
	}

	// review 게시판 게시글 삭제
	public int reviewBoardViewDelete(ReviewBoardTO reviewId) {
		
		String[] filenames = mapper.reviewBoardImage(reviewId).split("▒");
		if (filenames != null) {
			for (String filename : filenames) {
				if (!filename.equals("dotonView.jpg")) {
					File file = new File(uploadPath, filename);
					file.delete();
				}
			}
		}

		int flag = 1;
		int result = mapper.reviewBoardViewDelete(reviewId);
		if (result == 1) {
			flag = 0;
		}

		return flag;
	}
	
	// review 게시판 수정 뷰
	public ReviewBoardTO reviewBoardModify(ReviewBoardTO reviewId) {
		ReviewBoardTO to = mapper.reviewBoardModify(reviewId);
		return to;
	}
	
	// review 게시판 수정 로직
	public int reviewBoardModify_ok(ReviewBoardTO to) {

		int result = mapper.reviewBoardModify_ok(to);
		int flag = 1;
		if(result == 1) {
			flag = 0;
		}
		
		return flag;
	}
	
	// review 게시판 이미지파일 이름 가져오는 로직
	public String reviewBoardImage(ReviewBoardTO reviewId) {
		String oldFileName = mapper.reviewBoardImage(reviewId);
		return oldFileName;
	}
}

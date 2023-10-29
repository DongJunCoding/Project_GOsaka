package com.example.model;

import java.io.File;
import java.util.ArrayList;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import com.example.config.TipBoardMapperInter;

@Repository
@MapperScan(basePackages = { "com.example.controller", "com.example.config", "com.example.model",
		"com.example.service" })

public class TipBoardDAO {

	@Autowired
	private TipBoardMapperInter mapper;

	// application.properties에 설정되어 있는 업로드 경로를 클래스에서 사용하려면 @Value 어노테이션을 이용하여 프로퍼티 값
	// 주입받아 사용.
	@Value("${spring.servlet.multipart.location}") // $기호를 사용하여 프로퍼티 값을 설정할 수 있음.
	private String uploadPath;

	// Tip 게시판 쓰기
	public int tip_boardWrite(TipBoardTO to) {
		int result = mapper.boardWrite(to);
		int flag = 1;

		if (result == 1) {
			flag = 0;
		}

		return flag;
	}

	// Tip 게시판 리스트
	public ArrayList<TipBoardTO> tipBoardList() {
		ArrayList<TipBoardTO> tipBoardList = mapper.tipBoardList();
		return tipBoardList;
	}

	// Tip 게시판 검색
	public ArrayList<TipBoardTO> tipBoardSearchList(String searchKey, String searchWord) {
		ArrayList<TipBoardTO> searchList = new ArrayList<>();

		if (searchKey.equals("tsubject")) {
			searchList = mapper.subjectSearchList(searchWord);
		} else if (searchKey.equals("twriter")) {
			searchList = mapper.writerSearchList(searchWord);
		} else if (searchKey.equals("tcontent")) {
			searchList = mapper.contentSearchList(searchWord);
		}

		return searchList;
	}

	// Tip 게시판 뷰
	public TipBoardTO tipBoardView(TipBoardTO to) {

		mapper.tipBoardViewHit(to);

		to = mapper.tipBoardView(to);

		return to;
	}

	// Tip 게시판 게시글 삭제
	public int tipBoardViewDelete(TipBoardTO tipId) {
		
		String[] filenames = mapper.tipBoardImage(tipId).split("▒");
		if (filenames != null) {
			for (String filename : filenames) {
				if (!filename.equals("dotonView.jpg")) {
					File file = new File(uploadPath, filename);
					file.delete();
				}
			}
		}

		int flag = 1;
		int result = mapper.tipBoardViewDelete(tipId);
		if (result == 1) {
			flag = 0;
		}

		return flag;
	}
	
	// Tip 게시판 수정 뷰
	public TipBoardTO tipBoardModify(TipBoardTO tipId) {
		TipBoardTO to = mapper.tipBoardModify(tipId);
		return to;
	}
	
	// Tip 게시판 수정 로직
	public int tipBoardModify_ok(TipBoardTO to) {

		int result = mapper.tipBoardModify_ok(to);
		int flag = 1;
		if(result == 1) {
			flag = 0;
		}
		
		return flag;
	}
	
	// Tip 게시판 이미지파일 이름 가져오는 로직
	public String tipBoardImage(TipBoardTO tipId) {
		String oldFileName = mapper.tipBoardImage(tipId);
		return oldFileName;
	}
}

package com.example.model;

import java.io.File;
import java.util.ArrayList;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import com.example.config.QnaBoardMapperInter;

@Repository
@MapperScan(basePackages = { "com.example.controller", "com.example.config", "com.example.model",
		"com.example.service" })

public class QnaBoardDAO {

	@Autowired
	private QnaBoardMapperInter mapper;

	// application.properties에 설정되어 있는 업로드 경로를 클래스에서 사용하려면 @Value 어노테이션을 이용하여 프로퍼티 값
	// 주입받아 사용.
	@Value("${spring.servlet.multipart.location}") // $기호를 사용하여 프로퍼티 값을 설정할 수 있음.
	private String uploadPath;

	// QNA 게시판 쓰기
	public int qna_boardWrite(QnaBoardTO to) {
		int result = mapper.boardWrite(to);
		int flag = 1;

		if (result == 1) {
			flag = 0;
		}

		return flag;
	}

	// QNA 게시판 리스트
	public ArrayList<QnaBoardTO> qnaBoardList() {
		ArrayList<QnaBoardTO> qnaBoardList = mapper.qnaBoardList();
		return qnaBoardList;
	}

	// QNA 게시판 검색
	public ArrayList<QnaBoardTO> qnaBoardSearchList(String searchKey, String searchWord) {
		ArrayList<QnaBoardTO> searchList = new ArrayList<>();

		if (searchKey.equals("qsubject")) {
			searchList = mapper.subjectSearchList(searchWord);
		} else if (searchKey.equals("qwriter")) {
			searchList = mapper.writerSearchList(searchWord);
		} else if (searchKey.equals("qcontent")) {
			searchList = mapper.contentSearchList(searchWord);
		}

		return searchList;
	}

	// QNA 게시판 뷰
	public QnaBoardTO qnaBoardView(QnaBoardTO to) {

		mapper.qnaBoardViewHit(to);

		to = mapper.qnaBoardView(to);

		return to;
	}

	// QNA 게시판 게시글 삭제
	public int qnaBoardViewDelete(QnaBoardTO qnaId) {
		
		String[] filenames = mapper.qnaBoardImage(qnaId).split("▒");
		if (filenames != null) {
			for (String filename : filenames) {
				if (!filename.equals("dotonView.jpg")) {
					File file = new File(uploadPath, filename);
					file.delete();
				}
			}
		}

		int flag = 1;
		int result = mapper.qnaBoardViewDelete(qnaId);
		if (result == 1) {
			flag = 0;
		}

		return flag;
	}
	
	// QNA 게시판 수정 뷰
	public QnaBoardTO qnaBoardModify(QnaBoardTO qnaId) {
		QnaBoardTO to = mapper.qnaBoardModify(qnaId);
		return to;
	}
	
	// QNA 게시판 수정 로직
	public int qnaBoardModify_ok(QnaBoardTO to) {

		int result = mapper.qnaBoardModify_ok(to);
		int flag = 1;
		if(result == 1) {
			flag = 0;
		}
		
		return flag;
	}
	
	// QNA 게시판 이미지파일 이름 가져오는 로직
	public String qnaBoardImage(QnaBoardTO qnaId) {
		String oldFileName = mapper.qnaBoardImage(qnaId);
		return oldFileName;
	}
}

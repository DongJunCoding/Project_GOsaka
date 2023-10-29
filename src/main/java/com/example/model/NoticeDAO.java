package com.example.model;

import java.io.File;
import java.util.ArrayList;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import com.example.config.NoticeMapperInter;

@Repository
@MapperScan(basePackages = { "com.example.controller", "com.example.config", "com.example.model",
		"com.example.service" })
public class NoticeDAO {

	@Autowired
	private NoticeMapperInter mapper;

	// application.properties에 설정되어 있는 업로드 경로를 클래스에서 사용하려면 @Value 어노테이션을 이용하여 프로퍼티 값
		// 주입받아 사용.
		@Value("${spring.servlet.multipart.location}") // $기호를 사용하여 프로퍼티 값을 설정할 수 있음.
		private String uploadPath;

		// 공지사항 게시판 쓰기
		public int noticeWrite(NoticeTO to) {
			int result = mapper.noticeWrite(to);
			int flag = 1;

			if (result == 1) {
				flag = 0;
			}

			return flag;
		}

		// 공지사항 게시판 리스트
		public ArrayList<NoticeTO> noticeList() {
			ArrayList<NoticeTO> noticeList = mapper.noticeList();
			return noticeList;
		}

		// 공지사항 게시판 검색
		public ArrayList<NoticeTO> noticeSearchList(String searchKey, String searchWord) {
			ArrayList<NoticeTO> searchList = new ArrayList<>();

			searchList = mapper.subjectSearchList(searchWord);

			return searchList;
		}

		// 공지사항 게시판 뷰
		public NoticeTO noticeView(NoticeTO to) {

			mapper.noticeViewHit(to);

			to = mapper.noticeView(to);

			return to;
		}

		// 공지사항 게시판 게시글 삭제
		public int noticeViewDelete(NoticeTO tipId) {
			
			String[] filenames = mapper.noticeImage(tipId).split("▒");
			if (filenames != null) {
				for (String filename : filenames) {
					if (!filename.equals("dotonView.jpg")) {
						File file = new File(uploadPath, filename);
						file.delete();
					}
				}
			}

			int flag = 1;
			int result = mapper.noticeViewDelete(tipId);
			if (result == 1) {
				flag = 0;
			}

			return flag;
		}
		
		// Tip 게시판 수정 뷰
		public NoticeTO noticeModify(NoticeTO tipId) {
			NoticeTO to = mapper.noticeModify(tipId);
			return to;
		}
		
		// Tip 게시판 수정 로직
		public int noticeModify_ok(NoticeTO to) {

			int result = mapper.noticeModify_ok(to);
			int flag = 1;
			if(result == 1) {
				flag = 0;
			}
			
			return flag;
		}
		
		// Tip 게시판 이미지파일 이름 가져오는 로직
		public String noticeImage(NoticeTO tipId) {
			String oldFileName = mapper.noticeImage(tipId);
			return oldFileName;
		}
	
	// 패스티켓 게시물 리스트
	public ArrayList<PassTicketTO > passticketList() {
		ArrayList<PassTicketTO> passticketList = mapper.passticketList();

		return passticketList;
	}

	// 패스티켓 검색 리스트
	public ArrayList<PassTicketTO> searchList(String searchWord) {

		ArrayList<PassTicketTO> searchList = mapper.searchList(searchWord);

		return searchList;
	}

}

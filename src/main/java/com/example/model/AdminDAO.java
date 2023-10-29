package com.example.model;

import java.util.ArrayList;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.config.AdminMapperInter;

@Repository
@MapperScan(basePackages = { "com.example.controller", "com.example.config", "com.example.model",
		"com.example.service" })
public class AdminDAO {

	@Autowired
	private AdminMapperInter amapper;

	// 당일 회원가입자 리스트
	public ArrayList<LoginTO> todaySignup() {
		ArrayList<LoginTO> todayMember = amapper.todaySignup();

		return todayMember;
	}

	// 당일작성 qna 게시글 리스트
	public ArrayList<QnaBoardTO> todayQnaBoard() {
		ArrayList<QnaBoardTO> todayQnaList = amapper.todayQnaBoardList();

		return todayQnaList;
	}

	// 방명록 쓰기
	public int guestbookWriteOk(GuestBookTO to) {
		int flag = 1;
		int result = amapper.guestBookWriteOk(to);

		if (result == 1) {
			flag = 0;
		}

		return flag;
	}

	// 방명록 리스트
	public ArrayList<GuestBookTO> guestbookList() {
		ArrayList<GuestBookTO> list = amapper.guestBookList();

		return list;
	}

	// 방명록 글 삭제
	public int guestbookDelete(String gbId) {
		int flag = 1;
		int result = amapper.guestbookDeleteOk(gbId);

		if (result == 1) {
			flag = 0;
		}

		return flag;
	}

	// 전체 회원 리스트
	public ArrayList<LoginTO> totalUser() {
		ArrayList<LoginTO> totalUserList = amapper.totalUser();

		return totalUserList;
	}

	// 블랙 / 블랙헤제 role값 변경
	public int changeRole(LoginTO to) {
		int flag = 1;
		int result = amapper.changeRole(to);

		if (result == 1) {
			flag = 0;
		}

		return flag;
	}

	// 회원 삭제
	public int userDeleteOk(String memberId) {
		int flag = 1;
		int result = amapper.userDeleteOk(memberId);

		if (result == 1) {
			flag = 0;
		}

		return flag;
	}

}

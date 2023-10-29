package com.example.config;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.model.GuestBookTO;
import com.example.model.LoginTO;
import com.example.model.QnaBoardTO;

public interface AdminMapperInter {

	// 오늘 가입한 회원 리스트
	@Select("select memberId, userId, nickname, datediff(now(), mdate) gap, mdate from member order by memberId desc")
	public ArrayList<LoginTO> todaySignup();

	// QNA 게시판 List 3개
	@Select("select qnaId, qsubject, qwriter, qdate, datediff(now(), qdate) qgap from qna_board order by qnaId desc limit 0,3")
	public ArrayList<QnaBoardTO> todayQnaBoardList();
	
	// 방명록 글쓰기
	@Insert("insert into guestbook values(0, #{gbwriter}, #{gbcontent}, #{emot}, now())")
	public int guestBookWriteOk(GuestBookTO to);
	
	// 방명록 리스트
	@Select("select gbId, gbwriter, gbcontent, emot, gbdate from guestbook order by gbId desc")
	public ArrayList<GuestBookTO> guestBookList();
	
	// 방명록 삭제
	@Delete("delete from guestbook where gbId=#{gbId}")
	public int guestbookDeleteOk(String gbId);
	
	// 전체 회원 리스트
	@Select("select memberId, role, userId, nickname, mdate from member order by memberId desc")
	public ArrayList<LoginTO> totalUser();
	
	// 회원 블랙리스트
	@Update("update member set role=#{role} where memberId=#{memberId}")
	public int changeRole(LoginTO to);
	
	// 회원 삭제
	@Delete("delete from member where memberId=#{memberId}")
	public int userDeleteOk(String memberId);
}

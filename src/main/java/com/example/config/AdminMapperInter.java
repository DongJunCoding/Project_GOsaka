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
	/*
	 * 인터페이스는 추상메서드 집합이다. 
	 * 근데 왜 앞에 abstract가 없을까?
	 * 이유는 인터페이스는 언제나 메서드 앞에 public abstact가 있어야 하는데 항상 써줘야하기 때문에 생략이 되어있는 것.
	 * 변수는 public static final int i = 0; 이런식으로 타입 앞에  public static final이 붙어있는데 이것도 생략이 가능하다. -> 상수여아 가능
	 * 상수, static 메서드, default메서드 가능 -> 인터페이스의 핵심은 아님 핵심은 "추상 메서드의 집합"이라는 것
	 * public static final중에 안써도 되고 하나만 써도 되고 두개 써도 된다 왜냐하면 생략이 가능하기때문.
	 */
	
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

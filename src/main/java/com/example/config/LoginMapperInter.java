package com.example.config;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.model.LoginTO;

public interface LoginMapperInter {

	// 회원가입 정보 저장
	@Insert("insert into member values(0, 'NORMAL', #{userId}, #{nickname}, #{password}, #{femail}, #{semail}, now())")
	public int signup_ok(LoginTO to);
	
	// 카카오 회원정보 저장
	@Insert("insert into member values(0, 'NORMAL', #{userId}, #{nickname}, 'Kakao', #{femail}, #{semail}, now())")
	public int kakaoLogin(LoginTO to);

	// 아이디 중복확인용 select문
	@Select("select userId from member where userId=#{userId}")
	public String dup_id_check(String UserId);

	// 닉네임 중복확인용 select문
	@Select("select nickname from member where nickname=#{nickname}")
	public String dup_nickname_check(String nickname);

	// 이메일 중복확인용 select문
	@Select("select femail, semail from member where femail=#{femail} and semail=#{semail}")
	public LoginTO dup_femail_check(String femail, String semail);

	// 로그인시 필요한 select문 / 아이디 패스워드 외에는 정보를 위해 가져옴
	@Select("select role, userId, password, nickname, femail, semail from member where userId=#{userId}")
	public LoginTO login(LoginTO to);

	// 비밀번호 변경
	@Update("update member set password=#{password} where userId=#{userId}")
	public int changePw(LoginTO to);

	// 아이디 찾기
	@Select("select userId from member where femail=#{femail} and semail=#{semail}")
	public String findId(LoginTO to);

	// 사용자의 등록된 아이디에 대한 이메일 얻기, 비밀번호 변경시 이메일 인증번호전송에 사용(아이디, 이메일 일치성 검사)
	@Select("select femail, semail from member where userId=#{userId}")
	public LoginTO correctInfo(String userId);

}

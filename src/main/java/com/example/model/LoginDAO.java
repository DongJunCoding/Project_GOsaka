package com.example.model;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import com.example.config.LoginMapperInter;

@Repository
@MapperScan(basePackages = { "com.example.controller", "com.example.config", "com.example.model",
		"com.example.service" })
public class LoginDAO {

	@Autowired
	private LoginMapperInter mapper;

	// 회원가입
	public int signup_ok(LoginTO to) {

		int flag = 1;

		// DB에 저장하기 전 BCrypt를 사용하여 password를 암호화 시켜줌
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String encodePassword = encoder.encode(to.getPassword());
		to.setPassword(encodePassword);

		int result = mapper.signup_ok(to);

		if (result == 1) {
			flag = 0;
		}

		return flag;
	}
	
	// 카카오 회원가입
	public int kakaoLogin(LoginTO to) {
		
		int flag = 1;
	
		LoginTO login = mapper.login(to);
		
		if (login == null) {
			mapper.kakaoLogin(to);
			flag = 0;
		} else if (login != null) {
			mapper.login(to);
			flag = 0;
		}
		
		return flag;
	}

	// 아이디 중복확인
	public int dup_id_chek(String userId) {
		String id = mapper.dup_id_check(userId);

		int result = 0;

		if (id != null) {
			result = 1;
		} else {
			result = 0;
		}

		return result;
	}

	// 닉네임 중복확인
	public int dup_nickname_chek(String nickname) {
		String nick = mapper.dup_nickname_check(nickname);

		int result = 0;

		if (nick != null) {
			result = 1;
		} else {
			result = 0;
		}

		return result;
	}

	// 이메일 중복확인
	public String dup_femail_check(String femail, String semail) {
		LoginTO emailTO = new LoginTO();
		emailTO = mapper.dup_femail_check(femail, semail);

		String result = null;

		if (emailTO != null) {
			result = emailTO.getFemail() + "@" + emailTO.getSemail();
		}

		return result;
	}

	// 로그인
	public boolean login(LoginTO to) {

		LoginTO login = mapper.login(to);

		if (login != null) {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			String storedPasswordHash = login.getPassword(); // 데이터베이스에 저장된 hash 암호
			String enteredPassword = to.getPassword(); // 로그인 시 입력한 암호

			// match 메서드로 두 개의 값이 같은 값인지 확인 가능.
			if (encoder.matches(enteredPassword, storedPasswordHash)) {
				// 패스워드 검증 성공
				return true;
			}
		}
		return false;

	}

	// 비밀번호 변경
	public int changePw(LoginTO to) {
		int flag = 1;

		// DB에 저장하기 전 BCrypt를 사용하여 password를 암호화 시켜줌
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String encodePassword = encoder.encode(to.getPassword());
		to.setPassword(encodePassword);

		int result = mapper.changePw(to);

		if (result == 1) {
			flag = 0;
		}

		return flag;

	}

	// 아이디 찾기
	public String findId(LoginTO to) {

		String id = mapper.findId(to);

		return id;
	}

	// 닉네임 정보 가져오기
	public LoginTO infoSession(LoginTO to) {
		LoginTO loginTO = mapper.login(to);
		
		return loginTO;
	}

	// 사용자의 등록된 아이디에 대한 이메일 얻기
	public String correctInfo(String userId) {
		LoginTO to = mapper.correctInfo(userId);

		String email = null;

		if (to != null) {

			email = to.getFemail() + "@" + to.getSemail();

		}

		return email;
	}

}

package com.example.config;

import org.apache.ibatis.annotations.Update;

public interface MyPageMapperInter {

	// Review 게시판 수정 쿼리문
	@Update("update member set nickname=#{nickname} where userId=#{userId}")
	public int myPageModifyOk(String nickname, String userId); 
	
}

package com.example.model;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.config.MyPageMapperInter;

@Repository
@MapperScan(basePackages = { "com.example.controller", "com.example.config", "com.example.model",
		"com.example.service" })
public class MyPageDAO {

	@Autowired
	private MyPageMapperInter mpmapper;
	
	public int mypageModify(String nickname, String userId) {
		
		int flag = 1;
		int result = mpmapper.myPageModifyOk(nickname, userId);
		
		if(result == 1) {
			flag = 0;
		}
				
		return flag;
	}
}

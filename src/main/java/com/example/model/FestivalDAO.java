package com.example.model;

import java.util.ArrayList;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.config.FestivalMapperInter;

@Repository
@MapperScan(basePackages = { "com.example.controller", "com.example.config", "com.example.model",
		"com.example.service" })

public class FestivalDAO {

	@Autowired
	private FestivalMapperInter mapper;

	// 축제 리스트
	public ArrayList<FestivalTO> festivalList() {
		ArrayList<FestivalTO> festivalList = mapper.festivalList();
		return festivalList;
	}

	
}

package com.example.model;

import java.util.ArrayList;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.config.OsakaMapperInter;

@Repository
@MapperScan(basePackages = { "com.example.controller", "com.example.config", "com.example.model",
		"com.example.service" })
public class OsakaAreaDAO {

	@Autowired
	private OsakaMapperInter mapper;

	// 관광 게시물 리스트
	public ArrayList<OsakaAreaTO> osakaList() {
		ArrayList<OsakaAreaTO> osakaList = mapper.osakaList();

		return osakaList;
	}
	
	// 뷰 페이지
	public OsakaAreaTO osakaView(OsakaAreaTO to) {

		to = mapper.osakaView(to);

		return to;
	}

	// 오사카 검색 리스트
	public ArrayList<OsakaAreaTO> searchList(String category, String searchWord) {

		ArrayList<OsakaAreaTO> searchList = mapper.searchList(category, searchWord);

		return searchList;
	}

}

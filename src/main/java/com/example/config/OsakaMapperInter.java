package com.example.config;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.example.model.OsakaAreaTO;

public interface OsakaMapperInter {

	/* 오사카 시 관광정보 크롤링 */
	@Insert("insert into osaka_area values ( 0, #{category}, #{imageUrl}, #{title}, #{content}, #{latitude}, #{longitude} )")
	public int OsakaCrawling(OsakaAreaTO to);
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	/* 오사카, 교토, 고베, 나라 관광 리스트 */
	@Select("select osakaId, category, imageUrl, title from osaka_area")
	public ArrayList<OsakaAreaTO> osakaList();

	/* 오사카, 교토, 고베, 나라 관광 뷰 */
	@Select("select osakaId, category, imageUrl, title, content, latitude, longitude from osaka_area where osakaId=#{osakaId}")
	public OsakaAreaTO osakaView(OsakaAreaTO to);

	/* List 검색 */
	@Select("select osakaId, category, imageUrl, title from osaka_area where category=#{category} and title like concat('%', #{searchWord}, '%')")
	public ArrayList<OsakaAreaTO> searchList(String category, String searchWord);

}

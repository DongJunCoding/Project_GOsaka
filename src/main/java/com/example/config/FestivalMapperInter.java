package com.example.config;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.example.model.FestivalTO;

public interface FestivalMapperInter {

	/* 축제 크롤링 */
	@Insert("insert into festival values ( 0, #{category}, #{imageUrl}, #{ftitle}, #{fcontent}, #{floc}, #{fdate} )")
	public int FestivalCrawling(FestivalTO to);

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	/* 축제 리스트 */
	@Select("select festivalId, category, imageUrl, ftitle, fcontent, floc, fdate from festival")
	public ArrayList<FestivalTO> festivalList();

}

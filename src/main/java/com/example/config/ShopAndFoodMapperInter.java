package com.example.config;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.example.model.RestaurantTO;
import com.example.model.ShoppingTO;

public interface ShopAndFoodMapperInter {

	/* 쇼핑 크롤링 */
	@Insert("insert into shopping values ( 0, #{imageUrl}, #{stitle}, #{scontent}, #{latitude}, #{longitude} )")
	public int shopCrawling(ShoppingTO to);

	/* 음식 크롤링 */
	@Insert("insert into restaurant values ( 0, #{imageUrl}, #{rtitle}, #{rcontent}, #{latitude}, #{longitude} )")
	public int foodCrawling(RestaurantTO to);

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	/* 쇼핑 리스트 */
	@Select("select shopId, imageUrl, stitle from shopping")
	public ArrayList<ShoppingTO> shoppingList();

	/* 쇼핑 리스트 검색 */
	@Select("select shopId, imageUrl, stitle from shopping where stitle like concat('%', #{searchWord}, '%')")
	public ArrayList<ShoppingTO> shoppingSearchList(String searchWord);

	/* 쇼핑 View */
	@Select("select shopId, imageUrl, stitle, scontent, latitude, longitude from shopping where shopId=#{shopId}")
	public ShoppingTO shopppingView(ShoppingTO to);
	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	/* 음식 리스트 */
	@Select("select restaurantId, imageUrl, rtitle from restaurant")
	public ArrayList<RestaurantTO> restaurantList();
	
	/* 음식 리스트 검색 */
	@Select("select restaurantId, imageUrl, rtitle from restaurant where rtitle like concat('%', #{searchWord}, '%')")
	public ArrayList<RestaurantTO> restaurantSearchList(String searchWord);

	/* 음식 View */
	@Select("select restaurantId, imageUrl, rtitle, rcontent, latitude, longitude from restaurant where restaurantId=#{restaurantId}")
	public RestaurantTO restaurantView(RestaurantTO to);
	
}

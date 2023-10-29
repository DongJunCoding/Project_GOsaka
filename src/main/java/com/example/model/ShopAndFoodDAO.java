package com.example.model;

import java.util.ArrayList;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.config.ShopAndFoodMapperInter;

@Repository
@MapperScan(basePackages = { "com.example.controller", "com.example.config", "com.example.model",
		"com.example.service" })

public class ShopAndFoodDAO {

	@Autowired
	private ShopAndFoodMapperInter mapper;

	// 쇼핑 리스트
	public ArrayList<ShoppingTO> shoppingList() {
		ArrayList<ShoppingTO> shoppingList = mapper.shoppingList();
		return shoppingList;
	}

	// 쇼핑 리스트 검색
	public ArrayList<ShoppingTO> shoppingSearchList(String searchWord) {

		ArrayList<ShoppingTO> shoppingSearchList = mapper.shoppingSearchList(searchWord);

		return shoppingSearchList;
	}

	// 쇼핑 뷰 페이지
	public ShoppingTO shoppingView(ShoppingTO to) {

		to = mapper.shopppingView(to);

		return to;
	}
	
	
	// 음식 리스트
	public ArrayList<RestaurantTO> restaurantList() {
		ArrayList<RestaurantTO> restaurantList = mapper.restaurantList();
		return restaurantList;
	}
	
	// 음식 리스트 검색
	public ArrayList<RestaurantTO> restaurantSearchList(String searchWord) {
		
		ArrayList<RestaurantTO> restaurantSearchList = mapper.restaurantSearchList(searchWord);
		
		return restaurantSearchList;
	}
	
	// 음식 뷰 페이지
	public RestaurantTO restaurantView(RestaurantTO to) {
		
		to = mapper.restaurantView(to);
		
		return to;
	}

}

package com.example.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RestaurantTO {
	private String restaurantId;
	private String imageUrl;
	private String rtitle;
	private String rcontent;
	private String latitude;
	private String longitude;
}
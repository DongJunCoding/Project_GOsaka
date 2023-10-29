package com.example.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OsakaAreaTO {
	private String osakaId;
	private String imageUrl;
	private String category;
	private String title;
	private String content;
	private String latitude;
	private String longitude;
}
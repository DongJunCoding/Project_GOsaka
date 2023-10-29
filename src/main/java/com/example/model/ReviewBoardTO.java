package com.example.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReviewBoardTO {
	
	private String reviewId;
	private String image;
	private String category;
	private String rvsubject;
	private String rvwriter;
	private String rvcontent;
	private String rvdate;
	private int rvhit;
	private String ip;
	private int rvgap;
}

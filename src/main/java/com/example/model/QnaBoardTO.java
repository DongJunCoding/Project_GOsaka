package com.example.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QnaBoardTO {
	
	private String qnaId;
	private String image;
	private String qsubject;
	private String qwriter;
	private String qcontent;
	private String qdate;
	private int qhit;
	private String ip;
	private int qgap;
}

package com.example.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NoticeTO {
	
	private String noticeId;
	private String image;
	private String nsubject;
	private String nwriter;
	private String ncontent;
	private String ndate;
	private int nhit;
	private String ip;
	private int ngap;
}

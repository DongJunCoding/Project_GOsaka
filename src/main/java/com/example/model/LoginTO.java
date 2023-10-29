package com.example.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginTO {

	private String memberId;
	private String role;
	private String userId;
	private String nickname;
	private String password;
	private String femail;
	private String semail;
	private String mdate;
	private int gap;
}

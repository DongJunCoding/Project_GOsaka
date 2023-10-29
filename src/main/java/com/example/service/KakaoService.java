package com.example.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;



@Repository
@MapperScan(basePackages = { "com.example.controller"})
@SuppressWarnings("deprecation")
@Service
public class KakaoService {
	
	// 카카오로그인 인증토큰 받아오는 메서드
	public String getAccessToken(String authorize_code) {
		// 토큰받을 변수
		String access_Token = "";

		String refresh_Token = "";
		// 토큰 받아올 url (토큰을 받기위한 정보를 url로 넘겨줌)
		String reqURL = "https://kauth.kakao.com/oauth/token";
		
		BufferedWriter bw = null;
		BufferedReader br = null;
		
		try {
			URL url = new URL(reqURL);
			
			// url 연결
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			
			// post 요청을 위함
			conn.setRequestMethod("POST");
			// POST일때 출력 스트림을 사용하기 위해 true로 설정
			conn.setDoOutput(true);
			
			// POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
			bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			
			// 토큰받기 요청이 지원하는 인증 유형
			sb.append("grant_type=authorization_code");
			// 본인의 key
			sb.append("&client_id=aa90530c73e117df22ccaa129bd66135");
			// 설정한 redirect_uri
			sb.append("&redirect_uri=http://localhost:8080/kakao/callback");
			// 인가코드
			sb.append("&code=" + authorize_code);
			
			bw.write(sb.toString());
			bw.flush(); 
			
			// 결과코드 200이면 성공 + 데이터 넘어옴
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			
			// 요청을 통해 JSON타입의 Response 읽어오기
			br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
			
			// BufferedReader로 얻은 정보를 한 줄씩 읽어 result변수에 저장
			while((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);
			
			JsonParser parser = new JsonParser();			
			JsonElement element = parser.parse(result);
			
			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
			
			System.out.println("access_Token : " + access_Token);
			System.out.println("refresh_Token : " + refresh_Token + "123");
			
		} catch (IOException e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		} finally {
			if(br != null) try{ br.close();} catch(IOException e) {} 
			if(bw != null) try{ bw.close();} catch(IOException e) {} 
		}
		
		return access_Token;
	}
	
	
	// 카카오 로그인 사용자 정보 요청 메서드
	public HashMap<String, Object> getUserInfo(String access_Token) {
		
		// 요청하는 클라이언트마다 가진 정보가 다를 수 있어서 HashMap타입으로 선언
		HashMap<String, Object> userInfo = new HashMap<String, Object>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		BufferedReader br = null;
		
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			
			// 요청에 필요한 Header에 포함될 내용 / Authorization : HTTP헤더에 Authorization헤더 추가, Bearer : 토큰 유형 + 뒤에 공백 넣어주기
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);
			
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode2 : " + responseCode);
			
			br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			String line = "";
			String result = "";
			
			while((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body2 : " + result);
			
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			
			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
			
			String id = element.getAsJsonObject().get("id").getAsString();
			String nickname = properties.getAsJsonObject().get("nickname").getAsString();
			String email = kakao_account.getAsJsonObject().get("email").getAsString();
									
			userInfo.put("id", id);
			userInfo.put("email", email);
			userInfo.put("nickname", nickname);
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(br != null) try{br.close();} catch(IOException e) {}
		}
		
		return userInfo;
	}	
	
	// 카카오 로그아웃
	public void getLogout(String access_token) {
		String reqURL = "https://kapi.kakao.com/v1/user/logout";
		try {

			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "Bearer " + access_token);

			// 200 = 성공(로그아웃)
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode3 : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String br_line = "";
			String result = "";
			while ((br_line = br.readLine()) != null) {
				result += br_line;
			}
			System.out.println(result);

		} catch (IOException e) {

		}
	}
}

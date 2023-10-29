package com.example.service;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.config.NoticeMapperInter;
import com.example.model.PassTicketTO;

@Service("PassTicketCrawling")
public class PassTicketCrawling implements Ptservice {

	@Autowired
	private NoticeMapperInter mapper;

	@Override
	public int getPassTicketInfoFromWEB() throws Exception {
		int res = 0;

		// 크롤링 할 사이트 주소
		String baseUrl = "https://osaka-info.kr/tour-ticket/?q=YToxOntzOjEyOiJrZXl3b3JkX3R5cGUiO3M6MzoiYWxsIjt9&page=";
		int lastPage = 3;

		// Jsoup 라이브러리 통해 사이트 접속
		Document doc = null;

		// 사이트 접속
		for (int page = 1; page <= lastPage; page++) {
			String url = baseUrl + page;
			doc = Jsoup.connect(url).get();

			// 웹페이지의 소스 중 일부 태그 선택하여 쓰기 위해 사용
			Elements elements = doc.select("div.list-style");

			for (Element element : elements) {
				Elements imgWrappers = element.select("div.card._card");
				Elements titleElements = element.select("div.title-block");

				for (int i = 0; i < imgWrappers.size(); i++) {
					Element imgWrapper = imgWrappers.get(i);
					Element titleElement = titleElements.get(i);

					String imageUrl = imgWrapper.attr("style").replaceAll("background-image: url\\(", "")
							.replaceAll("\\);.*", "");

					String title = titleElement.text().trim().replaceAll("공지", "");

					// 이미지, 타이틀, 텍스트 내용을 TO에 저장

					PassTicketTO ptTO = new PassTicketTO();
					ptTO.setPtImage(imageUrl);
					ptTO.setPtName(title);
					res += mapper.PassTicketCrawling(ptTO);

				}
			}
		}

		return res;

	}
}

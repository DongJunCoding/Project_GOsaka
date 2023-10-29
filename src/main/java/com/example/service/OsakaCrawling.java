package com.example.service;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.config.OsakaMapperInter;
import com.example.model.OsakaAreaTO;

@Service("OsakaCrawling")
public class OsakaCrawling implements Iservice {

	@Autowired
	private OsakaMapperInter mapper;
	
	@Override
	public int getMovieInfoFromWEB() throws Exception {
		int res = 0;

		// 크롤링 할 사이트 주소
		String baseUrl = "https://osaka-info.kr/tour-nara/?q=YToxOntzOjEyOiJrZXl3b3JkX3R5cGUiO3M6MzoiYWxsIjt9&page=";
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
				Elements imgWrappers = element.select("div.card-thumbnail-wrap");
				Elements titleElements = element.select("div.title-block");
				Elements viewLinks = element.select("a.post_link_wrap"); // 이미지 클릭하여 뷰 페이지로 이동하는 링크

				for (int i = 0; i < imgWrappers.size(); i++) {
					Element imgWrapper = imgWrappers.get(i);
					Element titleElement = titleElements.get(i);
					Element viewLinkElement = viewLinks.get(i); // 해당 아이템의 뷰 페이지로 이동하는 링크

					String imageUrl = imgWrapper.attr("style").replaceAll("background-image: url\\(", "")
							.replaceAll("\\);.*", "");

					String title = titleElement.text().trim().replaceAll("공지", "");

					String viewLink = viewLinkElement.attr("href");
					String baseDomain = "https://osaka-info.kr"; // 기본 도메인 주소
					String absoluteViewLink = baseDomain + viewLink; // 절대 경로로 변환
					Document viewDoc = Jsoup.connect(absoluteViewLink).get();

					Elements redTextElements = viewDoc.select("div.board_txt_area.fr-view");
					Elements mapElements = viewDoc.select("iframe[src*=google.com/maps/embed]");

					// content추출
					StringBuilder redTextBuilder = new StringBuilder();
					for (Element redTextElement : redTextElements) {
						redTextBuilder.append(redTextElement.text()).append("\n");
					}
					String fullContent = redTextBuilder.toString().trim();

					if (!mapElements.isEmpty()) {

						Element mapElement = mapElements.first(); // 첫번째 지도만 가져옴

						String iframeSrc = mapElement.attr("src");					
						String latitude = null;
						String longitude = null;

						String[] urlParts = iframeSrc.split("[!&]");
						for (String part : urlParts) {
							if (part.startsWith("3d")) {
								latitude = part.substring(2);
							} else if (part.startsWith("2d")) {
								longitude = part.substring(2);
							}
						}

						// 이미지, 타이틀, 텍스트 내용을 TO에 저장
						if (latitude != null && longitude != null) {
							OsakaAreaTO cwTO = new OsakaAreaTO();
							cwTO.setCategory("nara");
							cwTO.setImageUrl(imageUrl);
							cwTO.setTitle(title);						
							cwTO.setContent(fullContent);
							cwTO.setLatitude(latitude);
							cwTO.setLongitude(longitude);
							res += mapper.OsakaCrawling(cwTO);

						}
					} else {
						OsakaAreaTO cwTO = new OsakaAreaTO();
						cwTO.setCategory("nara");
						cwTO.setImageUrl(imageUrl);
						cwTO.setTitle(title);
						cwTO.setContent(fullContent);
						cwTO.setLatitude("");
						cwTO.setLongitude("");
						res += mapper.OsakaCrawling(cwTO);
					}
				}

			}
		}
		
		return res;
		
	}
}

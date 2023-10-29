package com.example.service;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.config.FestivalMapperInter;
import com.example.model.FestivalTO;

@Service("FestivalCrawling")
public class FestivalCrawling implements Fservice {

    @Autowired
    private FestivalMapperInter mapper;

    @Override
    public int getFestivalInfoFromWEB() throws Exception {
        int res = 0;

        // 크롤링 할 사이트 주소
        String url = "https://osaka-info.kr/festival-nara1";

        // Jsoup 라이브러리를 사용하여 사이트 접속
        Document doc = Jsoup.connect(url).get();

        // 웹페이지의 행 태그 선택 ( tbody tr 안의 모든 태그 선택)
        Elements rows = doc.select("table").get(0).select("tbody tr");
        

        for (int i = 0; i <= rows.size(); i += 6) {
            FestivalTO cwTO = new FestivalTO();
            
            // 각 행의 정보 추출 (0행은 제목, 1행은 이미지url ...)
            Element titleRow = rows.get(i);
            Element imgRow = rows.get(i + 1);
            Element locRow = rows.get(i + 2);
            Element contentRow = rows.get(i + 3);
            Element dateRow = rows.get(i + 4);
            
            Elements nameCols = titleRow.select("td");
            Elements imgCols = imgRow.select("td");
            Elements locCols = locRow.select("td");
            Elements contentCols = contentRow.select("td");
            Elements dateCols = dateRow.select("td");

            // 축제 이름 가져오기
            String festivalName1 = nameCols.get(0).text().trim();
            String festivalName2 = nameCols.get(1).text().trim();
            String festivalName3 = nameCols.get(2).text().trim();
            
            // 이미지 URL 가져오기
            String imgUrl1 = imgCols.get(0).select("img").attr("src");
            String imgUrl2 = imgCols.get(1).select("img").attr("src");
            String imgUrl3 = imgCols.get(2).select("img").attr("src");
            
            // 장소 가져오기
            String loc1 = locCols.get(0).text().trim();
            String loc2 = locCols.get(1).text().trim();
            String loc3 = locCols.get(2).text().trim();
            
            // 내용 가져오기
            String content1 = contentCols.get(0).text().trim();
            String content2 = contentCols.get(1).text().trim();
            String content3 = contentCols.get(2).text().trim();
            
            // 기간 가져오기
            String date1 = dateCols.get(0).text().trim();
            String date2 = dateCols.get(1).text().trim();
            String date3 = dateCols.get(2).text().trim();
            
            if (!festivalName1.isEmpty()) {
                cwTO.setCategory("nara");
                cwTO.setFtitle(festivalName1);
                cwTO.setImageUrl(imgUrl1);
                cwTO.setFloc(loc1);
                cwTO.setFcontent(content1);
                cwTO.setFdate(date1);
                res += mapper.FestivalCrawling(cwTO);
            }
            
            if (!festivalName2.isEmpty()) {
                cwTO.setCategory("nara");
                cwTO.setFtitle(festivalName2);
                cwTO.setImageUrl(imgUrl2);
                cwTO.setFloc(loc2);
                cwTO.setFcontent(content2);
                cwTO.setFdate(date2);
                res += mapper.FestivalCrawling(cwTO);
            }
            
            if (!festivalName3.isEmpty()) {
                cwTO.setCategory("nara");
                cwTO.setFtitle(festivalName3);
                cwTO.setImageUrl(imgUrl3);
                cwTO.setFloc(loc3);
                cwTO.setFcontent(content3);
                cwTO.setFdate(date3);
                res += mapper.FestivalCrawling(cwTO);
            }       
        }

        return res;
    }
}
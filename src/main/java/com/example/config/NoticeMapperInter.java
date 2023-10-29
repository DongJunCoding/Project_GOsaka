package com.example.config;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.model.NoticeTO;
import com.example.model.PassTicketTO;

public interface NoticeMapperInter {

	
	// 공지사항 쓰기
	@Insert("insert into notice values ( 0, #{image}, #{nsubject}, #{nwriter}, #{ncontent}, now(), 0, #{ip} )")
	public int noticeWrite(NoticeTO to);
	
	// 공지사항 게시판 List
	@Select("select noticeId, nsubject, nwriter, ndate, datediff(now(), ndate) ngap, nhit, ip from notice order by noticeId desc")
	public ArrayList<NoticeTO> noticeList();
	
	/* 공지사항 검색 */
	@Select("select noticeId, nsubject, nwriter, ndate, nhit, ip from notice where nsubject like concat('%', #{searchWord}, '%') order by noticeId desc")
	public ArrayList<NoticeTO> subjectSearchList(String searchWord);
	
	// 공지사항 게시판 뷰
	@Select("select noticeId, image, nsubject, nwriter, ncontent, ndate, nhit, ip from notice where noticeId=#{noticeId}")
	public NoticeTO noticeView(NoticeTO to);
	
	// 공지사항 게시판 게시글 조회수
	@Update("update notice set nhit = nhit + 1 where noticeId = #{noticeId}")
	public int noticeViewHit(NoticeTO to);
	
	// 공지사항 게시판 삭제
	@Delete("delete from notice where noticeId=#{noticeId}")
	public int noticeViewDelete(NoticeTO noticeId);
	
	// 공지사항 게시판 업로드 이미지 삭제
	@Select("select image from notice where noticeId=#{noticeId}")
	public String noticeImage(NoticeTO noticeId);
	
	// 공지사항 게시판 수정 뷰
	@Select("select noticeId, image, nsubject, nwriter, ncontent from notice where noticeId=#{noticeId}")
	public NoticeTO noticeModify(NoticeTO noticeId);
	
	// 공지사항 게시판 수정 쿼리문
	@Update("update notice set image=#{image}, nsubject=#{nsubject}, nwriter=#{nwriter}, ncontent=#{ncontent} where noticeId=#{noticeId}")
	public int noticeModify_ok(NoticeTO to);
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	/* 패스 티켓 정보 크롤링 */
	@Insert("insert into passticket values ( 0, #{ptImage}, #{ptName} )")
	public int PassTicketCrawling(PassTicketTO to);	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	/* 패스티켓 리스트 */
	@Select("select ptId, ptImage, ptName from passticket")
	public ArrayList<PassTicketTO> passticketList();

	/* List 검색 */
	@Select("select ptId, ptImage, ptName from passticket where ptName like concat('%', #{searchWord}, '%')")
	public ArrayList<PassTicketTO> searchList(String searchWord);

}

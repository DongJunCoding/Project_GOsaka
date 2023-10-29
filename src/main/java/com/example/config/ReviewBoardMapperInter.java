package com.example.config;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.model.MyPageTO;
import com.example.model.ReviewBoardTO;

public interface ReviewBoardMapperInter {
	
	// Review 게시판 쓰기
	@Insert("insert into review_board values ( 0, #{image}, #{category}, #{rvsubject}, #{rvwriter}, #{rvcontent}, now(), 0, #{ip} )")
	public int boardWrite(ReviewBoardTO to);
	
	// Review 게시판 List
	@Select("select reviewId, category, rvsubject, rvwriter, rvdate, datediff(now(), rvdate) rvgap, rvhit, ip from review_board order by reviewId desc")
	public ArrayList<ReviewBoardTO> reviewBoardList();
	
	// Review MyPage List
	@Select("select reviewId, rvsubject, rvwriter, rvdate, rvhit from review_board")
	public ArrayList<MyPageTO> myReviewBoardList();
	
	/* Review Board List 검색 + rvsubject SearchKey */
	@Select("select reviewId, category, rvsubject, rvwriter, rvdate, rvhit, ip from review_board where rvsubject like concat('%', #{searchWord}, '%') order by reviewId desc")
	public ArrayList<ReviewBoardTO> subjectSearchList(String searchWord);
	
	/* Review Board List 검색 + rvwriter SearchKey */
	@Select("select reviewId, category, rvsubject, rvwriter, rvdate, rvhit, ip from review_board where rvwriter like concat('%', #{searchWord}, '%') order by reviewId desc")
	public ArrayList<ReviewBoardTO> writerSearchList( String searchWord);
	
	/* Review Board List 검색 + rvcontent SearchKey */
	@Select("select reviewId, category, rvsubject, rvwriter, rvdate, rvhit, ip from review_board where rvcontent like concat('%', #{searchWord}, '%') order by reviewId desc")
	public ArrayList<ReviewBoardTO> contentSearchList(String searchWord);
	
	// Review 게시판 뷰
	@Select("select reviewId, image, category, rvsubject, rvwriter, rvcontent, rvdate, rvhit, ip from review_board where reviewId=#{reviewId}")
	public ReviewBoardTO reviewBoardView(ReviewBoardTO to);
	
	// Review 게시판 게시글 조회수
	@Update("update review_board set rvhit = rvhit + 1 where reviewId = #{reviewId}")
	public int reviewBoardViewHit(ReviewBoardTO to);
	
	// Review 게시판 삭제
	@Delete("delete from review_board where reviewId=#{reviewId}")
	public int reviewBoardViewDelete(ReviewBoardTO reviewId);
	
	// Review 게시판 업로드 이미지 삭제
	@Select("select image from review_board where reviewId=#{reviewId}")
	public String reviewBoardImage(ReviewBoardTO reviewId);
	
	// Review 게시판 수정 뷰
	@Select("select reviewId, image, category, rvsubject, rvwriter, rvcontent from review_board where reviewId=#{reviewId}")
	public ReviewBoardTO reviewBoardModify(ReviewBoardTO reviewId);
	
	// Review 게시판 수정 쿼리문
	@Update("update review_board set image=#{image}, category=#{category}, rvsubject=#{rvsubject}, rvwriter=#{rvwriter}, rvcontent=#{rvcontent} where reviewId=#{reviewId}")
	public int reviewBoardModify_ok(ReviewBoardTO to); 
	
}

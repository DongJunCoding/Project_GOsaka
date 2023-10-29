package com.example.config;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.model.MyPageTO;
import com.example.model.TipBoardTO;

public interface TipBoardMapperInter {
	
	// Tip 게시판 쓰기
	@Insert("insert into tip_board values ( 0, #{image}, #{tsubject}, #{twriter}, #{tcontent}, now(), 0, #{ip} )")
	public int boardWrite(TipBoardTO to);
	
	// Tip 게시판 List
	@Select("select tipId, tsubject, twriter, tdate, datediff(now(), tdate) tgap, thit, ip from tip_board order by tipId desc")
	public ArrayList<TipBoardTO> tipBoardList();
	
	// Tip MyPage List
	@Select("select tipId, tsubject, twriter, thit from tip_board")
	public ArrayList<MyPageTO> myTipBoardList();
	
	/* Tip Board List 검색 + tsubject SearchKey */
	@Select("select tipId, tsubject, twriter, tdate, thit, ip from tip_board where tsubject like concat('%', #{searchWord}, '%') order by tipId desc")
	public ArrayList<TipBoardTO> subjectSearchList(String searchWord);
	
	/* Tip Board List 검색 + twriter SearchKey */
	@Select("select tipId, tsubject, twriter, tdate, thit, ip from tip_board where twriter like concat('%', #{searchWord}, '%') order by tipId desc")
	public ArrayList<TipBoardTO> writerSearchList( String searchWord);
	
	/* Tip Board List 검색 + tcontent SearchKey */
	@Select("select tipId, tsubject, twriter, tdate, thit, ip from tip_board where tcontent like concat('%', #{searchWord}, '%') order by tipId desc")
	public ArrayList<TipBoardTO> contentSearchList(String searchWord);
	
	// Tip 게시판 뷰
	@Select("select tipId, image, tsubject, twriter, tcontent, tdate, thit, ip from tip_board where tipId=#{tipId}")
	public TipBoardTO tipBoardView(TipBoardTO to);
	
	// Tip 게시판 게시글 조회수
	@Update("update tip_board set thit = thit + 1 where tipId = #{tipId}")
	public int tipBoardViewHit(TipBoardTO to);
	
	// Tip 게시판 삭제
	@Delete("delete from tip_board where tipId=#{tipId}")
	public int tipBoardViewDelete(TipBoardTO tipId);
	
	// Tip 게시판 업로드 이미지 삭제
	@Select("select image from tip_board where tipId=#{tipId}")
	public String tipBoardImage(TipBoardTO tipId);
	
	// Tip 게시판 수정 뷰
	@Select("select tipId, image, tsubject, twriter, tcontent from tip_board where tipId=#{tipId}")
	public TipBoardTO tipBoardModify(TipBoardTO tipId);
	
	// Tip 게시판 수정 쿼리문
	@Update("update tip_board set image=#{image}, tsubject=#{tsubject}, twriter=#{twriter}, tcontent=#{tcontent} where tipId=#{tipId}")
	public int tipBoardModify_ok(TipBoardTO to); 
	
}

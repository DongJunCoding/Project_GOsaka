package com.example.config;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.model.CommentTO;

public interface CommentMapperInter {

	// Tip 게시판 댓글 리스트
	@Select("select cmId, pcmId, cwriter, ccontent, cdate from tip_comment where pcmId = #{tipId}")
	public ArrayList<CommentTO> tip_CommentList(int tipId);

	// Tip 게시판 댓글 삽입 로직
	@Insert("insert into tip_comment values(0, #{pcmId}, #{cwriter}, #{ccontent}, now() )")
	@Options(useGeneratedKeys = true, keyProperty = "cmId")
	public int tip_commentOK(CommentTO to);

	// Tip 게시판 댓글 삭제 로직
	@Delete("delete from tip_comment where pcmId=#{pcmId} and cmId=#{cmId}")
	public int tip_commentDelete(CommentTO to);

	// Tip 게시판 댓글 수정 로직
	@Update("update tip_comment set ccontent=#{ccontent} where pcmId=#{pcmId} and cmId=#{cmId}")
	public int tip_commentModify(CommentTO to);

	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	
	// Review 게시판 댓글 리스트
	@Select("select cmId, pcmId, cwriter, ccontent, cdate from review_comment where pcmId = #{reviewId}")
	public ArrayList<CommentTO> review_CommentList(int reviewId);

	// Review 게시판 댓글 삽입 로직
	@Insert("insert into review_comment values(0, #{pcmId}, #{cwriter}, #{ccontent}, now() )")
	@Options(useGeneratedKeys = true, keyProperty = "cmId")
	public int review_commentOK(CommentTO to);

	// Review 게시판 댓글 삭제 로직
	@Delete("delete from review_comment where pcmId=#{pcmId} and cmId=#{cmId}")
	public int review_commentDelete(CommentTO to);

	// Review 게시판 댓글 수정 로직
	@Update("update review_comment set ccontent=#{ccontent} where pcmId=#{pcmId} and cmId=#{cmId}")
	public int review_commentModify(CommentTO to);

	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	
	// qna 게시판 댓글 리스트
	@Select("select cmId, pcmId, cwriter, ccontent, cdate from qna_comment where pcmId = #{qnaId}")
	public ArrayList<CommentTO> qna_CommentList(int qnaId);

	// qna 게시판 댓글 삽입 로직
	@Insert("insert into qna_comment values(0, #{pcmId}, #{cwriter}, #{ccontent}, now() )")
	@Options(useGeneratedKeys = true, keyProperty = "cmId")
	public int qna_commentOK(CommentTO to);

	// qna 게시판 댓글 삭제 로직
	@Delete("delete from qna_comment where pcmId=#{pcmId} and cmId=#{cmId}")
	public int qna_commentDelete(CommentTO to);

	// qna 게시판 댓글 수정 로직
	@Update("update qna_comment set ccontent=#{ccontent} where pcmId=#{pcmId} and cmId=#{cmId}")
	public int qna_commentModify(CommentTO to);

}

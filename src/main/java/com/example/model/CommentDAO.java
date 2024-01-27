package com.example.model;

import java.util.ArrayList;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.config.CommentMapperInter;

@Repository
@MapperScan(basePackages = { "com.example.controller", "com.example.config", "com.example.model",
		"com.example.service" })
public class CommentDAO {

	@Autowired
	private CommentMapperInter mapper;

	// Tip 게시판 댓글
	public ArrayList<CommentTO> tip_CommentList(int tipId) {
		return mapper.tip_CommentList(tipId);
	}

	// Tip 게시판 댓글 쓰기
	public int tip_CommentWriteOk(CommentTO commentTO) {
		int flag = 1;
		int result = mapper.tip_commentOK(commentTO);

		if (result == 1) {
			flag = 0;
		}

		return flag;
	}

	// tip 게시판 댓글 삭제
	public int tip_commentDelete(CommentTO to) {

		int flag = 1;
		int result = mapper.tip_commentDelete(to);

		if (result == 1) {
			flag = 0;
		}

		return flag;
	}

	// tip 게시판 댓글 수정
	public int tip_commentModify(CommentTO to) {

		int flag = 1;
		int result = mapper.tip_commentModify(to);

		if (result == 1) {
			flag = 0;
		}

		return flag;
	}

	// Tip 게시판 게시글 삭제시 댓글도 같이 삭제
	public void tip_BoardCommentDelete(String tipId) {
		mapper.tip_BoardCommentDelete(tipId);
	}

	// Review 게시판 댓글
	public ArrayList<CommentTO> review_CommentList(int reviewId) {
		return mapper.review_CommentList(reviewId);
	}

	// Review 게시판 댓글 쓰기
	public int review_CommentWriteOk(CommentTO commentTO) {
		int flag = 1;
		int result = mapper.review_commentOK(commentTO);

		if (result == 1) {
			flag = 0;
		}

		return flag;
	}

	// Review 게시판 댓글 삭제
	public int review_commentDelete(CommentTO to) {

		int flag = 1;
		int result = mapper.review_commentDelete(to);

		if (result == 1) {
			flag = 0;
		}

		return flag;
	}

	// Review 게시판 댓글 수정
	public int review_commentModify(CommentTO to) {

		int flag = 1;
		int result = mapper.review_commentModify(to);

		if (result == 1) {
			flag = 0;
		}

		return flag;
	}

	// Tip 게시판 게시글 삭제시 댓글도 같이 삭제
	public void review_BoardCommentDelete(String reviewId) {
		mapper.review_BoardCommentDelete(reviewId);
	}

	// qna 게시판
	public ArrayList<CommentTO> qna_CommentList(int qnaId) {
		return mapper.qna_CommentList(qnaId);
	}

	// qna 게시판 댓글 쓰기
	public int qna_CommentWriteOk(CommentTO commentTO) {
		int flag = 1;
		int result = mapper.qna_commentOK(commentTO);

		if (result == 1) {
			flag = 0;
		}

		return flag;
	}

	// qna 게시판 댓글 삭제
	public int qna_commentDelete(CommentTO to) {

		int flag = 1;
		int result = mapper.qna_commentDelete(to);

		if (result == 1) {
			flag = 0;
		}

		return flag;
	}

	// qna 게시판 댓글 수정
	public int qna_commentModify(CommentTO to) {

		int flag = 1;
		int result = mapper.qna_commentModify(to);

		if (result == 1) {
			flag = 0;
		}

		return flag;
	}

	// qna 게시판 게시글 삭제시 댓글도 같이 삭제
	public void qna_BoardCommentDelete(String qnaId) {
		mapper.qna_BoardCommentDelete(qnaId);
	}
}

package com.example.config;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.model.MyPageTO;
import com.example.model.QnaBoardTO;

public interface QnaBoardMapperInter {
	
	// QNA 게시판 쓰기
	@Insert("insert into qna_board values ( 0, #{image}, #{qsubject}, #{qwriter}, #{qcontent}, now(), 0, #{ip} )")
	public int boardWrite(QnaBoardTO to);
	
	// QNA 게시판 List
	@Select("select qnaId, qsubject, qwriter, qdate, datediff(now(), qdate) qgap, qhit, ip from qna_board order by qnaId desc")
	public ArrayList<QnaBoardTO> qnaBoardList();
	
	// QNA MyPage List
	@Select("select qnaId, qsubject, qwriter, qdate, qhit from qna_board")
	public ArrayList<MyPageTO> myQnaBoardList();
	
	/* QNA Board List 검색 + qsubject SearchKey */
	@Select("select qnaId, qsubject, qwriter, qdate, qhit, ip from qna_board where qsubject like concat('%', #{searchWord}, '%') order by qnaId desc")
	public ArrayList<QnaBoardTO> subjectSearchList(String searchWord);
	
	/* QNA Board List 검색 + qwriter SearchKey */
	@Select("select qnaId, qsubject, qwriter, qdate, qhit, ip from qna_board where qwriter like concat('%', #{searchWord}, '%') order by qnaId desc")
	public ArrayList<QnaBoardTO> writerSearchList( String searchWord);
	
	/* QNA Board List 검색 + qcontent SearchKey */
	@Select("select qnaId, qsubject, qwriter, qdate, qhit, ip from qna_board where qcontent like concat('%', #{searchWord}, '%') order by qnaId desc")
	public ArrayList<QnaBoardTO> contentSearchList(String searchWord);
	
	// QNA 게시판 뷰
	@Select("select qnaId, image, qsubject, qwriter, qcontent, qdate, qhit, ip from qna_board where qnaId=#{qnaId}")
	public QnaBoardTO qnaBoardView(QnaBoardTO to);
	
	// QNA 게시판 게시글 조회수
	@Update("update qna_board set qhit = qhit + 1 where qnaId = #{qnaId}")
	public int qnaBoardViewHit(QnaBoardTO to);
	
	// QNA 게시판 삭제
	@Delete("delete from qna_board where qnaId=#{qnaId}")
	public int qnaBoardViewDelete(QnaBoardTO qnaId);
	
	// QNA 게시판 업로드 이미지 삭제
	@Select("select image from qna_board where qnaId=#{qnaId}")
	public String qnaBoardImage(QnaBoardTO qnaId);
	
	// QNA 게시판 수정 뷰
	@Select("select qnaId, image, qsubject, qwriter, qcontent from qna_board where qnaId=#{qnaId}")
	public QnaBoardTO qnaBoardModify(QnaBoardTO qnaId);
	
	// QNA 게시판 수정 쿼리문
	@Update("update qna_board set image=#{image}, qsubject=#{qsubject}, qwriter=#{qwriter}, qcontent=#{qcontent} where qnaId=#{qnaId}")
	public int qnaBoardModify_ok(QnaBoardTO to); 
	
}

package com.example.model;

import java.util.ArrayList;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PageListTO {
	private int cpage; // 페이지 번호
	private int recordPerPage; // 한 페이지의 데이터 개수
	private int blockPerPage; // 한 페이지에서 보일 페이지 개수 ( ex : < 1 2 3 4 5 > 이면 5로 설정된 것)
	private int totalPage; // 전체 페이지
	private int totalRecord; // 전체 데이터
	private int startBlock;
	private int endBlock; 

	public PageListTO() {
		this.cpage = 1;
		this.recordPerPage = 9;
		this.blockPerPage = 5;
		this.totalPage = 1;
		this.totalRecord = 0;

	}

	private ArrayList<OsakaAreaTO> pageList;
	private ArrayList<ShoppingTO> shoppingPageList;
	private ArrayList<RestaurantTO> restaurantPageList;
	private ArrayList<TipBoardTO> tipBoardPageList;
	private ArrayList<ReviewBoardTO> reviewBoardPageList;
	private ArrayList<QnaBoardTO> qnaBoardPageList;
	private ArrayList<PassTicketTO> passticketPageList;
	private ArrayList<NoticeTO> noticePageList;
}

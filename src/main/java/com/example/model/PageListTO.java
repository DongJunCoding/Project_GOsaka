package com.example.model;

import java.util.ArrayList;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PageListTO {
	private int cpage;
	private int recordPerPage;
	private int blockPerPage;
	private int totalPage;
	private int totalRecord;
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

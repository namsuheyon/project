package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	private long rno;
	private long bno;
	private long parent_rno;
	private long child_bool;
	
	private String reply;	
	private String replyer;
	private Date replyDate;
	private Date updateDate;
}

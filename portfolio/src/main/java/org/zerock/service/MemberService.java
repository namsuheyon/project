package org.zerock.service;

import org.zerock.domain.MemberVO;

public interface MemberService {
	public void join(MemberVO member);
	public boolean checkId(String userid);
}
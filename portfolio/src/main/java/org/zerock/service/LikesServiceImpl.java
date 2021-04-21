package org.zerock.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.LikesDTO;
import org.zerock.mapper.LikesMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class LikesServiceImpl implements LikesService {
	
	@Setter(onMethod_ = @Autowired)
	private LikesMapper mapper;
	@Override
	public int likesUpdate(LikesDTO likes) {
		log.info("likes update");
		int check = mapper.check(likes);
		if(check  == 0){ // 추천하지 않았다면 추천 추가
			mapper.update(likes);
		}else{ // 추천을 하였다면 추천 삭제
			mapper.delete(likes);
		}
		mapper.updatecount(likes);
		return check;
		
	}
	@Override
	public int likesCount(Long bno) {
		log.info("likes count");
		return mapper.count(bno);
	}
}

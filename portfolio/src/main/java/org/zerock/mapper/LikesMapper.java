package org.zerock.mapper;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.LikesDTO;

public interface LikesMapper {
	public int count(Long bno);
	public void update(@Param("likes")LikesDTO likes);
	public int check(@Param("likes")LikesDTO likes);
	public void delete(@Param("likes")LikesDTO likes);
	public void updatecount(@Param("likes")LikesDTO likes);
	
}

package org.zerock.service;

import org.zerock.domain.LikesDTO;

public interface LikesService {
	public int likesUpdate(LikesDTO likes);

	public int likesCount(Long bno);
}

package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ReplyServiceImpl implements ReplyService {
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;	// spring 4.3이상에서 자동 처리 -> 생성자가 만들어짐
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;	
	
	@Transactional
	@Override
	public int register(ReplyVO vo) {
		log.info("register..." + vo);
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		log.info("get..." + rno);
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		log.info("modify..." + vo);
		return mapper.update(vo);
	}
	
	@Transactional
	@Override
	public int remove(Long rno) {
		log.info("remove..." + rno);
		ReplyVO vo = mapper.read(rno);
		mapper.delete_child(rno);
		mapper.delete(rno);
		return boardMapper.deleteUpdateReplyCnt(vo.getBno());
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		log.info("get Reply  List of a Board " + bno);
		return mapper.getListWithPaging(cri, bno);
	}

	  @Override
	  public ReplyPageDTO getListPage(Criteria cri, Long bno) {
	       
	    return new ReplyPageDTO(
	        mapper.getCountByBno(bno), 
	        mapper.getListWithPaging(cri, bno));
	  }

	  @Transactional
	  @Override
		public int addreply(ReplyVO vo) {

			log.info("addreply..." + vo);
			boardMapper.updateReplyCnt(vo.getBno(), 1);
			mapper.child_bool(vo);
			return mapper.insertreply(vo);
		}
	
}

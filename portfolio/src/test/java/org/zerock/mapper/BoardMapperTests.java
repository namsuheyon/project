package org.zerock.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Test
	public void testGetList() {
		mapper.getList().forEach(board -> log.info(board));
	}
	@Test
	public void testInsert() {
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글");
		board.setContent("새로 작성하는 내용");
		board.setWriter("newbie");
		mapper.insert(board);
		log.info(board);
	}
	
	@Test
	public void testInsertSelectKey() {
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글");
		board.setContent("새로 작성하는 내용");
		board.setWriter("newbie");
		mapper.insertSelectKey(board);
		log.info(board);
	}
	@Test
	public void testRead() {
		// 존재하는 게시물 번호로 테스트
		BoardVO board = mapper.read(22L);
		log.info(board);
	}
	@Test
	public void testDelete() {
		// 존재하는 게시물 번호로 테스트
		int result = mapper.delete(27L);
		log.info("게시물 삭제 : " + result);
	}
	@Test
	public void testUpdate() {
		// 존재하는 게시물 번호로 테스트
		BoardVO board = new BoardVO();
		board.setBno(26L);
		board.setTitle("새로 작성하는 글");
		board.setContent("새로 작성하는 내용 수정");
		board.setWriter("newbie");
		int count = mapper.update(board);
		log.info("Update Count : " + count);
	}


}

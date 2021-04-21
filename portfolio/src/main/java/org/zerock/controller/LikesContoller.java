package org.zerock.controller;

import org.junit.runners.Parameterized.Parameters;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.domain.LikesDTO;
import org.zerock.service.LikesService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/likes/*")
@AllArgsConstructor
public class LikesContoller {
	
	private LikesService service;
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/update", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<Integer> likesupdate(Long bno, String username) {
		log.info("bno :"+ bno + " username :"+ username);
		LikesDTO likes = new LikesDTO(bno,username);
		return new ResponseEntity<Integer>(service.likesUpdate(likes) , HttpStatus.OK);
		
	}
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/count", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<Integer> likescount(Long bno) {
		log.info("controller count");
		return new ResponseEntity<Integer>(service.likesCount(bno) , HttpStatus.OK);
		
	}
}

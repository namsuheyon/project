package org.zerock.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class LikesDTO {

  private Long bno;
  private String username ;
}

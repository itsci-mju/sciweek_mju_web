package model;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ReviewerResponse {

	private String reviewerName;
	
	private String status;
	
	private Double score = 0.0 ;
	
	private String comments;
	
}

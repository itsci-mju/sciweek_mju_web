package model;

import java.sql.Timestamp;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ProjectResponse {
	
	private String projectID;

	private String projectName;
	
	private Integer stateProject;
	
	private Timestamp reviewDate;
	
	private Timestamp endDate;
	
	private List<ReviewerResponse> reviewerResponseList;
	
	private Double totalScore;
	
}

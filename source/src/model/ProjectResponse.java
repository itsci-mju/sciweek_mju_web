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
	
	private Integer statusProject;
	
	private String awardProject;
	
	private Timestamp reviewDate;
	
	private List<ReviewerResponse> reviewerResponseList;
	
	private Double totalScore;

}

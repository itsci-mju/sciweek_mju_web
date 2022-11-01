package model;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class StudentProjectResponse {
	
	private String projectID;

	private String projectName;
	
	private String schoolName;
	
	private Double AVGscore ;
	
	private String awardProject;
	
	private List<StudentResponse> studentResponseList;
	
	private String advisorName;
	
}

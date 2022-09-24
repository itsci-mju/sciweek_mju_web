package bean;

import lombok.AllArgsConstructor;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor

public class StudentProject {
	
	private Student student;
	private Project project;
	private Advisor advisor;
	
	
}




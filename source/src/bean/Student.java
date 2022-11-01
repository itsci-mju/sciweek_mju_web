package bean;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Student {

	private int student_id;
	private String prefix;
	private String firstname;
	private String lastname;
	private String grade;
	private String mobileno;
	private String email;
	private String password;

	private School school;
	
	private Project project;

}

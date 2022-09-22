package bean;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Reviewer {

	private int reviewer_id;
	private String prefix;
	private String firstname;
	private String lastname;
	private String faculty;
	private String major;
	private String position;
	private String line;
	private String facebook;
	private String email;
	private String password;
	
	private Team team;

}

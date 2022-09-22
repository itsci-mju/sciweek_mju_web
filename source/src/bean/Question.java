package bean;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Question {
	
	public Question(int questionId) {
		this.question_id = questionId;
	}
	private int question_id ;
	private String question ;
	private int fullscore;

}

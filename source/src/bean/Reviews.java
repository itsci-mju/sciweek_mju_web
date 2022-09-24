package bean;

import java.sql.Timestamp;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Reviews {

	private String reviews_id;
	private Timestamp reviewdate;
	private Timestamp enddate;
	private String comments;
	private double totalscore;
	private String status;

	private Reviewer reviewer;
	private Project project;

	private List<Answer> listanswer;

}

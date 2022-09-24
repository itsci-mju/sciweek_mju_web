package bean;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Project {

	private String project_id;
	private String projectname;
	private String video;
	private String award;
	private Double avgscore;

	private ProjectType projecttype;
	private Team team;

	public Project(String id) {
		this.project_id = id;
	}

}

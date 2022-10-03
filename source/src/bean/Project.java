package bean;

import java.sql.Timestamp;

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
	private Timestamp importdate ;
	private String projectname;
	private String video;
	private String award;
	private Double avgscore;
	private Integer state_project = 1 ;
	
	// 1 คือ รอการประเมิน
	// 2 คือ ผ่านรอบแรก
	// 3 คือ ผ่านรอบสอง
	// 4 คือ ไม่ผ่านรอบแรก
	// 5 คือ ไม่ผ่านรอบสอง

	private ProjectType projecttype;
	private Team team;

	public Project(String id) {
		this.project_id = id;
	}

}

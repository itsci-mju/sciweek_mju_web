package bean;

import java.util.List;

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
	
	private Integer status_project = 0 ;
	
	// 0 คือ ยังไม่ประกาศ
	// 1 คือ ประกาศ
	
	private Integer state_project = 1 ;
	
	// 1 คือ รอการประเมิน
	// 2 คือ ผ่านรอบแรก
	// 3 คือ ผ่านรอบสอง
	// 4 คือ ไม่ผ่านการประเมิน

	private ProjectType projecttype;
	
	private Advisor advisor;
	
	private Report report;
	
	private List<Student> studentList;

	public Project(String id) {
		this.project_id = id;
	}

	public Project(String project_id2, String projectname2, String video2, String award2, String avgscore2,
			int status_project2, int state_project2) {
		// TODO Auto-generated constructor stub
	}

}

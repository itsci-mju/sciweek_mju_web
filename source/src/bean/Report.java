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
public class Report {
	
	private int report_id ;
	private String reportname;
	private Timestamp uploaddate;
	
	private Project project;

}

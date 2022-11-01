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
public class Schedules {
	
	private Integer years;
	private Timestamp uploaddate;
	private Timestamp expuploaddate;
	private Timestamp reviewdate;
	private Timestamp expreviewdate;
	private Timestamp announcedate;

}

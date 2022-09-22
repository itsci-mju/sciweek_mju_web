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
public class Pressrelease {
	
	private int newsid;
	private String type;
	private String title;
	private String detail;

	private Timestamp createdate;

}

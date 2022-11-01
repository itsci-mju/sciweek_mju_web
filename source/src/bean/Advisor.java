package bean;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Advisor {
	
	private int advisor_id ;
	private String prefix;
	private String firstname ;
	private String lastname ;
	private String email;
	private String mobileno;
	
}

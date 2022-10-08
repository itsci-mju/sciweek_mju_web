package manager;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import bean.Years;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class CreateScheduleManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();
	
	public boolean isCreateSchedule(Years years) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Boolean result = false;

		try {
			CallableStatement stmt = con.prepareCall("{call isCreateSchedule(?,?,?,?,?,?)}");
			stmt.setInt(1, years.getYears());
			stmt.setTimestamp(2, years.getUploaddate());
			stmt.setTimestamp(3, years.getExpuploaddate());
			stmt.setTimestamp(4, years.getReviewdate());
			stmt.setTimestamp(5, years.getExpreviewdate());
			stmt.setTimestamp(6, years.getAnnouncedate());
			stmt.execute();

			result = true;
			con.close();
			stmt.close();
		} catch (SQLException er) {
			er.printStackTrace();
		}
		return result;
	}

}

package manager;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import bean.Schedules;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class CreateScheduleManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();
	
	public boolean isCreateSchedule(Schedules schedules) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Boolean result = false;

		try {
			CallableStatement stmt = con.prepareCall("{call isCreateSchedule(?,?,?,?,?,?)}");
			stmt.setInt(1, schedules.getYears());
			stmt.setTimestamp(2, schedules.getUploaddate());
			stmt.setTimestamp(3, schedules.getExpuploaddate());
			stmt.setTimestamp(4, schedules.getReviewdate());
			stmt.setTimestamp(5, schedules.getExpreviewdate());
			stmt.setTimestamp(6, schedules.getAnnouncedate());
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

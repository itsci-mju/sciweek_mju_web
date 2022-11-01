package manager;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.Schedules;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class ViewScheduleDetailManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();
	
	public Schedules getSchedulesByID(Integer yearsTemp) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		Schedules schedules = new Schedules ();
		
		try {

			stmt = con.createStatement();
			String sql = "SELECT * FROM schedules WHERE years = '"+ yearsTemp +"' ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
							
				schedules = resultSetToClass.setResultSetToSchedules(rs);
									
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return schedules;
	}
	
	public boolean isEditSchedule(Schedules schedules) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Boolean result = false;

		try {

			CallableStatement stmt = con.prepareCall("{call isEditSchedule(?,?,?,?,?,?)}");
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

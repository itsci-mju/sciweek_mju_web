package manager;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.Years;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class ViewScheduleDetailManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();
	
	public Years getYearsByID(Integer yearsTemp) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		Years years = new Years ();
		
		try {

			stmt = con.createStatement();
			String sql = "SELECT * FROM years WHERE years = '"+ yearsTemp +"' ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
							
				years = resultSetToClass.setResultSetToYear(rs);
									
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return years;
	}
	
	public boolean isEditSchedule(Years years) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Boolean result = false;

		try {

			CallableStatement stmt = con.prepareCall("{call isEditSchedule(?,?,?,?,?,?)}");
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

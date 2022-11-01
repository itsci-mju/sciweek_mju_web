package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import bean.Schedules;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class ListScheduleManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();
	
	public List<Schedules> getListSchedules() throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<Schedules> schedulesList = new Vector<>();
		
		try {
			stmt = con.createStatement();
			String sql = "SELECT * FROM schedules ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {	
				
				schedulesList.add(resultSetToClass.setResultSetToSchedules(rs));
		
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return schedulesList;
	}

}

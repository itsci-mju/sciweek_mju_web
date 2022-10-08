package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import bean.Years;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class ListScheduleManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();
	
	public List<Years> getListYears() throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<Years> yearsList = new Vector<>();
		
		try {
			stmt = con.createStatement();
			String sql = "SELECT * FROM years ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {	
				
				yearsList.add(resultSetToClass.setResultSetToYear(rs));
		
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return yearsList;
	}

}

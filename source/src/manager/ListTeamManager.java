package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import bean.ProjectType;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class ListTeamManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();
	
	public List<ProjectType> getListProjectType() throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<ProjectType> projectTypeList = new Vector<>();
		
		try {
			stmt = con.createStatement();
			String sql = "SELECT * FROM projecttype ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {	
	
			projectTypeList.add(resultSetToClass.setResultSetToProjectType(rs));
				
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return projectTypeList;
	}
	
}

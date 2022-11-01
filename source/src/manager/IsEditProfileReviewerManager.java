package manager;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.ProjectType;
import bean.Reviewer;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class IsEditProfileReviewerManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();
	
	public ProjectType getTeamByID(Integer key) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		ProjectType projecttype = new ProjectType();
		
		try {

			stmt = con.createStatement();
			String sql = "SELECT * FROM projecttype WHERE projecttype_id like '"+ key +"'";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
						
				projecttype = resultSetToClass.setResultSetToProjectType(rs);

			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return projecttype;
	}

	public boolean isEditProfileReviewer(Reviewer reviewer) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Boolean result = false;

		try {

			CallableStatement stmt = con.prepareCall("{call isEditProfileReviewer(?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmt.setInt(1, reviewer.getReviewer_id());
			stmt.setString(2, reviewer.getPrefix());
			stmt.setString(3, reviewer.getFirstname());
			stmt.setString(4, reviewer.getLastname());
			stmt.setString(5, reviewer.getFaculty());
			stmt.setString(6, reviewer.getMajor());
			stmt.setString(7, reviewer.getPosition());
			stmt.setString(8, reviewer.getLine());
			stmt.setString(9, reviewer.getFacebook());
			stmt.setString(10, reviewer.getEmail());
			stmt.setString(11, reviewer.getPassword());
			stmt.setInt(12, reviewer.getProjecttype() != null ? reviewer.getProjecttype().getProjecttype_id() : 0 );
			
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

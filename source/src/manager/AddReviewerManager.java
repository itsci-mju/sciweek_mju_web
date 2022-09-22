package manager;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import bean.Reviewer;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class AddReviewerManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();

	public int getMaxReviewer() {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;

		int result = 0;
		try {
			stmt = con.createStatement();
			String sql = "Select MAX(reviewer_id) from reviewer";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				int id = rs.getInt(1)+1;
				result = id;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;

	}
	
	public List<Reviewer> getListReviewer() throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<Reviewer> listreviewer = new Vector<>();
		
		try {
			stmt = con.createStatement();
			String sql = "SELECT * FROM reviewer LEFT JOIN team on  reviewer.team_id = team.team_id" ;
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {	
					
			listreviewer.add(resultSetToClass.setResultSetToReviewer(rs));

			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return listreviewer;
	}

	public boolean isAddReviewer(Reviewer reviewer) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Boolean result = false;

		try {
			CallableStatement stmt = con.prepareCall("{call isAddReviewer(?,?,?,?,?,?,?,?,?,?,?)}");
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

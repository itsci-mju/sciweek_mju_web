package manager;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.Reviewer;
import bean.Team;
import util.ConnectionDB;

public class IsEditProfileReviewerManager {

	public IsEditProfileReviewerManager() {
		// TODO Auto-generated constructor stub
	}
	
	public Team getTeamByID(Integer key) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		Team team = new Team();
		
		try {

			stmt = con.createStatement();
			String sql = "SELECT * FROM team WHERE team_id like '"+ key +"'";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
						
				team.setTeam_id(rs.getInt("team_id"));
				team.setTeam_name(rs.getString("team_name"));			

			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return team;
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
			stmt.setInt(12, reviewer.getTeam() != null ? reviewer.getTeam().getTeam_id() : 0 );
			
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

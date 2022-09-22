package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.Reviewer;
import bean.Team;
import util.ConnectionDB;

public class ViewReviewerDetailManager {

	public Reviewer getReviewerByID(Integer key) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		Reviewer reviewer = new Reviewer();
		Team team = new Team();

		try {

			stmt = con.createStatement();
			String sql = "SELECT * FROM reviewer LEFT JOIN team ON reviewer.team_id = team.team_id"
					+ " WHERE reviewer.reviewer_id like '" + key + "'";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
			
				reviewer.setReviewer_id(rs.getInt("reviewer.reviewer_id"));
				reviewer.setPrefix(rs.getString("reviewer.prefix"));
				reviewer.setFirstname(rs.getString("reviewer.firstname"));
				reviewer.setLastname(rs.getString("reviewer.lastname"));
				reviewer.setFaculty(rs.getString("reviewer.faculty"));
				reviewer.setMajor(rs.getString("reviewer.major"));
				reviewer.setPosition(rs.getString("reviewer.position"));
				reviewer.setLine(rs.getString("reviewer.line"));
				reviewer.setFacebook(rs.getString("reviewer.facebook"));
				reviewer.setEmail(rs.getString("reviewer.email"));
				reviewer.setPassword(rs.getString("reviewer.password"));

				team.setTeam_id(rs.getInt("team.team_id"));
				team.setTeam_name(rs.getString("team.team_name"));

				reviewer.setTeam(team);

			}
			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return reviewer;
	}

}

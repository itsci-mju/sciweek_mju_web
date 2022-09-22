package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import bean.Team;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class ListTeamManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();
	
	public List<Team> getListTeam() {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<Team> listteam = new Vector<>();
		
		try {
			stmt = con.createStatement();
			String sql = "SELECT * FROM team ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {	
				Team team = new Team();
				team.setTeam_id(rs.getInt("team_id"));
				team.setTeam_name(rs.getString("team_name"));	
			
				listteam.add(team);
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return listteam;
	}
	
}

package manager;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import bean.Reviewer;
import bean.Project;
import bean.Team;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class ViewTeamDetailManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();
	
	public List<Project> getListProject() throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<Project> listproject = new Vector<>();

		try {
			stmt = con.createStatement();
			String sql = " SELECT * FROM project"	
					+ "  LEFT JOIN projecttype ON project.projecttype_id = projecttype.projecttype_id  "
					+ "  LEFT JOIN team ON project.team_id = team.team_id  "
					+ "  ORDER BY project.project_id ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				
				listproject.add(resultSetToClass.setResultSetToProject(rs));
				
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return listproject;
	}
	
	public List<Reviewer> getListReviewer() throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<Reviewer> listreviewer = new Vector<>();
		
		try {
			stmt = con.createStatement();
			String sql = "SELECT * FROM reviewer "
					+ "LEFT JOIN team ON reviewer.team_id = team.team_id";
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

	public Team getTeamByID(Integer key) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		Team team = new Team ();
		
		try {

			stmt = con.createStatement();
			String sql = "SELECT * FROM team WHERE team_id like '"+ key +"' ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
							
				team.setTeam_id(rs.getInt("team.team_id"));
				team.setTeam_name(rs.getString("team.team_name"));
									
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
	
	public List<Reviewer> getListReviewerByTeamID(Integer key) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<Reviewer> listreviewer = new Vector<>();
		try {
			stmt = con.createStatement();
			String sql = " SELECT * FROM reviewer "
					+ " LEFT JOIN team ON reviewer.team_id = team.team_id"
					+ " WHERE reviewer.team_id like "+ key +" ";
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
	
	public List<Project> getListProjectByTeamID(Integer key) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<Project> listproject = new Vector<>();
		
		try {
			stmt = con.createStatement();
			String sql = " SELECT * FROM project "
					+ " LEFT JOIN projecttype ON project.projecttype_id = projecttype.projecttype_id"
					+ " LEFT JOIN team ON project.team_id = team.team_id"
					+ " WHERE project.team_id like "+ key +" ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				listproject.add(resultSetToClass.setResultSetToProject(rs));
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return listproject;
	}
	
	public boolean isDeleteReviewerByTeamID(Integer team_id) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		boolean result = false;
	
			try {
				CallableStatement stmt = con.prepareCall("{call isDeleteReviewerByTeamID(?)}");
				stmt.setInt(1, team_id);
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

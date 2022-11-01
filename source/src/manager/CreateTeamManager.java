//package manager;
//
//import java.sql.CallableStatement;
//import java.sql.Connection;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.sql.Statement;
//import java.util.List;
//import java.util.Vector;
//
//import bean.ProjectType;
//import bean.Team;
//import resultset.ResultSetToClass;
//import util.ConnectionDB;
//
//public class CreateTeamManager {
//	
//	ResultSetToClass resultSetToClass = new ResultSetToClass();
//	
//	public int getMaxTeam() {
//		ConnectionDB condb = new ConnectionDB();
//		Connection con = condb.getConnection();
//		Statement stmt = null;
//
//		int result = 0;
//		try {
//			stmt = con.createStatement();
//			String sql = "Select MAX(team_id) from team";
//			ResultSet rs = stmt.executeQuery(sql);
//
//			while (rs.next()) {
//				int team_id = rs.getInt(1)+1;
//				result = team_id;
//			}
//
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//
//		return result;
//
//	}
//	
//	public List<Team> getListTeam() throws Exception {
//
//		ConnectionDB condb = new ConnectionDB();
//		Connection con = condb.getConnection();
//		Statement stmt = null;
//
//		List<Team> listTeam = new Vector<>();
//		try {
//
//			stmt = con.createStatement();
//			String sql = " SELECT * FROM team;";
//
//			ResultSet rs = stmt.executeQuery(sql);
//
//			while (rs.next()) {
//				listTeam.add(resultSetToClass.setResultSetToTeam(rs));
//			}
//
//			con.close();
//			stmt.close();
//			rs.close();
//		} catch (SQLException e) {
//			System.out.println("catch");
//			e.printStackTrace();
//		}
//
//		return listTeam;
//	}
//	
//	public List<ProjectType> getListProjectType() throws Exception {
//
//		ConnectionDB condb = new ConnectionDB();
//		Connection con = condb.getConnection();
//		Statement stmt = null;
//
//		List<ProjectType> projectTypeList = new Vector<>();
//		try {
//
//			stmt = con.createStatement();
//			String sql = " SELECT * FROM projecttype;";
//
//			ResultSet rs = stmt.executeQuery(sql);
//
//			while (rs.next()) {
//				projectTypeList.add(resultSetToClass.setResultSetToProjectType(rs));
//			}
//
//			con.close();
//			stmt.close();
//			rs.close();
//		} catch (SQLException e) {
//			System.out.println("catch");
//			e.printStackTrace();
//		}
//
//		return projectTypeList;
//	}
//	
//
//	public boolean isCreateTeam(Team team) {
//		ConnectionDB condb = new ConnectionDB();
//		Connection conn = condb.getConnection();
//		Boolean result = false;
//
//		try {
//			CallableStatement stmt = conn.prepareCall("{call isCreateTeam(?,?)}");
//			stmt.setInt(1, team.getTeam_id());
//			stmt.setString(2, team.getTeam_name());
//			
//			stmt.execute();
//
//			result = true;
//			conn.close();
//			stmt.close();
//		} catch (SQLException er) {
//			er.printStackTrace();
//		}
//		return result;
//	}
//
//}

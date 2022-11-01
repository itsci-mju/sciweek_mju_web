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
//import bean.Project;
//import resultset.ResultSetToClass;
//import util.ConnectionDB;
//
//public class AssignProjectManager {
//	
//	ResultSetToClass resultSetToClass = new ResultSetToClass();
//
//	public List<Project> getListProject() throws Exception {
//		ConnectionDB condb = new ConnectionDB();
//		Connection con = condb.getConnection();
//		Statement stmt = null;
//		List<Project> listproject = new Vector<>();
//
//		try {
//			stmt = con.createStatement();
//			String sql = " SELECT * FROM project"	
//					+ "  LEFT JOIN projecttype ON project.projecttype_id = projecttype.projecttype_id  "
//					+ "  LEFT JOIN team ON project.team_id = team.team_id  "
//					+ "  ORDER BY project.project_id ";
//			ResultSet rs = stmt.executeQuery(sql);
//
//			while (rs.next()) {
//				
//				listproject.add(resultSetToClass.setResultSetToProject(rs));
//				
//			}
//
//			con.close();
//			stmt.close();
//			rs.close();
//		} catch (SQLException e) {
//			System.out.println("catch");
//			e.printStackTrace();
//		}
//		return listproject;
//	}
//	
//	public boolean isAssignProject(Project project,Connection conn) {
//
//		Boolean result = false;
//
//		try {
//			CallableStatement stmt = conn.prepareCall("{call isAssignProject(?,?)}");
//			stmt.setString(1, project.getProject_id());
//			stmt.setInt(2,project.getTeam() != null ? project.getTeam().getTeam_id() : 0);
//			
//			stmt.execute();
//			result = true;
//			  
//			stmt.close();
//		} catch (SQLException er) {
//			er.printStackTrace();
//		}
//		return result;
//	}
//
//}

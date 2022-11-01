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
//import bean.Reviewer;
//import resultset.ResultSetToClass;
//import util.ConnectionDB;
//
//public class AssignReviewerManager {
//	
//	ResultSetToClass resultSetToClass = new ResultSetToClass();
//	
//	public List<Reviewer> getListReviewer() throws Exception {
//		ConnectionDB condb = new ConnectionDB();
//		Connection con = condb.getConnection();
//		Statement stmt = null;
//		List<Reviewer> listreviewer = new Vector<>();
//		
//		try {
//			stmt = con.createStatement();
//			String sql = "SELECT * FROM reviewer LEFT JOIN team on reviewer.team_id = team.team_id";
//			ResultSet rs = stmt.executeQuery(sql);
//
//			while (rs.next()) {
//				listreviewer.add(resultSetToClass.setResultSetToReviewer(rs));
//			}
//
//			con.close();
//			stmt.close();
//			rs.close();
//		} catch (SQLException e) {
//			System.out.println("catch");
//			e.printStackTrace();
//		}
//		return listreviewer;
//	}
//	
//	public boolean isAssignReviewer(Reviewer reviewer,Connection conn) {
//
//		Boolean result = false;
//
//		try {
//			CallableStatement stmt = conn.prepareCall("{call isAssignReviewer(?,?)}");
//			stmt.setInt(1, reviewer.getReviewer_id());
//			stmt.setInt(2,reviewer.getTeam() != null ? reviewer.getTeam().getTeam_id() : 0);
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

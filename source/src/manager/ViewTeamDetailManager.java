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
import bean.ProjectType;
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
					+ "  LEFT JOIN advisor ON project.advisor_id = advisor.advisor_id "
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
	
	public List<Project> getListProjectByProjectTypeName(String projecttype_name) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<Project> listproject = new Vector<>();

		try {
			stmt = con.createStatement();
			String sql = " SELECT * FROM project"	
					+ "  LEFT JOIN projecttype ON project.projecttype_id = projecttype.projecttype_id  "
					+ "  LEFT JOIN advisor ON project.advisor_id = advisor.advisor_id "
					+ "  WHERE project.projecttype_name like '"+ projecttype_name +"' "
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
					+ "  LEFT JOIN projecttype ON reviewer.projecttype_id = projecttype.projecttype_id";
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

	public ProjectType getTeamByID(Integer key) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		ProjectType projecttype = new ProjectType ();
		
		try {

			stmt = con.createStatement();
			String sql = "SELECT * FROM projecttype WHERE projecttype_id like '"+ key +"' ";
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
	
	public List<Reviewer> getListReviewerByTeamID(Integer key) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<Reviewer> listreviewer = new Vector<>();
		try {
			stmt = con.createStatement();
			String sql = " SELECT * FROM reviewer "
					+ " LEFT JOIN projecttype ON reviewer.projecttype_id = projecttype.projecttype_id"
					+ " WHERE reviewer.projecttype_id like "+ key +" ";
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
	
	public List<Project> getListProjectByTeamID(Integer projecttype_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<Project> listproject = new Vector<>();
		
		try {
			stmt = con.createStatement();
			String sql = " SELECT * FROM project "
					+ " LEFT JOIN projecttype ON project.projecttype_id = projecttype.projecttype_id"
					+ " LEFT JOIN advisor ON project.advisor_id = advisor.advisor_id"
					+ " WHERE project.projecttype_id = "+ projecttype_id +" ";
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
	
	public boolean isDeleteReviewerByTeamID(Integer projecttype_id,Integer reviewer_id) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		boolean result = false;
	
			try {
				CallableStatement stmt = con.prepareCall("{call isDeleteReviewerByTeamID(?,?)}");
				stmt.setInt(1, projecttype_id);
				stmt.setInt(2, reviewer_id);
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

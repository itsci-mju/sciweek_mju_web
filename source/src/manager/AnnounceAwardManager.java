package manager;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import bean.Project;
import bean.ProjectType;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class AnnounceAwardManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();
	
	public List<Project> getListProject() throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<Project> listproject = new Vector<>();

		try {
			stmt = con.createStatement();
			String sql = " SELECT * FROM project"
					+ " LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id "
					+ "  LEFT JOIN advisor on project.advisor_id = advisor.advisor_id  "
					+ " WHERE project.award LIKE 'รางวัล%' AND project.status_project = 0"
					+ " ORDER BY project.projecttype_id ASC , project.award ASC";
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
	
	public List<ProjectType> getlistProjectType() throws Exception {

		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;

		List<ProjectType> listProjectType = new Vector<>();
		try {

			stmt = con.createStatement();
			String sql = " SELECT * FROM projecttype ";

			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
			
				listProjectType.add(resultSetToClass.setResultSetToProjectType(rs));
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}

		return listProjectType;
	}
	
	public List<Project> getListProjectByProjecttypeID(Integer projecttype_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<Project> listproject = new Vector<>();

		try {
			stmt = con.createStatement();
			String sql = " SELECT * FROM project"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN advisor on project.advisor_id = advisor.advisor_id  "
					+ "  WHERE project.award LIKE 'รางวัล%' AND project.status_project = 0 AND project.projecttype_id = '"+ projecttype_id +"' "
					+ "  ORDER BY project.award ASC ";
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
	
	public boolean isUpdateAward(Project project) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		boolean result = false;
	
			try {
				CallableStatement stmt = con.prepareCall("{call isUpdateAward(?)}");
				stmt.setString(1, project.getProject_id());
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

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
import bean.StudentProject;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class AnnounceResultManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();
	
	public List<StudentProject> getListStudentProjectByProjectID(String project_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<StudentProject> listsproject = new Vector<>();

		try {
			stmt = con.createStatement();
			String sql = " SELECT * " + "  FROM studentproject"
					+ "  LEFT JOIN project on  studentproject.project_id = project.project_id"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN team on project.team_id = team.team_id"
					+ "  LEFT JOIN student on studentproject.student_id = student.student_id"
					+ "  LEFT JOIN school on student.school_id = school.school_id"
					+ "  LEFT JOIN advisor on studentproject.advisor_id = advisor.advisor_id  "
					+ "  WHERE studentproject.project_id like '" + project_id + "' "
					+ "  GROUP BY project.project_id ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				listsproject.add(resultSetToClass.setResultSetToStudentProject(rs));
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return listsproject;
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
	
	public List<Project> getListProject() throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<Project> listproject = new Vector<>();

		try {
			stmt = con.createStatement();
			String sql = " SELECT * FROM project"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN team on project.team_id = team.team_id "
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

	
	public List<Project> getListProjectByClassprojectAndProjecttypeID(String classproject, String projecttype_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<Project> listproject = new Vector<>();

		try {
			stmt = con.createStatement();
			String sql = " SELECT * FROM project"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN team on project.team_id = team.team_id "
					+ "  WHERE project.classproject = '"+ classproject +"' AND project.projecttype_id = '"+ projecttype_id +"' "
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
	
	public boolean isUpdateAward(String project_id,String award) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		boolean result = false;
	
			try {
				CallableStatement stmt = con.prepareCall("{call isUpdateAward(?,?)}");
				stmt.setString(1, project_id);
				stmt.setString(2, award);
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

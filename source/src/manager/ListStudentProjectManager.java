package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import bean.StudentProject;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class ListStudentProjectManager {

	ResultSetToClass resultSetToClass = new ResultSetToClass();

	public List<StudentProject> getListStudentProject() throws Exception {
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
					+ "  GROUP BY project.project_id "
					+ "  ORDER BY project.project_id ASC";
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
	
	public List<StudentProject> searchproject(String key) throws Exception {
		List<StudentProject> listsproject = new Vector<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;

		try {

			stmt = con.createStatement();
			String sql = " SELECT * " + "  FROM studentproject"
					+ "  LEFT JOIN project on  studentproject.project_id = project.project_id"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN team on project.team_id = team.team_id"
					+ "  LEFT JOIN student on studentproject.student_id = student.student_id"
					+ "  LEFT JOIN school on student.school_id = school.school_id"
					+ "  LEFT JOIN advisor on studentproject.advisor_id = advisor.advisor_id  "
					+ "  WHERE project.project_id like '%" + key + "%' "
					+ "  GROUP BY project.project_id ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {

				listsproject.add(resultSetToClass.setResultSetToStudentProject(rs));
				
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return listsproject;
	}
	
}

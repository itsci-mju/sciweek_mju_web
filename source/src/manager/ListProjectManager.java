package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.Project;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class ListProjectManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();

	public Project getStudentProjectByID(Integer student_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		Project project = new Project();

		try {
			stmt = con.createStatement();
			String sql = " SELECT * FROM student"
					+ "  LEFT JOIN school on student.school_id = school.school_id"
					+ "  LEFT JOIN project on  student.project_id = project.project_id"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN advisor on project.advisor_id = advisor.advisor_id  "
					+ "  WHERE student.student_id = '"+ student_id +"' ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				
				project = resultSetToClass.setResultSetToProject(rs);
				
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return project;
	}

}

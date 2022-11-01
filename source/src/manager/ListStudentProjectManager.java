package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import bean.Project;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class ListStudentProjectManager {

	ResultSetToClass resultSetToClass = new ResultSetToClass();

	public List<Project> getListStudentProject() throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<Project> listproject = new Vector<>();

		try {
			stmt = con.createStatement();
			String sql = " SELECT * FROM project"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN advisor on project.advisor_id = advisor.advisor_id  "
					+ "  GROUP BY project.project_id "
					+ "  ORDER BY project.project_id ASC";
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
	
	public List<Project> searchproject(String key) throws Exception {
		List<Project> listproject = new Vector<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;

		try {

			stmt = con.createStatement();
			String sql = " SELECT * FROM project"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN advisor on project.advisor_id = advisor.advisor_id  "
					+ "  WHERE project.project_id like '%" + key + "%' "
					+ "  GROUP BY project.project_id ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {

				listproject.add(resultSetToClass.setResultSetToProject(rs));
				
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return listproject;
	}

}

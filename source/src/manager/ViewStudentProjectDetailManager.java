package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import bean.Project;
import bean.Student;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class ViewStudentProjectDetailManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();
	
	public Project getStudentProjectByID(String project_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		Project project = new Project();
		
		try {
			
			stmt = con.createStatement();
			String sql = " SELECT * FROM project"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN advisor on project.advisor_id = advisor.advisor_id  "
					+ "  WHERE project.project_id = '"+ project_id +"'";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				
				project = resultSetToClass.setResultSetToProject(rs);
				project.setStudentList(getListStudent(project.getProject_id()));
				
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
	
	public List<Student> getListStudent(String project_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<Student> liststudent = new Vector<>();
		
		try {
			
			stmt = con.createStatement();
			String sql = " SELECT * FROM student"
					+ "  LEFT JOIN school on student.school_id = school.school_id"
					+ "  LEFT JOIN project on  student.project_id = project.project_id"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN advisor on project.advisor_id = advisor.advisor_id"
					+ "  WHERE student.project_id = '" + project_id + "'  ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
					
				liststudent.add(resultSetToClass.setResultSetToStudent(rs));		
				
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return liststudent;
	}

}

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

public class ViewStudentProjectDetailManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();
	
	public StudentProject getStudentProjectByID(String key) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		StudentProject sproject = new StudentProject();
		
		try {
			
			stmt = con.createStatement();
			String sql = " SELECT * FROM studentproject"
					+ "  LEFT JOIN project on  studentproject.project_id = project.project_id"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN team on project.team_id = team.team_id"
					+ "  LEFT JOIN student on studentproject.student_id = student.student_id"
					+ "  LEFT JOIN school on student.school_id = school.school_id"
					+ "  LEFT JOIN advisor on studentproject.advisor_id = advisor.advisor_id  "
					+ "  WHERE studentproject.project_id like '"+ key +"'";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				
				sproject.setProject(resultSetToClass.setResultSetToProject(rs));	
				sproject.setStudent(resultSetToClass.setResultSetToStudent(rs));
				sproject.setAdvisor(resultSetToClass.setResultSetToAdvisor(rs));
				
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return sproject;
	}
	
	public List<StudentProject> getListStudent(String pid) throws Exception {
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
					+ "  WHERE studentproject.project_id = '" + pid + "'  ";
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

}

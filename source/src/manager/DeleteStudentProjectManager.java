package manager;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import bean.*;
import util.ConnectionDB;

public class DeleteStudentProjectManager {
	
	public boolean isDeleteStudentProject(Student student, Project project, Advisor advisor) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		boolean result = false;
	
			try {
				CallableStatement stmt = con.prepareCall("{call isDeleteStudentProject(?,?,?)}");
				stmt.setInt(1, student.getStudent_id());
				stmt.setString(2, project.getProject_id());
				stmt.setInt(3, advisor.getAdvisor_id());
				stmt.execute();
				result = true;
				con.close();
				stmt.close();
			} catch (SQLException er) {
				er.printStackTrace();
			}
		
		return result;
	}
	
	public boolean isDeleteStudent(Integer student_id) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		boolean result = false;
	
			try {
				CallableStatement stmt = con.prepareCall("{call isDeleteStudent(?)}");
				stmt.setInt(1, student_id);
				stmt.execute();
				result = true;
				con.close();
				stmt.close();
			} catch (SQLException er) {
				er.printStackTrace();
			}
		
		return result;
	}
	
	public boolean isDeleteProject(String project_id) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		boolean result = false;
	
			try {
				CallableStatement stmt = con.prepareCall("{call isDeleteProject(?)}");
				stmt.setString(1, project_id);
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

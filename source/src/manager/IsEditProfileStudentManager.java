package manager;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.School;
import bean.Student;
import util.ConnectionDB;

public class IsEditProfileStudentManager {
	
	public IsEditProfileStudentManager() {
		// TODO Auto-generated constructor stub
	}
	
	public School getSchoolByID(Integer key) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		School school = new School ();
		
		try {

			stmt = con.createStatement();
			String sql = "SELECT * FROM school WHERE school_id like '"+ key +"'";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
						
				school.setSchool_id(rs.getInt("school_id"));
				school.setSchool_name(rs.getString("school_name"));			
				
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return school;
	}
	
	public boolean isEditProfileStudent(Student student) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Boolean result = false;

		try {

			CallableStatement stmt = con.prepareCall("{call isEditProfileStudent(?,?,?,?,?,?,?,?,?)}");
			stmt.setInt(1, student.getStudent_id());
			stmt.setString(2, student.getPrefix());
			stmt.setString(3, student.getFirstname());
			stmt.setString(4, student.getLastname());
			stmt.setString(5, student.getGrade());
			stmt.setString(6, student.getMobileno());
			stmt.setString(7, student.getEmail());
			stmt.setString(8, student.getPassword());
			stmt.setInt(9, student.getSchool() != null ? student.getSchool().getSchool_id() : null );
			
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

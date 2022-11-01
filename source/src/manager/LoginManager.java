package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.*;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class LoginManager {

	ResultSetToClass resultSetToClass = new ResultSetToClass();

	public Student doLoginStudent(Student student) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		Student stu = new Student();

		try {
			stmt = con.createStatement();
			String sql = " SELECT * FROM student "
					+ " JOIN school ON student.school_id = school.school_id "
					+ " JOIN project ON student.project_id = project.project_id "
					+ " JOIN projecttype ON project.projecttype_id = projecttype.projecttype_id "
					+ " JOIN advisor ON project.advisor_id = advisor.advisor_id "
					+ " WHERE student.email = '" + student.getEmail() + "' and student.password = '" + student.getPassword() + "'";
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next() && rs.getRow() == 1) {
				stu = resultSetToClass.setResultSetToStudent(rs);
			} else {
				stu = null;
			}
			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return stu;
	}

	public Reviewer doLoginReviewer(Reviewer reviewer) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		Reviewer rev = new Reviewer();

		try {
			stmt = con.createStatement();
			String sql = "SELECT * FROM reviewer "
					+ "LEFT JOIN projecttype ON reviewer.projecttype_id = projecttype.projecttype_id "
					+ "WHERE reviewer.email = '" + reviewer.getEmail() + "' and reviewer.password = '" + reviewer.getPassword() + "'";
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next() && rs.getRow() == 1) {
				rev = resultSetToClass.setResultSetToReviewer(rs);
			} else {
				rev = null;
			}
			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rev;
	}

	public Admin doLoginAdmin(Admin admin) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		Admin adm = null;

		try {
			stmt = con.createStatement();
			String sql = "SELECT * FROM admin WHERE admin.email = '" + admin.getEmail() + "' and admin.password = '" + admin.getPassword() + "'";
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next() && rs.getRow() == 1) {
				adm = resultSetToClass.setResultSetToAdmin(rs);
			} else {
				adm = null;
			}
			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return adm;
	}
	
	public Project getProjectByStudentID(Integer student_id) throws Exception {
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
			if (rs.next() && rs.getRow() == 1) {
				project = resultSetToClass.setResultSetToProject(rs);
			} else {
				project = null;
			}
			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return project;
	}
	
	public Report getReportByProjectID(String project_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		Report report = null;

		try {
			stmt = con.createStatement();
			String sql = " SELECT * FROM report " 
					+ "  LEFT JOIN project on  report.project_id = project.project_id"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN advisor on project.advisor_id = advisor.advisor_id  "
					+ "  WHERE report.project_id = '" + project_id + "' ";
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next() && rs.getRow() == 1) {
				report = resultSetToClass.setResultSetToReport(rs);
			} else {
				report = null;
			}
			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return report;
	}
	
}
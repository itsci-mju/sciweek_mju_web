package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

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
			String sql = "SELECT * "
					+ "FROM student "
					+ "JOIN school ON student.school_id = school.school_id "
					+ "WHERE email = '" + student.getEmail() + "' and password = '" + student.getPassword() + "'";
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
					+ "LEFT JOIN team ON reviewer.team_id = team.team_id "
					+ "WHERE email = '" + reviewer.getEmail() + "' and password = '" + reviewer.getPassword() + "'";
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
			String sql = "SELECT * FROM admin WHERE email = '" + admin.getEmail() + "' and password = '" + admin.getPassword() + "'";
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
	
	public List<StudentProject> getListStudentProjectByStudentID(Integer student_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<StudentProject> studentProjectList = new Vector<>();

		try {
			stmt = con.createStatement();
			String sql = " SELECT * FROM studentproject"
					+ "  LEFT JOIN project on  studentproject.project_id = project.project_id"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN team on project.team_id = team.team_id"
					+ "  LEFT JOIN student on studentproject.student_id = student.student_id"
					+ "  LEFT JOIN school on student.school_id = school.school_id"
					+ "  LEFT JOIN advisor on studentproject.advisor_id = advisor.advisor_id  "
					+ "  WHERE studentproject.student_id = '"+ student_id +"' ";
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next() && rs.getRow() == 1) {
				studentProjectList.add(resultSetToClass.setResultSetToStudentProject(rs));
			} else {
				studentProjectList = null;
			}
			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return studentProjectList;
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
					+ "  LEFT JOIN team on project.team_id = team.team_id" 
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

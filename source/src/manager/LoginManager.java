package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.Admin;
import bean.Reviewer;
import bean.Student;
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

}

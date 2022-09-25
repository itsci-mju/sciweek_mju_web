package manager;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import bean.Project;
import bean.Report;
import bean.StudentProject;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class IsUploadReportManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();
	
	public int  getnextreportid() {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;

		try {

			stmt = con.createStatement();
			String sql = " SELECT max(report_id) from report";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				return (rs.getInt(1)+1);
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return 1;
	}
	
	public boolean isUploadReport(Report report) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Boolean result = false;
		try {

			CallableStatement stmt = con.prepareCall("{call isUploadReport(?,?,?)}");
			stmt.setInt(1, report.getReport_id());
			stmt.setString(2, report.getReportname());
			stmt.setString(3, report.getProject().getProject_id());
			
			stmt.execute();

			result = true;
			con.close();
			stmt.close();
		} catch (SQLException er) {
			er.printStackTrace();
		}
		return result;
	}
	
	public boolean isUploadVideo(Project project) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Boolean result = false;
		try {

			CallableStatement stmt = con.prepareCall("{call isUploadVideo(?,?)}");
			stmt.setString(1, project.getProject_id());
			stmt.setString(2, project.getVideo());
	
			stmt.execute();

			result = true;
			con.close();
			stmt.close();
		} catch (SQLException er) {
			er.printStackTrace();
		}
		return result;
	}
	
	public StudentProject getStudentProjectByID(String key) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		StudentProject sproject = new StudentProject();
		
		try {
			
			stmt = con.createStatement();
			String sql = " SELECT * " + "  FROM studentproject"
					+ "  LEFT JOIN project on  studentproject.project_id = project.project_id"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN team on project.team_id = team.team_id"
					+ "  LEFT JOIN student on studentproject.student_id = student.student_id"
					+ "  LEFT JOIN school on student.school_id = school.school_id"
					+ "  LEFT JOIN advisor on studentproject.advisor_id = advisor.advisor_id  "
					+ "  WHERE studentproject.project_id like '"+ key +"'";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				
				sproject.setStudent(resultSetToClass.setResultSetToStudent(rs));
				sproject.setProject(resultSetToClass.setResultSetToProject(rs));
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
	
	public List<StudentProject> getListStudentProject(String pid) throws Exception {
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
	
	public boolean isDeleteUpload(Integer report_id) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		boolean result = false;
	
			try {
				CallableStatement stmt = con.prepareCall("{call isDeleteUpload(?)}");
				stmt.setInt(1, report_id);
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

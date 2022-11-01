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
import bean.Student;
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
				project.setReport(getReportByProjectID(project.getProject_id()));
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
	
	
	public Report getReportByProjectID(String project_id) throws Exception {	
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		Report report = new Report() ;
		
		try {		
			stmt = con.createStatement();
			String sql = " SELECT * FROM report "
					+ "  LEFT JOIN project on  report.project_id = project.project_id "
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id "
					+ "  LEFT JOIN advisor on project.advisor_id = advisor.advisor_id "
					+ " WHERE report.project_id = '"+ project_id +"' ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {		
				
			report = resultSetToClass.setResultSetToReport(rs);
			
			}
			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return report;
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

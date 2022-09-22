package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import bean.Report;
import bean.StudentProject;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class ViewProjectDetailManager {
	
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
					+ "  WHERE studentproject.project_id like '"+ key +"' ";
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
	
	public Report getReportByProjectID(String key) throws Exception {	
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		Report report = new Report() ;
		
		try {		
			stmt = con.createStatement();
			String sql = " SELECT * FROM report "
					+ "  LEFT JOIN project on  report.project_id = project.project_id"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN team on project.team_id = team.team_id"
					+ " WHERE report.project_id = '"+ key +"' ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {		
				
			report.setReport_id(rs.getInt("report.report_id"));
			report.setReportname(rs.getString("report.reportname"));
			report.setUploaddate(rs.getTimestamp("report.uploaddate"));
			report.setProject(resultSetToClass.setResultSetToProject(rs));
			
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
	
	public List<StudentProject> getListStudentProjectByProjectID(String project_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<StudentProject> listsproject = new Vector<>();
		
		try {
			
			stmt = con.createStatement();
			String sql = " SELECT * FROM studentproject"
					+ "  LEFT JOIN project on  studentproject.project_id = project.project_id"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN team on project.team_id = team.team_id"
					+ "  LEFT JOIN student on studentproject.student_id = student.student_id"
					+ "  LEFT JOIN school on student.school_id = school.school_id"
					+ "  LEFT JOIN advisor on studentproject.advisor_id = advisor.advisor_id  "
					+ "  WHERE studentproject.project_id = '" + project_id + "'  "
					+ "  GROUP BY studentproject.student_id ";
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

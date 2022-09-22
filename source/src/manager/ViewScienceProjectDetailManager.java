package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import bean.Answer;
import bean.Report;
import bean.Reviews;
import bean.StudentProject;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class ViewScienceProjectDetailManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();
	
	public List<Answer> getListAnswerByReviewID(String reviews_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		 List<Answer> listanswer = new Vector<>();
		
		try {
			
			stmt = con.createStatement();
			String sql = " SELECT * FROM answer"
					+ "  LEFT JOIN question on  answer.question_id = question.question_id"
					+ "  LEFT JOIN reviews on answer.reviews_id = reviews.reviews_id"
					+ "  WHERE answer.reviews_id = '" + reviews_id + "'  ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				
				listanswer.add(resultSetToClass.setResultSetToAnswer(rs));
					
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return listanswer;
	}
	
	public List<StudentProject> getListScienceProject(String pid) throws Exception {
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
	
	public StudentProject getStudentProjectByID(String key) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		StudentProject sproject = new StudentProject();
		
		try {
			
			stmt = con.createStatement();
			String sql = " SELECT * FROM studentproject"
					+ "  LEFT JOIN project on studentproject.project_id = project.project_id"
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
	
	public List<StudentProject> getListScienceProjectByTeamID(Integer tid) throws Exception {
		List<StudentProject> listsproject = new Vector<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;

		try {

			stmt = con.createStatement();
			String sql = " SELECT * FROM studentproject"
					+ "  LEFT JOIN project on  studentproject.project_id = project.project_id"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN team on project.team_id = team.team_id"
					+ "  LEFT JOIN student on studentproject.student_id = student.student_id"
					+ "  LEFT JOIN school on student.school_id = school.school_id"
					+ "  LEFT JOIN advisor on studentproject.advisor_id = advisor.advisor_id  "
					+ "  WHERE project.team_id like '%" + tid + "%' "
					+ "  GROUP BY studentproject.project_id";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {

				listsproject.add(resultSetToClass.setResultSetToStudentProject(rs));
				
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return listsproject;
	}
	
	public Reviews getReviewsByProjectID(String key) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		Reviews reviews = new Reviews();
		
		try {
			stmt = con.createStatement();
			String sql = " SELECT * FROM reviews "
					+ "  LEFT JOIN reviewer ON reviews.reviewer_id = reviewer.reviewer_id"
					+ "  LEFT JOIN project ON reviews.project_id = project.project_id"
					+ "  LEFT JOIN projecttype ON project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN team ON project.team_id = team.team_id"
					+ "  LEFT JOIN answer ON answer.review_id = reviews.review_id"
					+ " WHERE reviews.project_id = '"+ key +"' ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {		
				
			reviews.setReviews_id(rs.getString("reviews.reviews_id"));
			reviews.setReviewdate(rs.getTimestamp("reviews.reviewdate"));
			reviews.setComments(rs.getString("reviews.comments"));
			reviews.setTotalscore(rs.getDouble("reviews.totalscore"));
			reviews.setReviewer(resultSetToClass.setResultSetToReviewer(rs));
			reviews.setProject(resultSetToClass.setResultSetToProject(rs));
			
			}
			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return reviews;
	}	
	
}

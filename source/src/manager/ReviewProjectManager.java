package manager;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import org.springframework.stereotype.Controller;

import bean.Answer;
import bean.Question;
import bean.Report;
import bean.Reviews;
import bean.StudentProject;
import resultset.ResultSetToClass;
import util.ConnectionDB;

@Controller
public class ReviewProjectManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();
	
	public int getMaxReview() {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;

		int result = 0;
		try {
			stmt = con.createStatement();
			String sql = "Select MAX(reviews_id) from reviews";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				int id = rs.getInt(1)+1;
				result = id;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public boolean isUpdateStatus(String project_id, Integer reviewer_id) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		boolean result = false;
	
			try {
				CallableStatement stmt = con.prepareCall("{call isUpdateStatus(?,?)}");
				stmt.setString(1, project_id);
				stmt.setInt(2, reviewer_id);
				stmt.execute();
				result = true;
				con.close();
				stmt.close();
			} catch (SQLException er) {
				er.printStackTrace();
			}
		
		return result;
	}


	public List<Question> getListQuestion() throws Exception {
		List<Question> listquestion = new Vector<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		
		try {
			stmt = con.createStatement();
			String sql = "SELECT * FROM question";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				listquestion.add(resultSetToClass.setResultSetToQuestion(rs));
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return listquestion;
	}
	
	public List<StudentProject> getListScienceProject(String project_id) throws Exception {
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
					+ "  WHERE studentproject.project_id = '" + project_id + "'  ";
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
		Report report = new Report();
		
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
			report.setExpdate(rs.getTimestamp("report.expdate"));
			
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
					+ " WHERE reviews.project_id = '"+ key +"' ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {		
				
			reviews.setReviews_id(rs.getString("reviews.reviews_id"));
			reviews.setReviewdate(rs.getTimestamp("reviews.reviewdate"));
			reviews.setEnddate(rs.getTimestamp("reviews.enddate"));
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
	
	public boolean isReviewProject(Reviews reviews) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		
		boolean result = false;
	
			try {
				CallableStatement stmt = con.prepareCall("{call isReviewProject(?,?,?,?)}");
				stmt.setString(1, reviews.getReviews_id());
				stmt.setString(2, reviews.getComments());
				stmt.setInt(3, reviews.getReviewer().getReviewer_id());
				stmt.setString(4, reviews.getProject().getProject_id());
				stmt.execute();
				result = true;
				con.close();
				stmt.close();
			} catch (SQLException er) {
				er.printStackTrace();
			}
		
		return result;
	}
	
	public boolean isAnswerReview(Answer answer) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		
		boolean result = false;
	
			try {
				CallableStatement stmt = con.prepareCall("{call isAnswerReview(?,?,?,?,?)}");
				stmt.setDouble(1, answer.getAnswer());
				stmt.setInt(2, answer.getQuestion().getQuestion_id());
				stmt.setString(3, answer.getReview().getReviews_id());
				stmt.setInt(4, answer.getReviewer().getReviewer_id());
				stmt.setString(5, answer.getReview().getProject().getProject_id());
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

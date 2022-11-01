package manager;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import bean.Advisor;
import bean.Answer;
import bean.Project;
import bean.ProjectType;
import bean.Report;
import bean.Reviews;
import bean.School;
import bean.Student;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class ReviseProjectManager {

	ResultSetToClass resultSetToClass = new ResultSetToClass();
	
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

	public Student getStudentProjectByID(String project_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		Student student = new Student();
		Project project = new Project();
		School school = new School();
		Advisor advisor = new Advisor();
		ProjectType projecttype = new ProjectType();
		
		try {
			
			stmt = con.createStatement();
			String sql = " SELECT * FROM student"
					+ "  LEFT JOIN school on student.school_id = school.school_id"
					+ "  LEFT JOIN project on  student.project_id = project.project_id"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN advisor on project.advisor_id = advisor.advisor_id  "
					+ "  WHERE student.project_id = '"+ project_id +"' ";
			ResultSet rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				
				advisor.setAdvisor_id(rs.getInt("advisor.advisor_id"));
				advisor.setPrefix(rs.getString("advisor.prefix"));	
				advisor.setFirstname(rs.getString("advisor.firstname"));	
				advisor.setLastname(rs.getString("advisor.lastname"));	
				advisor.setEmail(rs.getString("advisor.email"));
				advisor.setMobileno(rs.getString("advisor.mobileno"));	
				
				projecttype.setProjecttype_id(rs.getInt("projecttype.projecttype_id"));
				projecttype.setProjecttype_name(rs.getString("projecttype.projecttype_name"));
				
				school.setSchool_id(rs.getInt("school.school_id"));
				school.setSchool_name(rs.getString("school.school_name"));		
				school.setSchool_address(rs.getString("school.school_address"));
				
				project = resultSetToClass.setResultSetToProject(rs);
				project.setReport(getReportByProjectID(project.getProject_id()));
				project.setStudentList(getListStudent(project.getProject_id()));
				
				student.setStudent_id(rs.getInt("student.student_id"));
				student.setPrefix(rs.getString("student.prefix"));
				student.setFirstname(rs.getString("student.firstname"));
				student.setLastname(rs.getString("student.lastname"));
				student.setGrade(rs.getString("student.grade"));
				student.setMobileno(rs.getString("student.mobileno"));		
				student.setEmail(rs.getString("student.email"));	
				student.setPassword(rs.getString("student.password"));	
				
				student.setSchool(school);
				student.setProject(project);
				
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return student;
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

	public List<Project> getListScienceProject(String project_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<Project> listproject = new Vector<>();

		try {

			stmt = con.createStatement();
			String sql = " SELECT * FROM project"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN advisor on project.advisor_id = advisor.advisor_id  "
					+ "  WHERE project.project_id = '"+ project_id +"'";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {

				listproject.add(resultSetToClass.setResultSetToProject(rs));

			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return listproject;
	}

	public Report getReportByProjectID(String project_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		Report report = new Report();

		try {
			stmt = con.createStatement();
			String sql = " SELECT * FROM report " 
					+ "  LEFT JOIN project on  report.project_id = project.project_id"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN advisor on project.advisor_id = advisor.advisor_id  " 
					+ "  WHERE report.project_id = '" + project_id + "' ";
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

	public boolean isReviseProject(Reviews reviews) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		boolean result = false;

		try {
			CallableStatement stmt = con.prepareCall("{call isReviseProject(?,?,?,?)}");
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

	public boolean isAnswerRevise(Answer answer) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		boolean result = false;

		try {
			CallableStatement stmt = con.prepareCall("{call isAnswerRevise(?,?,?)}");
			stmt.setDouble(1, answer.getAnswer());
			stmt.setInt(2, answer.getQuestion().getQuestion_id());
			stmt.setString(3, answer.getReview().getReviews_id());
			stmt.execute();
			result = true;
			con.close();
			stmt.close();
		} catch (SQLException er) {
			er.printStackTrace();
		}

		return result;
	}
	
	
	public boolean isUpdateReviewProject(Reviews reviews) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		boolean result = false;

		try {
			CallableStatement stmt = con.prepareCall("{call isUpdateReviewProject(?,?,?,?)}");
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
	
	public Reviews getReviewsByReviewerID(Integer reviewer_id, String project_id) throws Exception {
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
					+ "  LEFT JOIN advisor on project.advisor_id = advisor.advisor_id  "
					+ "  WHERE reviews.reviewer_id = '"+ reviewer_id +"' AND  reviews.project_id = '"+ project_id +"' ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {		
				
			reviews.setReviews_id(rs.getString("reviews.reviews_id"));
			reviews.setReviewdate(rs.getTimestamp("reviews.reviewdate"));
			reviews.setComments(rs.getString("reviews.comments"));
			reviews.setTotalscore(rs.getDouble("reviews.totalscore"));
			reviews.setReviewer(resultSetToClass.setResultSetToReviewer(rs));
			reviews.setProject(resultSetToClass.setResultSetToProject(rs));
			reviews.setListanswer(getListAnswerByReviewID(reviews.getReviews_id()));
			
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
					+ "  LEFT JOIN reviewer ON reviews.reviewer_id = reviewer.reviewer_id"
					+ "  LEFT JOIN project ON reviews.project_id = project.project_id"
					+ "  LEFT JOIN projecttype ON project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN advisor on project.advisor_id = advisor.advisor_id  "
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
	
	
	public boolean isUpdateState(String project_id) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		boolean result = false;
	
			try {
				CallableStatement stmt = con.prepareCall("{call isUpdateState(?)}");
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

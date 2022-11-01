package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import bean.Project;
import bean.Reviews;
import bean.Student;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class SummaryResultManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();
	
	public List<Student> getListStudentProjectByProjectID(String project_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<Student> studentList = new Vector<>();
		
		try {
			
			stmt = con.createStatement();
			String sql = " SELECT * FROM student"
					+ "  LEFT JOIN project on student.project_id = project.project_id"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN school on student.school_id = school.school_id"
					+ "  LEFT JOIN advisor on project.advisor_id = advisor.advisor_id  "
					+ "  WHERE student.project_id = '" + project_id + "'  "
					+ "  GROUP BY student.school_id ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
					
				studentList.add(resultSetToClass.setResultSetToStudent(rs));		
				
			}
			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return studentList;
	}
	
	public List<Reviews> getListReviews() throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<Reviews> listreviews = new Vector<>();

		try {
			stmt = con.createStatement();
			String sql = " SELECT *  FROM reviews"
					+ "  LEFT JOIN reviewer on reviews.reviewer_id = reviewer.reviewer_id"
					+ "  LEFT JOIN project on  reviews.project_id = project.project_id"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN advisor on project.advisor_id = advisor.advisor_id  "
					+ "  GROUP BY reviews.project_id";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				
				listreviews.add(resultSetToClass.setResultSetToReview(rs));
				
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return listreviews;
	}
	
	
	public List<Reviews> getListReviewsByReviewerID(Integer rid) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<Reviews> listreviews = new Vector<>();

		try {
			stmt = con.createStatement();
			String sql = " SELECT *  FROM reviews"
					+ "  LEFT JOIN reviewer on reviews.reviewer_id = reviewer.reviewer_id"
					+ "  LEFT JOIN project on  reviews.project_id = project.project_id"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN advisor on project.advisor_id = advisor.advisor_id  "
					+ "  WHERE reviews.reviewer_id like '" + rid + "' "
					+ "  ORDER BY reviews.totalscore DESC ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				
				listreviews.add(resultSetToClass.setResultSetToReview(rs));
				
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return listreviews;
	}

	public Project getStudentProjectByID(String key) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		Project project = new Project();
		
		try {
			
			stmt = con.createStatement();
			String sql = " SELECT * FROM project"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN advisor on project.advisor_id = advisor.advisor_id  "
					+ "  WHERE project.project_id like '"+ key +"'";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				
				project = resultSetToClass.setResultSetToProject(rs);
				
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
	
}

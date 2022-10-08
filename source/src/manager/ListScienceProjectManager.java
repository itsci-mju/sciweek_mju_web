package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import bean.Reviews;
import bean.StudentProject;
import lombok.val;
import model.ProjectResponse;
import model.ReviewerResponse;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class ListScienceProjectManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();
	
	public List<ProjectResponse> getListProjectByReviewerID(Integer reviewer_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<ProjectResponse> projectResponseList = new Vector<>();
		ObjectMapper mapper = new ObjectMapper();
		try {

			stmt = con.createStatement();
			String sql = " SELECT reviews.reviewdate"
					+ ", project.project_id"
					+ ", project.projectname"
					+ ", concat('[',(group_concat(JSON_OBJECT('reviewerName',concat(reviewer.firstname,' ',reviewer.lastname),'status',reviews.status))  ),']') AS reviewer_array"
					+ ", sum(reviews.totalscore) AS totalscore"
					+ " FROM reviews"
					+ " JOIN reviewer on reviews.reviewer_id = reviewer.reviewer_id"
					+ " JOIN team on reviewer.team_id = team.team_id"
					+ " JOIN project on  reviews.project_id = project.project_id"
					+ " JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ " WHERE reviewer.reviewer_id like '"+ reviewer_id + "' "
					+ " GROUP BY project.project_id ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				
				val projectResponse = new ProjectResponse();
				projectResponse.setProjectID(rs.getString("project.project_id"));
				projectResponse.setProjectName(rs.getString("project.projectname"));
				projectResponse.setReviewerResponseList(mapper.readValue(rs.getString("reviewer_array"),new TypeReference<List<ReviewerResponse>>() {}));
				projectResponseList.add(projectResponse);
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return projectResponseList;
	}
	
	public List<StudentProject> getListScienceProjectByTeamID(Integer team_id) throws Exception {
		List<StudentProject> studentProjectList = new Vector<>();
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
					+ "  WHERE project.team_id like '" + team_id + "' "
					+ "  GROUP BY studentproject.project_id";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				
				studentProjectList.add(resultSetToClass.setResultSetToStudentProject(rs));
				
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return studentProjectList;
	}
	
	public List<Reviews> getListReviewsByProjectIDAndReviewerID(String project_id,Integer reviewer_id) throws Exception {
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
					+ "  LEFT JOIN team on project.team_id = team.team_id"
					+ "  WHERE reviews.project_id like '"+ project_id + "' AND reviews.reviewer_id like '"+ reviewer_id + "' "
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

}

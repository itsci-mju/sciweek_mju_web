package manager;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.val;
import model.ProjectResponse;
import model.ReviewerResponse;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class SummaryOfReviewsManager {

	ResultSetToClass resultSetToClass = new ResultSetToClass();

	public List<ProjectResponse> getListReviewsByTeamID(Integer team_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<ProjectResponse> projectResponseList = new Vector<>();
		ObjectMapper mapper = new ObjectMapper();
		try {
			stmt = con.createStatement();
			String sql = " SELECT reviews.reviewdate"
					+ " ,project.project_id"
					+ ",project.projectname"
					+ " ,concat('[',(group_concat(JSON_OBJECT('reviewerName',concat(reviewer.firstname),'score',reviews.totalscore))  ),']') AS reviewer_array"
					+ " ,sum(reviews.totalscore) AS totalscore"
					+ " FROM reviews"
					+ " LEFT JOIN reviewer on reviews.reviewer_id = reviewer.reviewer_id"
					+ " LEFT JOIN team on reviewer.team_id = team.team_id"
					+ " LEFT JOIN project on  reviews.project_id = project.project_id"
					+ " LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ " WHERE reviewer.team_id like '"+ team_id + "' "
					+ " GROUP BY project.project_id "
					+ " ORDER BY totalscore DESC";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				val projectResponse = new ProjectResponse();
				projectResponse.setProjectID(rs.getString("project.project_id"));
				projectResponse.setProjectName(rs.getString("project.projectname"));
				projectResponse.setReviewDate(rs.getTimestamp("reviews.reviewdate"));
				projectResponse.setReviewerResponseList(mapper.readValue(rs.getString("reviewer_array"),new TypeReference<List<ReviewerResponse>>() {}));
				projectResponse.setTotalScore(rs.getDouble("totalscore"));
				projectResponseList.add(projectResponse);
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return projectResponseList;
	}
	
	public boolean isUpdateAVGScore(String project_id,Double avgscore) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		boolean result = false;
	
			try {
				CallableStatement stmt = con.prepareCall("{call isUpdateAVGScore(?,?)}");
				stmt.setString(1, project_id);
				stmt.setDouble(2, avgscore);
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

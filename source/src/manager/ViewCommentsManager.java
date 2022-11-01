package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import bean.*;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class ViewCommentsManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();
	
	public List<Reviews> getCommentsByProjectID(String project_id) throws Exception {
		List<Reviews> reviewsList = new Vector<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;

		try {

			stmt = con.createStatement();
			String sql = "  SELECT * FROM reviews "
					+ "  LEFT JOIN reviewer ON reviews.reviewer_id = reviewer.reviewer_id"
					+ "  LEFT JOIN project ON reviews.project_id = project.project_id"
					+ "  LEFT JOIN projecttype ON project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN advisor ON project.advisor_id = advisor.advisor_id"
					+ "  WHERE reviews.project_id = '"+ project_id +"' ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {		
				
				reviewsList.add(resultSetToClass.setResultSetToReview(rs));
				
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return reviewsList;
	}
	
	

}

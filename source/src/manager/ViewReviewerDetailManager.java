package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.Reviewer;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class ViewReviewerDetailManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();

	public Reviewer getReviewerByID(Integer key) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		Reviewer reviewer = new Reviewer();

		try {

			stmt = con.createStatement();
			String sql = "SELECT * FROM reviewer LEFT JOIN projecttype ON reviewer.projecttype_id = projecttype.projecttype_id"
					+ " WHERE reviewer.reviewer_id like '" + key + "'";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
			
				reviewer = resultSetToClass.setResultSetToReviewer(rs);

			}
			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return reviewer;
	}

}

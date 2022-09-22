package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.Pressrelease;
import util.ConnectionDB;

public class ViewNewsDetailManager {
	
	public Pressrelease viewnewsdetailByID(int id) {
		Pressrelease pressrelease = new Pressrelease();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;

		try {

			stmt = con.createStatement();
			String sql = " SELECT * FROM pressrelease WHERE newsid =  '"+ id +"' ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {		
				
				pressrelease.setNewsid(rs.getInt("pressrelease.newsid"));
				pressrelease.setTitle(rs.getString("pressrelease.title"));	
				pressrelease.setType(rs.getString("pressrelease.type"));	
				pressrelease.setDetail(rs.getString("pressrelease.detail"));
				pressrelease.setCreatedate(rs.getTimestamp("pressrelease.createdate"));
						
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return pressrelease;
	}

}

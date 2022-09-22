package manager;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.Pressrelease;
import util.ConnectionDB;

public class AddNewsManager {
	
	public int  getnextpressreleaseid() {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;

		try {

			stmt = con.createStatement();
			String sql = " SELECT max(newsid) from pressrelease";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				return (rs.getInt(1)+1);
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return 1;
	}
	
	
	public boolean isAddpressrelease(Pressrelease pressrelease) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Boolean result = false;
		try {

			CallableStatement stmt = con.prepareCall("{call isAddPressrelease(?,?,?,?)}");
			stmt.setInt(1, pressrelease.getNewsid());
			stmt.setString(2, pressrelease.getTitle());
			stmt.setString(3, pressrelease.getType());
			stmt.setString(4, pressrelease.getDetail());

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

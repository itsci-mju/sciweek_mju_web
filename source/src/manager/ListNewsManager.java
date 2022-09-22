package manager;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import bean.Pressrelease;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class ListNewsManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();
	
	public List<Pressrelease> getlistNews() throws Exception {
		List<Pressrelease> listnews = new Vector<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;

		try {

			stmt = con.createStatement();
			String sql = " SELECT * FROM pressrelease order by createdate DESC ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				
				listnews.add(resultSetToClass.setResultSetToPressrelease(rs));
			
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return listnews;
	}

	
	public List<Pressrelease> getlistNewsForshow() throws Exception {
		List<Pressrelease> listnews = new Vector<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;

		try {

			stmt = con.createStatement();
			String sql = " SELECT * FROM pressrelease order by createdate DESC LIMIT     9";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				
				listnews.add(resultSetToClass.setResultSetToPressrelease(rs));

			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return listnews;
	}
	
	public boolean editpressrelease(Pressrelease pressrelease) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Boolean result = false;
		try {

			CallableStatement stmt = con.prepareCall("{call isEditNews(?,?,?)}");
			stmt.setInt(1, pressrelease.getNewsid());
			stmt.setString(2, pressrelease.getTitle());
			stmt.setString(3, pressrelease.getDetail());


			stmt.execute();

			result = true;
			con.close();
			stmt.close();
		} catch (SQLException er) {
			er.printStackTrace();
		}

		return result;
	}
	
	public List<Pressrelease> searchnews(String key) throws Exception {
		List<Pressrelease> listnews = new Vector<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;

		try {

			stmt = con.createStatement();
			String sql = " SELECT * FROM pressrelease where title like '%" + key + "%' order by createdate DESC";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {

				listnews.add(resultSetToClass.setResultSetToPressrelease(rs));
				
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return listnews;
	}

	
	public boolean isDeleteNews(int id) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		
		boolean result = false;
	
			try {
				CallableStatement stmt = con.prepareCall("{call isDeleteNews(?)}");
				stmt.setInt(1, id);
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

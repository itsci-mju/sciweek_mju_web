package util;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Connection;

public class ConnectionDB {
    String url= "jdbc:mysql://localhost:3306/project?characterEncoding=UTF-8";
    String uname= "root";
    String pwd= "1234";
    Connection con;
    
    public ConnectionDB() {
        // TODO Auto-generated constructor stub
    }
    
	public Connection getConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url, uname, pwd);

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return con;
	}
	
    public static void main(String args[]) {
        ConnectionDB condb = new ConnectionDB();
        System.out.println(condb.getConnection());
    }
}

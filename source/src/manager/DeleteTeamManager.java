package manager;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import util.ConnectionDB;

public class DeleteTeamManager {
	
	public boolean isDeleteTeam(Integer team_id) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		boolean result = false;
	
			try {
				CallableStatement stmt = con.prepareCall("{call isDeleteTeam(?)}");
				stmt.setInt(1, team_id);
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

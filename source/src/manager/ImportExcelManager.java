package manager;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import bean.*;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class ImportExcelManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();
	
	public List<ProjectType> getListProjectType() throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<ProjectType> projectTypeList = new Vector<>();
		
		try {
			stmt = con.createStatement();
			String sql = "SELECT * FROM projecttype " ;
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {	
					
				projectTypeList.add(resultSetToClass.setResultSetToProjectType(rs));

			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return projectTypeList;
	}
	
	public boolean isImportSchool(School school) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Boolean result = false;

		try {
			CallableStatement stmt = con.prepareCall("{call isImportSchool(?,?,?)}");
			
			stmt.setInt(1, school.getSchool_id());
			stmt.setString(2, school.getSchool_name());
			stmt.setString(3, school.getSchool_address());
					
			stmt.execute();

			result = true;
			con.close();
			stmt.close();
		} catch (SQLException er) {
			er.printStackTrace();
		}
		return result;
	}
	
	public boolean isImportStudent(Student student) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Boolean result = false;

		try {
			CallableStatement stmt = con.prepareCall("{call isImportStudent(?,?,?,?,?,?,?,?,?)}");
			stmt.setInt(1, student.getStudent_id());
			stmt.setString(2, student.getPrefix());
			stmt.setString(3, student.getFirstname());
			stmt.setString(4, student.getLastname());
			stmt.setString(5, student.getGrade());
			stmt.setString(6, student.getMobileno());
			stmt.setString(7, student.getEmail());
			stmt.setString(8, student.getPassword()); 
			stmt.setInt(9, student.getSchool().getSchool_id());
							
			stmt.execute();

			result = true;
			con.close();
			stmt.close();
		} catch (SQLException er) {
			er.printStackTrace();
		}
		return result;
	}
	
	public boolean isImportProjectType(ProjectType projectType) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Boolean result = false;

		try {
			CallableStatement stmt = con.prepareCall("{call isImportProjectType(?,?)}");
			
			stmt.setInt(1, projectType.getProjecttype_id());
			stmt.setString(2, projectType.getProjecttype_name());
					
			stmt.execute();

			result = true;
			con.close();
			stmt.close();
		} catch (SQLException er) {
			er.printStackTrace();
		}
		return result;
	}
	
	public boolean isImportProject(Project project) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Boolean result = false;

		try {
			CallableStatement stmt = con.prepareCall("{call isImportProject(?,?,?,?,?,?)}");
		
			stmt.setString(1, project.getProject_id());
			stmt.setString(2, project.getProjectname());
			stmt.setString(3, project.getVideo());
			stmt.setString(4, project.getAward());
			stmt.setDouble(5, project.getAvgscore());	
			stmt.setInt(6, project.getProjecttype().getProjecttype_id());

					
			stmt.execute();

			result = true;
			con.close();
			stmt.close();
		} catch (SQLException er) {
			er.printStackTrace();
		}
		return result;
	}
	
	public boolean isImportAdvisor(Advisor advisor) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Boolean result = false;

		try {
			CallableStatement stmt = con.prepareCall("{call isImportAdvisor(?,?,?,?,?,?)}");

			stmt.setInt(1, advisor.getAdvisor_id());
			stmt.setString(2, advisor.getPrefix());
			stmt.setString(3, advisor.getFirstname());
			stmt.setString(4, advisor.getLastname());
			stmt.setString(5, advisor.getEmail());
			stmt.setString(6, advisor.getMobileno());
					
			stmt.execute();

			result = true;
			con.close();
			stmt.close();
		} catch (SQLException er) {
			er.printStackTrace();
		}
		return result;
	}
	
	public boolean isImportStudentData(Student student, Project project, Advisor advisor) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Boolean result = false;

		try {
			CallableStatement stmt = con.prepareCall("{call isImportStudentData(?,?,?)}");

			stmt.setInt(1, student.getStudent_id());
			stmt.setString(2, project.getProject_id());
			stmt.setInt(3, advisor.getAdvisor_id());

					
			stmt.execute();

			result = true;
			con.close();
			stmt.close();
		} catch (SQLException er) {
			er.printStackTrace();
		}
		return result;
	}
	
	public Student getStudentByID(Integer student_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		Student student = new Student();
		
		try {
			stmt = con.createStatement();
			String sql = "SELECT * FROM student WHERE student_id = '"+ student_id +"' " ;
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {	
					
				student.setStudent_id(rs.getInt("student.student_id"));
				student.setPrefix(rs.getString("student.prefix"));
				student.setFirstname(rs.getString("student.firstname"));
				student.setLastname(rs.getString("student.lastname"));
				student.setGrade(rs.getString("student.grade"));
				student.setMobileno(rs.getString("student.mobileno"));		
				student.setEmail(rs.getString("student.email"));	
				student.setPassword(rs.getString("student.password"));
				
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return student;
	}
	
	public School getSchoolByID(Integer school_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		School school = new School();
		
		try {
			stmt = con.createStatement();
			String sql = "SELECT * FROM school WHERE school_id = '"+ school_id +"' " ;
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {	
					
				school.setSchool_id(rs.getInt("school.school_id"));
				school.setSchool_name(rs.getString("school.school_name"));
				school.setSchool_address(rs.getString("school.school_address"));
				
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return school;
	}
	
	public ProjectType getProjectTypeByID(Integer projecttype_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		ProjectType projectType = new ProjectType();
		
		try {
			stmt = con.createStatement();
			String sql = "SELECT * FROM projecttype WHERE projecttype_id = '"+ projecttype_id +"' " ;
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {	
					
				projectType.setProjecttype_id(rs.getInt("projecttype.projecttype_id"));
				projectType.setProjecttype_name(rs.getString("projecttype.projecttype_name"));
				
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return projectType;
	}
	
	public Project getProjectByID(String project_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		Project project = new Project();
		
		try {
			stmt = con.createStatement();
			String sql = "SELECT * FROM project WHERE project_id = '"+ project_id +"' " ;
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {	
					
				project.setProject_id(rs.getString("project.project_id"));
				project.setProjectname(rs.getString("project.projectname"));		
				project.setVideo(rs.getString("project.video"));
				project.setAward(rs.getString("project.award"));
				project.setAvgscore(rs.getDouble("project.avgscore"));
				
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
	
	public Advisor getAdvisorByID(Integer advisor_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		Advisor advisor = new Advisor();
		
		try {
			stmt = con.createStatement();
			String sql = "SELECT * FROM advisor WHERE advisor_id = '"+ advisor_id +"' " ;
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {	
					
				advisor.setAdvisor_id(rs.getInt("advisor.advisor_id"));
				advisor.setPrefix(rs.getString("advisor.prefix"));	
				advisor.setFirstname(rs.getString("advisor.firstname"));	
				advisor.setLastname(rs.getString("advisor.lastname"));	
				advisor.setEmail(rs.getString("advisor.email"));
				advisor.setMobileno(rs.getString("advisor.mobileno"));	
				
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return advisor;
	}

}

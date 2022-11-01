package manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import bean.Project;
import bean.ProjectType;
import bean.Schedules;
import bean.Student;
import lombok.val;
import model.StudentResponse;
import model.StudentProjectResponse;
import resultset.ResultSetToClass;
import util.ConnectionDB;

public class AnnounceResultManager {
	
	ResultSetToClass resultSetToClass = new ResultSetToClass();
	
	public Schedules getDATE() throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		Schedules schedules = new Schedules();
		
		try {
			stmt = con.createStatement();
			String sql = " SELECT * FROM schedules ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {		
				
				schedules = resultSetToClass.setResultSetToSchedules(rs);
			
			}
			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return schedules;
	}	
	
	public List<StudentProjectResponse> getListStudentProject(Integer projecttype_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<StudentProjectResponse> studentProjectResponseList = new Vector<>();
		ObjectMapper mapper = new ObjectMapper();
		
		try {
			
			stmt = con.createStatement();
			String sql = " SELECT project.project_id ,project.projectname ,school.school_name ,project.avgscore, project.award "
					+ " ,concat('[',(group_concat(JSON_OBJECT('studentName',concat(student.prefix,' ',student.firstname,' ',student.lastname)))),']') AS student_array"
					+ " ,concat(advisor.prefix,' ',advisor.firstname,' ',advisor.lastname) AS advisorName"
					+ " FROM student "
					+ " LEFT JOIN project ON student.project_id = project.project_id"
					+ " LEFT JOIN projecttype ON project.projecttype_id = projecttype.projecttype_id"
					+ " LEFT JOIN school ON student.school_id = school.school_id"
					+ " LEFT JOIN advisor ON project.advisor_id = advisor.advisor_id"
					+ " WHERE project.award LIKE 'รางวัล%' AND project.status_project = 1 AND project.projecttype_id = '" + projecttype_id + "' "
					+ " GROUP BY project.project_id "
					+ " ORDER BY project.projecttype_id ASC , project.award ASC ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
					
				val studentProjectResponse = new StudentProjectResponse();	
				studentProjectResponse.setProjectID(rs.getString("project.project_id"));
				studentProjectResponse.setProjectName(rs.getString("project.projectname"));
				studentProjectResponse.setSchoolName(rs.getString("school.school_name"));
				studentProjectResponse.setAwardProject(rs.getString("project.award"));
				studentProjectResponse.setStudentResponseList(mapper.readValue(rs.getString("student_array"), new TypeReference<List<StudentResponse>>() {}));
				studentProjectResponse.setAdvisorName(rs.getString("advisorName"));
				studentProjectResponseList.add(studentProjectResponse);
			}
			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return studentProjectResponseList;
	}
	
	public List<Student> getListStudentProjectByProjectID(String project_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<Student> studentList = new Vector<>();
		
		try {
			
			stmt = con.createStatement();
			String sql = " SELECT * FROM student"
					+ "  LEFT JOIN project on student.project_id = project.project_id"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN school on student.school_id = school.school_id"
					+ "  LEFT JOIN advisor on project.advisor_id = advisor.advisor_id  "
					+ "  WHERE student.project_id = '" + project_id + "'  "
					+ "  GROUP BY student.school_id ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
					
				studentList.add(resultSetToClass.setResultSetToStudent(rs));		
				
			}
			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return studentList;
	}
	
	public List<ProjectType> getlistProjectType() throws Exception {

		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;

		List<ProjectType> listProjectType = new Vector<>();
		try {

			stmt = con.createStatement();
			String sql = " SELECT * FROM projecttype ";

			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
			
				listProjectType.add(resultSetToClass.setResultSetToProjectType(rs));
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}

		return listProjectType;
	}
	
	public List<Project> getListProject() throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<Project> listproject = new Vector<>();

		try {
			stmt = con.createStatement();
			String sql = " SELECT * FROM project"
					+ " LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id "
					+ "  LEFT JOIN advisor on project.advisor_id = advisor.advisor_id  "
					+ " WHERE project.award LIKE 'รางวัล%' AND project.status_project = 1"
					+ " ORDER BY project.projecttype_id ASC , project.award ASC";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				listproject.add(resultSetToClass.setResultSetToProject(rs));
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return listproject;
	}

	
	public List<Project> getListProjectByProjecttypeID(Integer projecttype_id) throws Exception {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Statement stmt = null;
		List<Project> listproject = new Vector<>();

		try {
			stmt = con.createStatement();
			String sql = " SELECT * FROM project"
					+ "  LEFT JOIN projecttype on project.projecttype_id = projecttype.projecttype_id"
					+ "  LEFT JOIN advisor on project.advisor_id = advisor.advisor_id  "
					+ "  WHERE project.award LIKE 'รางวัล%' AND project.status_project = 1 AND project.projecttype_id = '"+ projecttype_id +"' "
					+ "  ORDER BY project.award ASC ";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				listproject.add(resultSetToClass.setResultSetToProject(rs));
			}

			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			System.out.println("catch");
			e.printStackTrace();
		}
		return listproject;
	}

}

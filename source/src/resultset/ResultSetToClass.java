package resultset;

import java.sql.ResultSet;

import bean.*;


public class ResultSetToClass {
	
	public Admin setResultSetToAdmin (ResultSet rs) throws Exception {
		Admin admin = new Admin();
		
		admin.setAdmin_id(rs.getInt("admin.admin_id"));
		admin.setAdminname(rs.getString("admin.adminname"));	
		admin.setEmail(rs.getString("admin.email"));
		admin.setPassword(rs.getString("admin.password"));	
		
		return admin;
	}
	
	public Advisor setResultSetToAdvisor (ResultSet rs) throws Exception {
		Advisor advisor = new Advisor();
		
		advisor.setAdvisor_id(rs.getInt("advisor.advisor_id"));
		advisor.setPrefix(rs.getString("advisor.prefix"));	
		advisor.setFirstname(rs.getString("advisor.firstname"));	
		advisor.setLastname(rs.getString("advisor.lastname"));	
		advisor.setEmail(rs.getString("advisor.email"));
		advisor.setMobileno(rs.getString("advisor.mobileno"));	
			
		return advisor;
	}
	
	public Answer setResultSetToAnswer (ResultSet rs) throws Exception {
		Answer answer = new Answer();
		
		answer.setAnswer(rs.getDouble("answer.answer"));
		
		answer.setQuestion(this.setResultSetToQuestion(rs));
		answer.setReview(this.setResultSetToReview(rs));
		answer.setReviewer(this.setResultSetToReviewer(rs));
		answer.setProject(this.setResultSetToProject(rs));
		
		return answer;
	}
	
	public Pressrelease setResultSetToPressrelease (ResultSet rs) throws Exception {
		Pressrelease pressrelease = new Pressrelease();
		
		pressrelease.setNewsid(rs.getInt("pressrelease.newsid"));
		pressrelease.setType(rs.getString("pressrelease.type"));
		pressrelease.setTitle(rs.getString("pressrelease.title"));		
		pressrelease.setDetail(rs.getString("pressrelease.detail"));
		pressrelease.setCreatedate(rs.getTimestamp("pressrelease.createdate"));
		
		return pressrelease;
	}
	
	public Project setResultSetToProject (ResultSet rs) throws Exception {
		Project project = new Project();
		
		project.setProject_id(rs.getString("project.project_id"));
		project.setImportdate(rs.getTimestamp("project.importdate"));
		project.setProjectname(rs.getString("project.projectname"));		
		project.setVideo(rs.getString("project.video"));
		project.setAward(rs.getString("project.award"));
		project.setAvgscore(rs.getDouble("project.avgscore"));
		project.setState_project(rs.getInt("project.state_project"));
	
		project.setProjecttype(this.setResultSetToProjectType(rs));
		project.setTeam(this.setResultSetToTeam(rs));
		
		return project;
	}
	
	public ProjectType setResultSetToProjectType (ResultSet rs) throws Exception {
		ProjectType projecttype = new ProjectType();
		
		projecttype.setProjecttype_id(rs.getInt("projecttype.projecttype_id"));
		projecttype.setProjecttype_name(rs.getString("projecttype.projecttype_name"));
	
		return projecttype;
	}
	
	public Question setResultSetToQuestion (ResultSet rs) throws Exception {
		Question question = new Question();
		
		question.setQuestion_id(rs.getInt("question.question_id"));
		question.setQuestion(rs.getString("question.question"));
		question.setFullscore(rs.getInt("question.fullscore"));
		
		return question;
	}
	
	public Report setResultSetToReport (ResultSet rs) throws Exception {
		Report report = new Report();
		
		report.setReport_id(rs.getInt("report.report_id"));
		report.setReportname(rs.getString("report.reportname"));
		report.setUploaddate(rs.getTimestamp("report.uploaddate"));
		
		report.setProject(this.setResultSetToProject(rs));
		
		return report;
	}
	
	public Reviews setResultSetToReview (ResultSet rs) throws Exception {
		Reviews reviews = new Reviews();
		
		reviews.setReviews_id(rs.getString("reviews.reviews_id"));
		reviews.setReviewdate(rs.getTimestamp("reviews.reviewdate"));
		reviews.setComments(rs.getString("reviews.comments"));
		reviews.setTotalscore(rs.getDouble("reviews.totalscore"));
		reviews.setStatus(rs.getString("reviews.status"));
		
		reviews.setReviewer(this.setResultSetToReviewer(rs));
		reviews.setProject(this.setResultSetToProject(rs));
		
		return reviews;
	}
	
	public Reviewer setResultSetToReviewer (ResultSet rs) throws Exception {
		Reviewer reviewer = new Reviewer();
		
		reviewer.setReviewer_id(rs.getInt("reviewer.reviewer_id"));
		reviewer.setPrefix(rs.getString("reviewer.prefix"));
		reviewer.setFirstname(rs.getString("reviewer.firstname"));
		reviewer.setLastname(rs.getString("reviewer.lastname"));
		reviewer.setFaculty(rs.getString("reviewer.faculty"));
		reviewer.setMajor(rs.getString("reviewer.major"));
		reviewer.setPosition(rs.getString("reviewer.position"));
		reviewer.setLine(rs.getString("reviewer.line"));
		reviewer.setFacebook(rs.getString("reviewer.facebook"));
		reviewer.setEmail(rs.getString("reviewer.email"));
		reviewer.setPassword(rs.getString("reviewer.password"));
		
		reviewer.setTeam(this.setResultSetToTeam(rs));
		
		return reviewer;
	}
	
	public School setResultSetToSchool (ResultSet rs) throws Exception {
		School school = new School();
		
		school.setSchool_id(rs.getInt("school.school_id"));
		school.setSchool_name(rs.getString("school.school_name"));		
		school.setSchool_address(rs.getString("school.school_address"));
		
		return school;
	}
	
	public Student setResultSetToStudent (ResultSet rs) throws Exception {
		Student student = new Student();
		
		student.setStudent_id(rs.getInt("student.student_id"));
		student.setImportdate(rs.getTimestamp("student.importdate"));
		student.setPrefix(rs.getString("student.prefix"));
		student.setFirstname(rs.getString("student.firstname"));
		student.setLastname(rs.getString("student.lastname"));
		student.setGrade(rs.getString("student.grade"));
		student.setMobileno(rs.getString("student.mobileno"));		
		student.setEmail(rs.getString("student.email"));	
		student.setPassword(rs.getString("student.password"));	
		
		student.setSchool(this.setResultSetToSchool(rs));
		
		return student;
	}
	
	public StudentProject setResultSetToStudentProject (ResultSet rs) throws Exception {
		StudentProject studentproject = new StudentProject();
		
		studentproject.setStudent(this.setResultSetToStudent(rs));
		studentproject.setProject(this.setResultSetToProject(rs));
		studentproject.setAdvisor(this.setResultSetToAdvisor(rs));
			
		return studentproject;
	}
	
	public Team setResultSetToTeam (ResultSet rs) throws Exception {
		Team team = new Team();
		
		team.setTeam_id(rs.getInt("team.team_id"));
		team.setTeam_name(rs.getString("team.team_name"));
			
		return team;
	}
	

	public Years setResultSetToYear (ResultSet rs) throws Exception {
		Years years = new Years();
		
		years.setYears(rs.getInt("years.years"));
		years.setUploaddate(rs.getTimestamp("years.uploaddate"));
		years.setExpuploaddate(rs.getTimestamp("years.expuploaddate"));
		years.setReviewdate(rs.getTimestamp("years.reviewdate"));
		years.setExpreviewdate(rs.getTimestamp("years.expreviewdate"));
		years.setAnnouncedate(rs.getTimestamp("years.announcedate"));
			
		return years;
	}
	
	
	
}

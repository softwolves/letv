package entity;

import java.io.Serializable;

public class Course implements Serializable {

	private Integer courseId;
	private String courseName;
	private Integer days;
	
	//对象属性：courseId
	//Bean属性：id
	public Integer getId() {
		return courseId;
	}
	public void setId(Integer courseId) {
		this.courseId = courseId;
	}
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	public Integer getDays() {
		return days;
	}
	public void setDays(Integer days) {
		this.days = days;
	}
	
}








package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class StudentSelectCourseInfo {
    /*记录编号*/
    private Integer selectId;
    public Integer getSelectId(){
        return selectId;
    }
    public void setSelectId(Integer selectId){
        this.selectId = selectId;
    }

    /*学生对象*/
    private Student studentNumber;
    public Student getStudentNumber() {
        return studentNumber;
    }
    public void setStudentNumber(Student studentNumber) {
        this.studentNumber = studentNumber;
    }

    /*课程对象*/
    private CourseInfo courseNumber;
    public CourseInfo getCourseNumber() {
        return courseNumber;
    }
    public void setCourseNumber(CourseInfo courseNumber) {
        this.courseNumber = courseNumber;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonStudentSelectCourseInfo=new JSONObject(); 
		jsonStudentSelectCourseInfo.accumulate("selectId", this.getSelectId());
		jsonStudentSelectCourseInfo.accumulate("studentNumber", this.getStudentNumber().getStudentName());
		jsonStudentSelectCourseInfo.accumulate("studentNumberPri", this.getStudentNumber().getStudentNumber());
		jsonStudentSelectCourseInfo.accumulate("courseNumber", this.getCourseNumber().getCourseName());
		jsonStudentSelectCourseInfo.accumulate("courseNumberPri", this.getCourseNumber().getCourseNumber());
		return jsonStudentSelectCourseInfo;
    }}
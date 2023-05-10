package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class ScoreInfo {
    /*记录编号*/
    private Integer scoreId;
    public Integer getScoreId(){
        return scoreId;
    }
    public void setScoreId(Integer scoreId){
        this.scoreId = scoreId;
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

    /*成绩得分*/
    @NotNull(message="必须输入成绩得分")
    private Float scoreValue;
    public Float getScoreValue() {
        return scoreValue;
    }
    public void setScoreValue(Float scoreValue) {
        this.scoreValue = scoreValue;
    }

    /*学生评价*/
    private String studentEvaluate;
    public String getStudentEvaluate() {
        return studentEvaluate;
    }
    public void setStudentEvaluate(String studentEvaluate) {
        this.studentEvaluate = studentEvaluate;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonScoreInfo=new JSONObject(); 
		jsonScoreInfo.accumulate("scoreId", this.getScoreId());
		jsonScoreInfo.accumulate("studentNumber", this.getStudentNumber().getStudentName());
		jsonScoreInfo.accumulate("studentNumberPri", this.getStudentNumber().getStudentNumber());
		jsonScoreInfo.accumulate("courseNumber", this.getCourseNumber().getCourseName());
		jsonScoreInfo.accumulate("courseNumberPri", this.getCourseNumber().getCourseNumber());
		jsonScoreInfo.accumulate("scoreValue", this.getScoreValue());
		jsonScoreInfo.accumulate("studentEvaluate", this.getStudentEvaluate());
		return jsonScoreInfo;
    }}
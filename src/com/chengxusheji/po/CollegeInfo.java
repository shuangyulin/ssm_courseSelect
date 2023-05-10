package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class CollegeInfo {
    /*学院编号*/
    @NotEmpty(message="学院编号不能为空")
    private String collegeNumber;
    public String getCollegeNumber(){
        return collegeNumber;
    }
    public void setCollegeNumber(String collegeNumber){
        this.collegeNumber = collegeNumber;
    }

    /*学院名称*/
    @NotEmpty(message="学院名称不能为空")
    private String collegeName;
    public String getCollegeName() {
        return collegeName;
    }
    public void setCollegeName(String collegeName) {
        this.collegeName = collegeName;
    }

    /*成立日期*/
    @NotEmpty(message="成立日期不能为空")
    private String collegeBirthDate;
    public String getCollegeBirthDate() {
        return collegeBirthDate;
    }
    public void setCollegeBirthDate(String collegeBirthDate) {
        this.collegeBirthDate = collegeBirthDate;
    }

    /*院长姓名*/
    private String collegeMan;
    public String getCollegeMan() {
        return collegeMan;
    }
    public void setCollegeMan(String collegeMan) {
        this.collegeMan = collegeMan;
    }

    /*联系电话*/
    private String collegeTelephone;
    public String getCollegeTelephone() {
        return collegeTelephone;
    }
    public void setCollegeTelephone(String collegeTelephone) {
        this.collegeTelephone = collegeTelephone;
    }

    /*附加信息*/
    private String collegeMemo;
    public String getCollegeMemo() {
        return collegeMemo;
    }
    public void setCollegeMemo(String collegeMemo) {
        this.collegeMemo = collegeMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonCollegeInfo=new JSONObject(); 
		jsonCollegeInfo.accumulate("collegeNumber", this.getCollegeNumber());
		jsonCollegeInfo.accumulate("collegeName", this.getCollegeName());
		jsonCollegeInfo.accumulate("collegeBirthDate", this.getCollegeBirthDate().length()>19?this.getCollegeBirthDate().substring(0,19):this.getCollegeBirthDate());
		jsonCollegeInfo.accumulate("collegeMan", this.getCollegeMan());
		jsonCollegeInfo.accumulate("collegeTelephone", this.getCollegeTelephone());
		jsonCollegeInfo.accumulate("collegeMemo", this.getCollegeMemo());
		return jsonCollegeInfo;
    }}
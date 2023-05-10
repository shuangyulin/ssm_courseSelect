package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Teacher {
    /*教师编号*/
    @NotEmpty(message="教师编号不能为空")
    private String teacherNumber;
    public String getTeacherNumber(){
        return teacherNumber;
    }
    public void setTeacherNumber(String teacherNumber){
        this.teacherNumber = teacherNumber;
    }

    /*教师姓名*/
    @NotEmpty(message="教师姓名不能为空")
    private String teacherName;
    public String getTeacherName() {
        return teacherName;
    }
    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    /*登录密码*/
    private String teacherPassword;
    public String getTeacherPassword() {
        return teacherPassword;
    }
    public void setTeacherPassword(String teacherPassword) {
        this.teacherPassword = teacherPassword;
    }

    /*性别*/
    @NotEmpty(message="性别不能为空")
    private String teacherSex;
    public String getTeacherSex() {
        return teacherSex;
    }
    public void setTeacherSex(String teacherSex) {
        this.teacherSex = teacherSex;
    }

    /*出生日期*/
    @NotEmpty(message="出生日期不能为空")
    private String teacherBirthday;
    public String getTeacherBirthday() {
        return teacherBirthday;
    }
    public void setTeacherBirthday(String teacherBirthday) {
        this.teacherBirthday = teacherBirthday;
    }

    /*入职日期*/
    @NotEmpty(message="入职日期不能为空")
    private String teacherArriveDate;
    public String getTeacherArriveDate() {
        return teacherArriveDate;
    }
    public void setTeacherArriveDate(String teacherArriveDate) {
        this.teacherArriveDate = teacherArriveDate;
    }

    /*身份证号*/
    private String teacherCardNumber;
    public String getTeacherCardNumber() {
        return teacherCardNumber;
    }
    public void setTeacherCardNumber(String teacherCardNumber) {
        this.teacherCardNumber = teacherCardNumber;
    }

    /*联系电话*/
    private String teacherPhone;
    public String getTeacherPhone() {
        return teacherPhone;
    }
    public void setTeacherPhone(String teacherPhone) {
        this.teacherPhone = teacherPhone;
    }

    /*教师照片*/
    private String teacherPhoto;
    public String getTeacherPhoto() {
        return teacherPhoto;
    }
    public void setTeacherPhoto(String teacherPhoto) {
        this.teacherPhoto = teacherPhoto;
    }

    /*家庭地址*/
    private String teacherAddress;
    public String getTeacherAddress() {
        return teacherAddress;
    }
    public void setTeacherAddress(String teacherAddress) {
        this.teacherAddress = teacherAddress;
    }

    /*附加信息*/
    private String teacherMemo;
    public String getTeacherMemo() {
        return teacherMemo;
    }
    public void setTeacherMemo(String teacherMemo) {
        this.teacherMemo = teacherMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonTeacher=new JSONObject(); 
		jsonTeacher.accumulate("teacherNumber", this.getTeacherNumber());
		jsonTeacher.accumulate("teacherName", this.getTeacherName());
		jsonTeacher.accumulate("teacherPassword", this.getTeacherPassword());
		jsonTeacher.accumulate("teacherSex", this.getTeacherSex());
		jsonTeacher.accumulate("teacherBirthday", this.getTeacherBirthday().length()>19?this.getTeacherBirthday().substring(0,19):this.getTeacherBirthday());
		jsonTeacher.accumulate("teacherArriveDate", this.getTeacherArriveDate().length()>19?this.getTeacherArriveDate().substring(0,19):this.getTeacherArriveDate());
		jsonTeacher.accumulate("teacherCardNumber", this.getTeacherCardNumber());
		jsonTeacher.accumulate("teacherPhone", this.getTeacherPhone());
		jsonTeacher.accumulate("teacherPhoto", this.getTeacherPhoto());
		jsonTeacher.accumulate("teacherAddress", this.getTeacherAddress());
		jsonTeacher.accumulate("teacherMemo", this.getTeacherMemo());
		return jsonTeacher;
    }}
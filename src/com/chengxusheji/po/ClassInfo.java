package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class ClassInfo {
    /*班级编号*/
    @NotEmpty(message="班级编号不能为空")
    private String classNumber;
    public String getClassNumber(){
        return classNumber;
    }
    public void setClassNumber(String classNumber){
        this.classNumber = classNumber;
    }

    /*班级名称*/
    @NotEmpty(message="班级名称不能为空")
    private String className;
    public String getClassName() {
        return className;
    }
    public void setClassName(String className) {
        this.className = className;
    }

    /*所属专业*/
    private SpecialFieldInfo classSpecialFieldNumber;
    public SpecialFieldInfo getClassSpecialFieldNumber() {
        return classSpecialFieldNumber;
    }
    public void setClassSpecialFieldNumber(SpecialFieldInfo classSpecialFieldNumber) {
        this.classSpecialFieldNumber = classSpecialFieldNumber;
    }

    /*成立日期*/
    @NotEmpty(message="成立日期不能为空")
    private String classBirthDate;
    public String getClassBirthDate() {
        return classBirthDate;
    }
    public void setClassBirthDate(String classBirthDate) {
        this.classBirthDate = classBirthDate;
    }

    /*班主任*/
    private String classTeacherCharge;
    public String getClassTeacherCharge() {
        return classTeacherCharge;
    }
    public void setClassTeacherCharge(String classTeacherCharge) {
        this.classTeacherCharge = classTeacherCharge;
    }

    /*联系电话*/
    private String classTelephone;
    public String getClassTelephone() {
        return classTelephone;
    }
    public void setClassTelephone(String classTelephone) {
        this.classTelephone = classTelephone;
    }

    /*附加信息*/
    private String classMemo;
    public String getClassMemo() {
        return classMemo;
    }
    public void setClassMemo(String classMemo) {
        this.classMemo = classMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonClassInfo=new JSONObject(); 
		jsonClassInfo.accumulate("classNumber", this.getClassNumber());
		jsonClassInfo.accumulate("className", this.getClassName());
		jsonClassInfo.accumulate("classSpecialFieldNumber", this.getClassSpecialFieldNumber().getSpecialFieldName());
		jsonClassInfo.accumulate("classSpecialFieldNumberPri", this.getClassSpecialFieldNumber().getSpecialFieldNumber());
		jsonClassInfo.accumulate("classBirthDate", this.getClassBirthDate().length()>19?this.getClassBirthDate().substring(0,19):this.getClassBirthDate());
		jsonClassInfo.accumulate("classTeacherCharge", this.getClassTeacherCharge());
		jsonClassInfo.accumulate("classTelephone", this.getClassTelephone());
		jsonClassInfo.accumulate("classMemo", this.getClassMemo());
		return jsonClassInfo;
    }}
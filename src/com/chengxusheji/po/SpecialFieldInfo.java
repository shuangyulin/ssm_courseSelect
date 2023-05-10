package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class SpecialFieldInfo {
    /*专业编号*/
    @NotEmpty(message="专业编号不能为空")
    private String specialFieldNumber;
    public String getSpecialFieldNumber(){
        return specialFieldNumber;
    }
    public void setSpecialFieldNumber(String specialFieldNumber){
        this.specialFieldNumber = specialFieldNumber;
    }

    /*专业名称*/
    @NotEmpty(message="专业名称不能为空")
    private String specialFieldName;
    public String getSpecialFieldName() {
        return specialFieldName;
    }
    public void setSpecialFieldName(String specialFieldName) {
        this.specialFieldName = specialFieldName;
    }

    /*所在学院*/
    private CollegeInfo specialCollegeNumber;
    public CollegeInfo getSpecialCollegeNumber() {
        return specialCollegeNumber;
    }
    public void setSpecialCollegeNumber(CollegeInfo specialCollegeNumber) {
        this.specialCollegeNumber = specialCollegeNumber;
    }

    /*成立日期*/
    @NotEmpty(message="成立日期不能为空")
    private String specialBirthDate;
    public String getSpecialBirthDate() {
        return specialBirthDate;
    }
    public void setSpecialBirthDate(String specialBirthDate) {
        this.specialBirthDate = specialBirthDate;
    }

    /*联系人*/
    private String specialMan;
    public String getSpecialMan() {
        return specialMan;
    }
    public void setSpecialMan(String specialMan) {
        this.specialMan = specialMan;
    }

    /*联系电话*/
    private String specialTelephone;
    public String getSpecialTelephone() {
        return specialTelephone;
    }
    public void setSpecialTelephone(String specialTelephone) {
        this.specialTelephone = specialTelephone;
    }

    /*附加信息*/
    private String specialMemo;
    public String getSpecialMemo() {
        return specialMemo;
    }
    public void setSpecialMemo(String specialMemo) {
        this.specialMemo = specialMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonSpecialFieldInfo=new JSONObject(); 
		jsonSpecialFieldInfo.accumulate("specialFieldNumber", this.getSpecialFieldNumber());
		jsonSpecialFieldInfo.accumulate("specialFieldName", this.getSpecialFieldName());
		jsonSpecialFieldInfo.accumulate("specialCollegeNumber", this.getSpecialCollegeNumber().getCollegeName());
		jsonSpecialFieldInfo.accumulate("specialCollegeNumberPri", this.getSpecialCollegeNumber().getCollegeNumber());
		jsonSpecialFieldInfo.accumulate("specialBirthDate", this.getSpecialBirthDate().length()>19?this.getSpecialBirthDate().substring(0,19):this.getSpecialBirthDate());
		jsonSpecialFieldInfo.accumulate("specialMan", this.getSpecialMan());
		jsonSpecialFieldInfo.accumulate("specialTelephone", this.getSpecialTelephone());
		jsonSpecialFieldInfo.accumulate("specialMemo", this.getSpecialMemo());
		return jsonSpecialFieldInfo;
    }}
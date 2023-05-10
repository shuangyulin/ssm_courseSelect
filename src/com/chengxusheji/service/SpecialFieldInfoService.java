package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.CollegeInfo;
import com.chengxusheji.po.SpecialFieldInfo;

import com.chengxusheji.mapper.SpecialFieldInfoMapper;
@Service
public class SpecialFieldInfoService {

	@Resource SpecialFieldInfoMapper specialFieldInfoMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加专业信息记录*/
    public void addSpecialFieldInfo(SpecialFieldInfo specialFieldInfo) throws Exception {
    	specialFieldInfoMapper.addSpecialFieldInfo(specialFieldInfo);
    }

    /*按照查询条件分页查询专业信息记录*/
    public ArrayList<SpecialFieldInfo> querySpecialFieldInfo(String specialFieldNumber,String specialFieldName,CollegeInfo specialCollegeNumber,String specialBirthDate,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!specialFieldNumber.equals("")) where = where + " and t_specialFieldInfo.specialFieldNumber like '%" + specialFieldNumber + "%'";
    	if(!specialFieldName.equals("")) where = where + " and t_specialFieldInfo.specialFieldName like '%" + specialFieldName + "%'";
    	if(null != specialCollegeNumber &&  specialCollegeNumber.getCollegeNumber() != null  && !specialCollegeNumber.getCollegeNumber().equals(""))  where += " and t_specialFieldInfo.specialCollegeNumber='" + specialCollegeNumber.getCollegeNumber() + "'";
    	if(!specialBirthDate.equals("")) where = where + " and t_specialFieldInfo.specialBirthDate like '%" + specialBirthDate + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return specialFieldInfoMapper.querySpecialFieldInfo(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<SpecialFieldInfo> querySpecialFieldInfo(String specialFieldNumber,String specialFieldName,CollegeInfo specialCollegeNumber,String specialBirthDate) throws Exception  { 
     	String where = "where 1=1";
    	if(!specialFieldNumber.equals("")) where = where + " and t_specialFieldInfo.specialFieldNumber like '%" + specialFieldNumber + "%'";
    	if(!specialFieldName.equals("")) where = where + " and t_specialFieldInfo.specialFieldName like '%" + specialFieldName + "%'";
    	if(null != specialCollegeNumber &&  specialCollegeNumber.getCollegeNumber() != null && !specialCollegeNumber.getCollegeNumber().equals(""))  where += " and t_specialFieldInfo.specialCollegeNumber='" + specialCollegeNumber.getCollegeNumber() + "'";
    	if(!specialBirthDate.equals("")) where = where + " and t_specialFieldInfo.specialBirthDate like '%" + specialBirthDate + "%'";
    	return specialFieldInfoMapper.querySpecialFieldInfoList(where);
    }

    /*查询所有专业信息记录*/
    public ArrayList<SpecialFieldInfo> queryAllSpecialFieldInfo()  throws Exception {
        return specialFieldInfoMapper.querySpecialFieldInfoList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String specialFieldNumber,String specialFieldName,CollegeInfo specialCollegeNumber,String specialBirthDate) throws Exception {
     	String where = "where 1=1";
    	if(!specialFieldNumber.equals("")) where = where + " and t_specialFieldInfo.specialFieldNumber like '%" + specialFieldNumber + "%'";
    	if(!specialFieldName.equals("")) where = where + " and t_specialFieldInfo.specialFieldName like '%" + specialFieldName + "%'";
    	if(null != specialCollegeNumber &&  specialCollegeNumber.getCollegeNumber() != null && !specialCollegeNumber.getCollegeNumber().equals(""))  where += " and t_specialFieldInfo.specialCollegeNumber='" + specialCollegeNumber.getCollegeNumber() + "'";
    	if(!specialBirthDate.equals("")) where = where + " and t_specialFieldInfo.specialBirthDate like '%" + specialBirthDate + "%'";
        recordNumber = specialFieldInfoMapper.querySpecialFieldInfoCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取专业信息记录*/
    public SpecialFieldInfo getSpecialFieldInfo(String specialFieldNumber) throws Exception  {
        SpecialFieldInfo specialFieldInfo = specialFieldInfoMapper.getSpecialFieldInfo(specialFieldNumber);
        return specialFieldInfo;
    }

    /*更新专业信息记录*/
    public void updateSpecialFieldInfo(SpecialFieldInfo specialFieldInfo) throws Exception {
        specialFieldInfoMapper.updateSpecialFieldInfo(specialFieldInfo);
    }

    /*删除一条专业信息记录*/
    public void deleteSpecialFieldInfo (String specialFieldNumber) throws Exception {
        specialFieldInfoMapper.deleteSpecialFieldInfo(specialFieldNumber);
    }

    /*删除多条专业信息信息*/
    public int deleteSpecialFieldInfos (String specialFieldNumbers) throws Exception {
    	String _specialFieldNumbers[] = specialFieldNumbers.split(",");
    	for(String _specialFieldNumber: _specialFieldNumbers) {
    		specialFieldInfoMapper.deleteSpecialFieldInfo(_specialFieldNumber);
    	}
    	return _specialFieldNumbers.length;
    }
}

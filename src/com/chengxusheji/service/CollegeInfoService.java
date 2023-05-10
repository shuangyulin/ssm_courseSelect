package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.CollegeInfo;

import com.chengxusheji.mapper.CollegeInfoMapper;
@Service
public class CollegeInfoService {

	@Resource CollegeInfoMapper collegeInfoMapper;
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

    /*添加学院信息记录*/
    public void addCollegeInfo(CollegeInfo collegeInfo) throws Exception {
    	collegeInfoMapper.addCollegeInfo(collegeInfo);
    }

    /*按照查询条件分页查询学院信息记录*/
    public ArrayList<CollegeInfo> queryCollegeInfo(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return collegeInfoMapper.queryCollegeInfo(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<CollegeInfo> queryCollegeInfo() throws Exception  { 
     	String where = "where 1=1";
    	return collegeInfoMapper.queryCollegeInfoList(where);
    }

    /*查询所有学院信息记录*/
    public ArrayList<CollegeInfo> queryAllCollegeInfo()  throws Exception {
        return collegeInfoMapper.queryCollegeInfoList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = collegeInfoMapper.queryCollegeInfoCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取学院信息记录*/
    public CollegeInfo getCollegeInfo(String collegeNumber) throws Exception  {
        CollegeInfo collegeInfo = collegeInfoMapper.getCollegeInfo(collegeNumber);
        return collegeInfo;
    }

    /*更新学院信息记录*/
    public void updateCollegeInfo(CollegeInfo collegeInfo) throws Exception {
        collegeInfoMapper.updateCollegeInfo(collegeInfo);
    }

    /*删除一条学院信息记录*/
    public void deleteCollegeInfo (String collegeNumber) throws Exception {
        collegeInfoMapper.deleteCollegeInfo(collegeNumber);
    }

    /*删除多条学院信息信息*/
    public int deleteCollegeInfos (String collegeNumbers) throws Exception {
    	String _collegeNumbers[] = collegeNumbers.split(",");
    	for(String _collegeNumber: _collegeNumbers) {
    		collegeInfoMapper.deleteCollegeInfo(_collegeNumber);
    	}
    	return _collegeNumbers.length;
    }
}

package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.CollegeInfo;

public interface CollegeInfoMapper {
	/*添加学院信息信息*/
	public void addCollegeInfo(CollegeInfo collegeInfo) throws Exception;

	/*按照查询条件分页查询学院信息记录*/
	public ArrayList<CollegeInfo> queryCollegeInfo(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有学院信息记录*/
	public ArrayList<CollegeInfo> queryCollegeInfoList(@Param("where") String where) throws Exception;

	/*按照查询条件的学院信息记录数*/
	public int queryCollegeInfoCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条学院信息记录*/
	public CollegeInfo getCollegeInfo(String collegeNumber) throws Exception;

	/*更新学院信息记录*/
	public void updateCollegeInfo(CollegeInfo collegeInfo) throws Exception;

	/*删除学院信息记录*/
	public void deleteCollegeInfo(String collegeNumber) throws Exception;

}

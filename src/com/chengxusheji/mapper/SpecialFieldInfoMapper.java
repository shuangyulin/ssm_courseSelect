package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.SpecialFieldInfo;

public interface SpecialFieldInfoMapper {
	/*添加专业信息信息*/
	public void addSpecialFieldInfo(SpecialFieldInfo specialFieldInfo) throws Exception;

	/*按照查询条件分页查询专业信息记录*/
	public ArrayList<SpecialFieldInfo> querySpecialFieldInfo(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有专业信息记录*/
	public ArrayList<SpecialFieldInfo> querySpecialFieldInfoList(@Param("where") String where) throws Exception;

	/*按照查询条件的专业信息记录数*/
	public int querySpecialFieldInfoCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条专业信息记录*/
	public SpecialFieldInfo getSpecialFieldInfo(String specialFieldNumber) throws Exception;

	/*更新专业信息记录*/
	public void updateSpecialFieldInfo(SpecialFieldInfo specialFieldInfo) throws Exception;

	/*删除专业信息记录*/
	public void deleteSpecialFieldInfo(String specialFieldNumber) throws Exception;

}

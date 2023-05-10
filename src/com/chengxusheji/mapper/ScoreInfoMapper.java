package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.ScoreInfo;

public interface ScoreInfoMapper {
	/*添加成绩信息信息*/
	public void addScoreInfo(ScoreInfo scoreInfo) throws Exception;

	/*按照查询条件分页查询成绩信息记录*/
	public ArrayList<ScoreInfo> queryScoreInfo(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有成绩信息记录*/
	public ArrayList<ScoreInfo> queryScoreInfoList(@Param("where") String where) throws Exception;

	/*按照查询条件的成绩信息记录数*/
	public int queryScoreInfoCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条成绩信息记录*/
	public ScoreInfo getScoreInfo(int scoreId) throws Exception;

	/*更新成绩信息记录*/
	public void updateScoreInfo(ScoreInfo scoreInfo) throws Exception;

	/*删除成绩信息记录*/
	public void deleteScoreInfo(int scoreId) throws Exception;

}

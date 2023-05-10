package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.StudentSelectCourseInfo;

public interface StudentSelectCourseInfoMapper {
	/*添加选课信息信息*/
	public void addStudentSelectCourseInfo(StudentSelectCourseInfo studentSelectCourseInfo) throws Exception;

	/*按照查询条件分页查询选课信息记录*/
	public ArrayList<StudentSelectCourseInfo> queryStudentSelectCourseInfo(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有选课信息记录*/
	public ArrayList<StudentSelectCourseInfo> queryStudentSelectCourseInfoList(@Param("where") String where) throws Exception;

	/*按照查询条件的选课信息记录数*/
	public int queryStudentSelectCourseInfoCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条选课信息记录*/
	public StudentSelectCourseInfo getStudentSelectCourseInfo(int selectId) throws Exception;

	/*更新选课信息记录*/
	public void updateStudentSelectCourseInfo(StudentSelectCourseInfo studentSelectCourseInfo) throws Exception;

	/*删除选课信息记录*/
	public void deleteStudentSelectCourseInfo(int selectId) throws Exception;

}

package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Student;
import com.chengxusheji.po.CourseInfo;
import com.chengxusheji.po.StudentSelectCourseInfo;

import com.chengxusheji.mapper.StudentSelectCourseInfoMapper;
@Service
public class StudentSelectCourseInfoService {

	@Resource StudentSelectCourseInfoMapper studentSelectCourseInfoMapper;
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

    /*添加选课信息记录*/
    public void addStudentSelectCourseInfo(StudentSelectCourseInfo studentSelectCourseInfo) throws Exception {
    	studentSelectCourseInfoMapper.addStudentSelectCourseInfo(studentSelectCourseInfo);
    }

    /*按照查询条件分页查询选课信息记录*/
    public ArrayList<StudentSelectCourseInfo> queryStudentSelectCourseInfo(Student studentNumber,CourseInfo courseNumber,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != studentNumber &&  studentNumber.getStudentNumber() != null  && !studentNumber.getStudentNumber().equals(""))  where += " and t_studentSelectCourseInfo.studentNumber='" + studentNumber.getStudentNumber() + "'";
    	if(null != courseNumber &&  courseNumber.getCourseNumber() != null  && !courseNumber.getCourseNumber().equals(""))  where += " and t_studentSelectCourseInfo.courseNumber='" + courseNumber.getCourseNumber() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return studentSelectCourseInfoMapper.queryStudentSelectCourseInfo(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<StudentSelectCourseInfo> queryStudentSelectCourseInfo(Student studentNumber,CourseInfo courseNumber) throws Exception  { 
     	String where = "where 1=1";
    	if(null != studentNumber &&  studentNumber.getStudentNumber() != null && !studentNumber.getStudentNumber().equals(""))  where += " and t_studentSelectCourseInfo.studentNumber='" + studentNumber.getStudentNumber() + "'";
    	if(null != courseNumber &&  courseNumber.getCourseNumber() != null && !courseNumber.getCourseNumber().equals(""))  where += " and t_studentSelectCourseInfo.courseNumber='" + courseNumber.getCourseNumber() + "'";
    	return studentSelectCourseInfoMapper.queryStudentSelectCourseInfoList(where);
    }

    /*查询所有选课信息记录*/
    public ArrayList<StudentSelectCourseInfo> queryAllStudentSelectCourseInfo()  throws Exception {
        return studentSelectCourseInfoMapper.queryStudentSelectCourseInfoList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Student studentNumber,CourseInfo courseNumber) throws Exception {
     	String where = "where 1=1";
    	if(null != studentNumber &&  studentNumber.getStudentNumber() != null && !studentNumber.getStudentNumber().equals(""))  where += " and t_studentSelectCourseInfo.studentNumber='" + studentNumber.getStudentNumber() + "'";
    	if(null != courseNumber &&  courseNumber.getCourseNumber() != null && !courseNumber.getCourseNumber().equals(""))  where += " and t_studentSelectCourseInfo.courseNumber='" + courseNumber.getCourseNumber() + "'";
        recordNumber = studentSelectCourseInfoMapper.queryStudentSelectCourseInfoCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取选课信息记录*/
    public StudentSelectCourseInfo getStudentSelectCourseInfo(int selectId) throws Exception  {
        StudentSelectCourseInfo studentSelectCourseInfo = studentSelectCourseInfoMapper.getStudentSelectCourseInfo(selectId);
        return studentSelectCourseInfo;
    }

    /*更新选课信息记录*/
    public void updateStudentSelectCourseInfo(StudentSelectCourseInfo studentSelectCourseInfo) throws Exception {
        studentSelectCourseInfoMapper.updateStudentSelectCourseInfo(studentSelectCourseInfo);
    }

    /*删除一条选课信息记录*/
    public void deleteStudentSelectCourseInfo (int selectId) throws Exception {
        studentSelectCourseInfoMapper.deleteStudentSelectCourseInfo(selectId);
    }

    /*删除多条选课信息信息*/
    public int deleteStudentSelectCourseInfos (String selectIds) throws Exception {
    	String _selectIds[] = selectIds.split(",");
    	for(String _selectId: _selectIds) {
    		studentSelectCourseInfoMapper.deleteStudentSelectCourseInfo(Integer.parseInt(_selectId));
    	}
    	return _selectIds.length;
    }
}

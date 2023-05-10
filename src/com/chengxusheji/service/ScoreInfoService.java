package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Student;
import com.chengxusheji.po.CourseInfo;
import com.chengxusheji.po.ScoreInfo;

import com.chengxusheji.mapper.ScoreInfoMapper;
@Service
public class ScoreInfoService {

	@Resource ScoreInfoMapper scoreInfoMapper;
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

    /*添加成绩信息记录*/
    public void addScoreInfo(ScoreInfo scoreInfo) throws Exception {
    	scoreInfoMapper.addScoreInfo(scoreInfo);
    }

    /*按照查询条件分页查询成绩信息记录*/
    public ArrayList<ScoreInfo> queryScoreInfo(Student studentNumber,CourseInfo courseNumber,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != studentNumber &&  studentNumber.getStudentNumber() != null  && !studentNumber.getStudentNumber().equals(""))  where += " and t_scoreInfo.studentNumber='" + studentNumber.getStudentNumber() + "'";
    	if(null != courseNumber &&  courseNumber.getCourseNumber() != null  && !courseNumber.getCourseNumber().equals(""))  where += " and t_scoreInfo.courseNumber='" + courseNumber.getCourseNumber() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return scoreInfoMapper.queryScoreInfo(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<ScoreInfo> queryScoreInfo(Student studentNumber,CourseInfo courseNumber) throws Exception  { 
     	String where = "where 1=1";
    	if(null != studentNumber &&  studentNumber.getStudentNumber() != null && !studentNumber.getStudentNumber().equals(""))  where += " and t_scoreInfo.studentNumber='" + studentNumber.getStudentNumber() + "'";
    	if(null != courseNumber &&  courseNumber.getCourseNumber() != null && !courseNumber.getCourseNumber().equals(""))  where += " and t_scoreInfo.courseNumber='" + courseNumber.getCourseNumber() + "'";
    	return scoreInfoMapper.queryScoreInfoList(where);
    }

    /*查询所有成绩信息记录*/
    public ArrayList<ScoreInfo> queryAllScoreInfo()  throws Exception {
        return scoreInfoMapper.queryScoreInfoList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Student studentNumber,CourseInfo courseNumber) throws Exception {
     	String where = "where 1=1";
    	if(null != studentNumber &&  studentNumber.getStudentNumber() != null && !studentNumber.getStudentNumber().equals(""))  where += " and t_scoreInfo.studentNumber='" + studentNumber.getStudentNumber() + "'";
    	if(null != courseNumber &&  courseNumber.getCourseNumber() != null && !courseNumber.getCourseNumber().equals(""))  where += " and t_scoreInfo.courseNumber='" + courseNumber.getCourseNumber() + "'";
        recordNumber = scoreInfoMapper.queryScoreInfoCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取成绩信息记录*/
    public ScoreInfo getScoreInfo(int scoreId) throws Exception  {
        ScoreInfo scoreInfo = scoreInfoMapper.getScoreInfo(scoreId);
        return scoreInfo;
    }

    /*更新成绩信息记录*/
    public void updateScoreInfo(ScoreInfo scoreInfo) throws Exception {
        scoreInfoMapper.updateScoreInfo(scoreInfo);
    }

    /*删除一条成绩信息记录*/
    public void deleteScoreInfo (int scoreId) throws Exception {
        scoreInfoMapper.deleteScoreInfo(scoreId);
    }

    /*删除多条成绩信息信息*/
    public int deleteScoreInfos (String scoreIds) throws Exception {
    	String _scoreIds[] = scoreIds.split(",");
    	for(String _scoreId: _scoreIds) {
    		scoreInfoMapper.deleteScoreInfo(Integer.parseInt(_scoreId));
    	}
    	return _scoreIds.length;
    }
}

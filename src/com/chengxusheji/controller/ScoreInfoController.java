package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.ScoreInfoService;
import com.chengxusheji.po.ScoreInfo;
import com.chengxusheji.service.CourseInfoService;
import com.chengxusheji.po.CourseInfo;
import com.chengxusheji.service.StudentService;
import com.chengxusheji.po.Student;

//ScoreInfo管理控制层
@Controller
@RequestMapping("/ScoreInfo")
public class ScoreInfoController extends BaseController {

    /*业务层对象*/
    @Resource ScoreInfoService scoreInfoService;

    @Resource CourseInfoService courseInfoService;
    @Resource StudentService studentService;
	@InitBinder("studentNumber")
	public void initBinderstudentNumber(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("studentNumber.");
	}
	@InitBinder("courseNumber")
	public void initBindercourseNumber(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("courseNumber.");
	}
	@InitBinder("scoreInfo")
	public void initBinderScoreInfo(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("scoreInfo.");
	}
	/*跳转到添加ScoreInfo视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new ScoreInfo());
		/*查询所有的CourseInfo信息*/
		List<CourseInfo> courseInfoList = courseInfoService.queryAllCourseInfo();
		request.setAttribute("courseInfoList", courseInfoList);
		/*查询所有的Student信息*/
		List<Student> studentList = studentService.queryAllStudent();
		request.setAttribute("studentList", studentList);
		return "ScoreInfo_add";
	}

	/*客户端ajax方式提交添加成绩信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated ScoreInfo scoreInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        scoreInfoService.addScoreInfo(scoreInfo);
        message = "成绩信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询成绩信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("studentNumber") Student studentNumber,@ModelAttribute("courseNumber") CourseInfo courseNumber,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)scoreInfoService.setRows(rows);
		List<ScoreInfo> scoreInfoList = scoreInfoService.queryScoreInfo(studentNumber, courseNumber, page);
	    /*计算总的页数和总的记录数*/
	    scoreInfoService.queryTotalPageAndRecordNumber(studentNumber, courseNumber);
	    /*获取到总的页码数目*/
	    int totalPage = scoreInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = scoreInfoService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(ScoreInfo scoreInfo:scoreInfoList) {
			JSONObject jsonScoreInfo = scoreInfo.getJsonObject();
			jsonArray.put(jsonScoreInfo);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询成绩信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<ScoreInfo> scoreInfoList = scoreInfoService.queryAllScoreInfo();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(ScoreInfo scoreInfo:scoreInfoList) {
			JSONObject jsonScoreInfo = new JSONObject();
			jsonScoreInfo.accumulate("scoreId", scoreInfo.getScoreId());
			jsonArray.put(jsonScoreInfo);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询成绩信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("studentNumber") Student studentNumber,@ModelAttribute("courseNumber") CourseInfo courseNumber,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<ScoreInfo> scoreInfoList = scoreInfoService.queryScoreInfo(studentNumber, courseNumber, currentPage);
	    /*计算总的页数和总的记录数*/
	    scoreInfoService.queryTotalPageAndRecordNumber(studentNumber, courseNumber);
	    /*获取到总的页码数目*/
	    int totalPage = scoreInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = scoreInfoService.getRecordNumber();
	    request.setAttribute("scoreInfoList",  scoreInfoList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("studentNumber", studentNumber);
	    request.setAttribute("courseNumber", courseNumber);
	    List<CourseInfo> courseInfoList = courseInfoService.queryAllCourseInfo();
	    request.setAttribute("courseInfoList", courseInfoList);
	    List<Student> studentList = studentService.queryAllStudent();
	    request.setAttribute("studentList", studentList);
		return "ScoreInfo/scoreInfo_frontquery_result"; 
	}

     /*前台查询ScoreInfo信息*/
	@RequestMapping(value="/{scoreId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer scoreId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键scoreId获取ScoreInfo对象*/
        ScoreInfo scoreInfo = scoreInfoService.getScoreInfo(scoreId);

        List<CourseInfo> courseInfoList = courseInfoService.queryAllCourseInfo();
        request.setAttribute("courseInfoList", courseInfoList);
        List<Student> studentList = studentService.queryAllStudent();
        request.setAttribute("studentList", studentList);
        request.setAttribute("scoreInfo",  scoreInfo);
        return "ScoreInfo/scoreInfo_frontshow";
	}

	/*ajax方式显示成绩信息修改jsp视图页*/
	@RequestMapping(value="/{scoreId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer scoreId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键scoreId获取ScoreInfo对象*/
        ScoreInfo scoreInfo = scoreInfoService.getScoreInfo(scoreId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonScoreInfo = scoreInfo.getJsonObject();
		out.println(jsonScoreInfo.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新成绩信息信息*/
	@RequestMapping(value = "/{scoreId}/update", method = RequestMethod.POST)
	public void update(@Validated ScoreInfo scoreInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			scoreInfoService.updateScoreInfo(scoreInfo);
			message = "成绩信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "成绩信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除成绩信息信息*/
	@RequestMapping(value="/{scoreId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer scoreId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  scoreInfoService.deleteScoreInfo(scoreId);
	            request.setAttribute("message", "成绩信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "成绩信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条成绩信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String scoreIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = scoreInfoService.deleteScoreInfos(scoreIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出成绩信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("studentNumber") Student studentNumber,@ModelAttribute("courseNumber") CourseInfo courseNumber, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<ScoreInfo> scoreInfoList = scoreInfoService.queryScoreInfo(studentNumber,courseNumber);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "ScoreInfo信息记录"; 
        String[] headers = { "记录编号","学生对象","课程对象","成绩得分"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<scoreInfoList.size();i++) {
        	ScoreInfo scoreInfo = scoreInfoList.get(i); 
        	dataset.add(new String[]{scoreInfo.getScoreId() + "",scoreInfo.getStudentNumber().getStudentName(),scoreInfo.getCourseNumber().getCourseName(),scoreInfo.getScoreValue() + ""});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"ScoreInfo.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}

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
import com.chengxusheji.service.CourseInfoService;
import com.chengxusheji.po.CourseInfo;
import com.chengxusheji.service.TeacherService;
import com.chengxusheji.po.Teacher;

//CourseInfo管理控制层
@Controller
@RequestMapping("/CourseInfo")
public class CourseInfoController extends BaseController {

    /*业务层对象*/
    @Resource CourseInfoService courseInfoService;

    @Resource TeacherService teacherService;
	@InitBinder("courseTeacher")
	public void initBindercourseTeacher(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("courseTeacher.");
	}
	@InitBinder("courseInfo")
	public void initBinderCourseInfo(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("courseInfo.");
	}
	/*跳转到添加CourseInfo视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new CourseInfo());
		/*查询所有的Teacher信息*/
		List<Teacher> teacherList = teacherService.queryAllTeacher();
		request.setAttribute("teacherList", teacherList);
		return "CourseInfo_add";
	}

	/*客户端ajax方式提交添加课程信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated CourseInfo courseInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		if(courseInfoService.getCourseInfo(courseInfo.getCourseNumber()) != null) {
			message = "课程编号已经存在！";
			writeJsonResponse(response, success, message);
			return ;
		}
        courseInfoService.addCourseInfo(courseInfo);
        message = "课程信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询课程信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String courseNumber,String courseName,@ModelAttribute("courseTeacher") Teacher courseTeacher,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (courseNumber == null) courseNumber = "";
		if (courseName == null) courseName = "";
		if(rows != 0)courseInfoService.setRows(rows);
		List<CourseInfo> courseInfoList = courseInfoService.queryCourseInfo(courseNumber, courseName, courseTeacher, page);
	    /*计算总的页数和总的记录数*/
	    courseInfoService.queryTotalPageAndRecordNumber(courseNumber, courseName, courseTeacher);
	    /*获取到总的页码数目*/
	    int totalPage = courseInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = courseInfoService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(CourseInfo courseInfo:courseInfoList) {
			JSONObject jsonCourseInfo = courseInfo.getJsonObject();
			jsonArray.put(jsonCourseInfo);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询课程信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<CourseInfo> courseInfoList = courseInfoService.queryAllCourseInfo();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(CourseInfo courseInfo:courseInfoList) {
			JSONObject jsonCourseInfo = new JSONObject();
			jsonCourseInfo.accumulate("courseNumber", courseInfo.getCourseNumber());
			jsonCourseInfo.accumulate("courseName", courseInfo.getCourseName());
			jsonArray.put(jsonCourseInfo);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询课程信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String courseNumber,String courseName,@ModelAttribute("courseTeacher") Teacher courseTeacher,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (courseNumber == null) courseNumber = "";
		if (courseName == null) courseName = "";
		List<CourseInfo> courseInfoList = courseInfoService.queryCourseInfo(courseNumber, courseName, courseTeacher, currentPage);
	    /*计算总的页数和总的记录数*/
	    courseInfoService.queryTotalPageAndRecordNumber(courseNumber, courseName, courseTeacher);
	    /*获取到总的页码数目*/
	    int totalPage = courseInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = courseInfoService.getRecordNumber();
	    request.setAttribute("courseInfoList",  courseInfoList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("courseNumber", courseNumber);
	    request.setAttribute("courseName", courseName);
	    request.setAttribute("courseTeacher", courseTeacher);
	    List<Teacher> teacherList = teacherService.queryAllTeacher();
	    request.setAttribute("teacherList", teacherList);
		return "CourseInfo/courseInfo_frontquery_result"; 
	}

     /*前台查询CourseInfo信息*/
	@RequestMapping(value="/{courseNumber}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable String courseNumber,Model model,HttpServletRequest request) throws Exception {
		/*根据主键courseNumber获取CourseInfo对象*/
        CourseInfo courseInfo = courseInfoService.getCourseInfo(courseNumber);

        List<Teacher> teacherList = teacherService.queryAllTeacher();
        request.setAttribute("teacherList", teacherList);
        request.setAttribute("courseInfo",  courseInfo);
        return "CourseInfo/courseInfo_frontshow";
	}

	/*ajax方式显示课程信息修改jsp视图页*/
	@RequestMapping(value="/{courseNumber}/update",method=RequestMethod.GET)
	public void update(@PathVariable String courseNumber,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键courseNumber获取CourseInfo对象*/
        CourseInfo courseInfo = courseInfoService.getCourseInfo(courseNumber);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonCourseInfo = courseInfo.getJsonObject();
		out.println(jsonCourseInfo.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新课程信息信息*/
	@RequestMapping(value = "/{courseNumber}/update", method = RequestMethod.POST)
	public void update(@Validated CourseInfo courseInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			courseInfoService.updateCourseInfo(courseInfo);
			message = "课程信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "课程信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除课程信息信息*/
	@RequestMapping(value="/{courseNumber}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable String courseNumber,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  courseInfoService.deleteCourseInfo(courseNumber);
	            request.setAttribute("message", "课程信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "课程信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条课程信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String courseNumbers,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = courseInfoService.deleteCourseInfos(courseNumbers);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出课程信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String courseNumber,String courseName,@ModelAttribute("courseTeacher") Teacher courseTeacher, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(courseNumber == null) courseNumber = "";
        if(courseName == null) courseName = "";
        List<CourseInfo> courseInfoList = courseInfoService.queryCourseInfo(courseNumber,courseName,courseTeacher);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "CourseInfo信息记录"; 
        String[] headers = { "课程编号","课程名称","上课老师","上课时间","上课地点","课程学分"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<courseInfoList.size();i++) {
        	CourseInfo courseInfo = courseInfoList.get(i); 
        	dataset.add(new String[]{courseInfo.getCourseNumber(),courseInfo.getCourseName(),courseInfo.getCourseTeacher().getTeacherName(),courseInfo.getCourseTime(),courseInfo.getCoursePlace(),courseInfo.getCourseScore() + ""});
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
			response.setHeader("Content-disposition","attachment; filename="+"CourseInfo.xls");//filename是下载的xls的名，建议最好用英文 
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

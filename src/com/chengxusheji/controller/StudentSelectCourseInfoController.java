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
import com.chengxusheji.service.StudentSelectCourseInfoService;
import com.chengxusheji.po.StudentSelectCourseInfo;
import com.chengxusheji.service.CourseInfoService;
import com.chengxusheji.po.CourseInfo;
import com.chengxusheji.service.StudentService;
import com.chengxusheji.po.Student;

//StudentSelectCourseInfo管理控制层
@Controller
@RequestMapping("/StudentSelectCourseInfo")
public class StudentSelectCourseInfoController extends BaseController {

    /*业务层对象*/
    @Resource StudentSelectCourseInfoService studentSelectCourseInfoService;

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
	@InitBinder("studentSelectCourseInfo")
	public void initBinderStudentSelectCourseInfo(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("studentSelectCourseInfo.");
	}
	/*跳转到添加StudentSelectCourseInfo视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new StudentSelectCourseInfo());
		/*查询所有的CourseInfo信息*/
		List<CourseInfo> courseInfoList = courseInfoService.queryAllCourseInfo();
		request.setAttribute("courseInfoList", courseInfoList);
		/*查询所有的Student信息*/
		List<Student> studentList = studentService.queryAllStudent();
		request.setAttribute("studentList", studentList);
		return "StudentSelectCourseInfo_add";
	}

	/*客户端ajax方式提交添加选课信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated StudentSelectCourseInfo studentSelectCourseInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        studentSelectCourseInfoService.addStudentSelectCourseInfo(studentSelectCourseInfo);
        message = "选课信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询选课信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("studentNumber") Student studentNumber,@ModelAttribute("courseNumber") CourseInfo courseNumber,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)studentSelectCourseInfoService.setRows(rows);
		List<StudentSelectCourseInfo> studentSelectCourseInfoList = studentSelectCourseInfoService.queryStudentSelectCourseInfo(studentNumber, courseNumber, page);
	    /*计算总的页数和总的记录数*/
	    studentSelectCourseInfoService.queryTotalPageAndRecordNumber(studentNumber, courseNumber);
	    /*获取到总的页码数目*/
	    int totalPage = studentSelectCourseInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = studentSelectCourseInfoService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(StudentSelectCourseInfo studentSelectCourseInfo:studentSelectCourseInfoList) {
			JSONObject jsonStudentSelectCourseInfo = studentSelectCourseInfo.getJsonObject();
			jsonArray.put(jsonStudentSelectCourseInfo);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询选课信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<StudentSelectCourseInfo> studentSelectCourseInfoList = studentSelectCourseInfoService.queryAllStudentSelectCourseInfo();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(StudentSelectCourseInfo studentSelectCourseInfo:studentSelectCourseInfoList) {
			JSONObject jsonStudentSelectCourseInfo = new JSONObject();
			jsonStudentSelectCourseInfo.accumulate("selectId", studentSelectCourseInfo.getSelectId());
			jsonArray.put(jsonStudentSelectCourseInfo);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询选课信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("studentNumber") Student studentNumber,@ModelAttribute("courseNumber") CourseInfo courseNumber,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<StudentSelectCourseInfo> studentSelectCourseInfoList = studentSelectCourseInfoService.queryStudentSelectCourseInfo(studentNumber, courseNumber, currentPage);
	    /*计算总的页数和总的记录数*/
	    studentSelectCourseInfoService.queryTotalPageAndRecordNumber(studentNumber, courseNumber);
	    /*获取到总的页码数目*/
	    int totalPage = studentSelectCourseInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = studentSelectCourseInfoService.getRecordNumber();
	    request.setAttribute("studentSelectCourseInfoList",  studentSelectCourseInfoList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("studentNumber", studentNumber);
	    request.setAttribute("courseNumber", courseNumber);
	    List<CourseInfo> courseInfoList = courseInfoService.queryAllCourseInfo();
	    request.setAttribute("courseInfoList", courseInfoList);
	    List<Student> studentList = studentService.queryAllStudent();
	    request.setAttribute("studentList", studentList);
		return "StudentSelectCourseInfo/studentSelectCourseInfo_frontquery_result"; 
	}

     /*前台查询StudentSelectCourseInfo信息*/
	@RequestMapping(value="/{selectId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer selectId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键selectId获取StudentSelectCourseInfo对象*/
        StudentSelectCourseInfo studentSelectCourseInfo = studentSelectCourseInfoService.getStudentSelectCourseInfo(selectId);

        List<CourseInfo> courseInfoList = courseInfoService.queryAllCourseInfo();
        request.setAttribute("courseInfoList", courseInfoList);
        List<Student> studentList = studentService.queryAllStudent();
        request.setAttribute("studentList", studentList);
        request.setAttribute("studentSelectCourseInfo",  studentSelectCourseInfo);
        return "StudentSelectCourseInfo/studentSelectCourseInfo_frontshow";
	}

	/*ajax方式显示选课信息修改jsp视图页*/
	@RequestMapping(value="/{selectId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer selectId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键selectId获取StudentSelectCourseInfo对象*/
        StudentSelectCourseInfo studentSelectCourseInfo = studentSelectCourseInfoService.getStudentSelectCourseInfo(selectId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonStudentSelectCourseInfo = studentSelectCourseInfo.getJsonObject();
		out.println(jsonStudentSelectCourseInfo.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新选课信息信息*/
	@RequestMapping(value = "/{selectId}/update", method = RequestMethod.POST)
	public void update(@Validated StudentSelectCourseInfo studentSelectCourseInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			studentSelectCourseInfoService.updateStudentSelectCourseInfo(studentSelectCourseInfo);
			message = "选课信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "选课信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除选课信息信息*/
	@RequestMapping(value="/{selectId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer selectId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  studentSelectCourseInfoService.deleteStudentSelectCourseInfo(selectId);
	            request.setAttribute("message", "选课信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "选课信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条选课信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String selectIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = studentSelectCourseInfoService.deleteStudentSelectCourseInfos(selectIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出选课信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("studentNumber") Student studentNumber,@ModelAttribute("courseNumber") CourseInfo courseNumber, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<StudentSelectCourseInfo> studentSelectCourseInfoList = studentSelectCourseInfoService.queryStudentSelectCourseInfo(studentNumber,courseNumber);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "StudentSelectCourseInfo信息记录"; 
        String[] headers = { "记录编号","学生对象","课程对象"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<studentSelectCourseInfoList.size();i++) {
        	StudentSelectCourseInfo studentSelectCourseInfo = studentSelectCourseInfoList.get(i); 
        	dataset.add(new String[]{studentSelectCourseInfo.getSelectId() + "",studentSelectCourseInfo.getStudentNumber().getStudentName(),studentSelectCourseInfo.getCourseNumber().getCourseName()});
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
			response.setHeader("Content-disposition","attachment; filename="+"StudentSelectCourseInfo.xls");//filename是下载的xls的名，建议最好用英文 
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

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
import com.chengxusheji.service.ClassInfoService;
import com.chengxusheji.po.ClassInfo;
import com.chengxusheji.service.SpecialFieldInfoService;
import com.chengxusheji.po.SpecialFieldInfo;

//ClassInfo管理控制层
@Controller
@RequestMapping("/ClassInfo")
public class ClassInfoController extends BaseController {

    /*业务层对象*/
    @Resource ClassInfoService classInfoService;

    @Resource SpecialFieldInfoService specialFieldInfoService;
	@InitBinder("classSpecialFieldNumber")
	public void initBinderclassSpecialFieldNumber(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("classSpecialFieldNumber.");
	}
	@InitBinder("classInfo")
	public void initBinderClassInfo(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("classInfo.");
	}
	/*跳转到添加ClassInfo视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new ClassInfo());
		/*查询所有的SpecialFieldInfo信息*/
		List<SpecialFieldInfo> specialFieldInfoList = specialFieldInfoService.queryAllSpecialFieldInfo();
		request.setAttribute("specialFieldInfoList", specialFieldInfoList);
		return "ClassInfo_add";
	}

	/*客户端ajax方式提交添加班级信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated ClassInfo classInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		if(classInfoService.getClassInfo(classInfo.getClassNumber()) != null) {
			message = "班级编号已经存在！";
			writeJsonResponse(response, success, message);
			return ;
		}
        classInfoService.addClassInfo(classInfo);
        message = "班级信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询班级信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String classNumber,String className,@ModelAttribute("classSpecialFieldNumber") SpecialFieldInfo classSpecialFieldNumber,String classBirthDate,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (classNumber == null) classNumber = "";
		if (className == null) className = "";
		if (classBirthDate == null) classBirthDate = "";
		if(rows != 0)classInfoService.setRows(rows);
		List<ClassInfo> classInfoList = classInfoService.queryClassInfo(classNumber, className, classSpecialFieldNumber, classBirthDate, page);
	    /*计算总的页数和总的记录数*/
	    classInfoService.queryTotalPageAndRecordNumber(classNumber, className, classSpecialFieldNumber, classBirthDate);
	    /*获取到总的页码数目*/
	    int totalPage = classInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = classInfoService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(ClassInfo classInfo:classInfoList) {
			JSONObject jsonClassInfo = classInfo.getJsonObject();
			jsonArray.put(jsonClassInfo);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询班级信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<ClassInfo> classInfoList = classInfoService.queryAllClassInfo();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(ClassInfo classInfo:classInfoList) {
			JSONObject jsonClassInfo = new JSONObject();
			jsonClassInfo.accumulate("classNumber", classInfo.getClassNumber());
			jsonClassInfo.accumulate("className", classInfo.getClassName());
			jsonArray.put(jsonClassInfo);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询班级信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String classNumber,String className,@ModelAttribute("classSpecialFieldNumber") SpecialFieldInfo classSpecialFieldNumber,String classBirthDate,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (classNumber == null) classNumber = "";
		if (className == null) className = "";
		if (classBirthDate == null) classBirthDate = "";
		List<ClassInfo> classInfoList = classInfoService.queryClassInfo(classNumber, className, classSpecialFieldNumber, classBirthDate, currentPage);
	    /*计算总的页数和总的记录数*/
	    classInfoService.queryTotalPageAndRecordNumber(classNumber, className, classSpecialFieldNumber, classBirthDate);
	    /*获取到总的页码数目*/
	    int totalPage = classInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = classInfoService.getRecordNumber();
	    request.setAttribute("classInfoList",  classInfoList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("classNumber", classNumber);
	    request.setAttribute("className", className);
	    request.setAttribute("classSpecialFieldNumber", classSpecialFieldNumber);
	    request.setAttribute("classBirthDate", classBirthDate);
	    List<SpecialFieldInfo> specialFieldInfoList = specialFieldInfoService.queryAllSpecialFieldInfo();
	    request.setAttribute("specialFieldInfoList", specialFieldInfoList);
		return "ClassInfo/classInfo_frontquery_result"; 
	}

     /*前台查询ClassInfo信息*/
	@RequestMapping(value="/{classNumber}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable String classNumber,Model model,HttpServletRequest request) throws Exception {
		/*根据主键classNumber获取ClassInfo对象*/
        ClassInfo classInfo = classInfoService.getClassInfo(classNumber);

        List<SpecialFieldInfo> specialFieldInfoList = specialFieldInfoService.queryAllSpecialFieldInfo();
        request.setAttribute("specialFieldInfoList", specialFieldInfoList);
        request.setAttribute("classInfo",  classInfo);
        return "ClassInfo/classInfo_frontshow";
	}

	/*ajax方式显示班级信息修改jsp视图页*/
	@RequestMapping(value="/{classNumber}/update",method=RequestMethod.GET)
	public void update(@PathVariable String classNumber,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键classNumber获取ClassInfo对象*/
        ClassInfo classInfo = classInfoService.getClassInfo(classNumber);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonClassInfo = classInfo.getJsonObject();
		out.println(jsonClassInfo.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新班级信息信息*/
	@RequestMapping(value = "/{classNumber}/update", method = RequestMethod.POST)
	public void update(@Validated ClassInfo classInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			classInfoService.updateClassInfo(classInfo);
			message = "班级信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "班级信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除班级信息信息*/
	@RequestMapping(value="/{classNumber}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable String classNumber,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  classInfoService.deleteClassInfo(classNumber);
	            request.setAttribute("message", "班级信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "班级信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条班级信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String classNumbers,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = classInfoService.deleteClassInfos(classNumbers);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出班级信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String classNumber,String className,@ModelAttribute("classSpecialFieldNumber") SpecialFieldInfo classSpecialFieldNumber,String classBirthDate, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(classNumber == null) classNumber = "";
        if(className == null) className = "";
        if(classBirthDate == null) classBirthDate = "";
        List<ClassInfo> classInfoList = classInfoService.queryClassInfo(classNumber,className,classSpecialFieldNumber,classBirthDate);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "ClassInfo信息记录"; 
        String[] headers = { "班级编号","班级名称","所属专业","成立日期","班主任","联系电话"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<classInfoList.size();i++) {
        	ClassInfo classInfo = classInfoList.get(i); 
        	dataset.add(new String[]{classInfo.getClassNumber(),classInfo.getClassName(),classInfo.getClassSpecialFieldNumber().getSpecialFieldName(),classInfo.getClassBirthDate(),classInfo.getClassTeacherCharge(),classInfo.getClassTelephone()});
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
			response.setHeader("Content-disposition","attachment; filename="+"ClassInfo.xls");//filename是下载的xls的名，建议最好用英文 
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

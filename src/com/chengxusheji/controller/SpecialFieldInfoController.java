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
import com.chengxusheji.service.SpecialFieldInfoService;
import com.chengxusheji.po.SpecialFieldInfo;
import com.chengxusheji.service.CollegeInfoService;
import com.chengxusheji.po.CollegeInfo;

//SpecialFieldInfo管理控制层
@Controller
@RequestMapping("/SpecialFieldInfo")
public class SpecialFieldInfoController extends BaseController {

    /*业务层对象*/
    @Resource SpecialFieldInfoService specialFieldInfoService;

    @Resource CollegeInfoService collegeInfoService;
	@InitBinder("specialCollegeNumber")
	public void initBinderspecialCollegeNumber(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("specialCollegeNumber.");
	}
	@InitBinder("specialFieldInfo")
	public void initBinderSpecialFieldInfo(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("specialFieldInfo.");
	}
	/*跳转到添加SpecialFieldInfo视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new SpecialFieldInfo());
		/*查询所有的CollegeInfo信息*/
		List<CollegeInfo> collegeInfoList = collegeInfoService.queryAllCollegeInfo();
		request.setAttribute("collegeInfoList", collegeInfoList);
		return "SpecialFieldInfo_add";
	}

	/*客户端ajax方式提交添加专业信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated SpecialFieldInfo specialFieldInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		if(specialFieldInfoService.getSpecialFieldInfo(specialFieldInfo.getSpecialFieldNumber()) != null) {
			message = "专业编号已经存在！";
			writeJsonResponse(response, success, message);
			return ;
		}
        specialFieldInfoService.addSpecialFieldInfo(specialFieldInfo);
        message = "专业信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询专业信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String specialFieldNumber,String specialFieldName,@ModelAttribute("specialCollegeNumber") CollegeInfo specialCollegeNumber,String specialBirthDate,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (specialFieldNumber == null) specialFieldNumber = "";
		if (specialFieldName == null) specialFieldName = "";
		if (specialBirthDate == null) specialBirthDate = "";
		if(rows != 0)specialFieldInfoService.setRows(rows);
		List<SpecialFieldInfo> specialFieldInfoList = specialFieldInfoService.querySpecialFieldInfo(specialFieldNumber, specialFieldName, specialCollegeNumber, specialBirthDate, page);
	    /*计算总的页数和总的记录数*/
	    specialFieldInfoService.queryTotalPageAndRecordNumber(specialFieldNumber, specialFieldName, specialCollegeNumber, specialBirthDate);
	    /*获取到总的页码数目*/
	    int totalPage = specialFieldInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = specialFieldInfoService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(SpecialFieldInfo specialFieldInfo:specialFieldInfoList) {
			JSONObject jsonSpecialFieldInfo = specialFieldInfo.getJsonObject();
			jsonArray.put(jsonSpecialFieldInfo);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询专业信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<SpecialFieldInfo> specialFieldInfoList = specialFieldInfoService.queryAllSpecialFieldInfo();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(SpecialFieldInfo specialFieldInfo:specialFieldInfoList) {
			JSONObject jsonSpecialFieldInfo = new JSONObject();
			jsonSpecialFieldInfo.accumulate("specialFieldNumber", specialFieldInfo.getSpecialFieldNumber());
			jsonSpecialFieldInfo.accumulate("specialFieldName", specialFieldInfo.getSpecialFieldName());
			jsonArray.put(jsonSpecialFieldInfo);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询专业信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String specialFieldNumber,String specialFieldName,@ModelAttribute("specialCollegeNumber") CollegeInfo specialCollegeNumber,String specialBirthDate,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (specialFieldNumber == null) specialFieldNumber = "";
		if (specialFieldName == null) specialFieldName = "";
		if (specialBirthDate == null) specialBirthDate = "";
		List<SpecialFieldInfo> specialFieldInfoList = specialFieldInfoService.querySpecialFieldInfo(specialFieldNumber, specialFieldName, specialCollegeNumber, specialBirthDate, currentPage);
	    /*计算总的页数和总的记录数*/
	    specialFieldInfoService.queryTotalPageAndRecordNumber(specialFieldNumber, specialFieldName, specialCollegeNumber, specialBirthDate);
	    /*获取到总的页码数目*/
	    int totalPage = specialFieldInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = specialFieldInfoService.getRecordNumber();
	    request.setAttribute("specialFieldInfoList",  specialFieldInfoList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("specialFieldNumber", specialFieldNumber);
	    request.setAttribute("specialFieldName", specialFieldName);
	    request.setAttribute("specialCollegeNumber", specialCollegeNumber);
	    request.setAttribute("specialBirthDate", specialBirthDate);
	    List<CollegeInfo> collegeInfoList = collegeInfoService.queryAllCollegeInfo();
	    request.setAttribute("collegeInfoList", collegeInfoList);
		return "SpecialFieldInfo/specialFieldInfo_frontquery_result"; 
	}

     /*前台查询SpecialFieldInfo信息*/
	@RequestMapping(value="/{specialFieldNumber}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable String specialFieldNumber,Model model,HttpServletRequest request) throws Exception {
		/*根据主键specialFieldNumber获取SpecialFieldInfo对象*/
        SpecialFieldInfo specialFieldInfo = specialFieldInfoService.getSpecialFieldInfo(specialFieldNumber);

        List<CollegeInfo> collegeInfoList = collegeInfoService.queryAllCollegeInfo();
        request.setAttribute("collegeInfoList", collegeInfoList);
        request.setAttribute("specialFieldInfo",  specialFieldInfo);
        return "SpecialFieldInfo/specialFieldInfo_frontshow";
	}

	/*ajax方式显示专业信息修改jsp视图页*/
	@RequestMapping(value="/{specialFieldNumber}/update",method=RequestMethod.GET)
	public void update(@PathVariable String specialFieldNumber,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键specialFieldNumber获取SpecialFieldInfo对象*/
        SpecialFieldInfo specialFieldInfo = specialFieldInfoService.getSpecialFieldInfo(specialFieldNumber);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonSpecialFieldInfo = specialFieldInfo.getJsonObject();
		out.println(jsonSpecialFieldInfo.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新专业信息信息*/
	@RequestMapping(value = "/{specialFieldNumber}/update", method = RequestMethod.POST)
	public void update(@Validated SpecialFieldInfo specialFieldInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			specialFieldInfoService.updateSpecialFieldInfo(specialFieldInfo);
			message = "专业信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "专业信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除专业信息信息*/
	@RequestMapping(value="/{specialFieldNumber}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable String specialFieldNumber,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  specialFieldInfoService.deleteSpecialFieldInfo(specialFieldNumber);
	            request.setAttribute("message", "专业信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "专业信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条专业信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String specialFieldNumbers,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = specialFieldInfoService.deleteSpecialFieldInfos(specialFieldNumbers);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出专业信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String specialFieldNumber,String specialFieldName,@ModelAttribute("specialCollegeNumber") CollegeInfo specialCollegeNumber,String specialBirthDate, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(specialFieldNumber == null) specialFieldNumber = "";
        if(specialFieldName == null) specialFieldName = "";
        if(specialBirthDate == null) specialBirthDate = "";
        List<SpecialFieldInfo> specialFieldInfoList = specialFieldInfoService.querySpecialFieldInfo(specialFieldNumber,specialFieldName,specialCollegeNumber,specialBirthDate);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "SpecialFieldInfo信息记录"; 
        String[] headers = { "专业编号","专业名称","所在学院","成立日期","联系人","联系电话"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<specialFieldInfoList.size();i++) {
        	SpecialFieldInfo specialFieldInfo = specialFieldInfoList.get(i); 
        	dataset.add(new String[]{specialFieldInfo.getSpecialFieldNumber(),specialFieldInfo.getSpecialFieldName(),specialFieldInfo.getSpecialCollegeNumber().getCollegeName(),specialFieldInfo.getSpecialBirthDate(),specialFieldInfo.getSpecialMan(),specialFieldInfo.getSpecialTelephone()});
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
			response.setHeader("Content-disposition","attachment; filename="+"SpecialFieldInfo.xls");//filename是下载的xls的名，建议最好用英文 
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

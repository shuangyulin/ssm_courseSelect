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
import com.chengxusheji.service.CollegeInfoService;
import com.chengxusheji.po.CollegeInfo;

//CollegeInfo管理控制层
@Controller
@RequestMapping("/CollegeInfo")
public class CollegeInfoController extends BaseController {

    /*业务层对象*/
    @Resource CollegeInfoService collegeInfoService;

	@InitBinder("collegeInfo")
	public void initBinderCollegeInfo(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("collegeInfo.");
	}
	/*跳转到添加CollegeInfo视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new CollegeInfo());
		return "CollegeInfo_add";
	}

	/*客户端ajax方式提交添加学院信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated CollegeInfo collegeInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		if(collegeInfoService.getCollegeInfo(collegeInfo.getCollegeNumber()) != null) {
			message = "学院编号已经存在！";
			writeJsonResponse(response, success, message);
			return ;
		}
        collegeInfoService.addCollegeInfo(collegeInfo);
        message = "学院信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询学院信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)collegeInfoService.setRows(rows);
		List<CollegeInfo> collegeInfoList = collegeInfoService.queryCollegeInfo(page);
	    /*计算总的页数和总的记录数*/
	    collegeInfoService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = collegeInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = collegeInfoService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(CollegeInfo collegeInfo:collegeInfoList) {
			JSONObject jsonCollegeInfo = collegeInfo.getJsonObject();
			jsonArray.put(jsonCollegeInfo);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询学院信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<CollegeInfo> collegeInfoList = collegeInfoService.queryAllCollegeInfo();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(CollegeInfo collegeInfo:collegeInfoList) {
			JSONObject jsonCollegeInfo = new JSONObject();
			jsonCollegeInfo.accumulate("collegeNumber", collegeInfo.getCollegeNumber());
			jsonCollegeInfo.accumulate("collegeName", collegeInfo.getCollegeName());
			jsonArray.put(jsonCollegeInfo);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询学院信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<CollegeInfo> collegeInfoList = collegeInfoService.queryCollegeInfo(currentPage);
	    /*计算总的页数和总的记录数*/
	    collegeInfoService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = collegeInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = collegeInfoService.getRecordNumber();
	    request.setAttribute("collegeInfoList",  collegeInfoList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
		return "CollegeInfo/collegeInfo_frontquery_result"; 
	}

     /*前台查询CollegeInfo信息*/
	@RequestMapping(value="/{collegeNumber}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable String collegeNumber,Model model,HttpServletRequest request) throws Exception {
		/*根据主键collegeNumber获取CollegeInfo对象*/
        CollegeInfo collegeInfo = collegeInfoService.getCollegeInfo(collegeNumber);

        request.setAttribute("collegeInfo",  collegeInfo);
        return "CollegeInfo/collegeInfo_frontshow";
	}

	/*ajax方式显示学院信息修改jsp视图页*/
	@RequestMapping(value="/{collegeNumber}/update",method=RequestMethod.GET)
	public void update(@PathVariable String collegeNumber,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键collegeNumber获取CollegeInfo对象*/
        CollegeInfo collegeInfo = collegeInfoService.getCollegeInfo(collegeNumber);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonCollegeInfo = collegeInfo.getJsonObject();
		out.println(jsonCollegeInfo.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新学院信息信息*/
	@RequestMapping(value = "/{collegeNumber}/update", method = RequestMethod.POST)
	public void update(@Validated CollegeInfo collegeInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			collegeInfoService.updateCollegeInfo(collegeInfo);
			message = "学院信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "学院信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除学院信息信息*/
	@RequestMapping(value="/{collegeNumber}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable String collegeNumber,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  collegeInfoService.deleteCollegeInfo(collegeNumber);
	            request.setAttribute("message", "学院信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "学院信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条学院信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String collegeNumbers,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = collegeInfoService.deleteCollegeInfos(collegeNumbers);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出学院信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel( Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<CollegeInfo> collegeInfoList = collegeInfoService.queryCollegeInfo();
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "CollegeInfo信息记录"; 
        String[] headers = { "学院编号","学院名称","成立日期","院长姓名","联系电话"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<collegeInfoList.size();i++) {
        	CollegeInfo collegeInfo = collegeInfoList.get(i); 
        	dataset.add(new String[]{collegeInfo.getCollegeNumber(),collegeInfo.getCollegeName(),collegeInfo.getCollegeBirthDate(),collegeInfo.getCollegeMan(),collegeInfo.getCollegeTelephone()});
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
			response.setHeader("Content-disposition","attachment; filename="+"CollegeInfo.xls");//filename是下载的xls的名，建议最好用英文 
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

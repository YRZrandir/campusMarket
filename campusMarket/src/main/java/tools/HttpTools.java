package tools;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.alibaba.fastjson.*;

public class HttpTools {
	
	public static void writeJSON(HttpServletResponse response, String contents) {
		response.setContentType("text/plain;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Pargma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		
		String str = JSON.toJSONString(contents);
		try {
			response.getWriter().write(str);
		} catch (IOException e) {
			System.out.println("Json write failed : \n" + e.toString());
		}
	}
	
	public static void writeObject(HttpServletResponse response, Object obj) {
		response.setContentType("text/plain;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Pargma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		try {
			response.getWriter().println(JSONObject.toJSONString(obj));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

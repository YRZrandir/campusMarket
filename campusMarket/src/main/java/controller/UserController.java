/**
 * 
 */
package controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import model.user.*;

/**
 * @author Mithrandir
 *
 */
@Controller
public class UserController {
	private ApplicationContext context;
	private static final Log logger = LogFactory.getLog(UserController.class);
	
	@RequestMapping(value="/login")
	@ResponseBody
	public String login(HttpServletRequest request, HttpServletResponse response) {
		logger.info("post!!");
		try {
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");
			String id = (String)request.getParameter("id");
			String password = (String)request.getParameter("password");
			System.out.println("POST:" + id + password);
			context = new ClassPathXmlApplicationContext("Beans.xml");
			
			UserDAO userDAO = context.getBean("UserJDBCTemplate", UserJDBCTemplate.class);
			response.getWriter().println("success");
			return "success";
		} catch (UnsupportedEncodingException e) {
			
		} catch (IOException e) {
			
		}
		return "failed";
	}
	
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public void register(HttpServletRequest request, HttpServletResponse response) {
		
	}
	
	@RequestMapping(value="/updateUser", method=RequestMethod.POST)
	public void updateUser(HttpServletRequest request, HttpServletResponse response) {
		
	}
}

package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.net.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import model.product.*;
import model.user.*;
import tools.CookieTools;
import tools.StringTools;

@Controller
public class PageController {
	
	
	@RequestMapping(value = "/loginPage", method=RequestMethod.GET)
	public String loginPage() {
		return "login";
	}

	@RequestMapping(value = "/index", method=RequestMethod.GET)
	public String indexPage(HttpServletRequest request) {
		checkCookie(request);
		ApplicationContext context = new ClassPathXmlApplicationContext("classpath*:Beans.xml");
		ProductDAO productDAO = context.getBean("ProductJDBCTemplate", ProductJDBCTemplate.class);
		ArrayList<Product> products = productDAO.getAll();
		ArrayList<Product> results = new ArrayList<Product>();
		if(products.size() > 8) {
			for(int i = 0;i < 8;i++) {
				results.add(products.get(i));
			}
		} else {
			results = products;
		}
		request.setAttribute("products", products);
		return "index";
	}

	@RequestMapping(value = "/registerPage", method=RequestMethod.GET)
	public String registerPage() {
		return "register";
	}

	@RequestMapping(value = "/managePage", method=RequestMethod.GET)
	public String managePage(HttpServletRequest request, HttpSession session) {
		User me = checkCookie(request);
		if(me != null) {
			ApplicationContext context = new ClassPathXmlApplicationContext("classpath*:Beans.xml");
			ProductDAO productDAO = context.getBean("ProductJDBCTemplate", ProductJDBCTemplate.class);
			ArrayList<Product> products = productDAO.getByUserId(me.getId());
			request.setAttribute("products", products);
			return "manage";
		} else {
			return indexPage(request);
		}
	}

	@RequestMapping(value = "/aboutPage", method=RequestMethod.GET)
	public String aboutPage(HttpServletRequest request, HttpSession session) {
		checkCookie(request);
		return "about";
	}

	@RequestMapping(value = "/commodityPage", method=RequestMethod.GET)
	public String commodityPage(
			@RequestParam(name="keyword", required=true) String keyword,
			HttpServletRequest 	request,
			HttpSession 		session) {
		checkCookie(request);
		ApplicationContext context = new ClassPathXmlApplicationContext("classpath*:Beans.xml");
		ProductDAO productDAO = context.getBean("ProductJDBCTemplate", ProductJDBCTemplate.class);
		String[] keywords = StringTools.Cut(keyword);
		ArrayList<Product> results = productDAO.searchProduct(keywords);
		request.setAttribute("product", results);
		return "commodity";
	}

	@RequestMapping(value = "/addProductPage", method=RequestMethod.GET)
	public String addProductPage(HttpServletRequest request, HttpSession session) {
		User u = checkCookie(request);
		if(u != null) {
			return "addProduct";
		} else {
			return indexPage(request);
		}
	}
	
	@RequestMapping(value = "/detail", method=RequestMethod.GET)
	public String detailPage(
			@RequestParam(name="id", required=true) String id,
			HttpServletRequest 	request,
			HttpSession 		session) {
		checkCookie(request);
		ApplicationContext context = new ClassPathXmlApplicationContext("classpath*:Beans.xml");
		UserDAO userDAO = context.getBean("UserJDBCTemplate", UserJDBCTemplate.class);
		ProductDAO productDAO = context.getBean("ProductJDBCTemplate", ProductJDBCTemplate.class);
		Product product = productDAO.getById(id);
		String userId = product.getUserId();
		User user = userDAO.getUserById(userId);
		
		request.setAttribute("product", product);
		request.setAttribute("user", user);
		return "details";
	}
	
	@RequestMapping(value="updateProductPage", method=RequestMethod.GET)
	public String updateProductPage(@RequestParam(name="id", required=true) String id,
			HttpServletRequest request) {
		if(!IsUserLogin(request)) {
			return "index";
		} else {
			User me = checkCookie(request);
			ApplicationContext context = new ClassPathXmlApplicationContext("classpath*:Beans.xml");
			ProductDAO productDAO = context.getBean("ProductJDBCTemplate", ProductJDBCTemplate.class);
			Product product = productDAO.getById(id);
			if(!product.getUserId().equals(me.getId())) {
				return indexPage(request);
			} else {
				request.setAttribute("product", product);
				return "updateProduct";
			}
		}
	}
	
	private User checkCookie(HttpServletRequest request) {
		String id = CookieTools.getCookieId(request);
		if(id != null && !id.isEmpty()) {
			ApplicationContext context = new ClassPathXmlApplicationContext("classpath*:Beans.xml");
			UserDAO userDAO = context.getBean("UserJDBCTemplate", UserJDBCTemplate.class);
			User u = userDAO.getUserById(id);
			request.setAttribute("me", u);
			return u;
		} 
		return null;
	}
	
	private boolean IsUserLogin(HttpServletRequest request) {
		String id = CookieTools.getCookieId(request);
		return id != null && !id.isEmpty();
	}
}

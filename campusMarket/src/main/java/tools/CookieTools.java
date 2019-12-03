package tools;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

public class CookieTools {
	public static String getCookieId(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		if(cookies == null) {
			return null;
		} else {
			String id;
			for(Cookie cookie:cookies) {
				if (cookie.getName().equals("id")) {
					return cookie.getValue();
				}
			}
			return null;
		}
	}
	
	public static void writeCookie(HttpServletResponse response, String name, String value) {
		try {
			Cookie cookie = new Cookie(name, URLEncoder.encode(value, "UTF-8"));
			cookie.setMaxAge(24 * 60 * 60); //24hours
			response.addCookie(cookie);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

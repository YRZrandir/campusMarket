package tools;

import java.io.File;
import java.io.IOException;
import org.springframework.web.multipart.MultipartFile;

public class ImageTools {
	public static String saveImage(MultipartFile file, String filename, String path) {
		try {
			if(path.indexOf("ProductImage") != -1) {
				path = "D:\\apache-tomcat-9.0.27\\campusMarketImages\\ProductImages\\";
			} else {
				path = "D:\\apache-tomcat-9.0.27\\campusMarketImages\\UserImages\\";
			}
			File f = new File(path + filename);
			file.transferTo(f);
			return f.getPath();
		} catch (IOException e) {
			e.printStackTrace();
			return "";
		}
	}
}

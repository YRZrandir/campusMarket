package tools;

import java.io.File;
import java.io.IOException;
import org.springframework.web.multipart.MultipartFile;

public class ImageTools {
	public static String saveImage(MultipartFile file, String filename, String path) {
		try {
			File f = new File(path + filename);
			file.transferTo(f);
			System.out.println("Write image to " + f.getAbsolutePath());
			return f.getPath();
		} catch (IOException e) {
			e.printStackTrace();
			return "";
		}
	}
}

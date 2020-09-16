package sung2ne.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Base64;
import java.util.Base64.Encoder;
import java.util.UUID;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

public class FileManagement {

	/*
	 * 파일 업로드
	 * @param uploadDir 업로드 디렉터리
	 * @param file 업로드 파일
	 * @return savedFile 업로드 파일
	 */
	public static String upload(String uploadDir, MultipartFile file, String preString) {

		// 디렉터리 생성
		createDirectory(uploadDir);

		// UUID
		String originalFile = file.getOriginalFilename();
		String uploadedFile = getUuid(originalFile, "");

		if (preString != null && preString != "") {
			uploadedFile = preString + "_" + uploadedFile;
		}

		// 업로드
		File target = new File(uploadDir + "/", uploadedFile);
		try {
			FileCopyUtils.copy(file.getBytes(), target);

		} catch (IOException e) {
			e.printStackTrace();
		}

		return uploadedFile;
	}

	/*
	 * 파일 삭제
	 * @param filename 삭제할 파일
	 * @return 결과
	 */
	public static Boolean deleteFile(String filename) {
		Boolean result = false;

		File file = new File(filename);

		if (file.delete()) {
			result = true;
		} else {
			result = false;
		}

		return result;
	}

	/*
	 * 파일 복사
	 * @param directory 디렉터리
	 * @param originalFile 원본 파일
	 */
	public static void copyFile(String originalFile, String cloneFile) {
		try {
		   FileInputStream fis = new FileInputStream(originalFile);
		   FileOutputStream fos = new FileOutputStream(cloneFile);

		   int data = 0;
		   while((data=fis.read())!=-1) {
			   fos.write(data);
		   }
		   fis.close();
		   fos.close();

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/*
	 * 디렉터리 생성
	 * @param newPath 생성하고자 하는 디렉터리
	 */
	public static void createDirectory(String newDir) {
		File directory = new File(newDir);
	    if (!directory.exists()){
	    	directory.mkdir();
	    }
	}

	/*
	 * 디렉터리 삭제
	 */
	public static void removeDir(String source) {
		File[] listFile = new File(source).listFiles();

		try {
			if(listFile.length > 0) {
				for(int i = 0 ; i < listFile.length ; i++) {
					if(listFile[i].isFile()) {
						listFile[i].delete();
					} else {
						removeDir(listFile[i].getPath());
					}
					listFile[i].delete();
				}
			}
		} catch(Exception e) {
			System.err.println(System.err);
			System.exit(-1);
		}
	}

	/*
	 * uuid를 이용해서 유니크한 파일명을 생성
	 * @param fileName 파일 이름
	 * @return uuidName 유니크한 파일명
	 */
	public static String getUuid(String fileName, String extension) {

		if (extension != null && extension == "jpg") {
			extension = ".jpg";
		} else {
			extension = ".png";
		}

		String uuidName = UUID.randomUUID() + extension;
		return uuidName;
	}

	/*
	 * base64 인코딩
	 * @param imageFile 인코딩 하고자 하는 이미지
	 * @return 		인코딩 문자열
	 */
	// 참고 : https://ktko.tistory.com/entry/JAVA-BASE64-%EC%9D%B8%EC%BD%94%EB%94%A9-%EB%94%94%EC%BD%94%EB%94%A9%ED%95%98%EA%B8%B0
	public static String encodedBase64(String imageFile) {
		File originalFile = new File(imageFile);
		String encodedBase64 = null;
		try {
			@SuppressWarnings("resource")
			FileInputStream fileInputStreamReader = new FileInputStream(originalFile);
			byte[] bytes = new byte[(int) originalFile.length()];
			fileInputStreamReader.read(bytes);
			Encoder encoder = Base64.getEncoder();
			encodedBase64 = new String(encoder.encode(bytes));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return encodedBase64;
	}
}
